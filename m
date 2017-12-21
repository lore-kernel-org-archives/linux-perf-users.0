From: Hadrien Grasland <grasland@lal.in2p3.fr>
Subject: Re: Trying to understand some strange samples in a perf profile
Date: Thu, 21 Dec 2017 11:46:15 +0100
Message-ID: <6d2adf7a-b181-a8ed-2069-6063abadf6a1@lal.in2p3.fr>
References: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr>
 <9831756.pFeoWVMjH9@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp1.lal.in2p3.fr ([134.158.88.100]:57246 "EHLO
        smtp1.lal.in2p3.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdLUKlc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Dec 2017 05:41:32 -0500
In-Reply-To: <9831756.pFeoWVMjH9@milian-kdab2>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hi Milian!


Le 21/12/2017 à 10:54, Milian Wolff a écrit :
> On Wednesday, December 20, 2017 10:39:07 AM CET Hadrien Grasland wrote:
>> Hi all,
> Hey Hadrien!
>
>> I am currently trying to get a reliable perf setup for a new codebase
>> that I am working on. The software is rather big and complex (particle
>> physics framework from the Belle 2 experiment), and architected in a way
>> that makes it hard to break it down in smaller chunks, which brings some
>> new issues that I do not usually encounter in my smaller software
>> projects. I thought you might be able to help me understand some of the
>> oddities that I observe in perf's output.
>>
>> -----
>>
>> I am running perf 4.14.3 on top of Linux 4.14.6 and a Haswell machine
>> (Intel(R) Xeon(R) E5-1620 v3).
> Is this a self-build perf, or whatever you get from openSUSE? Is it using
> libunwind for unwinding, or libdw? Try do to a `ldd` on `perf` to see what it
> links against.

It is the "perf" package from openSUSE. According to ldd, it links to 
both libdw and libunwind...

----

hadrien@linux-2ak3:~> ldd /usr/bin/perf
	linux-vdso.so.1 (0x00007ffc079ae000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fc2db3c1000)
	librt.so.1 => /lib64/librt.so.1 (0x00007fc2db1b9000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fc2dae6e000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fc2dac6a000)
	libelf.so.1 => /usr/lib64/libelf.so.1 (0x00007fc2daa52000)
	libdw.so.1 => /usr/lib64/libdw.so.1 (0x00007fc2da80a000)
	libunwind-x86_64.so.8 => /usr/lib64/libunwind-x86_64.so.8 (0x00007fc2da5eb000)
	libunwind.so.8 => /usr/lib64/libunwind.so.8 (0x00007fc2da3d1000)
	liblzma.so.5 => /usr/lib64/liblzma.so.5 (0x00007fc2da196000)
	libaudit.so.1 => /usr/lib64/libaudit.so.1 (0x00007fc2d9f70000)
	libslang.so.2 => /usr/lib64/libslang.so.2 (0x00007fc2d9aab000)
	libperl.so => /usr/lib/perl5/5.26.1/x86_64-linux-thread-multi/CORE/libperl.so (0x00007fc2d96a4000)
	libpython2.7.so.1.0 => /usr/lib64/libpython2.7.so.1.0 (0x00007fc2d9260000)
	libz.so.1 => /lib64/libz.so.1 (0x00007fc2d9049000)
	libnuma.so.1 => /usr/lib64/libnuma.so.1 (0x00007fc2d8e3d000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fc2d8a83000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fc2dd9d6000)
	libbz2.so.1 => /usr/lib64/libbz2.so.1 (0x00007fc2d8866000)
	libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007fc2d862b000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007fc2d8428000)

----

...but by going meta and profiling perf script with perf during my 
experiments, I figured out that it is actually using libunwind here.


>> My Linux distribution, openSUSE
>> Tumbleweed, has the nasty but sadly widespread habit of building
>> everything using -fomit-frame-pointer, which makes FP-based call graphs
>> impractical. And some parts of the code produce rather huge stack traces
>> (> 100 frames, most likely originating from recursion) which preclude
>> use of LBR-based profiling. So as far as I understand, my only option is
>> to use DWARF with stack samples that are as large as possible ( 65528 ),
>> and hope that the remaining truncated traces do not bias my profile too
>> much. I estimated by analyzing the output of perf script (more about
>> that below) that they are < 2%, so the impact shouldn't be too bad.
>>
>> Since these big stack semples cause quite a lot of perf.data I/O, I keep
>> the sampling rate reasonable (1 kHz) and store my perf.data on a ramdisk
>> during sampling. With these final tweaks, my perf record command ends up
>> looking like this:
>>
>> $ perf record -a --call-graph=dwarf,65528 -F 1000 -o /dev/shm/perf.data
>> basf2 02_fit.py -i simulated.root && mv /dev/shm/perf.data /tmp/perf.data
> Why do you run record with `-a`? basf2 launches your simulation, right? So
> just recording it and its children should be enough for you, no?

