Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1F9C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Mar 2022 14:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiC2OSK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbiC2OSJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Mar 2022 10:18:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB71CE6143
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 07:16:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w21so20482192wra.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2022 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ApZndiwJNJZl0SipZbpbx1y3pSTDGsI2OYESYfSgmRI=;
        b=szLF4na2paIg1s4iZdbmJ8mCpPYLmW48qK3wdxRxIPWBTrhi0gaLJ1W1LAdCGuoVTA
         p8eWWU9aJBFQbKIsvCydcMEpWAQZ+XWzoxxSi8UCOZGPTCFHnM1ry3jCNQIyyWZrT9dK
         9nQL8s7AujVQyG0XZkaj8mW7qtEV+FyPmNNcnFZ9CSPz0Y9zUIyPiy5ViC8OfbMSdBly
         4Jo6W73cr5FpJlTlcYbqFY4vkpk2Op+vUNsllbVrQle/JWpjB6MWoQewc9ySt/RthV1D
         N/koCU1lPJthZdyVJbuh3RBJv8PkGy6KjvZiRcBXe3wMHPdKo03yAiYyuN2s+qN181D7
         ZXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ApZndiwJNJZl0SipZbpbx1y3pSTDGsI2OYESYfSgmRI=;
        b=Qn6R19US9VahzXSc00BJ4TCSNMP9vYDFluHRioNQfmOTH1GUUUbu0asB23O5M6TSrj
         u3X0hApnfTLenQdoL5lW/4Ji1ENL5sMkF1DK8Uix9d4jEaObL40bFegrTgdzWS6JKFUu
         Qh9TVJDszL/OH9PIcEtwgI8t3QQY9P/rThcZBUhOfaY7RCvNqnJnbdZpWrzLuACAlZTk
         w4fP0faKbjrHBOc5NTdl6Nv9y8tCky39gpPhyz9uWm7RYzUjq9B//FR1/yxZBVxrGcvx
         Zpi3TXBULx7i2YHrb/6WZSWx/4lq+tY2iXAD0KWUX+SXpLgg/0s7RSkuyO8kdr73JaFr
         9Enw==
X-Gm-Message-State: AOAM533jlpv9xNgUN4EeYahCtyBERgj9eUANz9C5zCBjFmYjFgkU3T+F
        syq4K8pq1P/u3YJGUToIk3b7dw==
X-Google-Smtp-Source: ABdhPJzoCt9FnR7gH0jRnO98pHDPc8I6nVcblqa6U4wrKW0EyTEOFSa98+n1XELxAHldPTuzcpRVOQ==
X-Received: by 2002:a5d:58f2:0:b0:205:7f1b:9dc7 with SMTP id f18-20020a5d58f2000000b002057f1b9dc7mr31327403wrd.109.1648563375739;
        Tue, 29 Mar 2022 07:16:15 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b0038cfb1a43d6sm2371826wmr.24.2022.03.29.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:16:14 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:16:11 +0200
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YkMUq/qrzEg5Mj1N@google.com>
References: <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
 <YjhUjotmo+kYvoNP@google.com>
 <ffa56520-09b5-9c5d-7733-6767d2f8e350@intel.com>
 <YjiuoEUL6jH32cBi@google.com>
 <Yjm5stBpRC0g4G8s@google.com>
 <YkL8EpWaeZ1US8t2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkL8EpWaeZ1US8t2@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 29, 2022 at 02:31:14PM +0200, Steinar H. Gunderson wrote:
>   int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
>   {
>           if (!sym_l || !sym_r)
>                   return cmp_null(sym_l, sym_r);
> 
>           if (sym_l == sym_r)
>                   return 0;
> 
>           if (sym_l->inlined || sym_r->inlined) {
>                   int ret = strcmp(sym_l->name, sym_r->name);
> 
>                   if (ret)
>                           return ret;
>                   if ((sym_l->start <= sym_r->end) && (sym_l->end >= sym_r->start))
>                           return 0;
>           }
> 
>           if (sym_l->start != sym_r->start)
>                   return (int64_t)(sym_r->start - sym_l->start);

Even fixing <= to <, I do get nonsensical results like an inlined
(and very small) destructor taking 50%+ of CPU time, and having a huge
call chain under it. It largely goes away (I'm not sure if it's perfect)
if I remove the entire if (sym_l->inlined || ... branch, but I guess
it's there for a reason.

Thinking about it, I wonder if this code breaks the entire tree
invariant of comparison being transitive. If left _or_ right is inlined,
it compares them by name, but if not, it compares them by address. So
you can have three symbols A, B (inline) and C, where A < B (on name),
B < C (on name) but C < A (on address; assuming C has a lower start
address than A). That doesn't look good to me.

I'm wondering if the right fix would be something like replacing the
entire if with something like

           if (sym_l->inlined && sym_r->inlined &&
	       strcmp(sym_l->name, sym_r->name) == 0) &&
	       <keep [start,end) overlap test here>) {
                   return 0;
	   }

but I'm not sure.

/* Steinar */
