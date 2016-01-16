From: Gary Byers <gb@clozure.com>
Subject: Re: odd error from "perf record"
Date: Sat, 16 Jan 2016 13:55:49 -0700
Message-ID: <569AAE55.8090902@clozure.com>
References: <569957F9.80700@clozure.com> <20160115211751.GI18367@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060609060500050506070606"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from gyp.clozure.com ([74.50.56.54]:34875 "EHLO gyp.clozure.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbcAPUzy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 16 Jan 2016 15:55:54 -0500
In-Reply-To: <20160115211751.GI18367@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------060609060500050506070606
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

thanks.  I can work around the problem described in my previous message, 
but the problem
that I describe below is harder for me to describe and I  don't know 
exactly where the
problem might be and of course don't know how to work around it

The code that I am trying to profile is written in Clozure Common Lisp 
(CCL( <http://ccl.clozure.com>.
the memory regions that I am most interested in profiling contain lisp 
code; other regions mapped by
the process are mapped to ELF files which do not seem to exhibit problems.

the problems that I am most concerned about involve profiling compiled 
Lisp code, and a (somewhat
rambling) description of that problem and steps to reproduce it follows.

A copy of /proc/<pid>/maps for a running CCL process is enclosed as 
"mail.txt", the memory map
shown in that file is "typical" of a CCL process but may not be as 
typical of programs written
in other development systems.



I would like to be able to use "perf record ..." and "perf report" to 
profile that
code, and was able to do so for many years.  the details of how I was 
able to do so
are (probably) not relevant, but did not involve a /tmp/<pid>/map file 
when I used
earlier Linux kernels


The perf map file that I have been creating recently contains entries of 
the form

000030000010D000 2411 CCL::+-2
000030000010F490 25F9 CCL::--2
0000300000111B10 1531 CCL::*-2
00003000001130F0 2C29 CCL::/-2
0000300000115DB0 1EB1 CCL::=-2
0000300000117CD0 59 CCL::/=-2

those entries were in a text file named /tmp/perf-22415.map.
for a process whose pid was 22415 when I ran "perf record ..."
the .map file contains a few thousand such entries.

the output that I get from 'perf report .. "   -with or without
a ,map file -  looks like

     14.97%  lx86cl64  lx86cl64           [.] zero_dnodes
     14.55%  lx86cl64  lx86cl64.image     [.] 0x000000000011da1d
     11.55%  lx86cl64  lx86cl64.image     [.] 0x000000000011da11
      9.34%  lx86cl64  lx86cl64.image     [.] 0x000000000011da24

where "lx86cl64" is an ELF executable and "lx86cl64.image" is a file 
from which
the memory regions described by the perf  .map file are mmapped. Note 
that the addresses
in the "perf report" output do not seem to have much to do with the 
address ranges
described in the perf .map file, though they might be correct in some of 
their low bits.

If this is indeed a problem in 'perf' or related kernel components, as 
it appears to be, I believe that it may have been
introduced sometime after Linux 3.13 and sometime before 3.19.

In the code that I was running, the entries for the code from the ELF 
file (lx86cl64) look
plausible and may be correct,  The number of addresses reported for the 
code mapped from
the lx86cl64.image file seems plausible. but the addresses themselves do 
not.

The simplest way that I know of to reproduce this is to
1 ) download 
<http://ccl.clozure.com/ftp/pub/release/1.11/ccl-1.11-linuxx86.tar.gz> 
and extract its
contents.  This should create and populate a directory named ccl, which 
includes ccl/lx86cl64
and ccl/lx86cl64.image
2) execute ccl/lx86cl64 (with no arguments) from the shell.  note the 
pid of of the process.  You should see some startup
messages, followed by a "? " prompt. If you cannot run ccl/lx86cl64 
because of ELF symbol version issues, you
can build lx86cl64 on your system and avoid those issues by doing
$ pushd ccl/lisp-kernel/linuxx8664
$ make
$ popd

the Makefile depends on GNU m4 being installed as "m4" and an otherwise 
fairly vanilla gnu toolchain
and a fairly small set of libraries being installed.   If you need any 
additional shared object files, you would
probably have difficulty building most C programs,  'ldd lx86cl64" can 
tell you more precisely than I usually
can, and of course can help to identify problems related to symbol 
versioning issues.,