I like to run with -a as a default, because it gives me a broader 
picture by telling me about the background system activity during a 
measurement: other CPU-hungry applications which I forgot to close (I 
unfortunately cannot afford the luxury of a dedicated node for 
performance measurements), the overhead of perf itself when I get too 
greedy with DWARF call graphs, etc.

IIRC, running with -a is also necessary to get a representative picture 
of kernel-side overhead in applications that perform a lot of syscalls. 
I was recently experimenting with a system monitoring library that would 
put some heavy load on procfs, and from memory the perf record/report 
picture was totally different in "normal" mode and with -a on.

However, you are correct that I do not need it any of these capabilities 
here, and that it introduces unnecessary complexity in our discussion, 
so I re-did a run without it.

With that change...

  * I don't get any samples without a stack trace anymore
  * Obviously the nvidia samples are gone as well (the way it should be,
    since this code is not supposed to do graphics)
  * I still get 1.6% of stack traces ending with ffffffffffffffff
  * I still get a negligible amount of /tmp/perf-<PID>.map samples
    (expected, the ROOT toolkit from HEP does some C++ JIT compilation
    for persistence of arbitrary objects)
  * I still get 10.6% of stack traces ending in the "[unknown]" DSO for
    no clear reason.
  * I still get 0.6% of stack traces ending abruptly.

Obviously, the behaviour which I am most interesting in is the one that 
introduces the highest bias in my profile (~11% starts to be enough to 
bias the conclusions of a performance analysis if it is all grouped in a 
single place), so it is fine by me if we focus on that one :)


>> Due to the aforementioned huge stack traces, I also had to increase perf
>> report's stack limit to avoid systematic statistical bias against large
>> stack traces. I did not find an "unlimited" option, so I just made it
>> large enough to encompass any possible stack trace:
>>
>> $ perf report --max-stack=65535 -i /tmp/perf.data
>>
>> -----
>>
>> Now, my problem is that the aforementioned perf report command only
>> attributes ~84% of the samples to the top-level function of the program
>> (here __libc_start_main), which seems a little low to me. In an attempt
>> to understand this, I started analyzing the perf script output, and
>> noticed a number of anomalous samples which I would like to discuss
>> further with you.
>>
>> ~0.7% of samples have no stack trace at all. I'm not sure if this is
>> expected, my guess was that this could possibly happen if the PMU
>> interrupt fires at a time where the system is in an idle state. You tell
>> me. In that case, perf script only displays a header like this:
>>
>> .   irqbalance  1497 [001]   275.010584:    1320760 cycles:uppp:
> This is probably a side-effect of you using `-a`, try removing it.
>
>> ~ 1.6% of stack traces end with the ffffffffffffffff pointer. I had a
>> little chat about those with Jiri on IRC, who suggested that a common
>> reason for this is when the stack sample is not large enough. It
>> certainly seems true for some samples, but I am not sure if this is
>> always the right explanation as I get it even for very short stacks like
>> the following one:
>>
>> .   basf2  3272 [007]   300.526376:    3571762 cycles:uppp:
>> .   	           27be5 __ieee754_pow_sse2 (/lib64/libm-2.26.so)
>> .   	ffffffffffffffff [unknown] ([unknown])
> Do you have debug symbols installed for libm/libc? Do you see other frames
> where unwinding through __ieee754_pow_sse2 works properly? I've personally
> also encountered issues similar to this one, and haven't found an explanation.
> I guess there can be many problems, my current hunch is buggy DWARF
> interpretation by libunwind, or alternatively wrong/limited information
> emitted by the compiler.

I have debug symbols for libm/libc, and also for the other DSOs which 
produce similarly broken stacks (libstdc++, ROOT, libpython, Geant4...).

If there is anything I can do to help you with investigating that 
anomaly, be my guest :)


