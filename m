Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Dec 2021 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhLIR4i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 12:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235869AbhLIR4i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Dec 2021 12:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639072383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ykeGzsdNOBrGlCb40v8EGvyxBXDB7d5oL6GZtHOQfP4=;
        b=i4g8Ou0cJHBbIXhvmYEOLwYWIB6A7c/eL8t28elngIwkCpcWm+nqHH71KOqlF9G+8udsQZ
        MI3Kdp24/0lLHat/ASatN39/M51ogmntDGsjJbJHNUIchtpD1eI6WXX4ZwzyjzxxeToLpJ
        ML9YWUf4LwdXGx7lzxACGKpvqD/oe44=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-TxyzGFn4PQCuEplbWRs9Gg-1; Thu, 09 Dec 2021 12:53:02 -0500
X-MC-Unique: TxyzGFn4PQCuEplbWRs9Gg-1
Received: by mail-wm1-f71.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso2773320wms.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2021 09:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ykeGzsdNOBrGlCb40v8EGvyxBXDB7d5oL6GZtHOQfP4=;
        b=hXsFk8mubsqQAeh+LBDbNyr9z2bAP3eBQwJJZaZcLMXIssOG3VZJ7VfXuMpFj3cT1u
         4eF/S4v3ix4ofuZ4kUw0xs4RSsud1L3Ke9baL8JnDXazHoVpLTvlgbEPWmiJ1E0zqYaK
         fPRXh0hZj3vuh87jXDff66oL3nBStC/7kKpxi+r3z8e5pv6VRSsDvZiYaVKtfxQAyO+b
         Aiji4Rly3IcZnV3KF0Rifh4emqvSJAMxG2bRe6mBSUh0noZnEeA5371vzt+6QWCQW7J7
         N1XMCR59Bc0E1B3prq8ZL1shLskrP6oImEH0Xwq5C3uSEBorwzfKVEl9LFJbCf0aIOFy
         MO6A==
X-Gm-Message-State: AOAM531pb0GEdqI4JuUUIOE5nF99Gl3Pgxcq5FjRHJVd9uUIfbrAjcxo
        RxP/niNuvypTXrHtfn6aE4vCNw936Fw0xeAO03c+KbmdOf6rQGBQgpdUZAdNeawtKPHbSF+3MP3
        CB34pRiwQD1F+vA5e48QV1UvVRjk4cQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr9037713wmi.178.1639072380851;
        Thu, 09 Dec 2021 09:53:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbsO2TcC5f2/0v+DOYSsG5pJMtYTJaN+0qN9M9JFSFywQIjjK3EBzV2ZgSpOwQ1UusdPn8RQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr9037684wmi.178.1639072380580;
        Thu, 09 Dec 2021 09:53:00 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g13sm569367wrd.57.2021.12.09.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:53:00 -0800 (PST)
Date:   Thu, 9 Dec 2021 18:52:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Josh Hunt <johunt@akamai.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: perf record per-thread vs per-cpu behavior
Message-ID: <YbJCeiV6iTitxYEb@krava>
References: <40cd791f-c9fd-bf2f-2119-7225460a5e2c@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40cd791f-c9fd-bf2f-2119-7225460a5e2c@akamai.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 08, 2021 at 03:33:18PM -0800, Josh Hunt wrote:
> Hi
> 
> I'm seeing what I believe to be incorrect behavior when running perf record
> -p and was hoping I could get some clarification from someone here. We have
> an application which has around 800 threads and when I run perf record -p
> <pid> on that the # of samples returned seems impossible given the # of
> cpus, sampling freq, and duration of profile.
> 
> I'm running on a 5.4 LTS kernel and the machine has 40 hw threads.
> 
> Running with -p <pid> I see:
> # perf record -p 7297 -s -F 49 --call-graph lbr -- sleep 5
> [ perf record: Woken up 32 times to write data ]
> [ perf record: Captured and wrote 11.798 MB perf.data (58430 samples) ]
> 
> and I've confirmed there are actually 58k samples in the data file, but the
> # of samples should be closer to 5 * 49 * 40 = 9800.
> 
> Running with -a I see something closer to what I would expect:
> 
> # perf record -a -s -F 49 --call-graph lbr -- sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 3.405 MB perf.data (9745 samples) ]
> 
> Running with -p on applications with fewer threads seems to produce
> something closer to what I would expect since the pid being profiled isn't
> on cpu 100% of the time:
> 
> # perf record -p 11629 -s -F 49 --call-graph lbr -- sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.279 MB perf.data (1324 samples) ]
> 
> It's very possible I'm doing something wrong or don't understand things :)
> but if anyone has any insights into the above I'd appreciate your help!

hi,
so with -p x you monitor also all the 800 threads

and IIRC the way -F works is by gradually moving counter's period into
proper value, to reach the desired frequency

so I think you get initial burst of samples when thread gets scheduled
(from 800 threads), which screws the expected count, like:

# ./perf script
                                           value:
 sched-messaging 281355 413544.604702:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281355 413544.604707:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281355 413544.604709:        195 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281355 413544.604711:     108360 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281355 413544.604758:   60054506 cycles:  ffffffff81653ced __list_del_entry_valid+0x2d ([kernel.kallsyms])
 sched-messaging 281341 413544.604778:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281341 413544.604780:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281341 413544.604782:        566 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281341 413544.604784:     357999 cycles:  ffffffff81c53ae7 rcu_nmi_exit+0x17 ([kernel.kallsyms])
 sched-messaging 281467 413544.604823:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281467 413544.604825:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281467 413544.604827:        645 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281467 413544.604829:     484508 cycles:  ffffffff81e015c6 nmi_restore+0x25 ([kernel.kallsyms])
 sched-messaging 281467 413544.605025:  345122294 cycles:  ffffffff81312f3a memcg_slab_post_alloc_hook+0x17a ([kernel.kallsyms])
 sched-messaging 281346 413544.605262:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281346 413544.605266:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281346 413544.605268:        260 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281346 413544.605270:     124558 cycles:  ffffffff8106f098 native_write_msr+0x8 ([kernel.kallsyms])
 sched-messaging 281345 413544.605306:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281345 413544.605308:          1 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281345 413544.605310:        518 cycles:  ffffffff8106f094 native_write_msr+0x4 ([kernel.kallsyms])
 sched-messaging 281345 413544.605312:     344137 cycles:  ffffffff81c53ce2 irqentry_nmi_exit+0x32 ([kernel.kallsyms])
 ...

check the 'value:' column

with system wide monitoring you don't see this issue and the counter
stabilize fast, because it's not scheduled in/out all the time

jirka

> 
> I should also say that the resulting reports look different and it has me
> questioning the validity of the -p data.
> 
> I'm happy to provide more info if needed, and thanks for any guidance you
> can provide.
> 
> Josh
> 

