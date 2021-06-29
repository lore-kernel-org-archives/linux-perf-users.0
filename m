Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25941C11F66
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4AA61DC4
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Jun 2021 14:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhF2OED (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF2OEA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Jun 2021 10:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DF7261DBC;
        Tue, 29 Jun 2021 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624975290;
        bh=DsD8rMlDKBJPBOFxaSULpJKu2DZLadi+YPehMXrDRsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6XThNsYjfdbCjDQcoSAbFTFEhScUTPCEW3ne68z8m+wxfydjetFSFdWOGKpGpp3v
         l599KBYLfC4gFH+ipcAbF6a2xGJOQ7KYy3Dfo/tO/4BEdzZTm4QP0tUCqPKlbVf8vu
         zBR/TxjOwSKnD70trKVWDJl56R9ruLPEOg5WjdSCflg8dwHanXTkiMu1lLEeZNPy5r
         Ux9vzUnBwHu9fu7J0wsfMwV6HKQuncdmq10KHt9cZXb/gehKMlYyeAaZxJqDY31nAa
         9z9fXPv86Mcrwb5JXscESqEEjlBt0hb8L7mddh4CihhZYsA4JZwIR/J5h/8IoOj516
         rBFmJZW51EZ/Q==
Date:   Tue, 29 Jun 2021 23:01:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: perf test case probe libc fails with latest Fedora34 glibc
 update, more info
Message-Id: <20210629230126.9b8d0d11bafbaa78d68a57ee@kernel.org>
In-Reply-To: <d689e8e0-64da-e3c6-bc3b-50d4d3a4ee03@linux.ibm.com>
References: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
        <f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com>
        <20210629140242.c16d9bf368865025e0ead480@kernel.org>
        <d689e8e0-64da-e3c6-bc3b-50d4d3a4ee03@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 29 Jun 2021 09:21:19 +0200
Thomas Richter <tmricht@linux.ibm.com> wrote:

> On 6/29/21 7:02 AM, Masami Hiramatsu wrote:
> > On Fri, 25 Jun 2021 12:43:29 +0200
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> > 
> 
> Masami,
> 
> here is more info on this issue:
> 
> # nm /usr/lib64/libc-2.33.so 
> 00000000000a7f30 t __GI_memchr
> 00000000000a3730 t __GI_memcmp
> 00000000000a37e0 t __GI_memcpy
> 00000000000a39a0 t __GI_memmove
> 00000000000a37d0 t __GI_mempcpy
> 00000000000a8000 t __GI___rawmemchr
> 00000000000a6070 t __GI_stpcpy
> 000000000009d190 t __GI___strcasecmp_l
> 00000000000a67a0 t __GI_strcat
> 00000000000a6ec0 t __GI_strchr
> 00000000000a6b70 t __GI_strcmp
> 00000000000a5f70 t __GI_strcpy
> 00000000000a7c70 t __GI_strcspn
> 00000000000a5ad0 t __GI_strlen
> 000000000009d200 t __GI___strncasecmp_l
> 00000000000a6ce0 t __GI_strncmp
> 00000000000a62a0 t __GI_strncpy
> 00000000000a5d30 t __GI_strnlen
> 00000000000a73e0 t __GI_strrchr
> 00000000000b8e80 t __GI_wmemchr
> 0000000000111f60 T __memcpy_chk
> 0000000000111f80 T __memmove_chk
> 0000000000112040 T __stpcpy_chk
> 0000000000112100 T __strcpy_chk
> # 
> 
> These are the entries in the .symtab section and can be used by perf:
> # ./perf probe -vvv -f -x /usr/lib64/libc-2.33.so -a __strcpy_chk

Are there any output of the perf probe? It may report that the
event is found by map (symbol) or debuginfo.

> # ./perf probe -l
>   probe_libc:__strcpy_chk (on __strcpy_chk@debug/strcpy_chk.c in /usr/lib64/libc-2.33.so)
> [root@t35lp46 perf]# 

Thanks! So at least the symbols in .symtab works.

> 
> Hope this helps
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


-- 
Masami Hiramatsu <mhiramat@kernel.org>
