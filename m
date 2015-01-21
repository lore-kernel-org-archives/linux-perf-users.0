From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Using perf to generate a call stack from a kernel function to
 the user space caller
Date: Wed, 21 Jan 2015 11:56:01 -0300
Message-ID: <20150121145601.GF3420@kernel.org>
References: <loom.20150120T180008-930@post.gmane.org>
 <54BEA111.9060504@hp.com>
 <loom.20150121T090925-23@post.gmane.org>
 <20150121124021.GB3420@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43022 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbbAUO4H (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Jan 2015 09:56:07 -0500
Content-Disposition: inline
In-Reply-To: <20150121124021.GB3420@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: AKel <ankelly006@hotmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Jan 21, 2015 at 09:40:21AM -0300, Arnaldo Carvalho de Melo escreveu:
> Then, in the 'perf report' TUI, use the 'P' hotkey after expanding a few
> callgraphs:
 
>   $ perf report --no-children # expand callgraphs, press P, press q
>   $ head -45 perf.hist.0  
>   -    3,47%  Image Scaler     libxul.so                      [.] _ZN4skia14BGRAConvolve2DEPKhibRKNS_19ConvolutionFilter1DES4_iPhb
>        _ZN4skia14BGRAConvolve2DEPKhibRKNS_19ConvolutionFilter1DES4_iPhb
>        _ZN4skia15ImageOperations11ResizeBasicERK8SkBitmapNS0_12ResizeMethodEiiRK7SkIRectPv
>        _ZN4skia15ImageOperations6ResizeERK8SkBitmapNS0_12ResizeMethodEiiRK7SkIRectPv

<SNIP>

> These C++ methods that needs unmangling, and I have the firefox-debuginfo
> package matching the binary... Have to check this.

  [acme@zoo linux]$ make -C tools/perf O=/tmp/build/perf install-bin
  make: Entering directory `/home/git/linux/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
  config/Makefile:597: No bfd.h/libbfd found, install binutils-dev[el]/zlib-static to gain symbol demangling

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ on  ]
  ...                      libaudit: [ on  ]
  ...                        libbfd: [ OFF ]

after installing binutils-devel it gets symbol demangling:
 
-    3,47%  Image Scaler     libxul.so                      [.] skia::BGRAConvolve2D
     skia::BGRAConvolve2D
     skia::ImageOperations::ResizeBasic
     skia::ImageOperations::Resize
     skia::ImageOperations::Resize
     mozilla::gfx::Scale
     mozilla::image::ScaleRunner::Run
     nsThread::ProcessNextEvent
     NS_ProcessNextEvent
     mozilla::ipc::MessagePumpForNonMainThreads::Run
     MessageLoop::Run
     nsThread::ThreadFunc
     _pt_root
     start_thread
     __clone
+    3,00%  Cache2 I/O       libc-2.18.so                   [.] __memmove_ssse3_back
+    1,79%  firefox          libz.so.1.2.8                  [.] inflate_fast
+    1,76%  Cache2 I/O       libxul.so                      [.] nsTArray_Impl<mozilla::net::CacheIndexRecord*, nsTArrayInfallibleAllocator>::RemoveElement<mozilla::net::CacheIndexRecord*, nsDefaultComparator<mozilla::net::CacheIndexRecord*, mozilla::net::CacheIndexRecord*> >
+    1,39%  firefox          libpthread-2.18.so             [.] pthread_mutex_lock
+    1,37%  firefox          firefox                        [.] arena_dalloc
+    1,27%  firefox          libpthread-2.18.so             [.] pthread_mutex_unlock
+    1,02%  firefox          firefox                        [.] arena_malloc
+    0,68%  firefox          libxul.so                      [.] PLDHashTable::SearchTable
+    0,58%  firefox          libxul.so                      [.] js::AtomizeChars<unsigned char>
+    0,55%  firefox          libxul.so                      [.] Interpret
+    0,52%  firefox          libxul.so                      [.] js::ObjectImpl::nativeLookup
+    0,49%  firefox          libc-2.18.so                   [.] __memcpy_sse2_unaligned
+    0,47%  firefox          libxul.so                      [.] NewObject
+    0,45%  firefox          p11-kit-trust.so               [.] lookup_or_create_bucket
+    0,41%  mozStorage #5    libpthread-2.18.so             [.] pthread_mutex_lock
+    0,39%  firefox          libxul.so                      [.] js::EmptyShape::getInitialShape
+    0,38%  mozStorage #5    libpthread-2.18.so             [.] pthread_mutex_unlock
+    0,35%  ImageDecoder #2  libz.so.1.2.8                  [.] inflate_fast
+    0,35%  firefox          libxul.so                      [.] mozilla::gfx::AlphaBoxBlur::BoxBlur_SSE2
+    0,34%  firefox          ld-2.18.so                     [.] do_lookup_x
+    0,34%  firefox          libxul.so                      [.] JSObject::putProperty<(js::ExecutionMode)0>
+    0,34%  firefox          libxul.so                      [.] js::ShapeTable::search
+    0,33%  firefox          libxul.so                      [.] js::baseops::GetProperty
-    0,32%  firefox          [kernel.vmlinux]               [k] clear_page_c_e
     clear_page_c_e
   - __alloc_pages_nodemask
      - 97,50% alloc_pages_vma
         - 95,75% handle_mm_fault
              __do_page_fault
              do_page_fault
            - page_fault
               - 19,82% __memcpy_sse2_unaligned
                  - 35,58% _XRead
                       _XReadPad
                       XGetImage
                       _get_image_surface
                       _cairo_xlib_surface_acquire_source_image
                       _cairo_surface_acquire_source_image
                       _pixman_image_for_pattern
                       _clip_and_composite_boxes
                       _cairo_image_surface_paint
                       _cairo_surface_paint
                       _cairo_gstate_paint
                       INT__moz_cairo_paint
                       _moz_cairo_paint_with_alpha
                       mozilla::gfx::DrawTargetCairo::DrawSurface
                       mozilla::image::imgFrame::LockImageData
                       mozilla::image::RasterImage::RequestScale
                       mozilla::image::RasterImage::OptimalImageSizeForDest
                       DrawImageInternal
                       nsLayoutUtils::DrawBackgroundImage
                       nsImageRenderer::Draw
                       nsImageRenderer::DrawBackground
                       nsCSSRendering::PaintBackgroundWithSC
                       nsCSSRendering::PaintBackground
                       nsDisplayBackgroundImage::PaintInternal
                       mozilla::FrameLayerBuilder::PaintItems
                       mozilla::FrameLayerBuilder::DrawThebesLayer
                       mozilla::layers::BasicThebesLayer::PaintBuffer
                       mozilla::layers::BasicThebesLayer::Validate
                       mozilla::layers::BasicContainerLayer::Validate
                       mozilla::layers::BasicContainerLayer::Validate
                       mozilla::layers::BasicLayerManager::EndTransactionInternal
                       nsDisplayList::PaintForFrame
                  - 22,39% js::jit::Assembler::executableCopy
                       js::jit::JitCode::copyFrom
                       js::jit::Linker::newCode<(js::AllowGC)1>
                       js::jit::ICStubCompiler::getStubCode
                       js::jit::ICCallScriptedCompiler::getStub
                       js::jit::TryAttachCallStub
                       js::jit::DoCallFallback
                       0x7f5e847ffdb0
                  - 21,73% js::NewObjectWithClassProtoCommon
                       js::jit::NewInitObject
                       js::jit::DoNewObject
                       0x7f5e84800ec4
                  + 20,30% updatewindow
               + 15,70% arena_dalloc
               + 12,82% arena_malloc
               + 12,73% js::gc::Chunk::fetchNextDecommittedArena
               + 7,31% skb_copy_datagram_iovec
               + 7,04% sse2_blt
               + 4,45% NS_CopySegmentToBuffer
               + 4,18% js::InflateString
               + 4,18% mozilla::VectorBase<js::jit::BaselineCompilerShared::ICLoadLabel, 16ul, js::SystemAllocPolicy, js::Vector<js::jit::BaselineCompilerShared::ICLoadLabel, 16ul, js::SystemAllocPolicy> >::growStorageBy
               + 4,13% mozilla::image::imgFrame::Init
               + 3,86% _cairo_image_surface_span
               + 3,78% sse2_fill
         + 4,25% do_wp_page
      + 2,50% alloc_pages_current
+    0,32%  ImageDecoder #3  libz.so.1.2.8                  [.] inflate_fast


And if you press 'V' you get the DSO name right after the symbol name:


+    0,32%  firefox          [k] clear_page_c_e
+    0,26%  firefox          [k] copy_user_enhanced_fast_string
+    0,26%  firefox          [k] page_fault
+    0,20%  firefox          [k] get_page_from_freelist
+    0,20%  firefox          [k] __list_del_entry
+    0,20%  firefox          [k] mem_cgroup_page_lruvec
+    0,16%  firefox          [k] lookup_page_cgroup_used
-    0,14%  firefox          [k] _raw_spin_lock
   - _raw_spin_lock [kernel.vmlinux]
      - 37,73% try_to_wake_up [kernel.vmlinux]
         - 64,20% wake_up_state [kernel.vmlinux]
              wake_futex [kernel.vmlinux]
              futex_wake [kernel.vmlinux]
              do_futex [kernel.vmlinux]
              sys_futex [kernel.vmlinux]
              system_call [kernel.vmlinux]
            - __lll_unlock_wake libpthread-2.18.so
                 37,39% 0x7f5e81b10400 libxul.so
                 32,07% 0x7f5e63e81bd0 unknown
               - 30,54% arena_malloc firefox
                    malloc firefox
                    nsStringBuffer::Alloc libxul.so
                    nsAString_internal::MutatePrep libxul.so
                    nsAString_internal::ReplacePrepInternal libxul.so
         + 35,80% default_wake_function [kernel.vmlinux]
      - 17,55% handle_mm_fault [kernel.vmlinux]
           __do_page_fault [kernel.vmlinux]
           do_page_fault [kernel.vmlinux]
         - page_fault [kernel.vmlinux]
            - 52,88% js::gc::Chunk::fetchNextDecommittedArena libxul.so
                 js::gc::Chunk::allocateArena libxul.so
                 js::gc::ArenaLists::allocateFromArenaInline libxul.so
                 js::gc::ArenaLists::refillFreeList<(js::AllowGC)1> libxul.so
                 js::PropertyTree::getChild libxul.so
                 JSObject::getChildProperty libxul.so
                 JSObject::addPropertyInternal<(js::ExecutionMode)0> libxul.so
                 JSObject::putProperty<(js::ExecutionMode)0> libxul.so
                 DefinePropertyOrElement<(js::ExecutionMode)0> libxul.so
                 js::DefineNativeProperty libxul.so
                 JSObject::defineGeneric libxul.so
                 js::DefineFunction libxul.so
                 JS_DefineFunctions libxul.so
                 js::GlobalObject::resolveConstructor libxul.so
                 js::GetBuiltinPrototype libxul.so
                 js::NewDenseUnallocatedArray libxul.so
                 js::XDRObjectLiteral<(js::XDRMode)1> libxul.so
                 js::XDRScript<(js::XDRMode)1> libxul.so
                 js::XDRState<(js::XDRMode)1>::codeScript libxul.so
                 JS_DecodeScript libxul.so
                 ReadCachedScript libxul.so
                 mozJSComponentLoader::ObjectForLocation libxul.so
                 mozJSComponentLoader::ImportInto libxul.so
                 mozJSComponentLoader::Import libxul.so
                 nsXPCComponents_Utils::Import libxul.so
                 NS_InvokeByIndex libxul.so
                 XPCWrappedNative::CallMethod libxul.so
                 XPC_WN_CallMethod libxul.so
                 js::Invoke libxul.so
            - 47,12% arena_dalloc firefox
                 nsTArray_base<nsTArrayFallibleAllocator, nsTArray_CopyWithMemutils>::ShiftData libxul.so
                 SnowWhiteKiller::~SnowWhiteKiller libxul.so
                 nsCycleCollector::FreeSnowWhite libxul.so
                 nsCycleCollector::Shutdown libxul.so
                 nsCycleCollector_shutdown libxul.so
                 mozilla::ShutdownXPCOM libxul.so
                 ScopedXPCOMStartup::~ScopedXPCOMStartup libxul.so
                 XREMain::XRE_main libxul.so
                 XRE_main libxul.so
                 do_main firefox
                 main firefox
                 __libc_start_main libc-2.18.so
                 _start firefox
      + 9,54% do_futex [kernel.vmlinux]

- Arnaldo
