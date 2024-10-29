import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/custom_form_field.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/view/widgets/audio_wave.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameContorller = TextEditingController();
  final genreContorller = TextEditingController();
  final artistContorller = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();

  void selectAudio() async{
    final pickedAudio = await pickAudio();
    if(pickedAudio!= null){
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }
  void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage!= null){
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    songNameContorller.dispose();
    genreContorller.dispose();
    artistContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeViewmodelProvider.select((val) => val?.isLoading == true));
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Upload Song'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async{
              if(formKey.currentState!.validate() && selectedAudio != null && selectedImage!= null){
                await ref.read(homeViewmodelProvider.notifier).uploadSong(
                  selectedAudio: selectedAudio!, 
                  selectedThumbnail: selectedImage!, 
                  songName: songNameContorller.text, 
                  artist: artistContorller.text, 
                  color: selectedColor,
                  genre: genreContorller.text, 
                );
              }
              else{
                showSnackBar(context, 'Missing Fields');
              }
            }, 
            icon: const Icon(Icons.check)
          )
        ],
      ),
      body: isLoading
      ? const Loader() 
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: selectImage,
                  child: selectedImage!=null 
                  ? SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          selectedImage!
                        ),
                      )
                    ) 
                  : DottedBorder(
                    dashPattern: const [10, 4],
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.round,
                    color: Pallete.borderColor,
                    child: const SizedBox(
                      height: 159,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            size: 40,
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'Select the thumbnail for your song',
                            style: TextStyle(
                              fontSize: 15
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 40,),
                selectedAudio != null 
                ? AudioWave(path: selectedAudio!.path)
                : CustomFormField(
                  onTap: selectAudio,
                  hintText: 'Pick Song', 
                  controller: null,
                  isReadOnly: true,
                ),
                const SizedBox(height: 20,),
                CustomFormField(
                  hintText: 'Song Name', 
                  controller: songNameContorller,
                ),
                const SizedBox(height: 20,),
                CustomFormField(
                  hintText: 'Genre', 
                  controller: genreContorller,
                ),
                const SizedBox(height: 20,),
                CustomFormField(
                  hintText: 'Artist', 
                  controller: artistContorller,
                ),
                const SizedBox(height: 20,),
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.wheel: true
                  },
                  color: selectedColor,
                  onColorChanged: (Color color){
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}