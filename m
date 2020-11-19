Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D07C63697
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21ADA2468B
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 13:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg6iOIE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKSNEg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKSNEg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Nov 2020 08:04:36 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042D72076B;
        Thu, 19 Nov 2020 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605791075;
        bh=wWKObAv3tO7fvMO6gLcwYcwJQIBZw932Zni5oUqZlJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tg6iOIE7c2zzPAeMIifLuuDW1CcpreM1+Go2ejrlcC6ln68bXyl3RNStyetC7iZB7
         1KMLbhVoMq3x80lgoasx98GtFDjtnkSksomlMkadTy//inaOT97irc3HFclx4m2R+Z
         NL0Cva2yWjQhmYdtWolq6IwVmgYoyDx/b9ohjvUU=
Date:   Thu, 19 Nov 2020 22:04:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: Fedora 33 and perf probe failures
Message-Id: <20201119220430.d3642bfea7515f3ac1b2815f@kernel.org>
In-Reply-To: <42f12f48-d515-8d7b-0116-d063afea9273@linux.ibm.com>
References: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
        <20201119100711.2309580850fec6a58142f7f1@kernel.org>
        <42f12f48-d515-8d7b-0116-d063afea9273@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, 19 Nov 2020 09:16:57 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> On 11/19/20 2:07 AM, Masami Hiramatsu wrote:
> > Hi Thomas,
> > 
> > On Wed, 18 Nov 2020 17:37:21 +0100
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > 
> >> I debugged the failure of some perf test cases on Fedora 33. The following
> >> test cases fail on s390 and x86_64 using
> > 
> > Thanks for the report!
> > Let me setup Fedora33.
> > 
> >>
> >> [root@f33 yum.repos.d]# uname -a
> >> Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020
> >>                                 x86_64 x86_64 x86_64 GNU/Linux
> >> [root@f33 yum.repos.d]#
> >>
> >> [root@f33 yum.repos.d]# perf test -F 74 77 78
> >> 74: Use vfs_getname probe to get syscall args filenames
> >>                 :Failed to write event: Invalid argument
> >> Error: Failed to add events.
> >> FAILED!
> >> 77: Check open filename arg using perf trace + vfs_getname
> >>                 :Failed to write event: Invalid argument
> >> Error: Failed to add events.
> >> FAILED!
> >> 78: Add vfs_getname probe to get syscall args filenames
> >>                 :Failed to write event: Invalid argument
> >> Error: Failed to add events.
> >> FAILED!
> >> [root@f33 yum.repos.d]#
> > 
> > BTW, do we have vfs_getname in the kernel?
> > 
> 
> No, that is the name of the probe when calling perf probe command,
> as in .../perf/tests/shell/lib/probe_vfs_getname.sh:
> 
> perf probe -q "vfs_getname=getname_flags:...."

Ah, OK.

> The probe is set on kernel function getname_flags()
> in fs/namei.c source file and named vfs_getname inside
> perf/tracing subsystem.

Hmm, this seems debuginfo is not correctly handled.


> >> The root cause is the output of perf probe -L which returns:
> >> [root@f33 yum.repos.d]# perf probe -L getname_flags
> >> Specified source line is not found.
> >> Error: Failed to show lines.
> > 
> > Hmm, could you run it with -vvv option?
> 
> [root@f33 ~]# uname -a
> Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@f33 ~]# cat /etc/fedora-release 
> Fedora release 33 (Thirty Three)
> [root@f33 ~]# perf kallsyms getname_flags
> getname_flags: [kernel] [kernel.kallsyms] 0xffffffffa8325000-0xffffffffa8325060 (0xffffffffa8325000-0xffffffffa8325060)
> [root@f33 ~]# find / -name vmlinux
> /home/richter/linux/arch/x86/boot/compressed/vmlinux
> /home/richter/linux/vmlinux
> /usr/lib/debug/usr/lib/modules/5.9.8-200.fc33.x86_64/vmlinux
> /sys/kernel/btf/vmlinux
> [root@f33 ~]# nm -g /usr/lib/debug/usr/lib/modules/5.9.8-200.fc33.x86_64/vmlinux| fgrep getname_flags
> ffffffff81325000 T getname_flags
> [root@f33 ~]# 
> 
> [root@f33 ~]# perf probe -vvv -L getname_flags
> Looking at the vmlinux_path (8 entries long)
> Using /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux for symbols
> Open Debuginfo file: /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux
> fname: ./include/linux/fs.h, lineno:2527
> New line range: 2527 to 2147483647
> path: (null)
> Specified source line is not found.

The fname seems wrong, there is a declaration of getname_flags, but not
the definition. Hmm, maybe the dwarf format is different?

>   Error: Failed to show lines. Reason: No such file or directory (Code: -2)
> [root@f33 ~]# 
> 
> > 
> >> [root@f33 yum.repos.d]#
> >>
> >> whereas on my Fedora 32 installation this command shows
> >> [root@t35lp46 perf]# cat /etc/redhat-release
> >> Fedora release 32 (Thirty Two)
> >> [root@t35lp46 perf]#
> >>
> >> [root@t35lp46 perf]# ./perf probe -L getname_flags | tail -10
> >>      68                         return ERR_PTR(-ENOENT);
> >>                         }
> >>                 }
> >>
> >>      72         result->uptr = filename;
> >>      73         result->aname = NULL;
> >>      74         audit_getname(result);
> >>                 return result;
> >> }
> >>
> >> [root@t35lp46 perf]#
> >>
> >> Any ideas how to fix this? Is this failure related to a missing debuginfod
> >> setup, even when I have installed the debuginfo packages for the kernel:
> > 
> > If you can find the vmlinux in debuginfo package, could you try
> > eu-addr2line to find getname_flags?
> >  
> > eu-addr2line -e /somewhere/to/vmlinux getname_flags+0
> 
> [root@f33 ~]# eu-addr2line -e /usr/lib/debug/usr/lib/modules/5.9.8-200.fc33.x86_64/vmlinux  getname_flags+0
> fs/namei.c:129:1
> [root@f33 ~]# 

OK, so elfutils can decode it.
I'll try to decode dwarf, trace elfutils and find what happens.

Thank you,

> 
> > 
> > Thank you,
> > 
> 
> You are welcome, thanks for looking into this.
> 
> I have added my Fedora32 output for completeness:
> 
> [root@t35lp46 perf]# ./perf probe -vvv -L getname_flags
> Looking at the vmlinux_path (8 entries long)
> Using /lib/modules/5.10.0-rc4d-perf+/build/vmlinux for symbols
> Open Debuginfo file: /lib/modules/5.10.0-rc4d-perf+/build/vmlinux
> fname: fs/namei.c, lineno:128
> New line range: 128 to 2147483647
> Get 20989 lines from this CU
> path: fs/namei.c
> Search fs/namei.c from debuginfod -> -38
> Failed to find fs/namei.c in debuginfod (8a690c7c154db1283cebb8953128584dd4f94b3d)
> <getname_flags@/root/linux/fs/namei.c:0>
>       0  getname_flags(const char __user *filename, int flags, int *empty)
>          {
>       2         struct filename *result;
>                 char *kname;
>                 int len;
> ......
> 
> root@t35lp46 perf]# eu-addr2line -e ~/linux/vmlinux  getname_flags+0
> fs/namei.c:129:1
> [root@t35lp46 perf]# 
> 
> 
> -- 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


-- 
Masami Hiramatsu <mhiramat@kernel.org>
