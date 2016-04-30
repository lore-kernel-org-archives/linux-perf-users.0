From: Mark Davis <markdavisinboston@gmail.com>
Subject: Re: No source code for static library (compiled with -g -ggdb)
Date: Sat, 30 Apr 2016 19:49:46 -0400
Message-ID: <CAPe7T+9VMic7cFUjCpMb=O6CUFTjmKXj5HWta7z5NXtQWVpaQw@mail.gmail.com>
References: <CAPe7T+8oQptK0Wak2y_b1RNBy7ddmftc+++HNMPF5R8BDxWVYQ@mail.gmail.com>
	<20160428221653.GD3386@kernel.org>
	<CAPe7T+_UbFVFWpfcM8VrGQ_yXKcMcK1CDMVrPKZ4NY5ac-VyCA@mail.gmail.com>
	<20160429144529.GI3386@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36524 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcD3Xts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 30 Apr 2016 19:49:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id i2so23807159oib.3
        for <linux-perf-users@vger.kernel.org>; Sat, 30 Apr 2016 16:49:47 -0700 (PDT)
In-Reply-To: <20160429144529.GI3386@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Arnaldo, I was able to install perf version 4.6.rc5.g1b46bac and am
able to see the arrows to indicate the annotated symbols. That is a
very useful feature. Furthermore, I'm now able to see exactly what I
wanted to see before -- annotated source of non-leaf symbols in the
callchain. So, as of now I think I'm all set.

Thank you,
Mark

