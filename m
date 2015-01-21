From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Using perf to generate a call stack from a kernel function to
 the user space caller
Date: Wed, 21 Jan 2015 09:40:21 -0300
Message-ID: <20150121124021.GB3420@kernel.org>
References: <loom.20150120T180008-930@post.gmane.org>
 <54BEA111.9060504@hp.com>
 <loom.20150121T090925-23@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35602 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbAUMk0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Jan 2015 07:40:26 -0500
Content-Disposition: inline
In-Reply-To: <loom.20150121T090925-23@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: AKel <ankelly006@hotmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Jan 21, 2015 at 09:42:29AM +0000, AKel escreveu:
> Thanks Rick for your reply. Unfortunately I'm in the big bad corporate 
> world where a simple minion such as myself is not granted sudo access. 

That should not be a problem in most of the cases for profiling your own
apps.

> I've tried passing the callgraph (-g) flag to perf, however I can only 
> recover the call stack within the kernel, it begins at what I suspect is 

Because it will try, by default, to collect %bp (frame pointer)
callchains, which unfortunately is not usually enabled for user space
programs, that use the %bp register for other purposes.

> the kernel entry point. Ideally I could generate a complete call stack.

You can try using the DWARF CFI (Call Frame Information), by using
instead:

  $ perf record --call-graph dwarf firefox

Then, in the 'perf report' TUI, use the 'P' hotkey after expanding a few
callgraphs:

  $ perf report --no-children # expand callgraphs, press P, press q
  $ head -45 perf.hist.0  
  -    3,47%  Image Scaler     libxul.so                      [.] _ZN4skia14BGRAConvolve2DEPKhibRKNS_19ConvolutionFilter1DES4_iPhb
       _ZN4skia14BGRAConvolve2DEPKhibRKNS_19ConvolutionFilter1DES4_iPhb
       _ZN4skia15ImageOperations11ResizeBasicERK8SkBitmapNS0_12ResizeMethodEiiRK7SkIRectPv
       _ZN4skia15ImageOperations6ResizeERK8SkBitmapNS0_12ResizeMethodEiiRK7SkIRectPv
       _ZN4skia15ImageOperations6ResizeERK8SkBitmapNS0_12ResizeMethodEiiPv
       _ZN7mozilla3gfx5ScaleEPhiiiS1_iiiNS0_13SurfaceFormatE
       _ZN7mozilla5image11ScaleRunner3RunEv
       _ZN8nsThread16ProcessNextEventEbPb
       _Z19NS_ProcessNextEventP9nsIThreadb
       _ZN7mozilla3ipc28MessagePumpForNonMainThreads3RunEPN4base11MessagePump8DelegateE
       _ZN11MessageLoop3RunEv
       _ZN8nsThread10ThreadFuncEPv
       _pt_root
       start_thread
       __clone
  -    3,00%  Cache2 I/O       libc-2.18.so                   [.] __memmove_ssse3_back
     - __memmove_ssse3_back
        - 69,64% _ZN13nsTArray_ImplIPN7mozilla3net16CacheIndexRecordE27nsTArrayInfallibleAllocatorE15InsertElementAtIRKS3_EEPS3_mOT_
           - 51,91% _ZN7mozilla3net10CacheIndex29InsertRecordToExpirationArrayEPNS0_16CacheIndexRecordE
                _ZN7mozilla3net25CacheIndexEntryAutoManageD2Ev
                _ZN7mozilla3net10CacheIndex12ParseRecordsEv
                _ZN7mozilla3net10CacheIndex10OnDataReadEPNS0_15CacheFileHandleEPc12tag_nsresult
                _ZN7mozilla3net9ReadEvent3RunEv
                _ZN7mozilla3net13CacheIOThread12LoopOneLevelEj
                _ZN7mozilla3net13CacheIOThread10ThreadFuncEv
                _ZN7mozilla3net13CacheIOThread10ThreadFuncEPv
                _pt_root
                start_thread
                __clone
           - 48,09% _ZN7mozilla3net10CacheIndex27InsertRecordToFrecencyArrayEPNS0_16CacheIndexRecordE
                _ZN7mozilla3net25CacheIndexEntryAutoManageD2Ev
                _ZN7mozilla3net10CacheIndex12ParseRecordsEv
                _ZN7mozilla3net10CacheIndex10OnDataReadEPNS0_15CacheFileHandleEPc12tag_nsresult
                _ZN7mozilla3net9ReadEvent3RunEv
                _ZN7mozilla3net13CacheIOThread12LoopOneLevelEj
                _ZN7mozilla3net13CacheIOThread10ThreadFuncEv
                _ZN7mozilla3net13CacheIOThread10ThreadFuncEPv
                _pt_root
                start_thread
                __clone
        + 30,36% _ZN13nsTArray_ImplIPN7mozilla3net16CacheIndexRecordE27nsTArrayInfallibleAllocatorE13RemoveElementIS3_19nsDefaultComparatorIS3_S3_EEEbRKT_RKT0_.isra.60
  +    1,79%  firefox          libz.so.1.2.8                  [.] inflate_fast
  +    1,76%  Cache2 I/O       libxul.so                      [.] _ZN13nsTArray_ImplIPN7mozilla3net16CacheIndexRecordE27nsTArrayInfallibleAllocatorE13RemoveElementIS3_19nsDefaultComparatorIS3_S3_EEEbRKT_RKT0_.isra.60
  +    1,39%  firefox          libpthread-2.18.so             [.] pthread_mutex_lock
  +    1,37%  firefox          firefox                        [.] arena_dalloc
  $ 


