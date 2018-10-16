From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Date: Tue, 16 Oct 2018 17:06:08 -0300
Message-ID: <20181016200608.GG3849@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20181016174923.GE3849@kernel.org>
 <20181016175204.GF3849@kernel.org>
 <19251847.rgPmgX8CgI@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19251847.rgPmgX8CgI@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 16, 2018 at 09:00:48PM +0200, Milian Wolff escreveu:
> On Dienstag, 16. Oktober 2018 19:52:04 CEST Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 16, 2018 at 02:49:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Oct 15, 2018 at 10:51:36PM +0200, Milian Wolff escreveu:
> > > > On Donnerstag, 11. Oktober 2018 21:39:20 CEST Arnaldo Carvalho de Melo 
> wrote:
> > > > > Em Thu, Oct 11, 2018 at 08:23:31PM +0200, Milian Wolff escreveu:
> > > > > > On Donnerstag, 27. September 2018 21:10:37 CEST Arnaldo Carvalho de
> > > > > > Melo
> > > > > > 
> > > > > > wrote:
> > > > > > > Em Wed, Sep 26, 2018 at 03:52:07PM +0200, Milian Wolff escreveu:
> > > > > > > > When the function name for an inline frame is invalid, we must
> > > > > > > > not try to demangle this symbol, otherwise we crash with:
> > > > > > > > 
> > > > > > > > #0  0x0000555555895c01 in bfd_demangle ()
> > > > > > > > #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90,
> > > > > > > > elf_name=0x0,
> > > > > > > > kmodule=0) at util/symbol-elf.c:215 #2  dso__demangle_sym
> > > > > > > > (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>,
> > > > > > > > kmodule@entry=0,
> > > > > > > > elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400 #3
> > > > > > > > 0x00005555557fef4b in new_inline_sym (funcname=0x0,
> > > > > > > > base_sym=0x555555d92b90, dso=0x555555d92b90) at
> > > > > > > > util/srcline.c:89 #4
> > > > > > > > inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00,
> > > > > > > > node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at
> > > > > > > > util/srcline.c:264 #5  0x00005555557ff27f in addr2line
> > > > > > > > (dso_name=dso_name@entry=0x555555d92430
> > > > > > > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da6603
> > > > > > > > 3d24fc
> > > > > > > > e5/
> > > > > > > > elf", addr=addr@entry=2888, file=file@entry=0x0,>
> > > > > > > > 
> > > > > > > >     line=line@entry=0x0, dso=dso@entry=0x555555c7bb00,
> > > > > > > >     unwind_inlines=unwind_inlines@entry=true,
> > > > > > > >     node=0x555555e31810,
> > > > > > > >     sym=0x555555d92b90) at util/srcline.c:313>
> > > > > > > > 
> > > > > > > > #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90,
> > > > > > > > dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430
> > > > > > > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da6603
> > > > > > > > 3d24fc
> > > > > > > > e5/
> > > > > > > > elf")>
> > > > > > > > 
> > > > > > > >     at util/srcline.c:358
> > > > > > > > 
> > > > > > > > So instead handle the case where we get invalid function names
> > > > > > > > for inlined frames and use a fallback '??' function name
> > > > > > > > instead.
> > > > > > > > 
> > > > > > > > While this crash was originally reported by Hadrien for rust
> > > > > > > > code,
> > > > > > > > I can now also reproduce it with trivial C++ code. Indeed, it
> > > > > > > > seems
> > > > > > > > like libbfd fails to interpret the debug information for the
> > > > > > > > inline
> > > > > > > > frame symbol name:
> > > > > > > > 
> > > > > > > > $ addr2line -e
> > > > > > > > /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033
> > > > > > > > d24fce
> > > > > > > > 5/e
> > > > > > > > lf -if b48 main
> > > > > > > > /usr/include/c++/8.2.1/complex:610
> > > > > > > > ??
> > > > > > > > /usr/include/c++/8.2.1/complex:618
> > > > > > > > ??
> > > > > > > > /usr/include/c++/8.2.1/complex:675
> > > > > > > > ??
> > > > > > > > /usr/include/c++/8.2.1/complex:685
> > > > > > > > main
> > > > > > > > /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-in
> > > > > > > > lining
> > > > > > > > /mai
> > > > > > > > n.cpp:39
> > > > > > > > 
> > > > > > > > I've reported this bug upstream and also attached a patch there
> > > > > > > > which should fix this issue:
> > > > > > > > https://sourceware.org/bugzilla/show_bug.cgi?id=23715
> > > > > > > 
> > > > > > > Millian, what about this one, which is the cset it is fixing?
> > > > > > 
> > > > > > Hey Arnaldo,
> > > > > > 
> > > > > > just noticed this email and that the corresponding patch hasn't
> > > > > > landed in
> > > > > > perf/core yet. The patch set which introduced this is a64489c56c307
> > > > > > ("perf
> > > > > > report: Find the inline stack for a given address"). Note that the
> > > > > > code
> > > > > > was
> > > > > > introduced by this patch, but then subsequently touched and moved by
> > > > > > follow up patches. So, is this the patch you want to see referenced?
> > > > > > Otherwise, the latest patch which gets fixed is afaik: 7285cf3325b4a
> > > > > > ("perf srcline: Show correct function name for srcline of
> > > > > > callchains").
> > > > > > 
> > > > > > Can you please pick either of these patches and amend the commit
> > > > > > message
> > > > > > of my patch and push it to perf/urgent and perf/core?
> > > > > 
> > > > > I'll reread all this later or tomorrow and continue, going AFK now.
> > > > 
> > > > Ping?
> > > 
> > > Applied, seems simple enough, makes this code a bit more robust.
> > > 
> > > With regards to the cset where the problem originally was introduced,
> > > i.e. not checking if a2l->funcname was NULL before either passing it to
> > > strdup() or all the way to bfd_demangle(), that would cause the crash in
> > > 
> > > either place, I think this is the cset:
> > >   commit a64489c56c307bf0955f0489158c5ecf6aa10fe2
> > >   Author: Jin Yao <yao.jin@linux.intel.com>
> > >   Date:   Sun Mar 26 04:34:26 2017 +0800
> > >   
> > >       perf report: Find the inline stack for a given address
> > >> 
> > >> Agreed?
> > 
> > But I'm not sure this will be worth for doing backports, as before
> > applying this patch a series of other patches touching this code would
> > have to be applied :-\
> > 
> > I can leave it there, so that we know when the problem was introduced,
> > i.e. I _guess_ that if this rust or C++ reproducers would be used with
> > perf built with a64489c56c307bf0955f0489158c5ecf6aa10fe2 as head, we
> > would see a crash as well.
 
> Yes, probably. And backporting this patch should be easily doable for anyone 
> with a little C knowledge ;-)

This specific one, yes, I kept the Fixes: tag :-)

- Arnaldo
