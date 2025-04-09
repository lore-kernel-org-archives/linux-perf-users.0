Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427514AEE2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165438; cv=none; b=JdUx+prYVoQlrJBcFb+Zf6ZYjKVzAynss1mQ2jTV8JYs1WBhUiktgXqmR8pcvYzeC9EBnF51qRmwqZu8biPad5bm55ihFXlPozr2Ygq8VNh6IQ2h+b+fix8g1a2eHU2wUkfAtsSUF1gVFXVcXi0I5y58uU11nYDbwrDUf+a1uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165438; c=relaxed/simple;
	bh=MoqGy/3HXLRwu+afsbY63vlYvA0nZGumcIH0ec0ZPMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMB8x0WA4f8Zrn9+W5+gw9v/VPSPaI0VPtSkSeIzonwjWFr45IKW28hq1Wz/56qtARa2ZutjZDZuWD0I8xqAgoUZ5Su+uT5819rxDzEL2K5BSmO8/XWYV6rX6h56fprsvHSaZ/9EreuVvir7wuzUWe+nQp6BiEYmpRCuOPsR644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1JH5n6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1JH5n6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DDDC4CEE5;
	Wed,  9 Apr 2025 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744165437;
	bh=MoqGy/3HXLRwu+afsbY63vlYvA0nZGumcIH0ec0ZPMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1JH5n6rnZDNMMZhewke6oy+Ti+L/IcjHBIdsAzosnkuciOnPNysu2ICkNfpqj997
	 enTOR3LEevRfoo5nNyTHsIpf4hAv+Q9PeG6rlt/kXtIkdyDLhz6j4oAm4791yHWxHX
	 YlkWVVHzVTymb65c2Uxuvbfzz3znlfBY1DoMw0yMwtcg9VlX/tX8A4bldkdnFr36z8
	 Qvtowk+ccqAHNFGFFh5aKlZkePw4xDmZQg93bjhdcwkbIyMwz6G2IiqIWEmPTDaGoW
	 hMGG98dHsVNxk6TJk2OMW1q5YZw9azGP0x1jWmWAJdKIxAbDrQ2iamSjefvj3RkYT8
	 etMr1VYxmmnZA==
Date: Tue, 8 Apr 2025 23:23:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_XaOp4TCBKe-M0o@x1>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_TYux5fUg2pW-pF@gmail.com>

On Tue, Apr 08, 2025 at 10:05:15AM +0200, Ingo Molnar wrote:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > So, with a patch I have (attached) here this turns into:

> > ⬢ [acme@toolbox perf-tools-next]$ perf check feature libunwind
> >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
> > ⬢ [acme@toolbox perf-tools-next]$

> I can confirm that on one system with your fix applied there's no 'OFF' 
> entry anymore:
 
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
> But on another, similar Ubuntu system I still get:
> 
> ...                               libunwind: [ OFF ]

Ok, I'm not being able to reproduce this, will try again in more
systems, but can you please take a look at what I've made available at
the perf-annotate+build branch in my tree at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-annotate+build

What is there now:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline v6.15-rc1..
6b4e380deb02de46 (HEAD -> perf-tools-next) perf ui browser annotate: Don't show the source code view status initially
befd9928ac3b0914 perf ui browser annotate: Show in the title the source code view toggle
6c557247d907487e perf ui browser map: Provide feedback on unhandled hotkeys
dcee76bd1ef37cd5 perf ui browser hists: Provide feedback on unhandled hotkeys
7cd3b61be22b6111 perf ui browser header: Provide feedback on unhandled hotkeys
4226b944d6cfec62 perf ui browser annotate: Provide feedback on unhandled hotkeys
96f43ea8e198b9cd perf ui browser annotate-data: Provide feedback on unhandled hotkeys
1101a930a674936a perf ui browser: Add a warn on unhandled hotkey helper
bdd6ce8eb8c2f2f7 perf ui browser: Add key_name() helper
65185f2cf7af5026 tools build: Don't show libbfd build status as it is opt-in
33da8804f7c00056 perf check: Add tip about building with libbfd using BUILD_NONDISTRO=1
da4de82814f54c6c perf build: Warn when libdebuginfod devel files are not available
d5f1c3eb842aaafe tools build: Don't show libunwind build status as it is opt-in
6cf8fa4dcce720f9 perf check: Allow showing a tip for opt-in features not built into perf
07f8bc136355d09a perf check: Move the FEATURE_STATUS() macro to its only user source file
a3fb01a0d062d9f4 perf check: Share the feature status printing routine with 'perf version'
c2bc1a34f2488b7f tools build: Don't set libunwind as available if test-all.c build succeeds
⬢ [acme@toolbox perf-tools-next]$

