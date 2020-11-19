Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A74CC63697
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 01:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FF322363
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 01:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFhGBu8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKSBHQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgKSBHP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Nov 2020 20:07:15 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8853F22260;
        Thu, 19 Nov 2020 01:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605748034;
        bh=32kFcSP+ECbknaTLksu9oT2V/2rI+g/6HEiCg3Byefs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JFhGBu8CEMnxgTD9FBmD9lLgYcpUxxSXGF/Cr6Wq2JBDssfVKayQ+xKWM6UfhQgSd
         NxJTe0r+C5jyfesynIg2QioKgWUmVWXYXGweqd+6p5OOIx5aYtdlVB2HUNpfUzOA+9
         CaThaeSpWB3NpLgEouSp3JJtVx0gQAM7kK+MY1qw=
Date:   Thu, 19 Nov 2020 10:07:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Fedora 33 and perf probe failures
Message-Id: <20201119100711.2309580850fec6a58142f7f1@kernel.org>
In-Reply-To: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
References: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Thomas,

On Wed, 18 Nov 2020 17:37:21 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> I debugged the failure of some perf test cases on Fedora 33. The following
> test cases fail on s390 and x86_64 using

Thanks for the report!
Let me setup Fedora33.

> 
> [root@f33 yum.repos.d]# uname -a
> Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020
>                                 x86_64 x86_64 x86_64 GNU/Linux
> [root@f33 yum.repos.d]#
> 
> [root@f33 yum.repos.d]# perf test -F 74 77 78
> 74: Use vfs_getname probe to get syscall args filenames
>                 :Failed to write event: Invalid argument
> Error: Failed to add events.
> FAILED!
> 77: Check open filename arg using perf trace + vfs_getname
>                 :Failed to write event: Invalid argument
> Error: Failed to add events.
> FAILED!
> 78: Add vfs_getname probe to get syscall args filenames
>                 :Failed to write event: Invalid argument
> Error: Failed to add events.
> FAILED!
> [root@f33 yum.repos.d]#

BTW, do we have vfs_getname in the kernel?

> 
> The root cause is the output of perf probe -L which returns:
> [root@f33 yum.repos.d]# perf probe -L getname_flags
> Specified source line is not found.
> Error: Failed to show lines.

Hmm, could you run it with -vvv option?

> [root@f33 yum.repos.d]#
> 
> whereas on my Fedora 32 installation this command shows
> [root@t35lp46 perf]# cat /etc/redhat-release
> Fedora release 32 (Thirty Two)
> [root@t35lp46 perf]#
> 
> [root@t35lp46 perf]# ./perf probe -L getname_flags | tail -10
>      68                         return ERR_PTR(-ENOENT);
>                         }
>                 }
> 
>      72         result->uptr = filename;
>      73         result->aname = NULL;
>      74         audit_getname(result);
>                 return result;
> }
> 
> [root@t35lp46 perf]#
> 
> Any ideas how to fix this? Is this failure related to a missing debuginfod
> setup, even when I have installed the debuginfo packages for the kernel:

If you can find the vmlinux in debuginfo package, could you try
eu-addr2line to find getname_flags?
 
eu-addr2line -e /somewhere/to/vmlinux getname_flags+0

Thank you,

> 
> [root@f33 ~]# perf probe -L getname_flags
> Specified source line is not found.
>   Error: Failed to show lines.
> [root@f33 ~]# uname -a
> Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@f33 ~]# rpm -qa | fgrep kernel | fgrep debuginfo
> kernel-debuginfo-common-x86_64-5.9.8-200.fc33.x86_64
> kernel-debuginfo-5.9.8-200.fc33.x86_64
> kernel-tools-debuginfo-5.9.7-200.fc33.x86_64
> [root@f33 ~]#
> ~                          
> 
> Thanks a lot
> -- 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


-- 
Masami Hiramatsu <mhiramat@kernel.org>
