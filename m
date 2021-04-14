Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A82C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1661611AD
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhDNNix (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhDNNiw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Apr 2021 09:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0459611B0;
        Wed, 14 Apr 2021 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407511;
        bh=IgP0aMyCCm/PYV2v0DllDGnDwAbw/198WivxSDk9IWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irHfEbTMBnjrHnQzAvwdcFrStnDZRGJUSyZpW3tNUaptgbt9MNsXwvReY9Hzh4o8O
         B/1pB0oQVBhPv50pZEo8K2C3la9HCzi1+VGGlVz7ah8rOr/AcMlqmXjiyjYqUowWAA
         le7q1rBGOHiGbyy+GtVmFO9k1FbOZiAYekeIXU1l0QeWQjSLvzPtViSvR1jKBjT3Gb
         Eq8uQTewphdUwSrI6YBaOBXrLEXtaIMG0DNx7PFyqH/DVq+e///b4/JTXILulskt8l
         EFY5t/jrqrbjF18vY90ycEcJKLFyBHgJUJgzXW54utkAvPr7Jmeh/mmkdIBhc5Givv
         t+0y+YpWd06vA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C05CE40647; Wed, 14 Apr 2021 10:38:27 -0300 (-03)
Date:   Wed, 14 Apr 2021 10:38:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Fontius Sebastian (XC-DA/ESV9)" <Sebastian.Fontius@de.bosch.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Perf call graphs on ARM
Message-ID: <YHbwU1mCp+Mslx6a@kernel.org>
References: <e083221298cc4bd09c4d77a85a33c2a1@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e083221298cc4bd09c4d77a85a33c2a1@de.bosch.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Apr 14, 2021 at 01:22:32PM +0000, Fontius Sebastian (XC-DA/ESV9) escreveu:
> Hi everyone,
> 
> we are having trouble to get perf to output a call graph using frame pointers on a Raspberry Pi 2 Model B Revision 1.1 (ARM Cortex-A7) running Raspbian on its official Kernel versions 4.9 and 5.10.
> 
> Let me illustrate the problem we're having using a small test program we will call aaa.cpp:

First question is what perf version are you using? The one that comes
with the distro you're using? If so can you please try following the
instructions at:

https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/HOWTO.build.perf

And try with the latest released perf, i.e.:

https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/v5.1.0/perf-5.1.0.tar.xz

Now lemme look at your message:
 
> #include <iostream>
> #include <cmath>
> __attribute__((noinline)) double G(double aaa) {
>   return sqrt(aaa);
> }
> __attribute__((noinline)) double doit(double aaa) {
>   for(int i=0; i<1000; i++)
>     aaa=G(aaa);
>   return aaa;
> }
> int main() {
>   double aaa = 12;
>   for(int i=0; i<10000; i++){
>     aaa = doit(aaa);
>     for(int j=0; j<1000; j++)
>       aaa++;
>     }
>   std::cout << aaa << std::endl;
> }
> 
> This program gets compiled like this using GCC Raspbian 8.3.0-6+rpi1:
> 
> g++ -O2 -fno-omit-frame-pointer aaa.cpp
> 
> Then we run perf on it like this:
> 
> perf record -e cycles --call-graph fp -- ./a.out
> perf report
> 
> In the output of perf there should be a tree like the following:
> 
> main
>   + doit
>     + G
> 
> Instead what we are getting is all of those functions attached to a.out (but we _do_ get the runtimes correctly).

Lemme try this on a x86_64, using the --no-children option:

[acme@five c++]$ perf report --no-children --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 226  of event 'cycles:u'
# Event count (approx.): 230936728
#
# Overhead  Command  Shared Object     Symbol
# ........  .......  ................  ........................
#
    86.45%  a.out    a.out             [.] G
            |
            ---G
               main
               __libc_start_main
               0x49564100002adb3d

    12.96%  a.out    a.out             [.] main
            |
            ---main
               __libc_start_main
               0x49564100002adb3d

     0.36%  a.out    [unknown]         [k] 0xffffffffa7269345
     0.20%  a.out    ld-2.32.so        [.] _dl_relocate_object
     0.02%  a.out    [unknown]         [k] 0xffffffffa7555945
     0.00%  a.out    ld-2.32.so        [.] __GI___tunables_init
     0.00%  a.out    [unknown]         [k] 0xffffffffa7269206
     0.00%  a.out    ld-2.32.so        [.] _dl_start
     0.00%  a.out    [unknown]         [k] 0xffffffffa72da481
     0.00%  a.out    [unknown]         [k] 0xffffffffa7681d07
     0.00%  a.out    [unknown]         [k] 0xffffffffa76821b7


#
# (Tip: Save output of perf stat using: perf stat record <target workload>)
#
[acme@five c++]$

So this is the reverse, so we can:

[acme@five c++]$ perf report --call-graph=fractal,1,caller --no-children --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 226  of event 'cycles:u'
# Event count (approx.): 230936728
#
# Overhead  Command  Shared Object     Symbol
# ........  .......  ................  ........................
#
    86.45%  a.out    a.out             [.] G
            |
            ---0x49564100002adb3d
               __libc_start_main
               main
               G

    12.96%  a.out    a.out             [.] main
            |
            ---0x49564100002adb3d
               __libc_start_main
               main

doit doesn't appear... So I tried using -O0, i.e.:

$ g++ -O0 -fno-omit-frame-pointer aaa.cpp

And there it is:

[acme@five c++]$ perf report --call-graph=fractal,1,caller --no-children --stdio | head -25
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 510  of event 'cycles:u'
# Event count (approx.): 536177203
#
# Overhead  Command  Shared Object     Symbol
# ........  .......  ................  ............................
#
    30.17%  a.out    libm-2.32.so      [.] __sqrt_finite@GLIBC_2.15
            |
            ---0x49564100002aeb3d
               __libc_start_main
               main
               doit
               __sqrt_finite@GLIBC_2.15

    21.84%  a.out    a.out             [.] main
            |
            ---0x49564100002aeb3d
               __libc_start_main
               main

[acme@five c++]$

That first 0x49564100002aeb3d remains a mistery, but I ran out of time,
have to go drive to pick up my 5yo kid :-)

