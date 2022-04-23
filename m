Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7652EC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 23 Apr 2022 06:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiDWGlN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Apr 2022 02:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiDWGlM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Apr 2022 02:41:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFF300
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Apr 2022 23:38:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so20112923ejf.11
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Apr 2022 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JfYNk7PKym38MlGAXyXafcCNWPn+2drPWLNtsAJTZac=;
        b=wYRkumz1HH5a5k41YA/3eyDDbvnMB1QTrSknt8c1j99bwzKt02sO/yGBsz4l9qzhVx
         JdgMXmnVnqe5kV8Html2wprELfIEpNmTRD3bGakgJS/qHVWcPU+sLDjpFY+jOl9b8+T5
         LKtUZ6In5Mvp/0CB6hxnHt12qThKxTApkJxaOik1N8AUYqMwHSGe4WZB8Y7lXZ58hRma
         D81PrYOUXEPCCSE4QAkX2/wFJngtAzRzub/zH38Bf1ZeFUv6eAyW9KHYipZpX+NZSUo9
         +LXdpkcwiBohl6gk/mtgxvVf6x2fv+6i+6lKMMNVHEktGiUyRGwDJ4YYBudkReeqX6EA
         2WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JfYNk7PKym38MlGAXyXafcCNWPn+2drPWLNtsAJTZac=;
        b=Kn9/iQcKAnkl5AfjdIjeya20yIZyjDH2WfE9FAVV6vn9Wwk6o745ruNOvNWi18q0Us
         WCUtdLC8MYCgInNJiYyy6WlN9zFpTAkkNLKdG47OfEgisc/G8KIWT7qHzkwu0bjrwNC+
         F3LlKAR0k8cZWWUA+mpcp7RLcZ8x2HzbFgioNEUYpf8oCXGO7VNjggLet9OczfUejjjg
         mZX1oDSbtaxCF4DHJ4RrxFJnMQZfMY1hrcgE4rKbGUqjJ4/z0Kvsm1l4jj0XimFbDnwv
         kHk3lMaHD0St+s7NvBCtYMZg1O9teJsZJUUFPUzGpjV8al0vVuY70Cx08H//kpYvguo6
         ZUVQ==
X-Gm-Message-State: AOAM533DrFGQo+FSMGxy5LCXYIJJ0XgMoK506bBN6J6D2ZIdopA9dzIL
        4euXvTka77RpyDcHH0hI3LVK9w==
X-Google-Smtp-Source: ABdhPJwzivo8NzW2VqVoaWDBZYgI3SnzZw9bPgroasDWLZL3hitJGtp3e92gxF/3V81cOzkCePJQXg==
X-Received: by 2002:a17:906:5d12:b0:6f0:17a5:6053 with SMTP id g18-20020a1709065d1200b006f017a56053mr7275588ejt.635.1650695894463;
        Fri, 22 Apr 2022 23:38:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906134c00b006ef8be0e8e9sm1398092ejb.168.2022.04.22.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 23:38:13 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:38:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     kan.liang@linux.intel.com, Nick.Forrington@arm.com,
        acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220423063805.GA559531@leoy-ThinkPad-X240s>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422212249.22463-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 22, 2022 at 09:22:49PM +0000, Ali Saidi wrote:
> 
> On Fri, 22 Apr 2022 21:43:28, Kan Liang wrote:
> > On 4/22/2022 2:49 PM, Ali Saidi wrote:
> > > On Wed, 20 Apr 2022 18:43:28, Kan Liang wrote:
> > >> On 4/8/2022 3:53 PM, Ali Saidi wrote:
> > >>> Add a flag to the perf mem data struct to signal that a request caused a
> > >>> cache-to-cache transfer of a line from a peer of the requestor and
> > >>> wasn't sourced from a lower cache level.
> > >>
> > >> It sounds similar to the Forward state. Why can't the
> > >> PERF_MEM_SNOOPX_FWD be reused?
> > > 
> > > Is there a definition of SNOOPX_FWD i can refer to? Happy to use this instead if
> > > the semantics align between architectures.
> > > 
> > 
> > + Andi
> > 
> > As my understanding, the SNOOPX_FWD means the Forward state, which is a 
> > non-modified (clean) cache-to-cache copy.
> > https://en.wikipedia.org/wiki/MESIF_protocol
>   
> In this case the semantics are different. We know the line was transferred from
> another peer cache, but don't know if it was clean, dirty, or if the receiving core
> now has exclusive ownership of it.

In the spec "Intel 64 and IA-32 Architectures Software Developer's Manual,
Volume 3B: System Programming Guide, Part 2", section "18.8.1.3 Off-core
Response Performance Monitoring in the Processor Core", it defines the
REMOTE_CACHE_FWD as:

"L3 Miss: local homed requests that missed the L3 cache and was serviced
by forwarded data following a cross package snoop where no modified copies
found. (Remote home requests are not counted)".

Except SNOOPX_FWD means a no modified cache snooping, it also means it's
a cache conherency from *remote* socket.  This is quite different from we
define SNOOPX_PEER, which only snoop from peer CPU or clusters.

If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
this would be easier for us to distinguish the semantics and support the
statistics for SNOOPX_FWD and SNOOPX_PEER separately.

I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.

Thanks,
Leo