The lisp (lx86cl64) is in a traditional  read-eval-print loop (REPL), 
continually reading Lisp expressions,
printing the values of those expressions, and prompting (with "? ") for 
another expression.

3) in another shell, note the pid of the running lx86cl64 process (using 
'ps' or 'top' or other means)
$ perf record -p <pid of lx86cl64>

3) back in the lisp and at the "? " prompt, define a lisp function. 
Either type its definition  very carefully, or use
copy-and-paste and hope that I have typed carefully here:
(defun fact (n) (if (zerop n) 1 (* n (fact (1- n)))))
add a newline at the end of that line.

you should see
FACT
?
e.g. FACT and another prompt as output
FACT is simply the "value" of the function definition.



4) call that function.  Doing it this way (testing whether or not 
calling the function returns a null value) avoids
printing a very large integer.

? (null (fact 10000))
Of course that input should also be terminated by a newline,  the very 
large integer is not null, but we did
do about 10000 multiplications, many of which also involved very large 
integers.  We've also compiled a small
function and done a few other things, but a significant part of what we 
have done while "perf record" has been
running involves functions that are defined in lx86cl64.image.

5) The previous step should have returned and printed
NIL
?

(the large integer is not itself NIL)

and another prompt ,and at that prompt, typing
(quit)

should exit the process and also cause the process that has been running 
"perf record" to exit.


A subsequent call to "perf report" will show output like
# Overhead  Command   Shared Object Symbol
# ........  ........  ................. ...............................
#
     15.41%  lx86cl64  lx86cl64           [.] zero_dnodes
     12.64%  lx86cl64  lx86cl64.image     [.] 0x000000000007cb8d
      6.29%  lx86cl64  lx86cl64.image     [.] 0x0000000000088251
      6.01%  lx86cl64  lx86cl64.image     [.] 0x000000000007cb88
      5.87%  lx86cl64  lx86cl64.image     [.] 0x000000000007cb97

Note that we did not create a ,map file in the steps above.  When  I
do that , the output is essentially the same. the "symbols" in the
output immediately above do not have any obvious correlation to
the addresses that are mapped by the lx86cl64 process , and it is plausible
that we have spent as much time as we have in a small number
of lisp functions when we call (fact 10000)  but the addresses of
the samples seem to be unrelated to any mapped memory region in the process

In previous versions of perf and Linux, I was able to associate ELF
symbols with lisp function addresses using a fairly brutal hack,
if using the ,map file fails because of a problem with the ,map
file, it is in some ways preferable to using  that hack.  Using
the hack instead of the perf map file does not seem to affect
the "perf report" output for functions defined in lx86cl64.image

I believe that I have also seen perf report identify the "shared object"
as the name of  the perf.<pid>.map file in (iirc) linux 3.19, and
I believe that I've seen this regardless of whether a .map file
existed or not.

If the "symbols" reported by "perf report" are (virtual, logical) 
addresses associated
with samples in the perf.out file, they don't seem to have much to do
with the address of any code in the process. If the reported "symbols" 
are something
other than addresses, I have no idea what they are.

at some point, I may have thought that the reported "symbols" were 
simply being truncated
to 32 bits, but I am not certain of that.

I hope that anyone who wants to reproduce this will find it relatively 
easy to do so.

the attached "mail.txt" file shows a typical /proc/pid/maps
file which may be helpful.

Thanks.