>> However, it might be the case that some functions allocate very large
>> stack objects, or that this invalid pointer is used in other cases. I
>> welcome additional explanations here.
>>
>> ~0.6% of samples look mostly normal, but end with a DSO like
>> "/tmp/perf-<PID>.map". A web search suggests that this happens when perf
>> detected JIT-compiled code, but did not get DWARF information from the
>> JIT. And in most cases this explanation looks accurate to me as the next
>> DSO in the stack is typically libmozjs or similar.
>>
>> ~0.2% of samples are full of "[unknown]" symbols and end up somewhere in
>> a DSO with "nvidia" in its name. I understand this as originating from
>> the fact that DWARF call graphs cannot work well with proprietary code
>> that does not have debug info, and that's fine by me considering the low
>> amount of samples.
> The proprietary nvidia libs have neither frame pointers, nor DWARF
> information, so unwinding is often impossible there and thus ends up in
> [unknown].
>
>> Now, these are the anomalous samples which I think I understand. But as
>> you can see, they are far from accounting for all of my 16% of "missing"
>> samples. For the remaining ones, I can explain ~2.8% as originating from
>> other system activity (other running programs, syscalls, etc), but that
>> still leaves a good 10.2% of samples for which I have absolutely no idea
>> what's going on.
>>
>> In the majority of the cases (~9.7%), the stack traces just suddenly go
>> someplace weird for no apparent reason:
>>
>> .   basf2  3272 [007]   300.560379:    3571034 cycles:uppp:
>> .   	          1a7036 G4PolyconeSide::DistanceAway
>> (/home/hadrien/Software/Belle2/externals/development/Linux_x86_64/opt/lib/l
>> ibG4geometry.so) .   	               1 [unknown] ([unknown])
>>
>> While in the remaining cases (~0.6%), the stack traces start fine but
>> end up rather abruptly:
>>
>> .   basf2  3272 [007]   300.541377:    3571664 cycles:uppp:
>> .   	            e4a9 Belle2::G4SafeNavigator::LocateGlobalPointAndSetup
>> (/home/hadrien/Software/Belle2/tests-release/modules/Linux_x86_64/opt/libge
>> nfitUtilities.so)
> In both cases, do you have full dwarf information available for these
> libraries? What compiler did you use for compilation? How deep into the stack
> trace does this happen?

I have the DWARF information for these libraries. Since I have had to 
build some of them myself, I thought it might have been a build system 
misconfiguration, but as far as I know ELF debugging sections never lie:

----

hadrien@linux-2ak3:~/Bureau/Programmation/perf-script-analyze> readelf -S /home/hadrien/Software/Belle2/externals/development/Linux_x86_64/opt/lib/libG4geometry.so
Il y a 36 en-têtes de section, débutant à l'adresse de décalage 0x1adc960:

