From: Mark Davis <markdavisinboston@gmail.com>
Subject: Re: No source code for static library (compiled with -g -ggdb)
Date: Fri, 29 Apr 2016 08:28:29 -0400
Message-ID: <CAPe7T+_UbFVFWpfcM8VrGQ_yXKcMcK1CDMVrPKZ4NY5ac-VyCA@mail.gmail.com>
References: <CAPe7T+8oQptK0Wak2y_b1RNBy7ddmftc+++HNMPF5R8BDxWVYQ@mail.gmail.com>
	<20160428221653.GD3386@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33828 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbcD2M2a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 29 Apr 2016 08:28:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id h205so1816061oig.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2016 05:28:30 -0700 (PDT)
In-Reply-To: <20160428221653.GD3386@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Arnaldo, that's a really nice feature. Unfortunately, I'm currently
running on an older version of perf (3.13.11-ckt18) and it's a bit of
a pain to modify things like this on the cluster I'm running on
(although I can if I have something I absolutely need). So, for me
when I run verbose mode I simply get the DSO names in the callchains,
but no arrows. I would assume, if I had a newer version of perf, that
I would get no arrows for the symbols I want to annotate, given the
behavior I'm seeing.

Anything else I can try? Does anyone have any ideas about why this may
be happening? Again, this is only happening for symbols in my static
library, and I'm creating this library using:

ar -cvrs $@ $(OBJS)

(I'm not an expert on ar, so I could be doing this wrong?)

On Thu, Apr 28, 2016 at 6:16 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Thu, Apr 28, 2016 at 01:44:16PM -0400, Mark Davis escreveu:
>> Hello, I'm using perf record and perf report to profile an applicati=
on
>> which is made from a static (.a) library file that I made as well as=
 a
>> handful of C++ files that are not in the static library. They are al=
l
>> compiled with "-g -ggdb -fno-inline -O2 -fno-omit-frame-pointer" and
>> all linked together to create the application.
>>
>> When I use perf report (in interactive/tui mode), when I annotate th=
e
>> symbols that are in the C++ files (not the static library), I see th=
e
>> source code intermingled with the assembly (this is what I want). I
>> can do this at any layer of the call stack. However, when I drill in=
to
>> the symbols that are from the static library, I just see the assembl=
y
>> of the leaf symbol. I don't expect to see the source in this case, a=
s
>> the leaf symbol is a low-level library from libc; but, perf report
>> won't let me drill into (i.e., annotate) any non-leaf symbols.
>>
>> Example:
>> execute_native_thread_routine
>> std::_Bind_simple<int (*(int, char**, Thread*))(int, char**,
>> Thread*)>::operator()()
>> main(int, char**)
>> my_func_A
>> my_func_B
>> malloc
>
> What happens when you press 'V'? Here, say for this callchain:
>
> -    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [.] =
handlers_find
>    - handlers_find
>       - 0.68% signal_handlers_foreach_matched_R
>            g_signal_handlers_disconnect_matched
>            0x7f71fe809a80
>            g_object_unref
>          - st_widget_get_theme_node
>               0.58% 0x7f71fe813429
>
> And I press V, I get:
>
> -    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [.] =
handlers_find
>    -=E2=86=92handlers_find libgobject-2.0.so.0.4600.2
>       - 0.68% signal_handlers_foreach_matched_R libgobject-2.0.so.0.4=
600.2
>            g_signal_handlers_disconnect_matched libgobject-2.0.so.0.4=
600.2
>            0x7f71fe809a80 libgnome-shell.so
>           =E2=86=92g_object_unref libgobject-2.0.so.0.4600.2
>          -=E2=86=92st_widget_get_theme_node libgnome-shell.so
>               0.58% 0x7f71fe813429 libgnome-shell.so
>
> See those arrows? They point to the places where you can annotate, th=
e others
> can't because they had no samples or were unresolved.
>
> With some changes I think we can show the ones without samples, but t=
hat remains to be done.
>
> Also, this is with:
>
> [root@jouet ~]# perf --version
> perf version 4.6.rc4.ga453697
>
> This feature was introduced in:
>
> commit 70e972788888315851a5c1b4982efbcafcd03b5b
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Mar 19 16:07:21 2015 -0300
>
>     perf hists browser: Indicate which callchain entries are annotate=
d
>
>     Now that we can annotate entries in a callchain, show which ones =
have an
>     associated symbol and samples, by adding a right arrow just befor=
e the
>     symbol name when in verbose mode.
>
>     To toggle verbose mode press 'V'.
>
> ---------------------------------
>
> Which is:
>
> [acme@jouet linux]$ git tag --contains 70e972788888315851a5c1b4982efb=
cafcd03b5b | grep ^v4 | head -1
> v4.1
> [acme@jouet linux]$
>
> Thanks,
>
> - Arnaldo
>
>> When I annotate my_func_A and my_func_B, it just jumps to the
>> annotation of malloc (I see this listed at the top of the annotation
>> view). Note that my_func_A and my_func_B are both defined in the
>> static library that I'm linking in. However, when I do a similar thi=
ng
>> with a different stack where I'm annotating a function that's not fr=
om
>> the static library (but in the regular C++ files), it works fine.
>>
>> Here's what I'm doing to create my static lib:
>> ar -cvrs $@ $(OBJS)
>>
>>
>> I did confirm with nm --debug-syms that my static lib has debugging
>> symbols in it:
>>
>> U __assert_fail
>> 0000000000000000 b .bss
>> 0000000000000000 n .comment
>> U __cxa_atexit
>> 0000000000000000 d .data
>> 0000000000000000 N .debug_abbrev
>> 0000000000000000 N .debug_aranges
>> 0000000000000000 N .debug_info
>> 0000000000000000 N .debug_line
>> 0000000000000000 N .debug_loc
>> 0000000000000000 N .debug_ranges
>> 0000000000000000 N .debug_str
>> U __dso_handle
>> 0000000000000000 r .eh_frame
>> U exit
>>
>>
>> How can I compile and link my application and configure perf report =
so
>> I can drill in like this on functions defined in a static library wi=
th
>> debug symbols?
>>
>> Thank you,
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf=
-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
