From: Mark Davis <markdavisinboston@gmail.com>
Subject: No source code for static library (compiled with -g -ggdb)
Date: Thu, 28 Apr 2016 13:44:16 -0400
Message-ID: <CAPe7T+8oQptK0Wak2y_b1RNBy7ddmftc+++HNMPF5R8BDxWVYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:36059 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbcD1RoR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 13:44:17 -0400
Received: by mail-ob0-f195.google.com with SMTP id ds1so7503020obc.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2016 10:44:17 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello, I'm using perf record and perf report to profile an application
which is made from a static (.a) library file that I made as well as a
handful of C++ files that are not in the static library. They are all
compiled with "-g -ggdb -fno-inline -O2 -fno-omit-frame-pointer" and
all linked together to create the application.

When I use perf report (in interactive/tui mode), when I annotate the
symbols that are in the C++ files (not the static library), I see the
source code intermingled with the assembly (this is what I want). I
can do this at any layer of the call stack. However, when I drill into
the symbols that are from the static library, I just see the assembly
of the leaf symbol. I don't expect to see the source in this case, as
the leaf symbol is a low-level library from libc; but, perf report
won't let me drill into (i.e., annotate) any non-leaf symbols.

Example:
execute_native_thread_routine
std::_Bind_simple<int (*(int, char**, Thread*))(int, char**,
Thread*)>::operator()()
main(int, char**)
my_func_A
my_func_B
malloc

When I annotate my_func_A and my_func_B, it just jumps to the
annotation of malloc (I see this listed at the top of the annotation
view). Note that my_func_A and my_func_B are both defined in the
static library that I'm linking in. However, when I do a similar thing
with a different stack where I'm annotating a function that's not from
the static library (but in the regular C++ files), it works fine.

Here's what I'm doing to create my static lib:
ar -cvrs $@ $(OBJS)


I did confirm with nm --debug-syms that my static lib has debugging
symbols in it:

U __assert_fail
0000000000000000 b .bss
0000000000000000 n .comment
U __cxa_atexit
0000000000000000 d .data
0000000000000000 N .debug_abbrev
0000000000000000 N .debug_aranges
0000000000000000 N .debug_info
0000000000000000 N .debug_line
0000000000000000 N .debug_loc
0000000000000000 N .debug_ranges
0000000000000000 N .debug_str
U __dso_handle
0000000000000000 r .eh_frame
U exit


How can I compile and link my application and configure perf report so
I can drill in like this on functions defined in a static library with
debug symbols?

Thank you,
Mark
