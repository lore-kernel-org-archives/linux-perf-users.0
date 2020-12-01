Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAFFC64E7A
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D42207FF
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Dec 2020 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaDcm7Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLANZz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgLANZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Dec 2020 08:25:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5309C2086A;
        Tue,  1 Dec 2020 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606829113;
        bh=UhznvO8zap1Y3rVrYCcaAYTh7y+bw2WlsUPMr4u3OOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaDcm7LdTtUTAc+nSZY2ckkSqnVa+kmjQGyJSxtLILZjMqhDT2Wg4qc/4UylxHB4U
         eGeIqBsRZzx6pw757E0QtOvV7QWIAWjyttKwQ9qjI1zzAM/XjPnvgTgpOX/XR+3gbO
         QDM/xmhNVKc5Z/tp7fEiM/fJuXVxUMweiZO8r95I=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3230B4079D; Tue,  1 Dec 2020 10:25:17 -0300 (-03)
Date:   Tue, 1 Dec 2020 10:25:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: perf probe can't remove probes
Message-ID: <20201201132517.GC49333@kernel.org>
References: <20201125172755.GA53351@kernel.org>
 <20201126092125.402257a8776637d6bd2e090c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126092125.402257a8776637d6bd2e090c@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Masami,

	Any idea why listing the source code doesn't work while simply
adding the probe works?

[root@seventh ~]# perf probe verify_pkcs7_signature
Added new event:
  probe:verify_pkcs7_signature (on verify_pkcs7_signature)

You can now use it in all perf tools, such as:

	perf record -e probe:verify_pkcs7_signature -aR sleep 1

[root@seventh ~]#

[root@seventh ~]# readelf -wi /lib/modules/5.10.0-rc3.bpfsign+/build/vmlinux | grep DW_AT_producer -m2
    <1c>   DW_AT_producer    : (indirect string, offset: 0x50): GNU AS 2.35
    <2f>   DW_AT_producer    : (indirect string, offset: 0x2daf): GNU C89 10.2.1 20201016 (Red Hat 10.2.1-6) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-strict-overflow -fstack-check=no -fconserve-stack -fcf-protection=none -fno-stack-protector
[root@seventh ~]#

[root@seventh ~]# perf probe -L verify_pkcs7_signature
Specified source line is not found.
  Error: Failed to show lines.
[root@seventh ~]# grep verify_pkcs7_signature /proc/kallsyms
ffffffff9f2617b0 T verify_pkcs7_signature
ffffffffa047ac30 r __ksymtab_verify_pkcs7_signature
ffffffffa0482e38 r __kstrtabns_verify_pkcs7_signature
ffffffffa0483b3b r __kstrtab_verify_pkcs7_signature
[root@seventh ~]# perf probe -L verify_pkcs7_signature
Specified source line is not found.
  Error: Failed to show lines.
[root@seventh ~]# perf probe -v -L verify_pkcs7_signature
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/5.10.0-rc3.bpfsign+/build/vmlinux for symbols
Open Debuginfo file: /lib/modules/5.10.0-rc3.bpfsign+/build/vmlinux
fname: /home/acme/git/bpf/include/linux/verification.h, lineno:38
New line range: 38 to 2147483647
path: (null)
Specified source line is not found.
  Error: Failed to show lines. Reason: No such file or directory (Code: -2)
[root@seventh ~]# readelf -wi /lib/modules/5.10.0-rc3.bpfsign+/build/vmlinux | grep -B2 -A8 verify_pkcs7_signature
 <1><1a362a2>: Abbrev Number: 64 (DW_TAG_subprogram)
    <1a362a3>   DW_AT_external    : 1
    <1a362a3>   DW_AT_name        : (indirect string, offset: 0xc2d22): verify_pkcs7_signature
    <1a362a7>   DW_AT_decl_file   : 52
    <1a362a8>   DW_AT_decl_line   : 38
    <1a362a9>   DW_AT_decl_column : 12
    <1a362aa>   DW_AT_prototyped  : 1
    <1a362aa>   DW_AT_type        : <0x1a3333f>
    <1a362ae>   DW_AT_sibling     : <0x1a36313>
 <2><1a362b2>: Abbrev Number: 65 (DW_TAG_formal_parameter)
    <1a362b3>   DW_AT_name        : (indirect string, offset: 0x19ee3d): data
--
 <1><24fa79d>: Abbrev Number: 83 (DW_TAG_subprogram)
    <24fa79e>   DW_AT_external    : 1
    <24fa79e>   DW_AT_name        : (indirect string, offset: 0xc2d22): verify_pkcs7_signature
    <24fa7a2>   DW_AT_decl_file   : 218
    <24fa7a3>   DW_AT_decl_line   : 38
    <24fa7a4>   DW_AT_decl_column : 12
    <24fa7a5>   DW_AT_prototyped  : 1
    <24fa7a5>   DW_AT_type        : <0x24e1e05>
    <24fa7a9>   DW_AT_sibling     : <0x24fa80e>
 <2><24fa7ad>: Abbrev Number: 41 (DW_TAG_formal_parameter)
    <24fa7ae>   DW_AT_name        : (indirect string, offset: 0x19ee3d): data
--
    <26258b8>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0 	(DW_OP_addr: 0)
 <1><26258c2>: Abbrev Number: 116 (DW_TAG_variable)
    <26258c3>   DW_AT_name        : (indirect string, offset: 0x10523f): __UNIQUE_ID___addressable_verify_pkcs7_signature164
    <26258c7>   DW_AT_decl_file   : 1
    <26258c8>   DW_AT_decl_line   : 305
    <26258ca>   DW_AT_decl_column : 1
    <26258cb>   DW_AT_type        : <0x2620ca6>
    <26258cf>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0 	(DW_OP_addr: 0)
 <1><26258d9>: Abbrev Number: 117 (DW_TAG_subprogram)
    <26258da>   DW_AT_external    : 1
    <26258da>   DW_AT_name        : (indirect string, offset: 0x1050d9): pkcs7_free_message
--
 <1><2625c2e>: Abbrev Number: 120 (DW_TAG_subprogram)
    <2625c2f>   DW_AT_external    : 1
    <2625c2f>   DW_AT_name        : (indirect string, offset: 0xc2d22): verify_pkcs7_signature
    <2625c33>   DW_AT_decl_file   : 1
    <2625c34>   DW_AT_decl_line   : 282
    <2625c36>   DW_AT_decl_column : 5
    <2625c37>   DW_AT_prototyped  : 1
    <2625c37>   DW_AT_type        : <0x26209e9>
    <2625c3b>   DW_AT_low_pc      : 0xffffffff812617b0
    <2625c43>   DW_AT_high_pc     : 0x73
    <2625c4b>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
--
 <1><495560e>: Abbrev Number: 68 (DW_TAG_subprogram)
    <495560f>   DW_AT_external    : 1
    <495560f>   DW_AT_name        : (indirect string, offset: 0xc2d22): verify_pkcs7_signature
    <4955613>   DW_AT_decl_file   : 61
    <4955614>   DW_AT_decl_line   : 38
    <4955615>   DW_AT_decl_column : 12
    <4955616>   DW_AT_prototyped  : 1
    <4955616>   DW_AT_type        : <0x49519fd>
    <495561a>   DW_AT_sibling     : <0x495567f>
 <2><495561e>: Abbrev Number: 74 (DW_TAG_formal_parameter)
    <495561f>   DW_AT_name        : (indirect string, offset: 0x19ee3d): data
