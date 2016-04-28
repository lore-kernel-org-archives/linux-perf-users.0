From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: No source code for static library (compiled with -g -ggdb)
Date: Thu, 28 Apr 2016 19:16:53 -0300
Message-ID: <20160428221653.GD3386@kernel.org>
References: <CAPe7T+8oQptK0Wak2y_b1RNBy7ddmftc+++HNMPF5R8BDxWVYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35579 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbcD1WQ6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 18:16:58 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2B2992015A
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2016 22:16:57 +0000 (UTC)
Received: from jouet.infradead.org (unknown [179.235.167.147])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D886520121
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2016 22:16:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPe7T+8oQptK0Wak2y_b1RNBy7ddmftc+++HNMPF5R8BDxWVYQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Apr 28, 2016 at 01:44:16PM -0400, Mark Davis escreveu:
> Hello, I'm using perf record and perf report to profile an applicatio=
n
> which is made from a static (.a) library file that I made as well as =
a
> handful of C++ files that are not in the static library. They are all
> compiled with "-g -ggdb -fno-inline -O2 -fno-omit-frame-pointer" and
> all linked together to create the application.
>=20
> When I use perf report (in interactive/tui mode), when I annotate the
> symbols that are in the C++ files (not the static library), I see the
> source code intermingled with the assembly (this is what I want). I
> can do this at any layer of the call stack. However, when I drill int=
o
> the symbols that are from the static library, I just see the assembly
> of the leaf symbol. I don't expect to see the source in this case, as
> the leaf symbol is a low-level library from libc; but, perf report
> won't let me drill into (i.e., annotate) any non-leaf symbols.
>=20
> Example:
> execute_native_thread_routine
> std::_Bind_simple<int (*(int, char**, Thread*))(int, char**,
> Thread*)>::operator()()
> main(int, char**)
> my_func_A
> my_func_B
> malloc

What happens when you press 'V'? Here, say for this callchain:

-    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [.] ha=
ndlers_find
   - handlers_find
      - 0.68% signal_handlers_foreach_matched_R
           g_signal_handlers_disconnect_matched
           0x7f71fe809a80
           g_object_unref
         - st_widget_get_theme_node
              0.58% 0x7f71fe813429=20

And I press V, I get:

-    0.73%  gnome-shell      libgobject-2.0.so.0.4600.2          [.] ha=
ndlers_find
   -=E2=86=92handlers_find libgobject-2.0.so.0.4600.2
      - 0.68% signal_handlers_foreach_matched_R libgobject-2.0.so.0.460=
0.2
           g_signal_handlers_disconnect_matched libgobject-2.0.so.0.460=
0.2
           0x7f71fe809a80 libgnome-shell.so
          =E2=86=92g_object_unref libgobject-2.0.so.0.4600.2
         -=E2=86=92st_widget_get_theme_node libgnome-shell.so
              0.58% 0x7f71fe813429 libgnome-shell.so=20

See those arrows? They point to the places where you can annotate, the =
others
can't because they had no samples or were unresolved.

With some changes I think we can show the ones without samples, but tha=
t remains to be done.

Also, this is with:

[root@jouet ~]# perf --version
perf version 4.6.rc4.ga453697

This feature was introduced in:

commit 70e972788888315851a5c1b4982efbcafcd03b5b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Mar 19 16:07:21 2015 -0300

    perf hists browser: Indicate which callchain entries are annotated
   =20
    Now that we can annotate entries in a callchain, show which ones ha=
ve an
    associated symbol and samples, by adding a right arrow just before =
the
    symbol name when in verbose mode.
   =20
    To toggle verbose mode press 'V'.

---------------------------------

Which is:

[acme@jouet linux]$ git tag --contains 70e972788888315851a5c1b4982efbca=
fcd03b5b | grep ^v4 | head -1
v4.1
[acme@jouet linux]$

Thanks,

- Arnaldo
=20
> When I annotate my_func_A and my_func_B, it just jumps to the
> annotation of malloc (I see this listed at the top of the annotation
> view). Note that my_func_A and my_func_B are both defined in the
> static library that I'm linking in. However, when I do a similar thin=
g
> with a different stack where I'm annotating a function that's not fro=
m
> the static library (but in the regular C++ files), it works fine.
>=20
> Here's what I'm doing to create my static lib:
> ar -cvrs $@ $(OBJS)
>=20
>=20
> I did confirm with nm --debug-syms that my static lib has debugging
> symbols in it:
>=20
> U __assert_fail
> 0000000000000000 b .bss
> 0000000000000000 n .comment
> U __cxa_atexit
> 0000000000000000 d .data
> 0000000000000000 N .debug_abbrev
> 0000000000000000 N .debug_aranges
> 0000000000000000 N .debug_info
> 0000000000000000 N .debug_line
> 0000000000000000 N .debug_loc
> 0000000000000000 N .debug_ranges
> 0000000000000000 N .debug_str
> U __dso_handle
> 0000000000000000 r .eh_frame
> U exit
>=20
>=20
> How can I compile and link my application and configure perf report s=
o
> I can drill in like this on functions defined in a static library wit=
h
> debug symbols?
>=20
> Thank you,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
