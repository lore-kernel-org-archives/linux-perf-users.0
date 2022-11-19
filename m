Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67718C4332F
	for <linux-perf-users@archiver.kernel.org>; Sat, 19 Nov 2022 01:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKSBqU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiKSBqC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Nov 2022 20:46:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48023111A
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Nov 2022 17:11:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso5252395wms.4
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Nov 2022 17:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poUEgSpW8aRR+UYT6TnHI6nLDP+vN2nQH/+BboE+CwA=;
        b=QJxTQsbhne1J0+HkYSqeeTJ8bAIxnkFEQPLDFXkPJOTL9+l4a2uz9W3tDZP/KE/OhI
         Uov3slDhLE8qws9664ELtwF5kXtbZz+9eqzqnj5B41WgPT9YXFxc6MnYIVIw8wmHdVxu
         cVtAW2Aiz5aLxZCJtkFz4y5svwqU0qfoexV+RiefHu+riHDabwWG4iux1ihYYAGcKMQU
         8OVS2r7SqG9dgCYqiwNYd+PkXiiIuzfohSYXXpiAM9e8MTjnJaeuHK4xlnrs+uzNjatW
         blQFethYpzfYBfhvU6HywPEwEpYwB0vfqhWkZ7iNzwniHirwV4FRf6mhxjdgIi3Oj5Oo
         1Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poUEgSpW8aRR+UYT6TnHI6nLDP+vN2nQH/+BboE+CwA=;
        b=RMu60SDH8GXu9P4Nhn7ZER5QMui+Z3nM2XCD1+UpIuCy8k4UR0GKl42yhZd1DKGm6L
         zBh/HzH4NJiCrE3hiDQzraDi5TUYvhmV24lZmpfu9y+9U5jpzRYeV6m0HiaLxN2wgnnL
         O34LyIGOpapfG9mcYNBa/TUSS4TTi/aJrvzx26HXJUU+UvDhzhVuKyVUxdTbXPHgAGuR
         gWaZNsf5i3OjtnfNzWay/UVa4QmvU+UofvDHlq8WL55KDzWulNg4/Vv0ayLWFy6vZO9v
         98qzZE9phlzWTLS7bxT6ITWmcoY/cqENS4f201kX7JeglK/lXUJy5d+Ik6CKJPAPsFyb
         sL7Q==
X-Gm-Message-State: ANoB5pn/NtKn2axSk2MLZrWnH/mZpbenUP6nin2EobXHmCRav5l4vIgR
        LYn1gsw1hjpW/cBPWLKwJvD6l3zGPZYb8cerQEMnFg==
X-Google-Smtp-Source: AA0mqf7V9eiJHCaM/vFfpvEdbjfi2x3hRxzmxWRSYnv0W7idsEOSf0y1t2VFaXjebmElzcfCavuMUUICqyvZPyC9wH8=
X-Received: by 2002:a7b:cb4d:0:b0:3cf:b2a6:267d with SMTP id
 v13-20020a7bcb4d000000b003cfb2a6267dmr6443367wmj.67.1668820307595; Fri, 18
 Nov 2022 17:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 18 Nov 2022 17:11:35 -0800
Message-ID: <CAP-5=fUGfJVLFzcUq8U-YH3S2EaPqJm3C2_uK4bF7m-NYpqNzQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf vendor events: Add the cpuid for Alderlake-N
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 17, 2022 at 11:56 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Alderlake-N only has E-core, it has been moved to non-hybrid code path on
> the kernel side, add the cpuid for Alderlake-N separately. Both events for
> Alderlake and Alderlake-N are based on JSON file v1.16.

The update to 1.16 is true at the end of the patch series rather than
the beginning. It makes more sense to bump the version in the same
change that updates the json otherwise reverting the json changes
leaves the version number in place.

Thanks,
Ian


> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 5e609b876790..df47462a125f 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -1,5 +1,6 @@
>  Family-model,Version,Filename,EventType
> -GenuineIntel-6-(97|9A|B7|BA|BE|BF),v1.15,alderlake,core
> +GenuineIntel-6-(97|9A|B7|BA|BF),v1.16,alderlake,core
> +GenuineIntel-6-BE,v1.16,alderlaken,core
>  GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
>  GenuineIntel-6-(3D|47),v26,broadwell,core
>  GenuineIntel-6-56,v23,broadwellde,core
> --
> 2.25.1
>
