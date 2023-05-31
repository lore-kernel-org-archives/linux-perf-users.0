Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E7C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 01:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjEaBTx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjEaBTw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 21:19:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E54DC7
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 18:19:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b025aaeddbso48375ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 18:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685495990; x=1688087990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAglrf8PCd1V6N2W8Uz36FXrK3c4ZLEoDhLUPZcuTSY=;
        b=rD1tRmQ1Fck5LJpxqUAqcYBVbzyaUltLUrkhuX+3a11rRgFrGU6Q0UQJWw0q+4N5ZS
         tlgb8H2pcD6SRCs9zfE4oAu4oA31A+1iqJgmN4Ex8Vuz8DMhl0p2EFxpCw7H5XzGccKb
         aoL3I0eZHZ2W2DmAkp+bvsQ6c/wynAInNPFhwLWr8vNGW+b4apDjK9DhQCz5YSZQT4kd
         RkyZZdS7HfnBKxRI994pW1J5M8NV/3cBg2LlWi68bubpFBzkCP4rsSqt6X1uW79Maah8
         AlWaJUSiQEQG1AGyKiWyEYwa4LmsuJJXr18zxR0mY1MKg8LKgYQoOy/ocZuQuTSKL1qc
         s8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685495990; x=1688087990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAglrf8PCd1V6N2W8Uz36FXrK3c4ZLEoDhLUPZcuTSY=;
        b=WD4MH8grZ+JsEuBq9GVv/UlZab6oAiadlEetQ5Ogvsv9Uuf4m/ufWe31igPec5UDxC
         zdQHvs4uMS1jnqEI9LdK+shMeRyQbEqXUiz0jDBMpinGB0gWwpc05vAvAOPGW5QAHp5Z
         sNPCrB5IDAI8zCfofal0qxym5nauR34G0RFrTST4bXQ244oImnnXfw3bUntPSQy4OLik
         v46KYl5PTwz7ErMetwqF9M2rf2CxWUDnHv+AX7vM82o3mMrVnlrccdS2pOcqpfd71VfZ
         v0o9I8+Odi8ToYx4GeuyyBxwW7xUsKxAOWxpV29QoHYgHNOwol1lwKhZDvJDoy74VgB0
         Z1YA==
X-Gm-Message-State: AC+VfDx8TVFQftt+lpzdDVV6tyqSfBmQZvwgEkAidN0s1E2H0wI5MVot
        5x08tyK0T8GJq97tYAdCrk7XMQuF5fBvzU2BP1HkzQ==
X-Google-Smtp-Source: ACHHUZ7FuWl4H6Symmfi8dFQJKTmmnG59YHutkIhpHo/Nh7GAwlGpglbKMOYoXADLXEYkUP/NLRZqJ2znsogsOrQoGQ=
X-Received: by 2002:a17:903:74f:b0:1b0:cea:2952 with SMTP id
 kl15-20020a170903074f00b001b00cea2952mr21011plb.25.1685495990418; Tue, 30 May
 2023 18:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com> <1685438374-33287-8-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1685438374-33287-8-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 May 2023 18:19:39 -0700
Message-ID: <CAP-5=fWadoqvUfEYKNEvfQ-5q4cdm8j0fXh7TJgPnA9u3Rz+-g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] docs: perf: Update metric usage for Alibaba's
 T-Head PMU driver
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 30, 2023 at 2:19=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Alibaba's T-Head ali_drw PMU supports DDR bandwidth metrics. Update
> its usage in the documentation.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  Documentation/admin-guide/perf/alibaba_pmu.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/admin-guide/perf/alibaba_pmu.rst b/Documentati=
on/admin-guide/perf/alibaba_pmu.rst
> index 11de998..7d84002 100644
> --- a/Documentation/admin-guide/perf/alibaba_pmu.rst
> +++ b/Documentation/admin-guide/perf/alibaba_pmu.rst
> @@ -88,6 +88,11 @@ data bandwidth::
>      -e ali_drw_27080/hif_rmw/ \
>      -e ali_drw_27080/cycle/ -- sleep 10
>
> +Example usage of counting all memory read/write bandwidth by metric::
> +
> +  perf stat -M ddr_read_bandwidth.all -- sleep 10
> +  perf stat -M ddr_write_bandwidth.all -- sleep 10
> +
>  The average DRAM bandwidth can be calculated as follows:
>
>  - Read Bandwidth =3D  perf_hif_rd * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
> --
> 1.8.3.1
>
