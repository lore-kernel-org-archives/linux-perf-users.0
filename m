Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B77C6FD19
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Mar 2023 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjCPPOX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCPPOW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Mar 2023 11:14:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F57B53EA
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 08:14:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so1889602pjt.5
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678979661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hipF8kv9btc+ofi69HcRjl9Ik6Nhwu9Uss+16//MXqk=;
        b=oYzM8mfqsog+QJRhec+BKT1ae38JEQWTABfr0aunbSbufycQbpAX77GixAo4mlG02a
         45Ax2iXM4BaAg0AxTbfA3lomJ+GKpTMAUWOKMhUJOcAcMZSovddcC0WcACaWrpBBhAz5
         47LkJ5DHckti+l5/4pFSBII35EmBlKHH3ak7prX1NUY/7oNkwwKbTB9xVkupcRNY+KId
         exvmcUc9nBg0rFZAJQ1HcgDp/BRZpfb80e/mh1lcpEF+N3Q6tU1omjJXdSX0PuyyQO4H
         qQCjcTC7Fc9WIqSUc5vvYgV2wyrocKvq6P7FP8PATz2pV4NlSpgBdCSRr66TE+UxjI/T
         dUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hipF8kv9btc+ofi69HcRjl9Ik6Nhwu9Uss+16//MXqk=;
        b=jJq6hUS1iSvjK4mgcFBU3xRZSFVpiO3WGlThj/74rnClpTY4Nm3ZuUC68GKdzBVzqI
         5j14I8BuSChyZ/6odBVY6efa/bijm6hYhJ8EBJyMBdRTpze6vgBb8ukVlTQVnq3f+DRn
         DdNWcVXrSzLa1O/LxmWV2Uy9EGQBZMZbC5Cww0j8IeWfASTTZVcHlacGRZY9B1FDdejt
         5epHghH7c9H5zRdScCClFZPPOs+becghZW28mWcmlmk3PXAE60cfHMlEQQ2p9D7V2RlL
         32A+Lr5X8wumBbWdpf1IssWqqk7iXRWZtF4aRHLTd6UeAieXvEMDPSYLCyE69PD9DjjU
         ErHQ==
X-Gm-Message-State: AO0yUKV2cGWjauRcyxhdL3++Cp7+wq/wi6jAAqnYX+90mZ0h3m+q+Lli
        ICDFGuOA3ckC+8zwNRQODzEb0ZC402gsCT3gjbsdXH8g
X-Google-Smtp-Source: AK7set+MWdri4mh3ohhBtzGkKy25cPA3xa0qhOawUt9CdCmWX/BF9DdxvoyfpfkQOUt1OsWmJAibtQ==
X-Received: by 2002:a17:902:e546:b0:1a0:6bd4:ea9a with SMTP id n6-20020a170902e54600b001a06bd4ea9amr4556577plf.16.1678979661080;
        Thu, 16 Mar 2023 08:14:21 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0019602274208sm5687274plg.186.2023.03.16.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:14:20 -0700 (PDT)
Date:   Thu, 16 Mar 2023 23:14:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 11/16] perf kvm: Use histograms list to replace cached
 list
Message-ID: <20230316151316.GA2813925@leoy-yangtze.lan>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-12-leo.yan@linaro.org>
 <CAM9d7chSKPxMHzpKZ92xGZ+XmLpd2q2EJwMuszosXu_FO4_dgA@mail.gmail.com>
 <20230316090418.GA2665235@leoy-yangtze.lan>
 <ZBLrruagawAbxqoz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBLrruagawAbxqoz@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 16, 2023 at 07:13:02AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Since I build tested this already and had the other fixes, I'm pushing
> this out to perf-tools-next (and perf/core for a while, for people not
> knowing about the new nbranch names) and you can continue from there,
> ok?

Sure, I will send a fixing patch.

Thanks,
Leo
