import 'package:flutter/material.dart';

class TCloudHelperFunctions {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    const loader = Center(child: CircularProgressIndicator());
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader;
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(
        child: Text(
          'Ешнәрсе табылмады',
        ),
      );
    }

    if (snapshot.hasError) {
      return const Center(
        child: Text(
          'Бірнәрсе дұрыс болмады',
        ),
      );
    }

    return null;
  }

  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader ?? const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return nothingFound ??
          const Center(
            child: Text(
              'Ешнәрсе табылмады',
            ),
          );
    }

    if (snapshot.hasError) {
      return error ??
          const Center(
            child: Text(
              'Бірнәрсе дұрыс болмады',
            ),
          );
    }

    return null;
  }
}
