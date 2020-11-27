Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6AC63777
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Nov 2020 00:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A66F221FA
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Nov 2020 00:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg4KGDrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbgK0AKJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 19:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730773AbgK0AKJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 19:10:09 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFFD221F1;
        Fri, 27 Nov 2020 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606435808;
        bh=8vLvGGZYxrHQJKMlk6UQmrzI6cuY97gY627sT0cMmlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qg4KGDrG+kZgC+ofdCOAsYubZinrb4zvc65oDW21rUMZliIVU+AGyV3NxBRUnkZ1M
         3dEBR/8kY7cxlCzQ27M9UehFJzkO/pE1CeOOG0PbF/Q7QTvOUKYazdKUsKMKvA+ShU
         +wzDYDHC2IlqMSSKbgGSkSfJ83o6g6HwgzZMDWSs=
Date:   Fri, 27 Nov 2020 09:10:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Fedora 33 and perf probe failures
Message-Id: <20201127091004.525072a77396e3c2fd1ceeba@kernel.org>
In-Reply-To: <20201126172849.GE53384@kernel.org>
References: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
        <20201119100711.2309580850fec6a58142f7f1@kernel.org>
        <42f12f48-d515-8d7b-0116-d063afea9273@linux.ibm.com>
        <20201126220848.e515e3da6921d1512108e3bf@kernel.org>
        <20201126172849.GE53384@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 26 Nov 2020 14:28:49 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Nov 26, 2020 at 10:08:48PM +0900, Masami Hiramatsu escreveu:
> > Hi Thomas,
> > 
> > I've setup fedora33 and found strange debuginfo.
> > 
> > On Thu, 19 Nov 2020 09:16:57 +0100
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > 
> > > [root@f33 ~]# perf probe -vvv -L getname_flags
> > > Looking at the vmlinux_path (8 entries long)
> > > Using /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux for symbols
> > > Open Debuginfo file: /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux
> > > fname: ./include/linux/fs.h, lineno:2527
> > > New line range: 2527 to 2147483647
> > > path: (null)
> > > Specified source line is not found.
> > >   Error: Failed to show lines. Reason: No such file or directory (Code: -2)
> > 
> > Above error was reproduced, and I found that the perf-probe's routine
> > failed to find the real function definition.
> > 
> > I decoded the vmlinux with eu-readelf -w, and I found there were 2
> > entries (DIEs) for the getname_flags.
> > 
> > (1)
> >  [2dbe7c6]    subprogram           abbrev: 54
> >              external             (flag_present) yes
> >              name                 (strp) "getname_flags"
> >              decl_file            (data1) fs.h (8)
> >              decl_line            (data2) 2527
> >              decl_column          (data1) 25
> >              prototyped           (flag_present) yes
> >              type                 (ref4) [2dbe7e7]
> >              sibling              (ref4) [2dbe7e7]
> >  [2dbe7d7]      formal_parameter     abbrev: 4
> >                type                 (ref4) [2da9721]
> >  [2dbe7dc]      formal_parameter     abbrev: 4
> >                type                 (ref4) [2da97a1]
> >  [2dbe7e1]      formal_parameter     abbrev: 4
> >                type                 (ref4) [2dabbdd]
> > 
> > (2)
> >  [2e0fde0]    subprogram           abbrev: 162
> >              external             (flag_present) yes
> >              name                 (strp) "getname_flags"
> >              decl_file            (data1) namei.c (1)
> >              decl_line            (data1) 128
> >              decl_column          (data1) 1
> >              prototyped           (flag_present) yes
> >              type                 (ref4) [2dfced6]
> >              inline               (data1) inlined (1)
> >              sibling              (ref4) [2e0fe49]
> >  [2e0fdf2]      formal_parameter     abbrev: 31
> >                name                 (strp) "filename"
> >                decl_file            (data1) namei.c (1)
> >                decl_line            (data1) 128
> >                decl_column          (data1) 34
> >                type                 (ref4) [2de77f3]
> >  [2e0fdfe]      formal_parameter     abbrev: 31
> >                name                 (strp) "flags"
> >                decl_file            (data1) namei.c (1)
> >                decl_line            (data1) 128
> >                decl_column          (data1) 48
> >                type                 (ref4) [2de7873]
> >  [2e0fe0a]      formal_parameter     abbrev: 31
> >                name                 (strp) "empty"
> >                decl_file            (data1) namei.c (1)
> >                decl_line            (data1) 128
> >                decl_column          (data1) 60
> >                type                 (ref4) [2de9ce4]
> > 
> > The first one is not the actual function, but that is a DIE
> > for the declaration. However, this DIE doesn't have DW_AT_declaration
> > attribute, it should be there if the DIE represents the declaration.
> 
> Its a bug in some gdb versions, see:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060

Thanks, so there is a compiler bug.

> 
> And here is the pahole cset dealing with that:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=5a22c2de79fb9edf2d36ff4e8d440a862fc99c2a

Oh, that's nice!

Anyway, I found how I can handle it for --lines option.
Let me fix it first.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
