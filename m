Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6D6C4708F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 11:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25C2613AE
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFBLSL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBLSK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 07:18:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB1C061574
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Jun 2021 04:16:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e1so916836pld.13
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jun 2021 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=18E7l9n3/2stmaDhvza08Z8aYCwKaZRCkX4V4crhdXw=;
        b=y6twmAWdJTjdmPxpLmTp294UtjfXzJYnpB8RDPSH21aX46NXnwoxlvH44KeZFtcBGO
         IWiceGOyUuo+m5p0NgX8chRntshxWusWQNji5+5xX1HvDbSE+Ep3FEx6IP7OsX59Wztw
         MDOGsu2/805OTcAihbYoFhCojDdLulmiU0IoDesc464WNVkBmuxUyCm0kmENHfG7epHW
         MjfNtkGky6FDw2tdfnRDdRwilyW9B3v3yIAtVtuk4ToJE+hjrXFExafTjdEwmoqa9Txx
         cY+a9cg0meqnt0hn6NsYjMoWlPHGsqzDubHhKlvSVPbsKV0Vw7dYk0Vd9zKH/UIKEbao
         pnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=18E7l9n3/2stmaDhvza08Z8aYCwKaZRCkX4V4crhdXw=;
        b=XtnoYjGqql6BMFpeXtPP9YAOGx5WLeOesJq4rXFCfrrVjnciTGKV5qfkKqmpBaD8+Q
         +1yLZN16yG/97J0+Y7uuxkysYZqkt5K51wNNI404t8hyhvRnzvTstEb08EOvhxFsjXc4
         wYxeTKcL/5s+XAFggPasKalsiiHZAOUfUzSMQTz+qYD87Vy6FjZE6l+CK3bMcGBXjZ4j
         rtZc/l5kUtfZ9wVTMTh8uFqB2Vdrti5STEw674qk7AKT9A1spQAQ2zVVqG+dv0/C+OUW
         GndTc5AaiR7BQMncBDhDdoMf+K6zhIWD8kyIMaj1SzD3GGfdJNtOL5FhnoQ5VM36A1Gl
         OOlA==
X-Gm-Message-State: AOAM532eZrpl0Nk9c2fLcBWHNKoXo9pJqjMw+QreOu26O1/IADh1K8Nd
        yNjaM1BwlgYFJvA4RTr5nArGmA==
X-Google-Smtp-Source: ABdhPJzzLMSfh/Db9hXIj11hpUVqsljuLS0xNGe/pYUhx4I+UvUBfYqiSfeNLvJEAKdYlcV/fdlMgg==
X-Received: by 2002:a17:902:6902:b029:106:50e3:b2db with SMTP id j2-20020a1709026902b029010650e3b2dbmr11793672plk.35.1622632586608;
        Wed, 02 Jun 2021 04:16:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id c19sm15689706pfo.150.2021.06.02.04.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:16:26 -0700 (PDT)
Date:   Wed, 2 Jun 2021 19:16:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/8] perf auxtrace: Drop legacy __sync functions
Message-ID: <20210602111620.GD10272@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-7-leo.yan@linaro.org>
 <fc7bfa25-d96e-ea6d-2756-f94653dc4771@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7bfa25-d96e-ea6d-2756-f94653dc4771@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrian,

On Wed, Jun 02, 2021 at 01:47:42PM +0300, Adrian Hunter wrote:

[...]

> > @@ -451,11 +445,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
> >  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> >  {
> >  	struct perf_event_mmap_page *pc = mm->userpg;
> > -#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
> 
> The test and setup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT is not needed anymore either.

Yes, I think there have two files should be cleaned:

  Makefile.config
  util/auxtrace.c

If still miss anything, please let me know (I remembered there have a
test case for __sync_xxx_compare_and_swap, but I cannot find it now,
so this is why I am concern if I miss anything not).

Thanks for review,
Leo
