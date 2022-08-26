Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5FECAAA3
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiHZGUA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 02:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244780AbiHZGT7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 02:19:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57B63F3
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2022 23:19:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id io24so786754plb.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Aug 2022 23:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=feSSvQfSIZTTbKIOXODfwXSxUp0ih4gkGwyK7VijaP0=;
        b=XgDFRm1E8UjNTOgDL5udYLrY3rfl7szKOjxlfoj2UF0hohpr4ppLGZHSckwe23lT/W
         zxa2FF/iIKpWsCVYwSDydF684UjFCrjEVy2f5leRBss3MTVvPgqoR76PCYGt86UNQdEi
         N0UqN2hg+A6xm1ZE2FaelV7AiMqK0vMwgw41Wjc/H05fiQCylmtdpfXIgzR12l6I0IY8
         SC8Ns9qRzM0Erh+Vli8KJ01EsBOXzMwu+Ct8BM5m4s3UvO9F4Ctzbaq1GnEyFsv7v2Mf
         5Uk6J3PCt+wWNx4Rh9MoGQeZ65B+7RxRGQ1gPyu0O6bU8WFplfmWRZgklWXHsVTEnnyA
         SdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=feSSvQfSIZTTbKIOXODfwXSxUp0ih4gkGwyK7VijaP0=;
        b=6Op6nqOcBemZvEikMObVM/MXgYDKqJPRq5E/ZZX+FUm9LZh/uSReJAaK0y3dJne9Kc
         YGKXJnT8AUvb2Sh0BbI7rX22ZqCLFnaH4aOWw9/u6seRsvJOywMmVUuzNjs/INSXaijd
         YZl9ehBepZZ7XLK13B3w7VUbRX6vefGSLWPU2gTvgHR/fMC9hqnKOltxw9YhQ6L2J3QI
         1OMxU1rIZHXQoduVCoZ6e6SExX9cEvLCb4Pqk9QeYV2D8IcZBu8hHeGcMv1uavWK23gb
         ADush4Redirg5T8keUUW4AJZGeOzW8E76RYoC67CbVfKI6+c+B4KDNYP+8oRf6SC6SXD
         U0Ng==
X-Gm-Message-State: ACgBeo1twJCQnTa1jR7wBOZPyLZOSCHa2ynfsclzbh24kt6ICcl4ZpLw
        brVHmXkyp3faxDqgBbX2UR8fjg==
X-Google-Smtp-Source: AA6agR5izOHSiZtIGwj1+c6VRv9kb4Nt6ZkJukay+Y+U1Aq3+odozhkh2KBhAAX/gzAij32vGXnc6A==
X-Received: by 2002:a17:90a:c402:b0:1f8:c335:d4d7 with SMTP id i2-20020a17090ac40200b001f8c335d4d7mr2850632pjt.242.1661494797001;
        Thu, 25 Aug 2022 23:19:57 -0700 (PDT)
Received: from leoy-huanghe.lan ([204.124.180.110])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b00536bbe91b83sm743055pfr.157.2022.08.25.23.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 23:19:56 -0700 (PDT)
Date:   Fri, 26 Aug 2022 14:19:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ali Saidi <alisaidi@amazon.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH RESEND v6] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <YwhmBlp0eVtiU5JW@leoy-huanghe.lan>
References: <20220826051603.174792-1-leo.yan@linaro.org>
 <YwhXXiuQ2VysVint@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwhXXiuQ2VysVint@leoy-huanghe.lan>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 26, 2022 at 01:17:18PM +0800, Leo Yan wrote:
> On Fri, Aug 26, 2022 at 01:16:03PM +0800, Leo Yan wrote:
> > From: Ali Saidi <alisaidi@amazon.com>
> > 
> > Add a flag to the perf mem data struct to signal that a request caused a
> > cache-to-cache transfer of a line from a peer of the requestor and
> > wasn't sourced from a lower cache level.  The line being moved from one
> > peer cache to another has latency and performance implications. On Arm64
> > Neoverse systems the data source can indicate a cache-to-cache transfer
> > but not if the line is dirty or clean, so instead of overloading HITM
> > define a new flag that indicates this type of transfer.
> > 
> > Update notes:
> > 
> > This patch is to sync the headers between kernel and user space, commit
> > 2e21bcf0514a ("perf tools: Sync addition of PERF_MEM_SNOOPX_PEER") for
> > updating kernel header has been merged in the mainline code.
> 
> Hi Peter, could you help to merge this patch?  Thanks!

I sent a new patch with adding my SoB:
https://lore.kernel.org/lkml/20220826060556.176681-1-leo.yan@linaro.org/T/#u

Sorry for spamming.
