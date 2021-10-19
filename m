Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2ADC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 13:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA2261374
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJSNO4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJSNOz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 09:14:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A22C061745
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Oct 2021 06:12:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d9so10382855pfl.6
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Oct 2021 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rg3Kgw5vrNE8ltWjJ/Ne3mXQemq6Bfc8CUmnwiMggRw=;
        b=D6BSuqx0TWFkCEOBKE917Xo1JDqEEx9wA3q0Az+amnAPUVfuxM0vyEWVOsllwg3H2K
         E6jvrPgzpFAdtBgQRzYpqgx24raI+8XbiKnFe0Z0VEmAdof1ew4kVWOFY4jwDSm++Wb/
         Rc376WqNMDCvYmujsCRH4BMi2frzu6RATFIXo0kB0kbjTz/oWNcFKhxU3UkjoL0HDEXG
         bjjUfifwQSlcEoi/dcodmv51hWSpXQoS0mxQ62qAzSwwByzAlPv+DGVtVw4uw4w0Q1Do
         n7FxnE38TjXXUtQGp4VR3honnC3jiIqWHUoCEni9YlLDdVv+v6xSYy9i7mtiktFowRGs
         hc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg3Kgw5vrNE8ltWjJ/Ne3mXQemq6Bfc8CUmnwiMggRw=;
        b=dtq6KZLt27a+aUmMAkXTb7Jxo5m7E6+fkWcWIuqgJTTNkSQ1nCNOF5c5KJOvI3UHcW
         wO4EQhgf9nr/o0AoE+Y7URvkAfREofyJS+U5hwmIbkq2yy07bqdoqazDgFG9hdVd2L1V
         9xyZzqCY0B+LoqFYS25vQHSaQ97fY01PNvI8ZwoCy8LZwC1uvShXm71J7BAXQms4V2Lv
         s5ya7ApdAOBSAzSf61sV06DJFGOfhX6hJK2vDXc6zzOJ2BJ53DDkvbCEH7zjR4alyM4y
         /bjwl9Mq5I2MYJAehdkoy/JhiaAshQtLg8n2mtieVEHrk5l5itOCJQIZsS2foxsOsXR6
         V6Yw==
X-Gm-Message-State: AOAM533iBpycpaLl0t/V/eOCwavLnKpWhbSUojtgkhNKQu+iKdcEGpgg
        qlN9OZHwgmRx8boSJJLOnvQUZQ==
X-Google-Smtp-Source: ABdhPJwcJIzKy4K/gAyjAYe2/KbWJInKZvxsFfmnIxMXkTdqq1VkXvuq6/T3HIw/Bokls8TqSs8O4Q==
X-Received: by 2002:aa7:9ede:0:b0:44d:13c7:14a7 with SMTP id r30-20020aa79ede000000b0044d13c714a7mr35099523pfq.18.1634649162095;
        Tue, 19 Oct 2021 06:12:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id 1sm5262347pfl.133.2021.10.19.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:12:41 -0700 (PDT)
Date:   Tue, 19 Oct 2021 21:12:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211019131234.GA221392@leoy-ThinkPad-X240s>
References: <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
 <20211013075125.GA6701@willie-the-truck>
 <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
 <20211017061305.GA130233@leoy-ThinkPad-X240s>
 <5e59784e-3f09-cfbc-1692-f3a5d85b0995@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e59784e-3f09-cfbc-1692-f3a5d85b0995@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi German,

On Tue, Oct 19, 2021 at 10:23:01AM +0100, German Gomez wrote:
> Hi Leo,
> 
> Yeah I agree the redundant AUX events are adding unnecessary bloat to
> the perf.data file... We actually cam across this when doing one of the
> test cases. Sorry for not reporting it!

No worries.

> Could we patch the driver in a separate patch set? Or do you think this
> is critical for the purposes of this one?

Yeah, we can take low priority for the redundant AUX events issue.

Please take a look for the issue mentioned in another email for
recording trace data with wrong size.  I think the issue for wrong
snapshot trace size should have a fixing in Arm SPE driver, and the
fixing need to be verified with the perf patches.  After that I am fine
for merging the perf patches (and you could upstream kernel driver
patches separately).  How about you think?

Thanks,
Leo
