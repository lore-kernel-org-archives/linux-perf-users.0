Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE77CC4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91335613AD
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 10:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFAKgw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFAKgw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 06:36:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA8C06174A
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Jun 2021 03:35:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d5-20020a17090ab305b02901675357c371so826217pjr.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jun 2021 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MnCPCat+8RzDgHVFliR6RXd+HzHEqd+QggHet3nM5oE=;
        b=NBUZjHqTLUiH4rqxnKctMAsZGBPuEsu3kRBBU0dZMZR15h95rYZkCUszlyPv8iwWn8
         vUAja/oQFPUqiln/Vz76/hamaUCMX+SbzQW/j2KccTS80R8onuWKpd8gvSj/KO346z9m
         j6nETjzX9cPAgJk5sOk4lmQZWsqKXjuqQ9e5RfVns9psjIG1CEWHEIm2LASGQUFEaym5
         3Dgs54ljdN6vlqbWZwzoHmJA/lzcwsQ4QLoM8F5ZRLLjLlWPxx6+0YeG/98UFM9nwGZ5
         DJRyA/vW8MK2jsQ4xkHaiCAd179zUm/yva6BVaBuuLec6Nx5y9RyvTX2WoR2Aqu8Qdln
         P9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnCPCat+8RzDgHVFliR6RXd+HzHEqd+QggHet3nM5oE=;
        b=mGFy3NrK5+SLYSnIGAU2hQgl9JdiWllKN+0HtyOYMZgESsVUBoZiHQzx1tct9oh8iX
         O63gJ/ZcsMqpPSghdGbawjtJ/TFNoDipQvEcWQrLQWI9CXtmau3ZzIgqR38iS30DUDjr
         Xe6uI1LpUC/DXIB++RF6plztzJkeP828eIDudM8VMYzcr01RywxZ9a6ryzLXHn/fx99D
         xtUpgmf0NAoNIfJiDW9eQgiCWWOA7uTcoozG0njTUsXPqThDyPXZGKWkefSkdFfTxW8L
         XCJ29lciC2ajW4/dcm7PjnmK5U55136BRX3KURPFt7rt+jSOHNKZnmRR61ZeXPM9hrhh
         9Waw==
X-Gm-Message-State: AOAM530yByQ/OCTAcvWlg8W27hnp/T84ga/DviUbklnsfAT9Dg1GsyPz
        M3ore1t8AkCBYFmo9p1pdqwuQA==
X-Google-Smtp-Source: ABdhPJwPJwJaRm3swpyOM0BG6qmPQF2bdJh3TwesErl7BWto5UaXid+zxZ1T/waRBfdZAbEi0U4jKg==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr4256420pjs.64.1622543710750;
        Tue, 01 Jun 2021 03:35:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id c17sm14149797pgm.3.2021.06.01.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 03:35:10 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:35:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
Message-ID: <20210601103504.GC10026@leoy-ThinkPad-X240s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
 <f29d2d68-2735-dddf-b872-6163d1dbc8f0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29d2d68-2735-dddf-b872-6163d1dbc8f0@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Tue, Jun 01, 2021 at 12:53:16PM +0300, James Clark wrote:

[...]

> Hi Leo,
> 
> I was testing out snapshot mode (without your patch) and I noticed that it
> only ever collects from the last CPU. For example on a 4 core system,
> the CPU ID of the AUX records and the AUXTRACE buffers is always 3.
> 
> This is with systemwide tracing, and running "stress -m 2 -c 2".
> Is this something that your patch fixes, or am I doing something wrong, or
> is it just a coincidence?

No, I think it's quite likely caused by blow code:

static unsigned long
tmc_update_etr_buffer(struct coresight_device *csdev,
                      struct perf_output_handle *handle,
                      void *config)
{
    unsigned long flags, offset, size = 0;

    ...

    /* Don't do anything if another tracer is using this sink */
    if (atomic_read(csdev->refcnt) != 1) {
        spin_unlock_irqrestore(&drvdata->spinlock, flags);
        goto out;
    }

    ...

    return size;
}

When using the system wide tracing, it updates the AUX ring buffer
until the last tracer is stopped.  Thus whis is why it only records
AUX ring buffer for the last CPU.

But this makes sense for me, this is because the last CPU is used to
copy trace data to AUX ring buffer (so the perf event PERF_RECORD_AUX
occurs on CPU3), but when you decode the trace data, you should can
see the activities from other CPUs.

Thanks,
Leo
