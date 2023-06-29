Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D9EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jun 2023 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjF2Vbv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjF2Vbt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jun 2023 17:31:49 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30013F5;
        Thu, 29 Jun 2023 14:31:47 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5773f41c1dcso2132707b3.1;
        Thu, 29 Jun 2023 14:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074306; x=1690666306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoENgYvXFLite5/xMgXTrtXiVpAbaDQ9fsoEG3w0OLA=;
        b=Lp4EkjHxJNUEmrX9VtFdA6xnngVpiCjlAM6ml9fl1IH1aUP3b7oY5SbgEdfIDrVJvJ
         BgBrqCAsKZe95OcecnhsaEbPfA++F9RvpJmDCb4O83AmayvMpstT1wgYL/XCAfERgAEB
         Ag9E9TfVxr73LhKJHzAYwWnF08jMJ1cH8+wD9DmGkElam0QxtlIfWRyfi+6KzwvnuT1y
         Fjt/M127qvfJok7rss/1dAfC7eHNLW9jIP1sfY84xZN3q60Bo4mqPLGUkAD51NjWQ5hz
         Q+4/M45usIZ/rvB5NgvM17T1DPhXtwyNG3vIgJNx+c5fUubQZQTFf9w5kU8e9G8YtkTt
         DBlA==
X-Gm-Message-State: ABy/qLah7vaZa4Kmb3OiRzRsiQgBkTki6m3uJ4VZnYPzFyw8OpekO1YX
        OOFM+Gglzz108vaOLidNKc6lJDYV2v9/CCsApRY=
X-Google-Smtp-Source: APBJJlHokpAkUFadL2QgrAZ2q/30Xl/epYQBSSEn/8mKrLBcEzR0CGXdNOWWDltlmQfe3fiUrDiwRZOUzf6KRLkIgHY=
X-Received: by 2002:a25:19c1:0:b0:c00:92c8:542f with SMTP id
 184-20020a2519c1000000b00c0092c8542fmr779020ybz.60.1688074306279; Thu, 29 Jun
 2023 14:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com>
In-Reply-To: <20230623151016.4193660-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Jun 2023 14:31:34 -0700
Message-ID: <CAM9d7cgX-vnwkrQMMHn2C1sCjm3YO=xaigmMTsrbkg+fHk2H2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Add metric has_event, update intel vendor events
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Fri, Jun 23, 2023 at 8:10 AM Ian Rogers <irogers@google.com> wrote:
>
> Add a new has_event function for metrics so that events that can be
> disabled by the kernel/firmware don't cause metrics to fail. Use this
> function for Intel transaction metrics fixing "perf all metrics test"
> on systems with TSX disabled. The update conversion script is posted in:
> https://github.com/intel/perfmon/pull/90
>
> Re-generate Intel vendor events using:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> Adding rocketlake support, uncore and many core events for meteorlake,
> and smaller updates for cascakelakex, icelake, icelakex,
> sapphirerapids, skylake, skylakex and tigerlake.
>
> v2. Handle failed memory allocated for evlist, John Garry.
>
> Ian Rogers (12):
>   perf expr: Add has_event function
>   perf jevents: Support for has_event function
>   perf vendor metrics intel: Make transaction metrics conditional
>   perf vendor events intel: Add rocketlake events/metrics
>   perf vendor events intel: Update meteorlake to 1.03
>   perf vendor events intel: Update cascadelakex to 1.19
>   perf vendor events intel: Update icelake to 1.19
>   perf vendor events intel: Update icelakex to 1.21
>   perf vendor events intel: Update sapphirerapids to 1.14
>   perf vendor events intel: Update skylake to 57
>   perf vendor events intel: Update skylakex to 1.31
>   perf vendor events intel: Update tigerlake to 1.13

My tigerlake laptop now passes the all metrics test with this.
It used to fail like below:

  event syntax error:
'{cpu/cycles-t,metric-id=cpu!3cycles!1t!3/,cpu/tx-start,m..'
                            \___ unknown term 'cycles-t' for pmu 'cpu'

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