En-têtes de section :
   [Nr] Nom               Type             Adresse           Décalage
        Taille            TaillEntrée      Fanion Lien  Info  Alignement
   [ 0]                   NULL             0000000000000000  00000000
        0000000000000000  0000000000000000           0     0     0
   [ 1] .hash             HASH             0000000000000190  00000190
        0000000000008c24  0000000000000004   A       2     0     8
   [ 2] .dynsym           DYNSYM           0000000000008db8  00008db8
        000000000001c860  0000000000000018   A       3     1     8
   [ 3] .dynstr           STRTAB           0000000000025618  00025618
        000000000003579e  0000000000000000   A       0     0     1
   [ 4] .gnu.version      VERSYM           000000000005adb6  0005adb6
        0000000000002608  0000000000000002   A       2     0     2
   [ 5] .gnu.version_r    VERNEED          000000000005d3c0  0005d3c0
        00000000000000d0  0000000000000000   A       3     4     8
   [ 6] .rela.dyn         RELA             000000000005d490  0005d490
        0000000000018990  0000000000000018   A       2     0     8
   [ 7] .rela.plt         RELA             0000000000075e20  00075e20
        00000000000089a0  0000000000000018  AI       2    22     8
   [ 8] .init             PROGBITS         000000000007e7c0  0007e7c0
        0000000000000017  0000000000000000  AX       0     0     4
   [ 9] .plt              PROGBITS         000000000007e7e0  0007e7e0
        0000000000005bd0  0000000000000010  AX       0     0     16
   [10] .plt.got          PROGBITS         00000000000843b0  000843b0
        0000000000000038  0000000000000000  AX       0     0     8
   [11] .text             PROGBITS         00000000000843f0  000843f0
        00000000001b1b9d  0000000000000000  AX       0     0     16
   [12] .fini             PROGBITS         0000000000235f90  00235f90
        0000000000000009  0000000000000000  AX       0     0     4
   [13] .rodata           PROGBITS         0000000000235fa0  00235fa0
        00000000000108e5  0000000000000000   A       0     0     32
   [14] .eh_frame_hdr     PROGBITS         0000000000246888  00246888
        0000000000006d3c  0000000000000000   A       0     0     4
   [15] .eh_frame         PROGBITS         000000000024d5c8  0024d5c8
        0000000000028a14  0000000000000000   A       0     0     8
   [16] .gcc_except_table PROGBITS         0000000000275fdc  00275fdc
        000000000000b2f2  0000000000000000   A       0     0     4
   [17] .init_array       INIT_ARRAY       00000000004820e8  002820e8
        00000000000006d8  0000000000000008  WA       0     0     8
   [18] .fini_array       FINI_ARRAY       00000000004827c0  002827c0
        0000000000000008  0000000000000008  WA       0     0     8
   [19] .data.rel.ro      PROGBITS         00000000004827c8  002827c8
        0000000000007a70  0000000000000000  WA       0     0     8
   [20] .dynamic          DYNAMIC          000000000048a238  0028a238
        0000000000000270  0000000000000010  WA       3     0     8
   [21] .got              PROGBITS         000000000048a4a8  0028a4a8
        0000000000000b58  0000000000000008  WA       0     0     8
   [22] .got.plt          PROGBITS         000000000048b000  0028b000
        0000000000002df8  0000000000000008  WA       0     0     8
   [23] .data             PROGBITS         000000000048de00  0028de00
        00000000000000fc  0000000000000000  WA       0     0     32
   [24] .bss              NOBITS           000000000048df00  0028defc
        0000000000006268  0000000000000000  WA       0     0     32
   [25] .comment          PROGBITS         0000000000000000  0028defc
        0000000000000011  0000000000000001  MS       0     0     1
   [26] .debug_aranges    PROGBITS         0000000000000000  0028df10
        0000000000008980  0000000000000000           0     0     16
   [27] .debug_info       PROGBITS         0000000000000000  00296890
        0000000000e6fae4  0000000000000000           0     0     1
   [28] .debug_abbrev     PROGBITS         0000000000000000  01106374
        000000000009e761  0000000000000000           0     0     1
   [29] .debug_line       PROGBITS         0000000000000000  011a4ad5
        0000000000121d15  0000000000000000           0     0     1
   [30] .debug_str        PROGBITS         0000000000000000  012c67ea
        00000000001278fe  0000000000000001  MS       0     0     1
   [31] .debug_loc        PROGBITS         0000000000000000  013ee0e8
        000000000051f1e4  0000000000000000           0     0     1
   [32] .debug_ranges     PROGBITS         0000000000000000  0190d2d0
        000000000016d610  0000000000000000           0     0     16
   [33] .symtab           SYMTAB           0000000000000000  01a7a8e0
        0000000000025d28  0000000000000018          34   1588     8
   [34] .strtab           STRTAB           0000000000000000  01aa0608
        000000000003c201  0000000000000000           0     0     1
   [35] .shstrtab         STRTAB           0000000000000000  01adc809
        0000000000000152  0000000000000000           0     0     1
Key to Flags:
   W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
   L (link order), O (extra OS processing required), G (group), T (TLS),
   C (compressed), x (unknown), o (OS specific), E (exclude),
   l (large), p (processor specific)

----

Everything was compiled using GCC 7.2.0, and as you can see in the perf 
script samples which I provided you in my initial mail, the problem 
tends to happen very early in the stack trace, typically at the first or 
second frame.


>> Can you help me check if my understanding of the other samples is
>> correct, and give me some clues about what could happen for these last
>> few weird ones?
>>
>> I can provide perf.data files and archives on demand, but since the
>> original is a rather big upload/download ( 2.7 GB ), I thought I would
>> wait until you can give me some specific requests or a way to produce
>> skimmed datasets with only the samples that you are looking for.
> The perf.data file wouldn't be enough, we'd need access to all of the so/dbg
> files too. perf archive could be used for that purpose, but I've seen many
> situations where not all DSOs encountered had a build-id, and thus where not
> put into the archive...

Yes, back when I discussed the ffffffffffffffff samples with Jiri on 
IRC, we had this problem that perf archive failed to include all 
necessary DSOs for analysis. So I'm not sure if it would work here.

If there is anything else which I can do to help you here, just tell me!

Cheers,
Hadrien
