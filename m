Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC88C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Mar 2022 10:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiCUKfY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346372AbiCUKfX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Mar 2022 06:35:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54904A3ED
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2022 03:33:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q8so8666293wrc.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2022 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CZC0d7HmPXrhiqppAlDfohvlvGHuAlJ7RvwDEFIcNS0=;
        b=LIeaOZBhiL5yuerMk2lnp8a4PCOg/BOguucMT6ZJy0ZQ8nDgeL+1/0r6SheRMQfj3s
         UIsDArpbrVfVL37a5hQyUPSU8evmwxS/g0N/OgLMX6pb76XutYg8rB/Uxys92+gu1o7n
         +wSq9VC4gSpBNtgr8C4USp0MEAnrz+LjP53IPl+C3Vxi4tREEmOqboyAPOVAXn3oqTjH
         mY6ZCwzttzdZe+z4q/V8hyDbQ2Rql/4qJ62dbIR7aDpUiae14O6NGsaf4CLDXcokiuEV
         uMmQsvsoU4RoM9m23C+CahdI6U4pQust1iR6VuM4Ug5P855PNlOSywxM6pkMXHFJiGQh
         I47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CZC0d7HmPXrhiqppAlDfohvlvGHuAlJ7RvwDEFIcNS0=;
        b=02qNjwSXtkNeBNC7Q6GklsTeu/0P9sk6k69W/jHCs/6xhK5nHw/W6abz1MzTv/BttG
         jt2rZYX2fc+nqDSFmBE6d07JPCTbsYV4WUUiPYABwdLGmR9fOOKp9XsEQv7V9SducE/f
         JJX19+KpoKGi7ezsUDy2WJO1cBqFrWtxlW6pBo4XvQkhFpHsiatFnp1G3fD4LSg+sAtb
         dY+DouHERb3BjWfOyz5HTVaxQhjImU385K5aBR22ctD0zPcdGBG17KOTOrH9I/xKJFpU
         DwXxBVzUbImfTaPDc2QI9gojyCvX0/SifQZeEuIsw1E/FdyUOup3Okz+I8YXbJqEKclS
         h7tA==
X-Gm-Message-State: AOAM533Qfr6ovb5qoRfdtqwfBiaUYBVTSR9vYfMN6KKPBr6RQIyCvyMZ
        I24I1AcxAppOqwfe00ZhezROWA==
X-Google-Smtp-Source: ABdhPJxMDFBRsgpdkQRN/CL+cgnLwEQ62GCD5wLzKyKD4fJvfeI0ZoHKUlz+LhovUdTGLP9HonhymA==
X-Received: by 2002:a05:6000:10cd:b0:203:d869:58e6 with SMTP id b13-20020a05600010cd00b00203d86958e6mr17991737wrx.683.1647858835402;
        Mon, 21 Mar 2022 03:33:55 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id n14-20020a7bcbce000000b0038c7776a300sm12049059wmi.0.2022.03.21.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:33:53 -0700 (PDT)
Date:   Mon, 21 Mar 2022 11:33:50 +0100
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
Message-ID: <YjhUjotmo+kYvoNP@google.com>
References: <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
 <YjHfGrZovk3N/H0f@google.com>
 <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371faf0d-f794-4a2e-0a1c-9d454d7c8b12@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 21, 2022 at 11:16:56AM +0200, Adrian Hunter wrote:
> I had another look at this and it seemed *mostly* OK for me.  One change
> I would make is to subject the cycle period to the logic of the 'A' option
> (approximate IPC).
> 
> So what does the 'A' option do.
> 
> By default, IPC is output only when the exact number of cycles and
> instructions is known for the sample.  Decoding walks instructions
> to reconstruct the control flow, so the exact number of instructions
> is known, but the cycle count (CYC packet) is only produced with
> another packet, so only indirect/async branches or the first
> conditional branch of a TNT packet.

Ah, I hadn't thought of the fact that you only get the first branch per
packet. It's a bit unfortunate for (exact) cycle counts, since I guess
TNT packets can also easily cross functions?

> So the cycle sample function looks like this:
> 
> static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
>
> [...]
>
> With regard to the results you got with perf report, please try:
> 
> 	perf report --itrace=y0nse --show-total-period --stdio
> 
> and see if the percentages and cycle counts for rarely executed
> functions make more sense.

I already run mostly with 0ns period, so I don't think that's it.
I tried your new version, and it's very similar to your previous one;
there are some small changes (largest is that one function goes from
2.5% to 2.2% or so), but the general gist of it is the same.
I am increasingly leaning towards that my original version is wrong
somehow, though.

By the way, I noticed that synthesized call stacks do not respect
--inline; is that on purpose? The patch seems simple enough (just
a call to add_inlines), although it exposes extreme slowness in libbfd
when run over large binaries, which I'll have to look into.
(10+ ms for each address-to-symbol lookup is rather expensive when you
have 4M samples to churn through!)

/* Steinar */
