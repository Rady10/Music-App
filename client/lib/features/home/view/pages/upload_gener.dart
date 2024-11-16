import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/core/theme/app_pallete.dart';
import 'package:music/core/utils.dart';
import 'package:music/core/widgets/custom_form_field.dart';
import 'package:music/core/widgets/loader.dart';
import 'package:music/features/home/viewmodel/home_viewmodel.dart';

class UploadGenre extends ConsumerStatefulWidget {
  const UploadGenre({super.key});

  @override
  ConsumerState<UploadGenre> createState() => _UploadGenreState();
}

class _UploadGenreState extends ConsumerState<UploadGenre> {
  final genreNameContorller = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  final formKey = GlobalKey<FormState>();

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
    genreNameContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeViewmodelProvider.select((val) => val?.isLoading == true));
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Upload Genre'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async{
              if(formKey.currentState!.validate() && selectedImage!= null){
                await ref.read(homeViewmodelProvider.notifier).uploadGenre(
                  selectedImage: selectedImage!,  
                  genreName: genreNameContorller.text,  
                  color: selectedColor
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
                const SizedBox(height: 20,),
                CustomFormField(
                  hintText: 'Genre Name', 
                  controller: genreNameContorller,
                ),
                const SizedBox(height: 20,),
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