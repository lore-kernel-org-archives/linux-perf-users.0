Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C631EB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGJQJP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJQJO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 12:09:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE35BC
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:09:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40371070eb7so399221cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005352; x=1691597352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTiYEcrVX04kfMcNb49jfpkl4E2yxYs1bGPg7/V1/HA=;
        b=mLTPgOWBxSD1SPV0oWxhxXSDCPtH7csxYjduUf1FBy0FfTGa4VxNA6UvwkixjZo6jw
         f6egEr8mzqDOnNAnLXTMhCGug1ADybHUXbZerPjiLPu+VOrJTlz77PDwc39tUXeQ7L8o
         EStpUmOxA3HYNQI003MetXllZgwWR9lBjkAbWzdnOmEB7H4EBOlM1bg/XkwKNJT+d7Af
         XjkUWByDGfSW9o/JeWgM9XSda+ezynO3Jjcn2OaY/Pl5VnPOvwD4QNExOPbru0Jd0XHI
         Bz1vHLxiLD1iQ5BsuUU1UZFOrgZZk9qZRUuwClabYnBsoPX91J5r0n1NJdOFwM4e2O+g
         clTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005352; x=1691597352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTiYEcrVX04kfMcNb49jfpkl4E2yxYs1bGPg7/V1/HA=;
        b=OKr706Zex7h8NDBJ1t8WPsjZ/WQqbGa8xqJqZiUkLrEP+ObNEZCK0zRLqLaS2RbMP5
         BRbdUWa1NXKSQWu04n0tYc2DUhXwjsdTTCqBiXSUPvFE3HIPpjJHqJ2mvZWSAD8w6hVU
         AY14T47VI8fwvYy4MBOmr40K0nal2jLTb1lr55PIjCysvXU7gOTO7FrYvFWrxwODlgkk
         cdMjk/y1xHdGoqU26+i3TmRmMk3qyhDsBlNKk3dXQ6vPRU/ZTZKW7WZQ90LUiABJO+R9
         GsLYZ/+f8r14+6TDQq5+RMrk3jTHAZ8fUHZ6+EJm0p9bvtMGJSkhHHAcPGPdWTeg/1z5
         0hfw==
X-Gm-Message-State: ABy/qLbX5C7gv/K5bwXchmzz3awHR/r/t8LKxQsJQzV4HFqveQGoQ87z
        /9iFvhku6fgq+rA/MRw0lRR/mwQpJDyq8w3zQZ0WPw==
X-Google-Smtp-Source: APBJJlHGZmfLfuEEqzR21NS5OF7E+xlM5zHBTw1/jIFXFYPfQfiXQkAbo1dOcHcob7SZnW2XzV2V2eNYPTiX4sgDfUo=
X-Received: by 2002:a05:622a:11ca:b0:403:affb:3c03 with SMTP id
 n10-20020a05622a11ca00b00403affb3c03mr186410qtk.10.1689005352318; Mon, 10 Jul
 2023 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-5-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-5-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:09:01 -0700
Message-ID: <CAP-5=fWggOQChrPj6UkSBCkpTcs5iu4SPU0JoVwpKFqm8xJDQA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 10, 2023 at 5:22=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Since commit bd2756811766 ("perf: Rewrite core context handling") the
> relationship between perf_event_context and PMUs has changed so that
> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
> silenced no longer exists.
>
> Remove the capability to avoid confusion that it actually influences
> any perf core behavior. This change should be a no-op.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..3f4d941fd6c5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -288,7 +288,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_EXTENDED_REGS             0x0008
>  #define PERF_PMU_CAP_EXCLUSIVE                 0x0010
>  #define PERF_PMU_CAP_ITRACE                    0x0020
> -#define PERF_PMU_CAP_HETEROGENEOUS_CPUS                0x0040
> +/* Unused                                      0x0040 */
>  #define PERF_PMU_CAP_NO_EXCLUDE                        0x0080
>  #define PERF_PMU_CAP_AUX_OUTPUT                        0x0100
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE          0x0200
> --
> 2.34.1
>
