Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC71C636D4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Feb 2023 08:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBMIzE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBMIzC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2023 03:55:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6313DC7
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 00:54:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so16242362pjq.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2/mSUWKlQedrqtTIBOMxdk2IBVcf3JH3oYstMkfrAk=;
        b=CIG9hHXtpyrGgUqYj2fchGva1a4G6Bps/aP7JA5AqxJYIzBD7kM0DMYdQMHITkUbew
         cq6j1fq5P951jNJC2bKW9Ngt4b9xQpN4H5YUI66zeHzWojLU9r5pmn/qXy0jAq4ezTC/
         xeEen2pN598DADe6fMynbAQsSYINgRuOzYLM8hKym8fMIlTRu99BwEoru8hHwzjrzjRb
         5JjO5xIlDUzUgaTcx743OvI42sDiLLuRfg0/H0cT7nB2IKcjPooJni4TBhs+/E1NeO5J
         yTSy8bz0Y+gnsQyMcvp/KAFmo5/LJp115OIzxGo8WKo7am9puXGu1vmuRqduYg+jFEd7
         mSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2/mSUWKlQedrqtTIBOMxdk2IBVcf3JH3oYstMkfrAk=;
        b=t5ofgFLJ7raE7YPveuUTpaujg89u3WwEe+UbINNFJwy06Dtj5iMGzskFBMw+E6KGki
         6BcbxmXTBAk+rbNnaCsF9eciLIq/D10YqDq3Gr3D8QBASSPJe8KCwMQtxW4rLdh8aZif
         D6KwOBmPxOW+yP4nRgXaCDxYeTJMCoiFPUr1byDOHx2VBBMh1RNB5Oe6NLbWHV4OJ13d
         cXnKArbDR8/aLwsvcUWI5VTBqaZXlAfZyzkeUHHmPd0Y/fnhiyleYGvskcJh3ehnUNat
         weU8IS1C2LFOOCcAA/+1FR/BSY3pKybt1DFRu6q//GIp3LOgAL39XE4vtmKY+MhDO+XH
         48Jg==
X-Gm-Message-State: AO0yUKU93YctGbmdBK33F0384luRJym6q266nuUHjyWzvArZ4BE7/l3y
        xGBLFPD81r3NL9/ALpp6V9qNsA==
X-Google-Smtp-Source: AK7set/TSDUJkzPnFx+7/gB56sSpKMXzphKQ1Rl4A/cwmpt51uV7IRswYltPBpVPD8UiWxP/wbHe+Q==
X-Received: by 2002:a17:902:e545:b0:199:f5d:478 with SMTP id n5-20020a170902e54500b001990f5d0478mr7310453plf.63.1676278495460;
        Mon, 13 Feb 2023 00:54:55 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id h22-20020a170902ac9600b0019aa6bf4450sm868142plr.188.2023.02.13.00.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 00:54:55 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:54:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH] perf c2c: Add report option to show false sharing in
 adjacent cachelines
Message-ID: <Y+n62XwT3nUGX4/M@leoy-yangtze.lan>
References: <20230213031733.236485-1-feng.tang@intel.com>
 <Y+nyakPnVDpVjn24@leoy-yangtze.lan>
 <Y+nzoaJcnMFokDMX@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+nzoaJcnMFokDMX@feng-clx>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 13, 2023 at 04:24:01PM +0800, Feng Tang wrote:

[...]

> > With these typo fixes, you could add my reviewed and tested tags.
> 
> Thanks a lot for the review and helping to test on Arm64 platform
> which I don't have access to!

Welcome, Feng!  And thanks for your patch!

Leo