On Fri, Apr 29, 2016 at 10:45 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Fri, Apr 29, 2016 at 08:28:29AM -0400, Mark Davis escreveu:
>> Arnaldo, that's a really nice feature. Unfortunately, I'm currently
>> running on an older version of perf (3.13.11-ckt18) and it's a bit o=
f
>> a pain to modify things like this on the cluster I'm running on
>> (although I can if I have something I absolutely need). So, for me
>
> Well, its not _that_ difficult to use a newer perf tool on whatever
> kernel you are using, and that should work, as the new tool should
> notice whatever features may be missing for something you ask it to d=
o.
>
> So, you can do:
>
> [acme@jouet linux]$ make help | grep perf
>   perf-tar-src-pkg    - Build perf-4.6.0-rc4.tar source tarball
>   perf-targz-src-pkg  - Build perf-4.6.0-rc4.tar.gz source tarball
>   perf-tarbz2-src-pkg - Build perf-4.6.0-rc4.tar.bz2 source tarball
>   perf-tarxz-src-pkg  - Build perf-4.6.0-rc4.tar.xz source tarball
> [acme@jouet linux]$
>
> Do any of this, say:
>
>   make perf-targz-src-pkg
>
> On a recent kernel source, and you'll get a tarball with what you nee=
d
> to build it on the target system.
>
> Then just use it as ./perf or make sure that the binary is in your pa=
th.
>
>> when I run verbose mode I simply get the DSO names in the callchains=
,
>> but no arrows. I would assume, if I had a newer version of perf, tha=
t
>> I would get no arrows for the symbols I want to annotate, given the
>> behavior I'm seeing.
>
> Yes, this seems to be the case.
>
>> Anything else I can try? Does anyone have any ideas about why this m=
ay
>> be happening? Again, this is only happening for symbols in my static
>> library, and I'm creating this library using:
>
> I'll read the other message you sent, I think you clarified things
> further there...
>
>> ar -cvrs $@ $(OBJS)
>>
>> (I'm not an expert on ar, so I could be doing this wrong?)
>>
>> On Thu, Apr 28, 2016 at 6:16 PM, Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com> wrote:
>> > Em Thu, Apr 28, 2016 at 01:44:16PM -0400, Mark Davis escreveu:
>> >> Hello, I'm using perf record and perf report to profile an applic=
ation
>> >> which is made from a static (.a) library file that I made as well=
 as a
>> >> handful of C++ files that are not in the static library. They are=
 all
>> >> compiled with "-g -ggdb -fno-inline -O2 -fno-omit-frame-pointer" =
and
>> >> all linked together to create the application.
>> >>
>> >> When I use perf report (in interactive/tui mode), when I annotate=
 the
>> >> symbols that are in the C++ files (not the static library), I see=
 the
>> >> source code intermingled with the assembly (this is what I want).=
 I
>> >> can do this at any layer of the call stack. However, when I drill=
 into
>> >> the symbols that are from the static library, I just see the asse=
mbly
>> >> of the leaf symbol. I don't expect to see the source in this case=
, as
>> >> the leaf symbol is a low-level library from libc; but, perf repor=
t
>> >> won't let me drill into (i.e., annotate) any non-leaf symbols.
>> >>
>> >> Example:
>> >> execute_native_thread_routine
>> >> std::_Bind_simple<int (*(int, char**, Thread*))(int, char**,
>> >> Thread*)>::operator()()
>> >> main(int, char**)
>> >> my_func_A
>> >> my_func_B
>> >> malloc
>> >
>> > What happens when you press 'V'? Here, say for this callchain:
>> >
>> > -    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [=
=2E] handlers_find
>> >    - handlers_find
>> >       - 0.68% signal_handlers_foreach_matched_R
>> >            g_signal_handlers_disconnect_matched
>> >            0x7f71fe809a80
>> >            g_object_unref
>> >          - st_widget_get_theme_node
>> >               0.58% 0x7f71fe813429
>> >
>> > And I press V, I get:
>> >
>> > -    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [=
=2E] handlers_find
>> >    -=E2=86=92handlers_find libgobject-2.0.so.0.4600.2
>> >       - 0.68% signal_handlers_foreach_matched_R libgobject-2.0.so.=
0.4600.2
>> >            g_signal_handlers_disconnect_matched libgobject-2.0.so.=
0.4600.2
>> >            0x7f71fe809a80 libgnome-shell.so
>> >           =E2=86=92g_object_unref libgobject-2.0.so.0.4600.2
>> >          -=E2=86=92st_widget_get_theme_node libgnome-shell.so
>> >               0.58% 0x7f71fe813429 libgnome-shell.so
>> >
>> > See those arrows? They point to the places where you can annotate,=
 the others
>> > can't because they had no samples or were unresolved.
>> >
>> > With some changes I think we can show the ones without samples, bu=
t that remains to be done.
>> >
>> > Also, this is with:
>> >
>> > [root@jouet ~]# perf --version
>> > perf version 4.6.rc4.ga453697
>> >
>> > This feature was introduced in:
>> >
>> > commit 70e972788888315851a5c1b4982efbcafcd03b5b
>> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>> > Date:   Thu Mar 19 16:07:21 2015 -0300
>> >
>> >     perf hists browser: Indicate which callchain entries are annot=
ated
>> >
>> >     Now that we can annotate entries in a callchain, show which on=
es have an
>> >     associated symbol and samples, by adding a right arrow just be=
fore the
>> >     symbol name when in verbose mode.
>> >
>> >     To toggle verbose mode press 'V'.
>> >
>> > ---------------------------------
>> >
>> > Which is:
>> >
>> > [acme@jouet linux]$ git tag --contains 70e972788888315851a5c1b4982=
efbcafcd03b5b | grep ^v4 | head -1
>> > v4.1
>> > [acme@jouet linux]$
>> >
>> > Thanks,
>> >
>> > - Arnaldo
>> >
>> >> When I annotate my_func_A and my_func_B, it just jumps to the
>> >> annotation of malloc (I see this listed at the top of the annotat=
ion
>> >> view). Note that my_func_A and my_func_B are both defined in the
>> >> static library that I'm linking in. However, when I do a similar =
thing
>> >> with a different stack where I'm annotating a function that's not=
 from
>> >> the static library (but in the regular C++ files), it works fine.
>> >>
>> >> Here's what I'm doing to create my static lib:
>> >> ar -cvrs $@ $(OBJS)
>> >>
>> >>
>> >> I did confirm with nm --debug-syms that my static lib has debuggi=
ng
>> >> symbols in it:
>> >>
>> >> U __assert_fail
>> >> 0000000000000000 b .bss
>> >> 0000000000000000 n .comment
>> >> U __cxa_atexit
>> >> 0000000000000000 d .data
>> >> 0000000000000000 N .debug_abbrev
>> >> 0000000000000000 N .debug_aranges
>> >> 0000000000000000 N .debug_info
>> >> 0000000000000000 N .debug_line
>> >> 0000000000000000 N .debug_loc
>> >> 0000000000000000 N .debug_ranges
>> >> 0000000000000000 N .debug_str
>> >> U __dso_handle
>> >> 0000000000000000 r .eh_frame
>> >> U exit
>> >>
>> >>
>> >> How can I compile and link my application and configure perf repo=
rt so
>> >> I can drill in like this on functions defined in a static library=
 with
>> >> debug symbols?
>> >>
>> >> Thank you,
>> >> Mark
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-p=
erf-users" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
