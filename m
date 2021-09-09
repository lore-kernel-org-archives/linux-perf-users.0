Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F244C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419A860F6C
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355452AbhIINWl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358664AbhIINPq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF41960F6C;
        Thu,  9 Sep 2021 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631193277;
        bh=LYI7dgSrXQLYiGKi/n/AUgRkd90E+WVx2ToX6u8nUYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY8IB6QeCr13n++kILODRWWR0uP4sA88K3QGovh2D4KvCl8b0EmpwG/MGH4lqNy+e
         tijpdSlv92pqd+duPLRcVPuNt8wM4pJDQ0jz69h1Q85GHY1R+2t0vQG8RtP4FttHen
         +XrKjL0G3D569f19VWBTH4g98W82TK9j/mDHiJHfqy7XTM+CdF91rqoP9v/jej/Lan
         XUKftez/0SAVYaWWL/xiKZGSiIpZ31fFOwDP4PH51gbk2MYe5u7JKcZYDi8Lm3VVy3
         SzRk34UPvXkNIX/+nRFO9HLvXc1hoJlpkypblS4AdaibeKfrcXOzXWtdEw7lhIbLdB
         s5hruo6vDtHmg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92B1E4038F; Thu,  9 Sep 2021 10:14:33 -0300 (-03)
Date:   Thu, 9 Sep 2021 10:14:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org,
        jolsa@redhat.com, jlelli@redhat.com, milian.wolff@kdab.com
Subject: Re: [PATCH] perf machine: Initialize srcline string member in
 add_location struct
Message-ID: <YToIuTUuudHKZmN2@kernel.org>
References: <20210719145332.29747-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719145332.29747-1-mpetlan@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 19, 2021 at 04:53:32PM +0200, Michael Petlan escreveu:
> It's later supposed to be either a correct address or NULL. Without the
> initialization, it may contain an undefined value which results in the
> following segmentation fault:
> 
>   # perf top --sort comm -g --ignore-callees=do_idle

Later where? The backtrace below is unresolved, I couldn't reproduce it
here, that al variable is local to add_callchain_ip(), and is then
passed to several places where I couldn't find al->srcline being used,
can you state where it is used and causes the segfault?

- Arnaldo
 
> terminates with
> 
>   perf: Segmentation fault
>   -------- backtrace --------
>   perf(+0x417b26)[0x557794f1fb26]
>   /lib64/libc.so.6(+0x37400)[0x7f62a0194400]
>   /lib64/libc.so.6(+0x15d685)[0x7f62a02ba685]
>   /lib64/libc.so.6(__strdup+0x12)[0x7f62a01e6802]
>   perf(+0x3769d9)[0x557794e7e9d9]
>   perf(+0x376d3a)[0x557794e7ed3a]
>   perf(+0x377284)[0x557794e7f284]
>   perf(+0x3773e0)[0x557794e7f3e0]
>   perf(hist_entry_iter__add+0xc4)[0x557794e80114]
>   perf(+0x2799aa)[0x557794d819aa]
>   perf(+0x354ec8)[0x557794e5cec8]
>   perf(+0x279341)[0x557794d81341]
>   /lib64/libpthread.so.0(+0x814a)[0x7f62a27b514a]
>   /lib64/libc.so.6(clone+0x43)[0x7f62a0259dc3]
> 
> Fixes: 1fb7d06a509e ("perf report: Use srcline from callchain for hist entries")
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Reported-by: Juri Lelli <jlelli@redhat.com>
> CC: Milian Wolff <milian.wolff@kdab.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/machine.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index da19be7da284..44e40bad0e33 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2149,6 +2149,7 @@ static int add_callchain_ip(struct thread *thread,
>  
>  	al.filtered = 0;
>  	al.sym = NULL;
> +	al.srcline = NULL;
>  	if (!cpumode) {
>  		thread__find_cpumode_addr_location(thread, ip, &al);
>  	} else {
> -- 
> 2.18.4
> 

-- 

- Arnaldo
