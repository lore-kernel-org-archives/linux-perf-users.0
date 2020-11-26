Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E7AC56202
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1311B221E9
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAClFcLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbgKZNIx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 08:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390067AbgKZNIx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 08:08:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CE821D46;
        Thu, 26 Nov 2020 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606396132;
        bh=viiBRexjTrW8vzVFXbk6VdMTF1/y030vXai4MZE/kN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CAClFcLFWsgL5TmyoOoBfT2ApTsYlNcdWBfVUcyO2qfw4+FqA3t7oNSzbuaKBw0qS
         hKcPSQIRV2XNhIqlsHeYJYmySOW48ygtjz41NRMoS99tsJsn/3L0vktxAhvqsDD4v9
         GWpgvm6wFgBSiSGm0zWlJST7x6QIq6PIP2vnBVsQ=
Date:   Thu, 26 Nov 2020 22:08:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Fedora 33 and perf probe failures
Message-Id: <20201126220848.e515e3da6921d1512108e3bf@kernel.org>
In-Reply-To: <42f12f48-d515-8d7b-0116-d063afea9273@linux.ibm.com>
References: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
        <20201119100711.2309580850fec6a58142f7f1@kernel.org>
        <42f12f48-d515-8d7b-0116-d063afea9273@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Thomas,

I've setup fedora33 and found strange debuginfo.

On Thu, 19 Nov 2020 09:16:57 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> [root@f33 ~]# perf probe -vvv -L getname_flags
> Looking at the vmlinux_path (8 entries long)
> Using /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux for symbols
> Open Debuginfo file: /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux
> fname: ./include/linux/fs.h, lineno:2527
> New line range: 2527 to 2147483647
> path: (null)
> Specified source line is not found.
>   Error: Failed to show lines. Reason: No such file or directory (Code: -2)

Above error was reproduced, and I found that the perf-probe's routine
failed to find the real function definition.

I decoded the vmlinux with eu-readelf -w, and I found there were 2
entries (DIEs) for the getname_flags.

(1)
 [2dbe7c6]    subprogram           abbrev: 54
             external             (flag_present) yes
             name                 (strp) "getname_flags"
             decl_file            (data1) fs.h (8)
             decl_line            (data2) 2527
             decl_column          (data1) 25
             prototyped           (flag_present) yes
             type                 (ref4) [2dbe7e7]
             sibling              (ref4) [2dbe7e7]
 [2dbe7d7]      formal_parameter     abbrev: 4
               type                 (ref4) [2da9721]
 [2dbe7dc]      formal_parameter     abbrev: 4
               type                 (ref4) [2da97a1]
 [2dbe7e1]      formal_parameter     abbrev: 4
               type                 (ref4) [2dabbdd]

(2)
 [2e0fde0]    subprogram           abbrev: 162
             external             (flag_present) yes
             name                 (strp) "getname_flags"
             decl_file            (data1) namei.c (1)
             decl_line            (data1) 128
             decl_column          (data1) 1
             prototyped           (flag_present) yes
             type                 (ref4) [2dfced6]
             inline               (data1) inlined (1)
             sibling              (ref4) [2e0fe49]
 [2e0fdf2]      formal_parameter     abbrev: 31
               name                 (strp) "filename"
               decl_file            (data1) namei.c (1)
               decl_line            (data1) 128
               decl_column          (data1) 34
               type                 (ref4) [2de77f3]
 [2e0fdfe]      formal_parameter     abbrev: 31
               name                 (strp) "flags"
               decl_file            (data1) namei.c (1)
               decl_line            (data1) 128
               decl_column          (data1) 48
               type                 (ref4) [2de7873]
 [2e0fe0a]      formal_parameter     abbrev: 31
               name                 (strp) "empty"
               decl_file            (data1) namei.c (1)
               decl_line            (data1) 128
               decl_column          (data1) 60
               type                 (ref4) [2de9ce4]

The first one is not the actual function, but that is a DIE
for the declaration. However, this DIE doesn't have DW_AT_declaration
attribute, it should be there if the DIE represents the declaration.

In perf, die_is_func_def() checks that attribute, and if the DIE doen't
have DW_AT_declaration, line_range_search_cb() think the DIE represents
the function definition (function prototype). And search the instance
to find the line range.

However, since the (1) has no DW_AT_declaration, perf probe was mislead
that the DIE is the function definition, and search the function instance
which links to the DIE. And it failed to find any instances because
the DIE it found was just a prototype in the header file. (But it seems
some call-site DIE refers the declaration DIE.)

Let me try to fix if we skip the first DIE.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
