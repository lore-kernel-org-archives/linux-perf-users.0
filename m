Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3C3C433B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75128610F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhDPLRX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 07:17:23 -0400
Received: from foss.arm.com ([217.140.110.172]:39192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPLRW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 07:17:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0373A31B;
        Fri, 16 Apr 2021 04:16:58 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 980503F85F;
        Fri, 16 Apr 2021 04:16:57 -0700 (PDT)
Subject: Re: Perf call graphs on ARM
To:     "Fontius Sebastian (XC-DA/ESV9)" <Sebastian.Fontius@de.bosch.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <e083221298cc4bd09c4d77a85a33c2a1@de.bosch.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <25a2fd6c-05ca-3ccc-11a3-41249323fbd2@arm.com>
Date:   Fri, 16 Apr 2021 14:16:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e083221298cc4bd09c4d77a85a33c2a1@de.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 14/04/2021 16:22, Fontius Sebastian (XC-DA/ESV9) wrote:
> Hi everyone,
> 
> we are having trouble to get perf to output a call graph using frame pointers on a Raspberry Pi 2 Model B Revision 1.1 (ARM Cortex-A7) running Raspbian on its official Kernel versions 4.9 and 5.10.
> 
> Let me illustrate the problem we're having using a small test program we will call aaa.cpp:
> 
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

Hi Sebastian,

Is it possible to simplify the example and hold the process in G(), with some
kind of while loop for example (as long as the compiler still produces frame
records for each function).

I tried this on 64bit Arm and got a sensible stack and the kernel's frame pointer
unwind for 64 bit is pretty much the same as the 32 bit one. Could it be that
samples are being taken in the function prologues before the frame pointer is
fully setup which is causing some unexpected results?

Here is my stack which looks mostly the same with --call-graph=fp and --call-graph=dwarf:

-   99.73%    99.73%  unwind-simple.o  unwind-simple.out    [.] G                                                                                                                     
     0xfffff67decfd                                                                                                                                                                   
     _start                                                                                                                                                                           
     __libc_start_main                                                                                                                                                                
     main                                                                                                                                                                             
     doit                                                                                                                                                                             
     G   

Thanks
James

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
> 
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
