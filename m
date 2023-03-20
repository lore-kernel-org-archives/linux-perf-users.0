Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB23C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCTRtM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCTRsK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 13:48:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35BC2B9C7
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 10:43:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3e0965f70ecso200241cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679334202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXrg78CHAvQFWwunzy/sBvC4hXOal5MucBHYBTkMOtc=;
        b=qTfxowaDb3Vm9DmyrA4AMcYS/AdR88YTOLnauq1gQaQ8bGxoTGs8UmJzZvmF5Dw4qD
         0e5lnWIJgKnObCdyDs+EcyS7BFisAufEcav937GhS4fRpEs93HsWkGQ0ihMr6I9pjLeK
         L0y8/g4WXVv4/mJqMfQt7uL9oAc/+0DO9QjrhUxaryDjTDs02F0KqVxdb7obVk3tH240
         TMOH3iJsVRqtblucDXHSi76S86JpV6TITUF3AilU+zkG4PnLa5H7lYdLNU7TzWoH9bHA
         y0Iq7tC45FG2kvWrSS0lRbHfyPzupsDeNLebqfBv1900YLiOEpFo9QBmrUaTNsReYgOu
         qRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXrg78CHAvQFWwunzy/sBvC4hXOal5MucBHYBTkMOtc=;
        b=e9viBXejurAzbzgN2CeCWpowqakya0+m5KMbTJZ2E1wbp8LWhRqGJW6dj5sDekQk1j
         qaXW0GnmGBqQxANms02RTCcMowbcVhralJ4ubO0e1/xz4eo9UrAF/0sKtSLSkw6HNXmo
         QWFServ79N97+PKIYYDb6U4a5HOGjH5HUvG3aDNGaZmYaV1RX39JFmrEuAv6ct99Fmqe
         SfvAi49/Iqwi4jKc7jf5Kq3CuWWazEx74aWgVxDccb1kssYftuaPWJMW09uDJ9IH4V9+
         20hM6DeyYJ/LiIS/UjMSOQrlTkY0BYav07DWIFoUJrX5KcuQ1NPn73ccQLjWaO3OFIuL
         HOFA==
X-Gm-Message-State: AO0yUKWg1mNWVbVoW5QbqOj7V/RoIKlnvdXHOJGS8s4jwvfkcbW9/MZr
        3ayio9IfC7jJpNXwLEiaRE1tH2vcDVybtqfEAxxPOw==
X-Google-Smtp-Source: AK7set+g9keyd2/SkBVR8eY7a5R47s7uLczWHF3qlTvG0Qff8UXx4WaOh79fxawmEQKK1rywqF/k9ElVn4EWDYwdcxo=
X-Received: by 2002:a05:622a:189b:b0:3bd:f99:502e with SMTP id
 v27-20020a05622a189b00b003bd0f99502emr675564qtc.5.1679334202196; Mon, 20 Mar
 2023 10:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230320061619.29520-1-leo.yan@linaro.org>
In-Reply-To: <20230320061619.29520-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 10:43:11 -0700
Message-ID: <CAP-5=fVBZfTrtp6OUzop3HxL-Aw80FDC+7MPS6UEwDhhfkgk_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf kvm: Fix memory leak
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Mar 19, 2023 at 11:16=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote=
:
>
> This patch seris is to address memory leak issues in perf kvm.
>
> The first patch introduces refcnt in structure kvm_info, so we can avoid
> memory leak for it.
>
> The second patch explicitly delete histograms entries before program
> exiting rather than relying on kernel releasing memory space.
>

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Leo Yan (2):
>   perf kvm: Support refcnt in structure kvm_info
>   perf kvm: Delete histograms entries before exiting
>
>  tools/perf/builtin-kvm.c   |  6 ++++--
>  tools/perf/util/hist.c     |  5 +++++
>  tools/perf/util/kvm-stat.h | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> --
> 2.39.2
>