On 01/15/2016 02:17 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 15, 2016 at 01:35:05PM -0700, Gary Byers escreveu:
>
>> Hi.
>>
>> I happen to be using Ubuntu 15.10
>>
>> [~] gb@abq> uname -a
>> Linux abq 4.2.0-23-generic #28-Ubuntu SMP Sun Dec 27 17:47:31 UTC 2015
>> x86_64 x86_64 x86_64 GNU/Linux
>>
>>
>> I am trying to use perf to profile a 64-bit x86 Linux program. The program
>> maps a large (512gb) chunk
>> of address space, but "only" about 20mb of that are mapped with permissions
>> that allow any of read,
>> write, or execute access. (The atypical memory mapping is done for what I
>> believe to be very good
>> reasons and I don't think that those reasons are directly relevant here.)
>>
>> Some of the code that I an trying to profile is on pages that have read and
>> execute permissions
>> and atypically "high" addresses, often of the form 0000300000xxxxxx,  If
>> anyone reading this would
>> find it helpful, I can certainly provide a copy of /proc/<pid>/maps or
>> similar for a typical instance
>> of the process.  As far as I know, few (if any) pages in the process are
>> locked via mlock() or variants.
>>
>> For the sake of argument, it may be helpful to think of that code as having
>> been "JITted" there.  it is
>> not mapped from an ELF executable or library, and my later questions may
>> have to do with the .map file
>> that I am trying to use to provide symbolic information
> Right, see tools/perf/Documentation/jit-interface.txt to see how to
> provide that map.
>
> if you could provide the minimal reproducer for this, i.e. a simple 
> program that does the kind of mapping you described and when monitored 
> produces the error being reported. But please try bumping 
> /proc/sys/kernel/perf_event_mlock_kb first.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------060609060500050506070606
Content-Type: text/plain; charset=UTF-8;
 name="mail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mail.txt"

00012000-00014000 rwxp 00000000 08:07 18350962                           /usr/local/src/ccl/lx86cl64.image
00015000-00016000 rwxp 00000000 00:00 0 
00400000-00430000 r-xp 00000000 08:07 18375976                           /usr/local/src/ccl/lx86cl64
00630000-00631000 r-xp 00030000 08:07 18375976                           /usr/local/src/ccl/lx86cl64
00631000-00632000 rwxp 00031000 08:07 18375976                           /usr/local/src/ccl/lx86cl64
00632000-00633000 rwxp 00000000 00:00 0 
00edd000-00f22000 rwxp 00000000 00:00 0                                  [heap]
300000000000-300000fc6000 r-xp 00002000 08:07 18350962                   /usr/local/src/ccl/lx86cl64.image
300000fc6000-300000fc8000 rwxp 00fc8000 08:07 18350962                   /usr/local/src/ccl/lx86cl64.image
300000fc8000-300001559000 r-xp 00fca000 08:07 18350962                   /usr/local/src/ccl/lx86cl64.image
300001559000-300040000000 ---p 00000000 00:00 0 
300040000000-300040568000 rwxp 019d9000 08:07 18350962                   /usr/local/src/ccl/lx86cl64.image
300040568000-302000000000 ---p 00000000 00:00 0 
302000000000-30200047e000 rwxp 0155b000 08:07 18350962                   /usr/local/src/ccl/lx86cl64.image
30200047e000-302002480000 rwxp 00000000 00:00 0 
302002480000-307bfe000000 ---p 00000000 00:00 0 
307bfe000000-307bfe04a000 rwxp 00000000 00:00 0 
307bfe04a000-307dfe000000 ---p 00000000 00:00 0 
307dfe000000-307e0000b000 rwxp 00000000 00:00 0 
307e0000b000-307e3f800000 ---p 00000000 00:00 0 
307e3f800000-307e3f84a000 rwxp 00000000 00:00 0 
307e3f84a000-308000020000 ---p 00000000 00:00 0 
7ffb54000000-7ffb54021000 rwxp 00000000 00:00 0 
7ffb54021000-7ffb58000000 ---p 00000000 00:00 0 
7ffb5aeee000-7ffb5af08000 r-xp 00000000 00:00 0 
7ffb5af08000-7ffb5b109000 rwxp 00000000 00:00 0 
7ffb5b109000-7ffb5b10a000 ---p 00000000 00:00 0 
7ffb5b10a000-7ffb5b36d000 rwxp 00000000 00:00 0                          [stack:28309]
7ffb5b36d000-7ffb5b387000 r-xp 00000000 00:00 0 
7ffb5b387000-7ffb5b5bb000 rwxp 00000000 00:00 0 
7ffb5b5bb000-7ffb5b7b6000 ---p 00000000 00:00 0 
7ffb5b7b6000-7ffb5b7c1000 rwxp 01f41000 08:07 18350962                   /usr/local/src/ccl/lx86cl64.image
7ffb5b7c1000-7ffb7b3b6000 ---p 00000000 00:00 0 
7ffb7b3b6000-7ffb7b576000 r-xp 00000000 08:07 266583                     /lib/x86_64-linux-gnu/libc-2.21.so
7ffb7b576000-7ffb7b776000 ---p 001c0000 08:07 266583                     /lib/x86_64-linux-gnu/libc-2.21.so
7ffb7b776000-7ffb7b77a000 r-xp 001c0000 08:07 266583                     /lib/x86_64-linux-gnu/libc-2.21.so
7ffb7b77a000-7ffb7b77c000 rwxp 001c4000 08:07 266583                     /lib/x86_64-linux-gnu/libc-2.21.so
7ffb7b77c000-7ffb7b780000 rwxp 00000000 00:00 0 
7ffb7b780000-7ffb7b787000 r-xp 00000000 08:07 266727                     /lib/x86_64-linux-gnu/librt-2.21.so
7ffb7b787000-7ffb7b986000 ---p 00007000 08:07 266727                     /lib/x86_64-linux-gnu/librt-2.21.so
7ffb7b986000-7ffb7b987000 r-xp 00006000 08:07 266727                     /lib/x86_64-linux-gnu/librt-2.21.so
7ffb7b987000-7ffb7b988000 rwxp 00007000 08:07 266727                     /lib/x86_64-linux-gnu/librt-2.21.so
7ffb7b988000-7ffb7b9a0000 r-xp 00000000 08:07 266719                     /lib/x86_64-linux-gnu/libpthread-2.21.so
7ffb7b9a0000-7ffb7bba0000 ---p 00018000 08:07 266719                     /lib/x86_64-linux-gnu/libpthread-2.21.so
7ffb7bba0000-7ffb7bba1000 r-xp 00018000 08:07 266719                     /lib/x86_64-linux-gnu/libpthread-2.21.so
7ffb7bba1000-7ffb7bba2000 rwxp 00019000 08:07 266719                     /lib/x86_64-linux-gnu/libpthread-2.21.so
7ffb7bba2000-7ffb7bba6000 rwxp 00000000 00:00 0 
7ffb7bba6000-7ffb7bcad000 r-xp 00000000 08:07 266645                     /lib/x86_64-linux-gnu/libm-2.21.so
7ffb7bcad000-7ffb7beac000 ---p 00107000 08:07 266645                     /lib/x86_64-linux-gnu/libm-2.21.so
7ffb7beac000-7ffb7bead000 r-xp 00106000 08:07 266645                     /lib/x86_64-linux-gnu/libm-2.21.so
7ffb7bead000-7ffb7beae000 rwxp 00107000 08:07 266645                     /lib/x86_64-linux-gnu/libm-2.21.so
7ffb7beae000-7ffb7beb1000 r-xp 00000000 08:07 266602                     /lib/x86_64-linux-gnu/libdl-2.21.so
7ffb7beb1000-7ffb7c0b0000 ---p 00003000 08:07 266602                     /lib/x86_64-linux-gnu/libdl-2.21.so
7ffb7c0b0000-7ffb7c0b1000 r-xp 00002000 08:07 266602                     /lib/x86_64-linux-gnu/libdl-2.21.so
7ffb7c0b1000-7ffb7c0b2000 rwxp 00003000 08:07 266602                     /lib/x86_64-linux-gnu/libdl-2.21.so
7ffb7c0b2000-7ffb7c0d6000 r-xp 00000000 08:07 266555                     /lib/x86_64-linux-gnu/ld-2.21.so
7ffb7c11d000-7ffb7c12d000 rwxp 00000000 00:00 0 
7ffb7c12d000-7ffb7c14f000 r-xp 00000000 00:00 0 
7ffb7c14f000-7ffb7c250000 rwxp 00000000 00:00 0 
7ffb7c250000-7ffb7c272000 r-xp 00000000 00:00 0 
7ffb7c272000-7ffb7c2b7000 rwxp 00000000 00:00 0 
7ffb7c2c2000-7ffb7c2d5000 rwxp 00000000 00:00 0 
7ffb7c2d5000-7ffb7c2d6000 r-xp 00023000 08:07 266555                     /lib/x86_64-linux-gnu/ld-2.21.so
7ffb7c2d6000-7ffb7c2d7000 rwxp 00024000 08:07 266555                     /lib/x86_64-linux-gnu/ld-2.21.so
7ffb7c2d7000-7ffb7c2d8000 rwxp 00000000 00:00 0 
7fff7a102000-7fff7a123000 rwxp 00000000 00:00 0                          [stack]
7fff7a1b4000-7fff7a1b6000 r--p 00000000 00:00 0                          [vvar]
7fff7a1b6000-7fff7a1b8000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]

--------------060609060500050506070606--
