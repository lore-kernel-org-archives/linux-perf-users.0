Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555EC48CE0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 May 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561601; cv=none; b=eWkvLoPL9BXpTGMxwXsZbYKA5vK4CZgyiy6f/Zqg/SkhuAbyfcKXnJMbGDOTDbW6D4ux1lx5Y3E6tHgHV9ioXJKXJQ3G8FmE74EYAQ9oLlrGzPuR0BPJaOzbgt3nNJ7iK9N3jvlHuUuF5gwkEHSfPFQEAcB4/KrWZi1lyRthyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561601; c=relaxed/simple;
	bh=8Ern/w3N5sL4wLf8mWZQzBfabAjbgCGzxG/d/rNuRT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzEnRItFzV7yhssIzQQhJVcecKabDDOYO0lPerVzaDf8EzV8+wrtE1pNlAulHBnenN74JkIIVkK+JjtxnnMyQGsCLRjipyH6yKdNK2BnCNwjXlCRAYzxoW1f58CEWmIfhEhI9pbUFVV9n+9nJZ3o0TYzky38c+URhrXtTeoGfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMpNrJC4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMpNrJC4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso5653227b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714561599; x=1715166399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UVIfCEDLcryVh1sxegO1WMzH32gqhTaOJpqJeO8zPZI=;
        b=eMpNrJC4M4qGrIQJtM34Z32GvUCmKNcl3/h9L2WhKEOAH9g0XkiMSvomfWrnBxz0dA
         bXvE45U6qg80AGk9EmKI4YQ5nEuXgGnF4qvsw74ndNoXYODpaha/UZCjyGR/AODE09Uu
         gJHAmJ2c38/HtMvKcb3msy1AdnprvOaEKzkxmz360lVx0PM5p35LHY4Xf8TwxnGPeoN0
         Vlyh2sn8Qlev7bABki4sDXak+DYKYxHVs7VjuKGx3MAbVgW8+r4XihUimkZOeJMxTrUu
         MrlmZnDrZyLwtAjT9U1EqHmvrPeGHChpToYJ3vlBVqZkbmcZzx5Wsb8HoYA+HVNh//Mg
         bjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561599; x=1715166399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVIfCEDLcryVh1sxegO1WMzH32gqhTaOJpqJeO8zPZI=;
        b=kQsTKfiu/FPAZSf0UYuJo4CgTuugXX2li/cPmZ72KLZ5TV5LQkylO8OeLN1iN442sr
         OP59RK8TazDiptvEyHMbYDGbQr3GdUWyXkBaST9ub5d1zXLSepWjzhrXArWExonTtv/D
         HwOTVSw3QJg+KUzP0pSj7uwtNRsyxMSge+olqRR0Wopo7suaEkx2ny8Vn21bwuQYf7Qf
         d/qf5R+t+fr+92cFWE9J61JZKbL7QjdPRGvOL3zKHRUZ2F+TEsP8rHrJn1myyn7PqAzU
         qK5sxvh4vfs5EdRzhxFzEtcddGiNxlmI1X1Cwp8m+u40/ff1resnivBwUXltjRvp6JML
         2wcA==
X-Gm-Message-State: AOJu0YzpcLdqwz8Q81RWGwzduucv0JaJndcsfVNupuomqzR52pzbwkPg
	fKx8a/4Gmg68oNTB0+wAZfyFc0QX0M25GMayJLSadAppxFMIJqCYAMhFkCkMO4l2WFlu4uYgiWw
	hEOnbz8erDrzvvEACvmt50kMwJJPb8JFSAkXHDA==
X-Google-Smtp-Source: AGHT+IEIeZDG2abjSl7JiRn4xQhRhE22MbWI7q0YUcF0ys8JS5PMok3Dg8kUX1MoLmYeliXkgq+kWLLlOGEYtodZ7Ag=
X-Received: by 2002:a05:6a20:5a89:b0:1a7:9e85:c28f with SMTP id
 kh9-20020a056a205a8900b001a79e85c28fmr1964085pzb.48.1714561599628; Wed, 01
 May 2024 04:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-9-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-9-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 12:06:28 +0100
Message-ID: <CAJ9a7VgAg==xysGSjR9Cd5oO1+=HQF0xxcpamgntb_PV6aw6JQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] coresight: Remove unused stubs
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com, 
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org, 
	suzuki.poulose@arm.com, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 16:24, James Clark <james.clark@arm.com> wrote:
>
> This file is never included anywhere if CONFIG_CORESIGHT is not set so
> they are unused and aren't currently compile tested with any config so
> remove them.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../hwtracing/coresight/coresight-etm-perf.h   | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index bebbadee2ceb..744531158d6b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -62,7 +62,6 @@ struct etm_event_data {
>         struct list_head * __percpu *path;
>  };
>
> -#if IS_ENABLED(CONFIG_CORESIGHT)
>  int etm_perf_symlink(struct coresight_device *csdev, bool link);
>  int etm_perf_add_symlink_sink(struct coresight_device *csdev);
>  void etm_perf_del_symlink_sink(struct coresight_device *csdev);
> @@ -77,23 +76,6 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  int etm_perf_add_symlink_cscfg(struct device *dev,
>                                struct cscfg_config_desc *config_desc);
>  void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc);
> -#else
> -static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
> -{ return -EINVAL; }
> -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> -{ return -EINVAL; }
> -void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
> -static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> -{
> -       return NULL;
> -}
> -int etm_perf_add_symlink_cscfg(struct device *dev,
> -                              struct cscfg_config_desc *config_desc)
> -{ return -EINVAL; }
> -void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc) {}
> -
> -#endif /* CONFIG_CORESIGHT */
> -
>  int __init etm_perf_init(void);
>  void etm_perf_exit(void);
>
> --
> 2.34.1
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