I'll try to read the remaining parts of your message later, but perhaps
the above will help,

Thanks,

- Arnaldo
 
> It seems the frame pointers are written to the binary, but do not work. We can see the frame pointers in a disassembly output created by compiling with -save-temps like this:
> 
> g++ -O2 -fno-omit-frame-pointer -save-temps aaa.cpp
> 
> This gives the following output for the doit() function:
> 
> _Z4doitd:
> .fnstart
> .LFB1758:
> @ args = 0, pretend = 0, frame = 0
> @ frame_needed = 1, uses_anonymous_args = 0
> vmov.f64 d7, d0
> push {r4, r5, fp, lr}
> mov r4, #1000
> add fp, sp, #12
> .L7:
> vmov.f64 d0, d7
> bl _Z1Gd
> subs r4, r4, #1
> vmov.f64 d7, d0
> bne .L7
> pop {r4, r5, fp, pc}
> .cantunwind
> .fnend
> 
> One thing we did try in addition to using frame pointers is to use the DWARF format, but that has some disadvantages like e.g. using roughly 20x the space of the FP format and being much slower to record. Also the recording itself seems unstable and can simply hang the whole Raspberry Pi completely requiring a hard reset. Using Kernel 5.10 the DWARF format also did exhibit the same 'disconnectedness' of the call stack (i.e. all function directly below a.out).
> 
> We also tried running Ubuntu 20.04 using its Kernel 5.4, but there both FP and DWARF were 'disconnected' again.
> 
> We're at a loss what is going wrong here. Does someone here have an idea what we could try to further debug or even understand the problem?
> 
> Mit freundlichen Grüßen / Best regards
> 
> Sebastian Fontius
> 
> Chassis Systems Control, Image Processing 9 (XC-DA/ESV9)
> Robert Bosch GmbH | Postfach 16 61 | 71226 Leonberg | GERMANY | www.bosch.com
> 
> Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart, HRB 14000;
> Aufsichtsratsvorsitzender: Franz Fehrenbach; Geschäftsführung: Dr. Volkmar Denner, 
> Prof. Dr. Stefan Asenkerschbaumer, Filiz Albrecht, Dr. Michael Bolle, Dr. Christian Fischer, 
> Dr. Stefan Hartung, Dr. Markus Heyn, Harald Kröger, Rolf Najork, Uwe Raschke
> 

-- 

- Arnaldo
