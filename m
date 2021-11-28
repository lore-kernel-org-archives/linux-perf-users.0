Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 15:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358107AbhK1Pps (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 10:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358128AbhK1Pnr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 10:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638114030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UMyoPpt+Q8m9AgfYC5Ypfcf2UJkCpNXdhotyu9hT7Q=;
        b=e5XfoqCR/2D3d2VVEPeBhDFmmh9UcsEfwtb1AJA+9q1UTyH0BZzINDbzzJE9sx5LYfzPO/
        dhu/9GkmIAGs2iRbU3hgwW8V6MVIZ8M6kBhY723p2zWebHSftl/UBgFYWZqDCH45RFeSOM
        pEGmztXc9QGLZSLufs94HJLdmXVB8YU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-NEhxmJY0Pn2Y9DA5nS3wAQ-1; Sun, 28 Nov 2021 10:40:29 -0500
X-MC-Unique: NEhxmJY0Pn2Y9DA5nS3wAQ-1
Received: by mail-wm1-f69.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso10429788wme.8
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 07:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8UMyoPpt+Q8m9AgfYC5Ypfcf2UJkCpNXdhotyu9hT7Q=;
        b=8ONtWM0K+yCp8U3c6YJpqMrONdNp3ydIrYBK11v4vcCTCWJDSGXigm7d41HSgDg8yO
         h/Mu5oys/1BEkT9mFyhUM6lD/r927o3laafPnz/FRTZxJblayCZgnLzzkV3O9J1cAfvS
         OMPC5faqWfC/N6Stj9UpwgC9X3lSP4F8aKhGCs5rubEcQ9iI64Vaz7I14NlBMnphKl79
         coo6mB0FI5IA/XqfG4+AsIxGG91FkQ7n4kW/0GPhAf3gmKFfZow26YzAty/s9A3PVR5L
         RUahdsc9g4WgXLm9NyqEj2MIf4jz63uHG8gWq2+4MlaQ0mkGpr5J5Dqo9QQ+SxsyTNQ2
         CEbQ==
X-Gm-Message-State: AOAM532axgtiE6JAyUahPd1I/DDiGCJigxUQcCOF8eJVJ9EKyP2FLRht
        9YKthYM7BOeyeUh4oitoMrFZHLduZyu5FtKnZqm0KRE+eVj82j/ufSMo/UndgBGM7askLZvUSbT
        6PqBl6oNuiSf9U4yUT/Ql52gDE973TQ==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr27238495wrr.370.1638114028397;
        Sun, 28 Nov 2021 07:40:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygMyjMHbNI23H+ZCybDVr9RWFWAc/0badX3EuYx93Sx4Rje46QCw+3Cv2nXzJWe6d0OmTF4g==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr27238480wrr.370.1638114028257;
        Sun, 28 Nov 2021 07:40:28 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g18sm20326140wmq.4.2021.11.28.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:40:27 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:40:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf map: Fix namespace memory leak
Message-ID: <YaOi6pYqoc3boYX/@krava>
References: <20211118193714.2293728-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118193714.2293728-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 18, 2021 at 11:37:14AM -0800, Ian Rogers wrote:
> This leak was happening reliably with test "Lookup mmap thread" with
> stack traces like:
> 
> Direct leak of 5504 byte(s) in 172 object(s) allocated from:
>     #0 0x7f4685e47987 in __interceptor_calloc
>     #1 0x56063b974c2a in nsinfo__new util/namespaces.c:142
>     #2 0x56063b9781ff in thread__new util/thread.c:70
>     #3 0x56063b944953 in ____machine__findnew_thread util/machine.c:543
>     #4 0x56063b944ac6 in __machine__findnew_thread util/machine.c:574
>     #5 0x56063b944b36 in machine__findnew_thread util/machine.c:584
>     #6 0x56063b94c892 in machine__process_fork_event util/machine.c:1954
>     #7 0x56063b94cc1f in machine__process_event util/machine.c:2019
>     #8 0x56063b894f18 in perf_event__process util/event.c:567
>     #9 0x56063ba17951 in perf_tool__process_synth_event util/synthetic-events.c:65
>     #10 0x56063ba19086 in perf_event__synthesize_fork util/synthetic-events.c:287
>     #11 0x56063ba1c39d in __event__synthesize_thread util/synthetic-events.c:775
>     #12 0x56063ba1cf6f in __perf_event__synthesize_threads util/synthetic-events.c:929
>     #13 0x56063ba1d4ab in perf_event__synthesize_threads util/synthetic-events.c:1000
>     #14 0x56063b821a3d in synth_all tests/mmap-thread-lookup.c:136
>     #15 0x56063b821c86 in mmap_events tests/mmap-thread-lookup.c:174
>     #16 0x56063b8221b7 in test__mmap_thread_lookup tests/mmap-thread-lookup.c:230
> 
> The dso->nsinfo is overwritten, but without a nsinfo__put this can leak
> the overwritten nsinfo.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

nice catch!

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 8af693d9678c..ceed8f407bc0 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -192,6 +192,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  			if (!(prot & PROT_EXEC))
>  				dso__set_loaded(dso);
>  		}
> +		nsinfo__put(dso->nsinfo);
>  		dso->nsinfo = nsi;
>  
>  		if (build_id__is_defined(bid))
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 