Please see below for further commentary.

>   kepler:~/tip> dpkg -l | grep -E 'capstone|unwind|libdw'
>   ii  libcapstone-dev:amd64                                       4.0.2-5.1build1                                     amd64        lightweight multi-architecture disassembly framework - devel files
>   ii  libcapstone4:amd64                                          4.0.2-5.1build1                                     amd64        lightweight multi-architecture disassembly framework - library
>   ii  libdw-dev:amd64                                             0.191-2ubuntu0.1                                    amd64        libdw1t64 development libraries and header files
>   ii  libdw1t64:amd64                                             0.191-2ubuntu0.1                                    amd64        library that provides access to the DWARF debug information
>   ii  libunwind-dev:amd64                                         1.6.2-3.1                                           amd64        library to determine the call-chain of a program - development
>   ii  libunwind8:amd64                                            1.6.2-3.1                                           amd64        library to determine the call-chain of a program - runtime
> 
> And I have your fix applied:
> 
>  kepler:~/tip> git diff --stat
>   tools/perf/builtin-check.c   | 27 +++++++++++----------------
>   tools/perf/builtin-version.c | 30 +-----------------------------
>   tools/perf/builtin.h         | 10 ++++++++++
>   3 files changed, 22 insertions(+), 45 deletions(-)
> 
>   kepler:~/tip> perf check feature libunwind
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )

Tried on a raspberry pi5 16 16gb with:

acme@raspberrypi:~/git/perf-tools-next $ head /etc/os-release 
PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
acme@raspberrypi:~/git/perf-tools-next $

acme@raspberrypi:~/git/perf-tools-next $ dpkg -l | grep -E 'capstone|unwind|libdw'
ii  libcapstone-dev:arm64                 4.0.2-5                             arm64        lightweight multi-architecture disassembly framework - devel files
ii  libcapstone4:arm64                    4.0.2-5                             arm64        lightweight multi-architecture disassembly framework - library
ii  libdw-dev:arm64                       0.188-2.1                           arm64        libdw1 development libraries and header files
ii  libdw1:arm64                          0.188-2.1                           arm64        library that provides access to the DWARF debug information
ii  libunwind-16:arm64                    1:16.0.6-15~deb12u1                 arm64        production-quality unwinder
ii  libunwind-dev:arm64                   1.6.2-3                             arm64        library to determine the call-chain of a program - development
ii  libunwind8:arm64                      1.6.2-3                             arm64        library to determine the call-chain of a program - runtime
acme@raspberrypi:~/git/perf-tools-next $

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     /tmp/build/perf-tools-next/common-cmds.h
  PERF_VERSION = 6.15.rc1.g6b4e380deb02

And then:

acme@raspberrypi:~/git/perf-tools-next $ perf check feature libunwind
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
acme@raspberrypi:~/git/perf-tools-next $

Ok, lemme try following the tip provided:

acme@raspberrypi:~/git/perf-tools-next $ make -k CORESIGHT=1 LIBUNWIND=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
<SNIP>
Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  CC      /tmp/build/perf-tools-next/libperf/core.o
  INSTALL libapi_headers
  INSTALL libsubcmd_headers
  INSTALL libsymbol_headers
<SNIP>
  CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
util/unwind-libunwind-local.c: In function ‘read_unwind_spec_debug_frame’:
util/unwind-libunwind-local.c:374:56: error: expected ‘)’ before ‘{’ token
  374 |                 if (dso__data_get_fd(dso, machine, &fd) {
      |                    ~                                   ^~
      |                                                        )
util/unwind-libunwind-local.c:423:9: error: expected expression before ‘}’ token
  423 |         }
      |         ^
