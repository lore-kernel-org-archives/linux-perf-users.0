Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB4ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiHaQQF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiHaQPz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 12:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB015FC5
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 09:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EC7AB821E7
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 16:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006DFC433D6;
        Wed, 31 Aug 2022 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661962551;
        bh=W7akWVCk7SwY/cZltR04pZb//YBrWYi2mWc4lS/sQFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvIGP87K+P0Q3aNUNsExGucN3ZIO9B0Gq/xvWN/xqg9uiE9aY6JPo5s1PQLV5yqcV
         Il//CHbm6MaW5f9dzPBiWpmsA5SY6c81B94hVwZPXmqoj5qhYO0ISBzMbuJ63bJAPC
         Ey40+PA9FT0Ssv0B7x3RdxnvHz8/j370Riuu01XLRrQuVbAQDNW0D/FoFUfwm3I0iF
         qTuXiiogQYCSyKIw5ntPQSg6uZOI9u3j/lzSzw8OK64wcgEfRgwCTbFU5By9gobEgw
         SN+zeOP3FohxcSOB1bkBAuZW9jiLS1x/jIp7Zpo3mqvZcMN0JsbsKo0JA05H/DwmYX
         79yt65UtNEOQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B5E8404A1; Wed, 31 Aug 2022 13:15:48 -0300 (-03)
Date:   Wed, 31 Aug 2022 13:15:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     William Cohen <wcohen@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: PROBLEM: The --call-graph=fp data does do not agree with the
 --call-graph=dwarf results
Message-ID: <Yw+JNCAHEylfxmsr@kernel.org>
References: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
 <Yw9RVlb3YxpTxROw@krava>
 <4906849.bAGh5ZhPcH@milian-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4906849.bAGh5ZhPcH@milian-workstation>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 31, 2022 at 04:22:31PM +0200, Milian Wolff escreveu:
> On Mittwoch, 31. August 2022 14:17:26 CEST Jiri Olsa wrote:

> > > initially discovered when processing perf.data files created with
> > > --call-graph=dwarf.  The output of the perf-report call-graph for
> > > dwarf information notes inlined functions in the report. The
> > > excessive time spent in binutils bfd's lookup_func_by_offset was
> > > caused by perf-report building up a red-black tree mapping IP
> > > addresses to functions including inlined functions.

> > > I ran a similar experiment with --call-graph=fp to see if it
> > > triggered the same execessive overhead in building the red-black
> > > tree for inlined functions.  It did not.  The resulting output of
> > > the perf-report for --call-graph=fp does not include information
> > > about inlined functions.

> > > I have a small reproducer in the attached perf_inlined.tar.gz that
> > > demonstrates the difference between the two methods of storing
> > > call-chain information. Compile and collect data with:

> > > tar xvfz perf_inlined.tar.gz
> > > cd perf_inlined
> > > make all
> > > perf report --input=perf_fp.data > fp.log
> > > perf report --input=perf_dwarf.data > dwarf.log
> > > 
> > > The dwarf.log has the expected call structure for main:
> > >                main
> > >                
> > >                 --85.72%--fill_array (inlined)
> > >                 
> > >                           |--78.09%--rand
> > >                           |
> > >                           |           --75.10%--__random
> > >                           |           
> > >                           |                      --9.14%--__random_r
> > >                           |
> > >                           |--1.58%--compute_sqrt (inlined)
> > >                           |
> > >                            --1.32%--_init
> > > 
> > > The fp.log looks odd given program:
> > what's odd about that? perhaps the confusion is that you are
> > in children mode? you could try --no-children
> > 
> > >    99.99%     0.00%  time_waste  libc.so.6             [.]
> > >    __libc_start_call_main>    
> > >             ---__libc_start_call_main
> > >             
> > >                |--66.07%--__random
> > >                |
> > >                |--21.28%--main
> > >                |
> > >                |--8.42%--__random_r
> > >                |
> > >                |--2.91%--rand
> > >                |
> > >                 --1.31%--_init
 
> > > Given how common that functions are inlined in optimized code it seems
> > > like perf-report of --call-graph=fp should include information about
> > > time spent in inlined functions.
 
> > hum, so 'fp' call graph is tracersing frame pointers which I would
> > not expect for inlined functions
 
> I think the oddity is that there is no mention of any (inlined) frames at all 
> in frame pointer unwinding. I guess this is simply an oversight - I never had 
> a setup where frame pointers are available and thus never implemented that. It 
> might be that similar issues arises for LBR unwinding? Hopefully it's just a 
> matter of reusing some of the DWARF code for FP/LBR.

Right, probably add the inlining info in DWARF for the ranges where its
expanded, things like:

 <1><9da>: Abbrev Number: 54 (DW_TAG_subprogram)
    <9db>   DW_AT_external    : 1
    <9db>   DW_AT_name        : (indirect string, offset: 0x5680): cmd_bench
    <9df>   DW_AT_decl_file   : 1
    <9e0>   DW_AT_decl_line   : 252
    <9e1>   DW_AT_decl_column : 5
    <9e2>   DW_AT_prototyped  : 1
    <9e2>   DW_AT_type        : <0x55>
    <9e6>   DW_AT_low_pc      : 0x40fa40
    <9ee>   DW_AT_high_pc     : 0x461
    <9f6>   DW_AT_frame_base  : 1 byte block: 9c        (DW_OP_call_frame_cfa)
    <9f8>   DW_AT_call_all_calls: 1
    <9f8>   DW_AT_sibling     : <0x11b4>
<SNIP>
 <3><a76>: Abbrev Number: 24 (DW_TAG_inlined_subroutine)
    <a77>   DW_AT_abstract_origin: <0x177b>
    <a7b>   DW_AT_entry_pc    : 0x40fc15
    <a83>   DW_AT_GNU_entry_view: 1
    <a84>   DW_AT_low_pc      : 0x40fc15
    <a8c>   DW_AT_high_pc     : 0x4c
    <a94>   DW_AT_call_file   : 1
    <a94>   DW_AT_call_line   : 318
    <a96>   DW_AT_call_column : 4
    <a97>   DW_AT_sibling     : <0xb48>
<SNIP>
 <1><177b>: Abbrev Number: 43 (DW_TAG_subprogram)
    <177c>   DW_AT_name        : (indirect string, offset: 0xa42b): dump_benchmarks
    <1780>   DW_AT_decl_file   : 1
    <1780>   DW_AT_decl_line   : 133
    <1781>   DW_AT_decl_column : 13
    <1781>   DW_AT_prototyped  : 1
    <1781>   DW_AT_inline      : 1      (inlined)
    <1781>   DW_AT_sibling     : <0x179d>


Where, in the perf binary, cmd_bench() calls dump_benchmarks() that gets
inlined at that DW_AT_entry_pc/DW_AT_low_pc/DW_AT_high_pc range inside
cmd_bench().

Probably we could add those to the dso symbols list with some flag to
mean its an inline and from where to get more info about it.

This is important, as Will points out as functions not explicitely
marked inline end up being inlined by the compiler.

- Arnaldo