These C++ methods that needs unmangling, and I have the firefox-debuginfo
package matching the binary... Have to check this.

Anyway, either you have your binaries (your main binary and the libraries it
uses) built with -fno-omit-frame-pointer, like the kernel is, and then you can
use '-g', that, in its default form is equivalent to '--call-graph fp', or you
will have to ask that the kernel collects stack dumps to then use CFI to do the
callchains, i.e. use '--call-graph dwarf'.

You may want to state how much stack is collected when using --call-graph dwarf,
please look at the 'record' help:

  -g                    enables call-graph recording
      --call-graph <mode[,dump_size]>
                        setup and enables call-graph (stack chain/backtrace)
                        recording: fp dwarf

Ah, here is another example, this time crossing from kernel to userspace, all the way
back from a spin lock operation to the memory allocation routines used by
firefox, after I pressed -> and zoomed into the kernel DSO:

[acme@zoo linux]$ head -50 perf.hist.1 
+    0,32%  firefox          [k] clear_page_c_e
+    0,26%  firefox          [k] copy_user_enhanced_fast_string
+    0,26%  firefox          [k] page_fault
+    0,20%  firefox          [k] get_page_from_freelist
+    0,20%  firefox          [k] __list_del_entry
+    0,20%  firefox          [k] mem_cgroup_page_lruvec
+    0,16%  firefox          [k] lookup_page_cgroup_used
-    0,14%  firefox          [k] _raw_spin_lock
   - _raw_spin_lock
      - 37,73% try_to_wake_up
         - 64,20% wake_up_state
              wake_futex
              futex_wake
              do_futex
              sys_futex
              system_call
            - __lll_unlock_wake
                 37,39% 0x7f5e81b10400
                 32,07% 0x7f5e63e81bd0
               - 30,54% arena_malloc
                    malloc
                    _ZN14nsStringBuffer5AllocEm
                    _ZN18nsAString_internal10MutatePrepEjPPDsPj
                    _ZN18nsAString_internal19ReplacePrepInternalEjjjj
         + 35,80% default_wake_function
      - 17,55% handle_mm_fault
           __do_page_fault
           do_page_fault
         - page_fault
            + 52,88% _ZN2js2gc5Chunk25fetchNextDecommittedArenaEv
            - 47,12% arena_dalloc
                 _ZN13nsTArray_baseI25nsTArrayFallibleAllocator25nsTArray_CopyWithMemutilsE9ShiftDataEmmmmm
                 _ZN15SnowWhiteKillerD2Ev
                 _ZN16nsCycleCollector13FreeSnowWhiteEb
                 _ZN16nsCycleCollector8ShutdownEv
                 _Z25nsCycleCollector_shutdownv
                 _ZN7mozilla13ShutdownXPCOMEP17nsIServiceManager
                 _ZN18ScopedXPCOMStartupD2Ev
                 _ZN7XREMain8XRE_mainEiPPcPK12nsXREAppData
                 XRE_main
                 _ZL7do_mainiPPcP7nsIFile
                 main
                 __libc_start_main
                 _start
      + 9,54% do_futex
      + 9,36% do_cow_fault
      + 9,33% tick_do_update_jiffies64
      + 8,72% futex_wait_setup
      + 7,62% unix_stream_recvmsg
+    0,14%  firefox          [k] mem_cgroup_begin_page_stat
[acme@zoo linux]$

- Arnaldo
