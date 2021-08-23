Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57893C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399B16137B
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbhHWMPW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbhHWMPT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 08:15:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08809C061153
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 05:13:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n12so10044705plf.4
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=USD5OFknfQfTTpEURTjZ0WrHVrtGhEjlaRPsgw1f+QE=;
        b=vo8MOmKcUWIsLMfw5yQwAqFC5pN/iVnhcnEJibUyh0i31ox9NIt/BXe8Y4RoxpXIM3
         Cz3h2wPLXFnWY49bz6JhAOvaNezU6BOoqZ4U24k2Y5sBm/az7WAJi3ugoWTFzA3MkZGV
         DM9Vzs62DIVfiivf7wEvYLe60k1JW4kJroPlAHRE5zqXxE1mMUmOTBLmsXk1ZfX5TN+Z
         /kLQgLkjiIvt/7iipOdzyeY9jn6iWzvSz6dnUVRv8G7VgfcmA34XC0DIn+BVWfN4gWAJ
         KhVZo98NG+NHYz1F0SFSgy3+c3ouvnDwopWONF0u+si8JeBfaxDs6eopmJjY+2zaIFvu
         virQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USD5OFknfQfTTpEURTjZ0WrHVrtGhEjlaRPsgw1f+QE=;
        b=ApGTw3QLzYPTr21Xn/6ItB0s8R1a+pd1OcRR7/bv4RWEacbgATey+6uSewbSfkVY7R
         9oFnCZ1IUIMpIytfqyL+xIZWdaAqP18YvzjiHtbJV97vVOViovG6kYuADCT44t2j5TLE
         9OoQQNt2/xyjQU8Bzv8EgZKViZl5X2mH6TqJbhxfge1Cgwz0eY9MREgISweTk/3Ogxau
         4IyCQnf/UR62tHpzM1+TyFzLqPgCO4TW83JaTy2/erRyrTCEeR3yzAYbxy5fZFZByVUV
         XN1uxagTcaBCZv2MyS0sLyEj46RD91AOyBUOJsymmg1PRGXunFcbG9f5rtQduplygXTL
         Xjvg==
X-Gm-Message-State: AOAM530VuEUsvlGgIeSFesHllsDrC1Vy1sxZx+/1wEPt8daqQnqqQQgn
        N2mZ+Zq5IpB/V1OiGD40Hed1tQ==
X-Google-Smtp-Source: ABdhPJyNUbHpBwjyvMydx8DGbGbM8fWE1CehelWG1WvHoJPE237bsM++fPdTwPOlRbyrtdvtEU7sOw==
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id j11-20020a17090276cbb029012b2fb87c35mr28087072plt.16.1629720835386;
        Mon, 23 Aug 2021 05:13:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id w8sm16336627pjd.55.2021.08.23.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:54 -0700 (PDT)
Date:   Mon, 23 Aug 2021 20:13:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org
Subject: Re: [PATCH v1 2/3] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210823121348.GE100516@leoy-ThinkPad-X240s>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
 <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
 <20210823095155.GC100516@leoy-ThinkPad-X240s>
 <319ee11a-06f7-abde-6495-d2175928b9fe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319ee11a-06f7-abde-6495-d2175928b9fe@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 23, 2021 at 11:57:52AM +0100, James Clark wrote:

[...]

> Ok thanks for the explanation, that makes sense now. I do have one other
> point about the documentation for the function:

Welcome!

> > + * When update the AUX tail and detects any carrying in the high 32 bits, it
> > + * means there have two store operations in user space and it cannot promise
> > + * the atomicity for 64-bit write, so return '-1' in this case to tell the
> > + * caller an overflow error has happened.
> > + */
> 
> I couldn't see how it can ever return -1, it seems like it would loop forever
> until it reads the correct value.

I use this chunk comment to address the function
compat_auxtrace_mmap__write_tail():

+int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 mask = (u64)(UINT32_MAX) << 32;
+
+	if (tail & mask)
+		return -1;
+
+	/* Ensure all reads are done before we write the tail out */
+	smp_mb();
+	WRITE_ONCE(pc->aux_tail, tail);
+	return 0;
+}

Please let me know if this is okay or not?  Otherwise, if you think
the format can cause confusion, I'd like to split the comments into
two sections, one section for reading AUX head and another is for
writing AUX tail.

Thanks,
Leo
