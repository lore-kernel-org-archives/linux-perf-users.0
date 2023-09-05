Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F05CA0FE2
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Sep 2023 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjIEQCS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbjIEBd4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2023 21:33:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49DCC5
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Sep 2023 18:33:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27183f4ccc1so931591a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Sep 2023 18:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693877633; x=1694482433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S8Zr6qvg1Ao4DxVpdQ4RADfHwn46fbVmt8Nq/6N2T8=;
        b=gCZjUL0OOc5vrqUQ1EslFtA7E8KovwlzkIN7BUlC4P7rkcJMdN/R/FruxpjMnmfdU0
         qatxD5w84iIv0h6ALhtvDEpZDUrkFK6CSlSPobP2yxah5SRBsDJNJzZN8uMqjtE2m0ee
         0m0nnajZGvvvMB0tKLylxduEbFnHbkO+CaTw5ViTbE90DLQmxz8oQ1zEg0C5v5EEfNle
         NUAWIiRA9mL5GfdIhvGA8n82rb8uM6A0qLi9MnPmnAP6Bjc0WewxhFltupA1gvC+ZuWJ
         2o6rh/EnM0ESvhGkluE9FuSY3omR+o06x++2at5l7Pp+GSkuIkOmdHww+Ny/ApRKMlWu
         9SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693877633; x=1694482433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S8Zr6qvg1Ao4DxVpdQ4RADfHwn46fbVmt8Nq/6N2T8=;
        b=PIqXS4OGkuzgckCnJCpjHS0cCQ/j4uxzMUcp9YRTaZJzvbzmOxWCwRBfvm6Z+FRD2Y
         0ZwVmZIUG+V+qIpC+AHKyQ/BgSAiGyXl8G4U3th/TlBux+sy+XSCbbsJFTHX9xO3ePLf
         /y9n1lSQGii36xor1+8Ps+w5AHRgMXGdpRsVE8K6YcIvpu0adfZWUU9knzKvuqoCO55d
         ddRrVs5qQ5hIEGTirysyZ9dqi+7V1Smycnm1Zk6l3CQ0z8qjEnM/eEk5J95XPXTyfZ38
         AwthFW3Wn31iJI/Z3lvpLVczpFcchB/btBBRvSauwu5OohGAbKtD0gVo6ZzWcr+vyAiz
         qj1w==
X-Gm-Message-State: AOJu0YytiHzjKIFW7aY7W449tNz6UfJ1WCyVQipwB/wFRnaxg6hQ6HvP
        h3lE383DNvCIBEp56+zzxGwBgw==
X-Google-Smtp-Source: AGHT+IHXumvH4mpK+FtuZ8UBv3wR5yIPoKGnroc4pvxo61RJr3QNYTKh8hRpX35n/csahdAepThgNw==
X-Received: by 2002:a17:902:f689:b0:1bf:205f:c02c with SMTP id l9-20020a170902f68900b001bf205fc02cmr11406801plg.58.1693877632918;
        Mon, 04 Sep 2023 18:33:52 -0700 (PDT)
Received: from leoy-huanghe ([223.104.5.47])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b001b8af7f632asm8116268plg.176.2023.09.04.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:33:52 -0700 (PDT)
Date:   Tue, 5 Sep 2023 09:33:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf cs-etm: Validate timestamp tracing in
 per-thread mode
Message-ID: <20230905013214.GE114383@leoy-huanghe>
References: <20230827133557.112494-1-leo.yan@linaro.org>
 <20230827133557.112494-2-leo.yan@linaro.org>
 <8eb9b2c0-1dbb-8a93-fc4e-463a6daadb9c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb9b2c0-1dbb-8a93-fc4e-463a6daadb9c@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 04, 2023 at 04:23:43PM +0100, James Clark wrote:
> 
> On 27/08/2023 14:35, Leo Yan wrote:
> > So far, it's impossible to validate timestamp trace in Arm CoreSight when
> > the perf is in the per-thread mode.  E.g. for the command:
> > 
> >   perf record -e cs_etm/timestamp/ --per-thread -- ls
> > 
> > The command enables config 'timestamp' for 'cs_etm' event in the
> > per-thread mode.  In this case, the function cs_etm_validate_config()
> > directly bails out and skips validation.
> > 
> > Given profiled process can be scheduled on any CPUs in the per-thread
> > mode, this patch validates timestamp tracing for all CPUs when detect
> > the CPU map is empty.
> 
> There is an edge case where the profiled process is known by the user to
> be pinned to a specific CPU, rather than possibly running on all CPUs,
> so this isn't always true.

Good point.

However, when a process is pinned to specific CPUs, we still can
dynamically change the scheduling affinity to any other CPUs by using
taskset command or calling sched_setaffinity().  From a perf session's
pespective, it is sane to validate timestamp tracing for all online
CPUs for per-thread mode.

> But I think that can be worked around by changing it to a per-cpu
> session to get around the new error. Given that this validation was only
> supposed to be best effort information and not get in the way you could
> say to not make it more restrictive.
> 
> But it's quite a small edge case so either way:
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks for review!

Leo
