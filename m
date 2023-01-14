Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A84FC3DA78
	for <linux-perf-users@archiver.kernel.org>; Sat, 14 Jan 2023 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjANWjo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 14 Jan 2023 17:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjANWjl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 14 Jan 2023 17:39:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C1A5FE
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 14:39:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so133207wml.3
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Jan 2023 14:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0yzC8ZlGvRmgReUtkQlOS8z9agGk4HR8CX9kDFJuDeY=;
        b=KYfAF+1UgLuuLeMR43j+XU2GWx0P59DA4XS0dEkOV0S8nCfYfWytWv1439IOuYwbVc
         +z+/F+o/nWghbbVtFilc2W+Vk+i4zzKYx+BD9Px4WUR5HGuDya2C/VJesGjoXhizHjfp
         +2Atk3cdDvdBJi8QQqyjOGW2xsziQt4NWfxSxIBpLWJ/8NzwTfYVkmaAvhuSRKDs00mK
         LJhLUgCfdrMu20+tb2y3RiwSGDPluHMblXd5nCtDpdZXu287uN6b5mXsqIl6XgpHvpzo
         22/GtNGDPB/HS8B2FdM9TkIYGUgKL2Yd7R6bLqwAfLrFIwUyfuw4S69vOvfZJe6Izfm2
         1I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yzC8ZlGvRmgReUtkQlOS8z9agGk4HR8CX9kDFJuDeY=;
        b=4r8x0p7IuuicX3bWGwgZhxdfMlOBjVlrH2GIHyriZZKLd4L8sRgeydlgnoQgqlZOZ0
         CCW4bOpFql2MDl1apkGIZlwlHJBsv3OLiQEAlVIhaR8fVurVn8UYTAySVf4/ZWzPOjnb
         7ksq4HhxDysFwS7IzBN3xe2gIOVwfWBfIQ3T3J6lutr9FHAJNDpxbZVRwvVdMUWZWPHO
         /FSGwfPK31CiBQQnHGZiizpKHkiO6dOYqndxVQHA+ZcQLd+bH3aVIX+Bjdm+PL4thcsN
         5POyPgT+hKYRuoi3E8cyqAX7CJ6rRbexrEn0vpgBHht5lzVnX3Q9cvI0xXoM1TH4emBT
         5CQA==
X-Gm-Message-State: AFqh2kqus26c+TH9dfI6k6irCT8Z/TJN313hRL3C+XfmYwVaYxmtDAHd
        y6QwRUwQsK2qLqIi7aviwX2haAXoIz+gnsKbsp7NUw==
X-Google-Smtp-Source: AMrXdXvkG0GgV6L4b0qlqq2w/S82FF0IdiIsQvPw96Yyo/z3BCx2VZG53lj4IsPusQN06EybyGoWgTi1N+etc+PnunQ=
X-Received: by 2002:a05:600c:3b04:b0:3d0:50c4:432c with SMTP id
 m4-20020a05600c3b0400b003d050c4432cmr4337596wms.67.1673735978906; Sat, 14 Jan
 2023 14:39:38 -0800 (PST)
MIME-Version: 1.0
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com> <1673601740-122788-3-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1673601740-122788-3-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 14 Jan 2023 14:39:26 -0800
Message-ID: <CAP-5=fUgKMcjgB3jsdtxdmSomt_K0XMKgHcc0Jjc6oR7ixJu4w@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] perf jevent: Add general metrics support
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 13, 2023 at 1:22 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
> Add general metrics support, so that some general metrics applicable
> to multiple architectures can be defined in the public json file like
> general events, and then add general metrics through "arch_std_event"
> in json file of different architecture.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 4c398e0..0416b74 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -358,6 +358,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
>        for event in read_json_events(item.path, topic=''):
>          if event.name:
>            _arch_std_events[event.name.lower()] = event
> +        if event.metric_name:
> +          _arch_std_events[event.metric_name.lower()] = event
>
>
>  def print_events_table_prefix(tblname: str) -> None:
> --
> 1.8.3.1
>
