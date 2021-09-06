Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DEC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA39E60F6B
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 14:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbhIFOWw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 10:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243062AbhIFOWw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Sep 2021 10:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630938107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YC6RqGFBMLZOBtlEqyjmXA5z7zAqICUhDycS9Tr4+y4=;
        b=KFQbEHfJGPn7JK4o5j7ZXKSH6f4QX3TSw4vFYZjcd+loUBJrYVqiBb/56nJ79lM7qMqIWg
        B09+0i6SeJv6JEpz91SRPnT7mhT68DGaoZ06nhbqzOP2pND8s4rlR2W9FdzutvTinGRVh0
        5IYgQyvRWv3Gq1bYWEiBjnwL8UhX8k8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-iQmtogLJPLWxAkbMmHmFnA-1; Mon, 06 Sep 2021 10:21:46 -0400
X-MC-Unique: iQmtogLJPLWxAkbMmHmFnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F13FC101371B;
        Mon,  6 Sep 2021 14:21:44 +0000 (UTC)
Received: from Diego (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 012B21ABD8;
        Mon,  6 Sep 2021 14:21:42 +0000 (UTC)
Date:   Mon, 6 Sep 2021 16:21:40 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     acme@redhat.com
cc:     linux-perf-users@vger.kernel.org, jolsa@redhat.com,
        jlelli@redhat.com, milian.wolff@kdab.com
Subject: Re: [PATCH] perf machine: Initialize srcline string member in
 add_location struct
In-Reply-To: <20210719145332.29747-1-mpetlan@redhat.com>
Message-ID: <alpine.LRH.2.20.2109061620510.27231@Diego>
References: <20210719145332.29747-1-mpetlan@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Arnaldo,
could you please have a look at this and comment/merge?
Thanks,
Michael

On Mon, 19 Jul 2021, Michael Petlan wrote:
> It's later supposed to be either a correct address or NULL. Without the
> initialization, it may contain an undefined value which results in the
> following segmentation fault:
> 
>   # perf top --sort comm -g --ignore-callees=do_idle
> 
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
> 

