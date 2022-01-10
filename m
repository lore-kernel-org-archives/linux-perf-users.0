Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9EAC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jan 2022 22:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbiAJWWs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiAJWWs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jan 2022 17:22:48 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A8C061748
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jan 2022 14:22:47 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w9so6676094iol.13
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jan 2022 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GECtgr52QV1EPTta/2B2UmimcgBEplWvMNOTcq1vS+M=;
        b=kgBQtrZHWwIJdlu/GkbHgK1ITF4NgJgumTL1y0OAA50GernivyX0Y8EwcW4XnAr4zE
         93KmJk3auGzU+hGxD3/n96RpUJd1YpdXahQfojM6x9eiGh08s+LWGKC5RnKBb6i3weHq
         XxGBBzKmIOs6VNQpTFXJzb8Uhpfh7ZXi1CB1G7tZUZmAYuh3VXyaTiSC3nAjgLDRaSZN
         lLfw7s7gpjfHLNcdAe+P8/Y1jES6fXACoHZC36+Y5dBptSc7BxfST5xy6nMBhl59Wzvp
         QeyDDXvXgsgnotzda2gTd36lv28MWf1kyitrQOQPlrao+EhLSGYbmkG9tYsgcoXwQtNV
         Rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GECtgr52QV1EPTta/2B2UmimcgBEplWvMNOTcq1vS+M=;
        b=lHI1h1QbR7mC36mESqggkt6F0wqqjWZec87Uv2EBxVkNm4e13M2UO2qHvDklio37ZZ
         V9kaF+JeQ71f+VQbI4osq0Wxtyq/YINiDGgYsD/+XEyq3jrwHnhV60MXpeYmJ35Eu+lt
         2xPmereZnB3iBcNXQlUiHPYjPhDGRgpcDxAgIqIWcd5p4GIWpSQXcqsPxCAASgAmKwk7
         us0pk959bT1eQJsUmLq+rCvA+PdmWwqCzw+o5eJ0GNAkl7pZypaRNR+X/i2jU6drATTS
         zU3wwezWeKhW995RunPGbkqOSphqtPTNSlpR7t0QnXf3+8xmXtaPj2F03hl4hZY8jnDt
         kvBA==
X-Gm-Message-State: AOAM533Uh2eP3HLxtvOf2+Z3V+lNPCVMbcy0n4YllZTaY0Lua7UeFjSI
        JAZidOkL3+kzwPAB2cPnsLbAOZF7IDd6qVmWL80bCQ==
X-Google-Smtp-Source: ABdhPJyISpavZ8R66rZeWCAR7t9VhZ6UHzPHo8uijxDXyTrjndiRPXu1rvhqDAUd/s9WRwwU9PbbkBJWrszWNNvd70w=
X-Received: by 2002:a02:294b:: with SMTP id p72mr927296jap.263.1641853367120;
 Mon, 10 Jan 2022 14:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-5-irogers@google.com>
 <0e26524c-9f4c-b351-2498-0a56bc86b4ee@huawei.com>
In-Reply-To: <0e26524c-9f4c-b351-2498-0a56bc86b4ee@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jan 2022 14:22:34 -0800
Message-ID: <CAP-5=fWU+JBpqpE0ujGfs5TmnY9mv5CWNdMc=X_zKe79GTvPfw@mail.gmail.com>
Subject: Re: [PATCH v4 04/48] perf stat: Switch aggregation to use for_each loop
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 10, 2022 at 10:51 AM John Garry <john.garry@huawei.com> wrote:
>
> On 05/01/2022 06:13, Ian Rogers wrote:
> > +     cpus = evsel__cpus(evsel);
> > +     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
>
> It seems a common pattern to evaluate cpus and use in
> perf_cpu_map__for_each_cpu() - is it possible to make a macro to accept
> evsel and create cpus, like perf_evsel__for_each_cpu()?

It's possible, I'm not sure it is saving much and it is common to also
want to iterate the cpumap of the evlist.

Thanks,
Ian

> > +             if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
> > +                                              id))
> > +                     return cpu;
> >       }
> >       return 0;
>