util/unwind-libunwind-local.c: At top level:
util/unwind-libunwind-local.c:198:12: error: ‘elf_section_offset’ defined but not used [-Werror=unused-function]
  198 | static u64 elf_section_offset(int fd, const char *name)
      |            ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/build/perf-tools-next/util/unwind-libunwind-local.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[2]: *** [Makefile.perf:798: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
acme@raspberrypi:~/git/perf-tools-next $ 

So now I find a bug (I think I fixed this at some point but the patch
didn't get merged? Seems simple enough:

acme@raspberrypi:~/git/perf-tools-next $ vim tools/perf/util/unwind-libunwind-local.c
acme@raspberrypi:~/git/perf-tools-next $ git diff
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 9fb2c1343c7f..0b037e7389a0 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -371,7 +371,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
         *    has to be pointed by symsrc_filename
         */
        if (ofs == 0) {
-               if (dso__data_get_fd(dso, machine, &fd) {
+               if (dso__data_get_fd(dso, machine, &fd)) {
                        ofs = elf_section_offset(fd, ".debug_frame");
                        dso__data_put_fd(dso);
                }
acme@raspberrypi:~/git/perf-tools-next $

acme@raspberrypi:~/git/perf-tools-next $ perf check feature libunwind
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
acme@raspberrypi:~/git/perf-tools-next $

Seems to work:

acme@raspberrypi:~/git/perf-tools-next $ ldd ~/bin/perf | grep -i -E 'capstone|unwind|llvm'
	libunwind.so.8 => /lib/aarch64-linux-gnu/libunwind.so.8 (0x00007ffec89c0000)
	libunwind-aarch64.so.8 => /lib/aarch64-linux-gnu/libunwind-aarch64.so.8 (0x00007ffec8960000)
	libLLVM-14.so.1 => /lib/aarch64-linux-gnu/libLLVM-14.so.1 (0x00007ffec1180000)
	libcapstone.so.4 => /lib/aarch64-linux-gnu/libcapstone.so.4 (0x00007ffec0740000)
acme@raspberrypi:~/git/perf-tools-next$
 
> > The annotate case is unrelated from what I can see, the preference 
> > for the disassembler (libcapstone, libllvm or the old method of 
> > parsing objdump output) has to start with the most capable, and the 
> > source code part shows that the current order isn't the best, I'll 
> > continue the investigation/tests tomorrow and will come up with a 
> > series of patches for the problems reported.
 
> But I was able to test the annotation behavior with 
> annotate.disassemblers=objdump:
 
> > For reference, from 'perf-config' man page:
> > 
> > annotate.*::
> >         These are in control of addresses, jump function, source code
> >         in lines of assembly code from a specific program.
> > 
> >         annotate.disassemblers::
> >                 Choose the disassembler to use: "objdump", "llvm",  "capstone",
> >                 if not specified it will first try, if available, the "llvm" one,
> >                 then, if it fails, "capstone", and finally the original "objdump"
> >                 based one.
> > 
> >                 Choosing a different one is useful when handling some feature that
> >                 is known to be best support at some point by one of the options,
> >                 to compare the output when in doubt about some bug, etc.
> > 
> >                 This can be a list, in order of preference, the first one that works
> >                 finishes the process.
> > 
> > A quick test here with perf top without setting the above ends up with
> > the behaviour that Ingo reported, no source code is shown and 's'
> > doesn't work. Then if I set it to use objdump:
> > 
> > root@number:~# perf config annotate.disassemblers=objdump
> > root@number:~# perf config annotate.disassemblers
> > annotate.disassemblers=objdump
> > root@number:~# cat ~/.perfconfig 
> > # this file is auto-generated.
> > [annotate]
> > 	disassemblers = objdump
> > root@number:~#
> > 
> > It takes longer to show the annotated output but there is source code
> > and 's' works.
 
> I can confirm that this works around the annotation bug, and I can also 
> confirm that objdump is pretty slow, 'perf top' just appears to hang 
> for many seconds. :-)

Note, it is possible to do source code annotation with at least the llvm
one, I did investigate it but the developer that contributed the llvm
didn't had time to work on it, see the analysis in my message:

https://lore.kernel.org/all/ZzT6fjDSUlPzUt0U@x1/T/#u

I.e. llvm-objdump _has_ it:

-S, --source             Intermix source code with disassembly

I describe in that message how to use it, etc, haven't tried to check if
it is faster than using binutils' objdump :-\

You can try with:

⬢ [acme@toolbox perf-tools-next]$ perf annotate -h objdump

 Usage: perf annotate [<options>]

        --objdump <path>  objdump binary to use for disassembly and annotations

⬢ [acme@toolbox perf-tools-next]$

The message has more details.
 
> BTW., if objdump source-annotation is the best output we have right 
> now, then it would be nice to somehow visually distinguish source code 
> versus disassembly. Right now it's all the same color and flows 
> together on the screen. Maybe we could gray out source code lines or 
> so?

I'll try something like I did a long time ago in an attempt I plan to
revisit in showing what parts of functions are inline expansions, see
this screen shot from those times:

http://oldvger.kernel.org/~acme/perf/inline_annotate/ipt_do_table.png
https://web.git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/inline_annotate
 
> Also, the source code appears to lose its horizontal indentation 
> levels:
> 
>    0.25          sub    $0xffffffff8495b8a0,%rax
>    0.20          sar    $0x3,%rax 
>    0.22          imul   %rdx,%rax 
>                __debug_atomic_inc(lock_class_ops[idx]);
>    0.59          movslq %eax,%rbx 
>    0.38          incq   %gs:-0x7b9433f8(,%rbx,8)
>                  
>                class_idx = class - lock_classes;
>                  
>                if (depth && !sync) {
>                /* we're holding locks and the new held lock is not a sync */
>                hlock = curr->held_locks + depth - 1;
>    0.39          mov    oops_in_progress,%edx
>                class_idx = class - lock_classes;
>    0.26          mov    0xeb8(%r14),%ecx
>    0.25          mov    %ecx,(%rsp)
>                hlock = curr->held_locks + depth - 1;
>    0.25          test   %edx,%edx 
>                ↓ jne    c3        
>    0.26          cmp    $0x2f,%ecx
>    0.00        ↓ ja     fc7       
>                if (!references)
>                references++;
>                  
>                if (!hlock->references)
>                hlock->references++;
>                  
>    0.26    c3:   mov    (%rsp),%ecx
>    0.26          lea    0x0(,%rcx,8),%r10
>    0.13          mov    %rcx,%rsi 
>    0.26          sub    %rcx,%r10 
>    0.26          lea    0xec0(%r14),%rcx
>    0.13          shl    $0x3,%r10 
>                if (!hlock->references)
> 
> I suspect a lot of the formatting is up to objdump, but we should at 
> least be able to print all out extra 's' output a visually more 
> distinctive fashion?

I think that objdump just keeps whatever indentation is in the original
source code, it just picks it from what is in DWARF, just like 'perf
probe' does, etc:

root@number:~# perf probe -L icmp_rcv | head -20
<icmp_rcv@/root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/source-d5d23b89-#usr#src#debug#kernel-6.13.9#linux-6.13.9-100.fc40.x86_64#net#ipv4#icmp.c:0>
      0  int icmp_rcv(struct sk_buff *skb)
         {
      2  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
         	struct rtable *rt = skb_rtable(skb);
         	struct net *net = dev_net_rcu(rt->dst.dev);
         	struct icmphdr *icmph;
         
         	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
      8  		struct sec_path *sp = skb_sec_path(skb);
      9  		int nh;
         
         		if (!(sp && sp->xvec[sp->len - 1]->props.flags &
         				 XFRM_STATE_ICMP)) {
         			reason = SKB_DROP_REASON_XFRM_POLICY;
         			goto drop;
         		}
         
     17  		if (!pskb_may_pull(skb, sizeof(*icmph) + sizeof(struct iphdr)))
         			goto drop;
root@number:~#

The instruction part is completely parsed out from the objdump -dS
output and put into internal representation that then was reused to get
the disassembly from libcapstone and libllvm, no parsing from some tool.

So I think we can adjust things and get something better, will check.
 
> But if we had full control over annotation output, I think a popular 
> annotation output style would be to leave the original source code 
> formatting and indentation.
> 
> Finally, here's a higher level UI design discussion of current perf 
> top/report behavior:
> 
> perf top/report IMHO frequently violates core principles of good TUI 
> interfaces:
> 
>   - There's no guaranteed feedback on keypresses:
 
>      - If I press an unbound key it just ignores it, and I keep 
>        wondering whether I mis-typed, misremembered the key binding, 
>        whether the keybinding doesn't work, or wether it's a keybinding 
>        with 'silent' behavior.

Look at the branch above, there are still things do do, but I'm making
progrsess.
 
>      - There are keybindings with 'silent' behavior: for example 'P' 
>        (print current annotation) doesn't update anything in the status 
>        line. A good TUI would do that, and it would also show something 
>        visible on repeat keypresses of the same key.

That is now the behaviour for 's'
 
>      - Basically I consider it an UI bug if the tool does not give me 
>        visual feedback on *any* keypress. If a user types something, 
>        it's very much intended: arrow keys move up and down or 
>        enter/exit functions, 'q' will quit, etc. There's *always* 
>        expected behavior when a user presses a key - and it's basically 
>        an UI bug if that is ignored for any reason.

More will be done in that direction.
 
>   - On long processing steps sometimes there's no progress bar, the 
>     tool just 'hangs'. In some cases this is implemented: such as the 
>     initial parsing of perf.data. In others it's not: such as the 
>     objdump annotation output. (Which is default-off, so this isn't 
>     really a bugreport.)

the objdump disassembly should have a progress bar.
 
>   - Sometimes there's nonsensical UI flows with non-intuitive outcomes. 
>     An example I noticed is the 'zoom in' behavior in perf report/top:
> 
>      - If in the default 'perf report' starting screen of a short 
>        profiling session I enter into a function name on the screen, I 
>        get these choices:
> 
>                 Annotate file_cache_slot::get_next_line(char**, long*)
>                 Zoom into cc1 thread
>                 Zoom into cc1 DSO (use the 'k' hotkey to zoom directly into the kernel)
>                 Browse map details
>                 Run scripts for samples of symbol [file_cache_slot::get_next_line(char**, long*)]
>                 Run scripts for all samples
>                 Switch to another data file in PWD
>                 Exit
> 
>      - If I press 'Zoom into cc1 thread', I get into some sort of 
>        filtered mode I am unable to exit via intuitive ways. There's no 
>        on-screen hint to make it go away, I have to exit the tool and 
>        restart it entirely to get back to the main profiling screen again 
>        ... which is obviously a suboptimal UI flow.
> 
>      - To make matters worse, the 'h' screen gives me this hint:
> 
>              ESC           Zoom out
> 
>        except it doesn't appear to be working, my profiling output is 
>        still limited to cc1 entries.

I think it worked when I last touched that code, but thanks for the
report, I'll ifx it.
 
>      - The *only* way I found to zoom out into the general screen again 
>        was to press 'm' for the 'context menu' (I found this not 
>        because it was named intuitively, but because I trial-error 
>        brute forced the UI keybindings), and there it had:
> 
>              Zoom out of cc1 thread

I think originally zooming out was with the left arrow key, but then
IIRC it was reused for scrolling because of modes where lots of columns
were needed, like with 'perf c2c report', or something like that, well,
here it is:

⬢ [acme@toolbox perf-tools-next]$ git show 31eb4360546b4bd89
commit 31eb4360546b4bd890f349db01295a173c09b0fb
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Oct 13 09:02:01 2015 +0900

    perf hists browser: Add 'm' key for context menu display
    
    With horizontal scrolling, the left/right arrow keys are used to scroll
    columns and ENTER/ESC keys are used to enter/exit menu.  However if
    callchain is recorded, the ENTER key is used to toggle callchain
    expansion so there's no way to display menu.  Use 'm' key to display the
    menu for this case.
    
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Link: http://lkml.kernel.org/r/1444694521-8136-1-git-send-email-namhyung@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

>      - Yay! But very unintuitive. The intuitive step would have been 
>        the left arrow key BTW. (with restoring the cursor position to 
>        the cc1 entry I pressed 'Enter' on originally), but that doesn't 

That is how I implemented it initially, yes, over 10 years ago.

>        do anything, it gets ignored. Also, a status line printout that 
>        we are filtered to cc1, and how to exit that mode, would be nice 
>        as well.

I'll work on that
 
>   - [ Sub-bugreport: at higher levels the 'P' keybinding doesn't print 
>       the current screen like on the annotation screen, it goes back a 
>       level. Guess how I found out. ;-)

That should work as well.
 
>       To be able to quote the above context menu screen, I copy-pasted 
>       the ncurses lines, and manually edited out all the non-printable 
>       characters unsuitable for emails. ]

Which is a PITA, one more detail to tidy, thanks.
 
> I genuinely believe that these "basic profiling workflow" details are 
> *FAR* more important to perf usability and perf popularity than pretty 
> much any of the more esoteric hardware features, scalability 
> enhancements and niche tools I see almost daily progress on - and these 
> basic workflow details affect *everyone* who uses perf...

Right, agreed, balancing processing tons of patches, addressing tech
debt, supporting new features is a balancing act that doesn't always
work well.

But, again, thanks for your report, I'll try to get all of this sorted
out.

Meanwhile, if you could please test what I put in that branch and report
results, that would be great.

- Arnaldo
