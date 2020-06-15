From: Ian Rogers <irogers@google.com>
Subject: Re: Perf Script Erroneous User Stack Trace
Date: Mon, 15 Jun 2020 13:53:34 -0700
Message-ID: <CAP-5=fUM3r=QmUus9vh=QfNj+dRMwJoOe86ftdc4=Kg0fM7q-g@mail.gmail.com>
References: <816cb5f558cd0e528812dff2168ef4ca@ut.ac.ir> <20200615163145.458bd878@oasis.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20200615163145.458bd878@oasis.local.home>
Sender: linux-trace-users-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>, Linux-trace Users <linux-trace-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jun 15, 2020 at 1:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 14 Jun 2020 18:13:21 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
>
> > Hi,
> >
> > I used the following command to sample backtraces for a simple "ffmpeg"
> > benchmark:
> > sudo perf record -d --call-graph dwarf,65528 -c 1000000 -e
> > mem_load_uops_retired.l3_miss:u ffmpeg -i
> > /media/ahmad/DATA/Videos/video.mp4 -threads 1 -vf spp out.mp4
> >
> > As can be seen PEBS is not used, the stack size is set to the maximum
> > and the sampling period is quite large. I also limited the thread count,
> > but this is the first portion of "perf script --no-demangle" output:
> > ffmpeg 11750  6670.061261:    1000000 mem_load_uops_retired.l3_miss:u:
> >               0         5080021 N/A|SNP N/A|TLB N/A|LCK N/A
> >          7fffeab68844 x264_pixel_avg_w16_avx2+0x4
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >
> > ffmpeg 11750  6670.274835:    1000000 mem_load_uops_retired.l3_miss:u:
> >               0         5080021 N/A|SNP N/A|TLB N/A|LCK N/A
> >          7fffeab68844 x264_pixel_avg_w16_avx2+0x4
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >
> > ffmpeg 11750  6670.496159:    1000000 mem_load_uops_retired.l3_miss:u:
> >               0         5080021 N/A|SNP N/A|TLB N/A|LCK N/A
> >          7fffeab8ef89 x264_pixel_sad_x4_16x16_avx2+0x49
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >
> > ffmpeg 11750  6670.852598:    1000000 mem_load_uops_retired.l3_miss:u:
> >               0         5080021 N/A|SNP N/A|TLB N/A|LCK N/A
> >          7fffeaac97b3 pixel_memset+0x293 (inlined)
> >          7fffeaac97b3 plane_expand_border+0x293 (inlined)
> >          7fffeaac97b3 x264_frame_expand_border_filtered+0x293
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab463bc x264_fdec_filter_row+0x69c
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab49523 x264_slice_write+0x1873
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab85285 x264_stack_align+0x15
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab45bdb x264_slices_write+0xfb
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          5555561e3d87 [unknown] ([heap])
> >
> > ffmpeg 11750  6671.110007:    1000000 mem_load_uops_retired.l3_miss:u:
> >               0         5080021 N/A|SNP N/A|TLB N/A|LCK N/A
> >          7fffeab6cdde x264_frame_init_lowres_core_avx2+0x8e
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >
> > ffmpeg 11750  6671.463562:    1000000 mem_load_uops_retired.l3_miss:u:
> >               0         5080021 N/A|SNP N/A|TLB N/A|LCK N/A
> >          7fffeaabf806 x264_macroblock_load_pic_pointers+0x886 (inlined)
> >          7fffeaabf806 x264_macroblock_cache_load+0x886 (inlined)
> >          7fffeaabf806 x264_macroblock_cache_load_progressive+0x886
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab49204 x264_slice_write+0x1554
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab85285 x264_stack_align+0x15
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >          7fffeab45bdb x264_slices_write+0xfb
> > (/usr/lib/x86_64-linux-gnu/libx264.so.152)
> >                    1c [unknown] ([unknown])
> >
> > None of the backtraces are correct. Because none of them begin with
> > "__start" or "__GI___clone". I also used "LBR", instead. But it has more
> > size constraints and, therefore, not suitable. The important thing to
> > note is that the problem occurs only with user space events (and for all
> > events that I checked). I do not think that the problem is with
> > DebugInfo. Because I manually used "perf_event_open()" system call
> > (without using "Perf") and the problem was still there (with raw
> > callstack IPs).
> >
> > Therefore, I assumed that the problem is inside the kernel. Precisely,
> > it should be where the userspace callchain is extracted or dumped. I
> > looked for the latter (i.e., the callchain dump implementation) and it
> > seemed to be here:
> > https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L6786
> >
> > But I could not (or, equivalently, did not know how to) view the user
> > callchain instruction pointers.
> > Am I on the right track? Does anybody know the kernel mechanism for
> > extracting userspace callchains?

Hi Ahmad,

a lot of ffmpeg is hand written assembly such as:
https://github.com/FFmpeg/FFmpeg/blob/master/libavresample/x86/audio_convert.asm
For this to work with dwarf unwinding it needs to have call frame information:
https://sourceware.org/binutils/docs/as/CFI-directives.html

Thanks,
Ian

> > Please accept my apology for my frequent questions. I tried to get
> > around the problem, myself, but it has taken more than three complete
> > days and I'm stuck!
> > I really appreciate any suggestions.
>
> No problem, but please note that perf questions are more likely to be
> answered via: linux-perf-users@vger.kernel.org and not
> linux-trace-users. As linux-trace-users are more for ftrace and not
> perf.
>
> -- Steve
