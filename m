Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30161EE7BE
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Apr 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099521; cv=none; b=sL6bDUx2D2To0kVSQtnXQ8/CTIxmjgw7ZgkTOH88cOZBAxheLL95xgf3EdiSbsDQTTowbLnZcErBaYrzLyYxXQ9kvJR8uvWwUlFlcwJ8zcP70x9xbQg6TMCXHcLUXHxF8dsWIuU8WhXacgj7bt1xvzrc/WBkF4cW6fi7CrltuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099521; c=relaxed/simple;
	bh=G0pFuGLNRqQFjLwvMbaUWrEQ5mfT75f5UDxch2PSrzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDnKTD71cqaye0GZjVHDC0jz/IFEN0aywAkbunHuJpf/dEB1rotWJiX8PNuTAtZX+T41pRoRGMYA1M3Mca2iawDcyhoJx1d+ee8pWBGM4nC0OaCi+f1dSJJGt5lGathBtD9xrMH1ueg4Y9lFgs/WYFCS4/GL3b7J25lJQZThovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM3k6IJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM3k6IJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F344CC4CEE5;
	Tue,  8 Apr 2025 08:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744099520;
	bh=G0pFuGLNRqQFjLwvMbaUWrEQ5mfT75f5UDxch2PSrzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM3k6IJ+EBguO4m/w0rB265iMeyAY/R4RE/pCVd/OhqoQTobPguw58NmElcQGn0rh
	 EJTye5WF/7NWBgATGq0mkn68uRIYT7FpUDxaQCldIksinajCx0lIsC1PvK0jswca5k
	 bNu8drMUYDWz5s2S/pbDDLeG5OSJAK29kRQTfTgZSbBnSWsQ2VPlwI7rNt4NUvsKm+
	 QOuSuuPcY4RIGCqQM6I5itENcd62G3+0ZOmsQO8GbUptLpvvNIfTz1HoNhCPfM3wo5
	 aQsuPPwMsK/dMtrk4/EmIB0PS5OyiZo3i5LDc4w6SyWS+xs/yjVyyY1/CK7x9nxl0L
	 J9jztCgnz35Qg==
Date: Tue, 8 Apr 2025 10:05:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_TYux5fUg2pW-pF@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_Rz10stoLzBocIO@x1>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> So, with a patch I have (attached) here this turns into:
> 
> ⬢ [acme@toolbox perf-tools-next]$ perf check feature libunwind
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
> ⬢ [acme@toolbox perf-tools-next]$

I can confirm that on one system with your fix applied there's no 'OFF' 
entry anymore:

...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

But on another, similar Ubuntu system I still get:

...                               libunwind: [ OFF ]

  kepler:~/tip> dpkg -l | grep -E 'capstone|unwind|libdw'
  ii  libcapstone-dev:amd64                                       4.0.2-5.1build1                                     amd64        lightweight multi-architecture disassembly framework - devel files
  ii  libcapstone4:amd64                                          4.0.2-5.1build1                                     amd64        lightweight multi-architecture disassembly framework - library
  ii  libdw-dev:amd64                                             0.191-2ubuntu0.1                                    amd64        libdw1t64 development libraries and header files
  ii  libdw1t64:amd64                                             0.191-2ubuntu0.1                                    amd64        library that provides access to the DWARF debug information
  ii  libunwind-dev:amd64                                         1.6.2-3.1                                           amd64        library to determine the call-chain of a program - development
  ii  libunwind8:amd64                                            1.6.2-3.1                                           amd64        library to determine the call-chain of a program - runtime

And I have your fix applied:

 kepler:~/tip> git diff --stat
  tools/perf/builtin-check.c   | 27 +++++++++++----------------
  tools/perf/builtin-version.c | 30 +-----------------------------
  tools/perf/builtin.h         | 10 ++++++++++
  3 files changed, 22 insertions(+), 45 deletions(-)

  kepler:~/tip> perf check feature libunwind
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )

> The annotate case is unrelated from what I can see, the preference 
> for the disassembler (libcapstone, libllvm or the old method of 
> parsing objdump output) has to start with the most capable, and the 
> source code part shows that the current order isn't the best, I'll 
> continue the investigation/tests tomorrow and will come up with a 
> series of patches for the problems reported.

But I was able to test the annotation behavior with 
annotate.disassemblers=objdump:

> For reference, from 'perf-config' man page:
> 
> annotate.*::
>         These are in control of addresses, jump function, source code
>         in lines of assembly code from a specific program.
> 
>         annotate.disassemblers::
>                 Choose the disassembler to use: "objdump", "llvm",  "capstone",
>                 if not specified it will first try, if available, the "llvm" one,
>                 then, if it fails, "capstone", and finally the original "objdump"
>                 based one.
> 
>                 Choosing a different one is useful when handling some feature that
>                 is known to be best support at some point by one of the options,
>                 to compare the output when in doubt about some bug, etc.
> 
>                 This can be a list, in order of preference, the first one that works
>                 finishes the process.
> 
> A quick test here with perf top without setting the above ends up with
> the behaviour that Ingo reported, no source code is shown and 's'
> doesn't work. Then if I set it to use objdump:
> 
> root@number:~# perf config annotate.disassemblers=objdump
> root@number:~# perf config annotate.disassemblers
> annotate.disassemblers=objdump
> root@number:~# cat ~/.perfconfig 
> # this file is auto-generated.
> [annotate]
> 	disassemblers = objdump
> root@number:~#
> 
> It takes longer to show the annotated output but there is source code
> and 's' works.

