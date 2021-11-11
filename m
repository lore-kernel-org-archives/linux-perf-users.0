Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EFBC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3E8610FC
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhKKNaM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhKKN3q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 08:29:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4CEC06127A
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 05:26:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id o14so5766924plg.5
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 05:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+5ZZCvB7cw3hxgR2a0Zb0YuaBAaUVc++Fgiq7CcVKlI=;
        b=Gc2X4tKrbUgmH8pZ6b2ngv7PYyDIUUmGkDXHWRyLKAP9hlLqOtfzQttT0prEy79j8x
         7QLu6UMoc79OxVTgbKvFzW6+z/2I+k7M+TsObUUc3/H7jAXhPnZRUKFF98vPc28LhKB4
         fcDsze/LsOPhYY3oDztOzwtk9R6IU1rEUELwYcrC3sGzjp8nAYWHQ9FMD73x/heFh2/u
         YbiXH9G++3/y/mjzD/bPRo7CZek6T48pUMzEr06NuNzy21IODIa/+VXSjRDS8MzYyUzi
         0noUg50ItLHTLmDv8pdVCA7W4I6WN/+pFq/RKv95TT/x70ux+jCa8RYtbRC03JpPCfHj
         BuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+5ZZCvB7cw3hxgR2a0Zb0YuaBAaUVc++Fgiq7CcVKlI=;
        b=1oYCygV9WNNE1QS0tpHkXu0DIpeEdufoOsYSLy7wV/vGvycOB7QFqBE9GksRaXHqaK
         /gI9GT3lgUxl7qKhjvxP5dF6oSN3f9aoKxgc20rqBpZiD9uajRFzONP8jKO3pqd8Pr3f
         UAPmwQnpAhg3tjoY98JpMGddyipjgo9Thf2VyvJ22IQp35WHSgTIx6q4UQsfYEle8n+Y
         BWRa2sXascqyaLs38EebfU39MyjCnVgbYwuqaiUp9uxYQ2fnGSJVTWm0IUQa3uZyCp2A
         Bky9crwVGDD6pH7USSWl3bJOb4APvKnTi1DV2ss4RGYnj6LtFyEW2fjH6mIhi4iG3NC+
         wpBw==
X-Gm-Message-State: AOAM531rxf/QgbNRCcqvBV5eD/YvsiFqjuhyo94Swoewa79mvENu9XHr
        6SLdw8+DrQrhoBZZCXZUZjUkaZHxfI8/BY6A
X-Google-Smtp-Source: ABdhPJx+iquOm/A/o8dJzkfx0jH3xgN1cdgV9HpuS1Ct1QFtC/wkEFVlMk5Xnct2Gpt4cu/NvdozTQ==
X-Received: by 2002:a17:902:c245:b0:141:f279:1c72 with SMTP id 5-20020a170902c24500b00141f2791c72mr7636312plg.18.1636637216665;
        Thu, 11 Nov 2021 05:26:56 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id q6sm3309107pfk.144.2021.11.11.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 05:26:55 -0800 (PST)
Date:   Thu, 11 Nov 2021 21:26:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] perf arm-spe: Track pid/tid for Arm SPE samples
Message-ID: <20211111132647.GC106654@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211111072714.GB102075@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111072714.GB102075@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 11, 2021 at 03:27:14PM +0800, Leo Yan wrote:
> Hi Arnaldo,
> 
> On Tue, Nov 09, 2021 at 11:50:16AM +0000, German Gomez wrote:
> > The following patchset is an iteration on RFC [1] where pid/tid info is
> > assigned to the Arm SPE synthesized samples. Two methods of tracking
> > pids are considered: hardware-based (using Arm SPE CONTEXT packets), and
> > context-switch events (from perf) as fallback.
> > 
> >   - Patch #1 enables pid tracking using RECORD_SWITCH* events from perf.
> >   - Patch #2 updates perf-record documentation and arm-spe recording so
> >     that they are consistent.
> >   - Patch #3 saves the value of SPE CONTEXT packet to the arm_spe_record
> >     struct.
> >   - Patch #4 enables hardware-based pid tracking using SPE CONTEXT
> >     packets.
> 
> I have tested this patch set, it works well on Hisilicon D06 board,
> please consider to pick up.  Thanks!

Hi Arnaldo,

Please hold on this version and German will respin a new patch set for
a found issue.

Thanks,
Leo
