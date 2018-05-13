// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'basic.dart';
import 'framework.dart';
import 'layout_builder.dart';
import 'media_query.dart';

/// Signature for a function that builds a widget given an [Orientation].
///
/// Used by [OrientationBuilder.builder].
typedef Widget OrientationWidgetBuilder(BuildContext context, Orientation orientation);

/// Builds a widget tree that can depend on the parent widget's orientation
/// (distinct from the device orientation).
///
/// See also:
///
/// * [LayoutBuilder], which exposes the complete constraints, not just the
///   orientation.
/// * [CustomSingleChildLayout], which positions its child during layout.
/// * [CustomMultiChildLayout], with which you can define the precise layout
///   of a list of children during the layout phase.
class OrientationBuilder extends StatelessWidget {
  /// Creates an orientation builder.
  ///
  /// The [builder] argument must not be null.
  const OrientationBuilder({
    Key key,
    @required this.builder,
  }) : assert(builder != null),
       super(key: key);

  /// Builds the widgets below this widget given this widget's orientation.
  ///
  /// A widget's orientation is simply a factor of its width relative to its
  /// height. For example, a [Column] widget will have a landscape orientation
  /// if its width exceeds its height, even though it displays its children in
  /// a vertical array.
  final OrientationWidgetBuilder builder;

  Widget _buildWithConstraints(BuildContext context, BoxConstraints constraints) {
    // If the constraints are fully unbounded (i.e., maxWidth and maxHeight are
    // both infinite), we prefer Orientation.portrait because its more common to
    // scroll vertically then horizontally.
    final Orientation orientation = constraints.maxWidth > constraints.maxHeight ? Orientation.landscape : Orientation.portrait;
    return builder(context, orientation);
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: _buildWithConstraints);
  }
}