I can confirm that this works around the annotation bug, and I can also 
confirm that objdump is pretty slow, 'perf top' just appears to hang 
for many seconds. :-)

BTW., if objdump source-annotation is the best output we have right 
now, then it would be nice to somehow visually distinguish source code 
versus disassembly. Right now it's all the same color and flows 
together on the screen. Maybe we could gray out source code lines or 
so?

Also, the source code appears to lose its horizontal indentation 
levels:

   0.25          sub    $0xffffffff8495b8a0,%rax
   0.20          sar    $0x3,%rax 
   0.22          imul   %rdx,%rax 
               __debug_atomic_inc(lock_class_ops[idx]);
   0.59          movslq %eax,%rbx 
   0.38          incq   %gs:-0x7b9433f8(,%rbx,8)
                 
               class_idx = class - lock_classes;
                 
               if (depth && !sync) {
               /* we're holding locks and the new held lock is not a sync */
               hlock = curr->held_locks + depth - 1;
   0.39          mov    oops_in_progress,%edx
               class_idx = class - lock_classes;
   0.26          mov    0xeb8(%r14),%ecx
   0.25          mov    %ecx,(%rsp)
               hlock = curr->held_locks + depth - 1;
   0.25          test   %edx,%edx 
               ↓ jne    c3        
   0.26          cmp    $0x2f,%ecx
   0.00        ↓ ja     fc7       
               if (!references)
               references++;
                 
               if (!hlock->references)
               hlock->references++;
                 
   0.26    c3:   mov    (%rsp),%ecx
   0.26          lea    0x0(,%rcx,8),%r10
   0.13          mov    %rcx,%rsi 
   0.26          sub    %rcx,%r10 
   0.26          lea    0xec0(%r14),%rcx
   0.13          shl    $0x3,%r10 
               if (!hlock->references)

I suspect a lot of the formatting is up to objdump, but we should at 
least be able to print all out extra 's' output a visually more 
distinctive fashion?

But if we had full control over annotation output, I think a popular 
annotation output style would be to leave the original source code 
formatting and indentation.

Finally, here's a higher level UI design discussion of current perf 
top/report behavior:

perf top/report IMHO frequently violates core principles of good TUI 
interfaces:

  - There's no guaranteed feedback on keypresses:

     - If I press an unbound key it just ignores it, and I keep 
       wondering whether I mis-typed, misremembered the key binding, 
       whether the keybinding doesn't work, or wether it's a keybinding 
       with 'silent' behavior.

     - There are keybindings with 'silent' behavior: for example 'P' 
       (print current annotation) doesn't update anything in the status 
       line. A good TUI would do that, and it would also show something 
       visible on repeat keypresses of the same key.

     - Basically I consider it an UI bug if the tool does not give me 
       visual feedback on *any* keypress. If a user types something, 
       it's very much intended: arrow keys move up and down or 
       enter/exit functions, 'q' will quit, etc. There's *always* 
       expected behavior when a user presses a key - and it's basically 
       an UI bug if that is ignored for any reason.

  - On long processing steps sometimes there's no progress bar, the 
    tool just 'hangs'. In some cases this is implemented: such as the 
    initial parsing of perf.data. In others it's not: such as the 
    objdump annotation output. (Which is default-off, so this isn't 
    really a bugreport.)

  - Sometimes there's nonsensical UI flows with non-intuitive outcomes. 
    An example I noticed is the 'zoom in' behavior in perf report/top:

     - If in the default 'perf report' starting screen of a short 
       profiling session I enter into a function name on the screen, I 
       get these choices:

                Annotate file_cache_slot::get_next_line(char**, long*)
                Zoom into cc1 thread
                Zoom into cc1 DSO (use the 'k' hotkey to zoom directly into the kernel)
                Browse map details
                Run scripts for samples of symbol [file_cache_slot::get_next_line(char**, long*)]
                Run scripts for all samples
                Switch to another data file in PWD
                Exit

     - If I press 'Zoom into cc1 thread', I get into some sort of 
       filtered mode I am unable to exit via intuitive ways. There's no 
       on-screen hint to make it go away, I have to exit the tool and 
       restart it entirely to get back to the main profiling screen again 
       ... which is obviously a suboptimal UI flow.

     - To make matters worse, the 'h' screen gives me this hint:

             ESC           Zoom out

       except it doesn't appear to be working, my profiling output is 
       still limited to cc1 entries.

     - The *only* way I found to zoom out into the general screen again 
       was to press 'm' for the 'context menu' (I found this not 
       because it was named intuitively, but because I trial-error 
       brute forced the UI keybindings), and there it had:

             Zoom out of cc1 thread

     - Yay! But very unintuitive. The intuitive step would have been 
       the left arrow key BTW. (with restoring the cursor position to 
       the cc1 entry I pressed 'Enter' on originally), but that doesn't 
       do anything, it gets ignored. Also, a status line printout that 
       we are filtered to cc1, and how to exit that mode, would be nice 
       as well.

  - [ Sub-bugreport: at higher levels the 'P' keybinding doesn't print 
      the current screen like on the annotation screen, it goes back a 
      level. Guess how I found out. ;-)

      To be able to quote the above context menu screen, I copy-pasted 
      the ncurses lines, and manually edited out all the non-printable 
      characters unsuitable for emails. ]

I genuinely believe that these "basic profiling workflow" details are 
*FAR* more important to perf usability and perf popularity than pretty 
much any of the more esoteric hardware features, scalability 
enhancements and niche tools I see almost daily progress on - and these 
basic workflow details affect *everyone* who uses perf...

Thanks,

	Ingo
