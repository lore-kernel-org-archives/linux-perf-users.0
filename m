Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB32261B78
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337911; cv=pass; b=VuW0Zpmk5FwbUCtBRp2BwwPNImcp8G0R2qhz8VXTqwPZBdV4ZIgV42W4RUY+D3pBfAg/ucHyEU/vitzflXMIxuOO93AAtK51owYas5K+dY72Rx+TOE0D9lpS1eDQ7Sbn46omQB/odZnadsoqW/FJhgP4uj1pD9FmSpZoMJdve0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337911; c=relaxed/simple;
	bh=kuWZuW4wPGGvXuOvTnAr1IqvBref4y/8+bkQeN6joUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwkq+zQspvEWG/zKzpA0yDcul9g7eoeKsQboIiw6aCRkbqiQoqQR9pZzMnLQBrHFhYqAGb/el5sgy/SOEyeMvlucgGfMdEQ/baYcpKIbX///UjsGaxAbaq6NptY7DWqJKykPWMd3IU35FIh/UtDgrSGLM1XgVFfZBIjIyjnMhlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upv4EFRf; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upv4EFRf"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12331482a4dso366c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 12:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768337909; cv=none;
        d=google.com; s=arc-20240605;
        b=OII40H3uFOqN6KZkhv4NrLPXiuho+2c20snXBAkqZZhU9OoXJs3zGgAi603qBo3jfD
         6feolwaWYOHRFafLseGxfSa8dZDOhYZ5X6vcPbOKvKTUatck+lsxscXgm2YCV62m5Om6
         AKnFnnJ+DNesyEyHhGUBGrB+j2NSnoC2UvXi0VueODbduFvpOydsaK0YWZi8+Gq6K8g0
         fKGVMpzrdCfDcmn7SExxrdJOpmkvyI6PYXBqPobK3M54KpMMYM+LhiyIJyY3yX8FBrW5
         IaZvdjht3k/WOWW/gVLX7vgr11kp4VocirIdzAj/844vwSVw92LQjzOd8SZlp+gDbWQZ
         cvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZx7N+YvGY9qNRmZoiOWyKdXlqTlBXef0uI2sCfZ+I8=;
        fh=uEVTjcFkrWN3MFfeuRoPy/aBJ7FZ0NcZCEasWHTUsn8=;
        b=ZotH72glZXsg1Q9HHI2WzATSQRfHWZtuIpHvD7yxzE4FcT68s1v7UGcm+QI58OvDa+
         VV78r875+d2YD7Vm2Aw/SryPMkisaaBq7QkDMxnHox1sZ1Cg5nj2treXM7wMNLuujQne
         shjAA27cLQQLeBMmjLNjbywNLPg5cexLHtrYuuk5I9Psf1hoQIED1pgL5ZtCLLLbcliU
         1rufj+2WJH3uZ63yS/hmYymvDW6Mv0yo4LPLrEPEW5MAXslf2saQhn9/plsFDynRVQbs
         evt9o2jFcFgi3jb8O7QZmFsNa9z8W+2Rv+vMT1vaTCdtQOoLPUdEdRqb/JYnSg/stTmS
         xSKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768337909; x=1768942709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZx7N+YvGY9qNRmZoiOWyKdXlqTlBXef0uI2sCfZ+I8=;
        b=upv4EFRf675YiETpfeQP0qurCegoZrEgC0s7onUHrTkCj4mDB+0OxnR627Kh/y2mJD
         enSfNC0qJoyzGOJa4rnJ68swnJbb/E0DOz0jauwjRc/4hzFWnd1d67QDWykWLqZ7y04m
         Bzys6pQ4dlrTrj/JyyolQTWeromxx04Dw3QVJewyBX7sCPKLwHZ8TLTCt/kcef61uE0f
         95plIjEsnl1F+55WNrtWPpsDn4xTqZU/2KElh0g2UNPOU8laG6UwRidf9RZ+QqmlwoaT
         XmpJRtildE1oznDoAGXRNQA8ou4j9+WCU1k67dWiLAk32s5jeIXO/ibmNiW28cVV8rEH
         AhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768337909; x=1768942709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZx7N+YvGY9qNRmZoiOWyKdXlqTlBXef0uI2sCfZ+I8=;
        b=AvM7URy62ufpZSFaR79860Oi6Esg6a8rrwhonk2Ou7GVqyrKDxFKExYoBSOEn1ZlpJ
         JBYk5EetcpCkvNs1/q0FjcR8YxSO+5rtkwXY+XF4/reka7zYShpYrr4l99JSvuT4MQV7
         aFZUDJ/5KdimZAq3vpXc0tf9T7N43OSSgzMrfpWDQpGK1Swo16W2jWyXdBUgItUTHn8+
         bO8zPTrgwfipe5gWfo8qNP381P6cv3Lq8jV5oU8MZsqDVSY+TTPBD1cH6xrWL3QqAYUY
         FEtLbNQBuEytyNQIf0g5rN5ZCxZr6T76Hpzrvw4I236+RBunVM5qL6VAQbv1b9YgGFKa
         aejA==
X-Forwarded-Encrypted: i=1; AJvYcCU38QCSnqxJsdqwpJeHkseVZ3z4I1/74Xww/zoveOhBqVN1eC/PkAuAU8kbgR29RrE2ZOJaSuObH9uX8cU/CBv9@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2KVmeq/ZQ29T6j4YJaIsyXEnHNJebiMfCJ213JCBG8hwuh3Q
	siuYK421gI50bkdz9Wh5qud+BjhA3sksEDVB+03t4aSMngJ+LKBeLhwm9F09P61+75DA5iwK1dX
	Pwjb11fTJAQJrKOA362j0a36YSTpOetOhqwKtTF30
X-Gm-Gg: AY/fxX4vM9t35Syu7gWn9FbRwAC3Cc4XExYQg/NTL5jJRua7064MyL2//Yle9cJ1vK0
	7lE2mw8/aIDDWyc7pLDZg9BeDN2N0z9R8VRWRPqKRVbA8z0ykHdnqqWWcXid5m2ktSMoTxzdhZT
	ZgntuZ21FQIHzesq2I/6n2IhPYWrhCWHfOoky+MY+Xa14whrrulj9I7d2upV2Qq77xwyu/FrnUb
	WDk+xvwkygbtZL5RkxF5vT9uJbmIw/WtGAd4N8ksPlulvm8wCKvx2gtiwTGL2lC50o3b1mUN3vy
	eDFr7d+civ3qOrVYF3QooPnz6w==
X-Received: by 2002:a05:7023:d09:b0:119:e55a:808a with SMTP id
 a92af1059eb24-1233734a5admr36c88.7.1768337908333; Tue, 13 Jan 2026 12:58:28
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Jan 2026 12:58:16 -0800
X-Gm-Features: AZwV_QhwVy_DwsVlor3QOvBuG8edCAjDtJwMPf5T1IYYLOeF_2FNriw7fADm0LU
Message-ID: <CAP-5=fXbz-jgh6=WXn3V3UoM827t4UBPe9oK_mRh8K7Q6RRC3w@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] perf cs-etm/arm-spe: Remove hard coded config fields
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 7:14=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The specific config field that an event format attribute is in is
> consistently hard coded, even though the API is supposed to be that the
> driver publishes the config field name. To stop this pattern from being
> copy pasted and causing problems in the future, replace them all with
> calls to a new helper that returns the value that a user set.
>
> This reveals some issues in evsel__set_config_if_unset(). It doesn't
> work with sparse bitfields, which are an unused but documented feature.
> And it also only writes to the attr.config field. To fix it we need to
> start tracking user changes for all config fields and then use existing
> helper functions that support sparse bitfields. Some other refactoring
> was also required and a test was added.
>
> ---
> Changes in v4:
> - Constify some function args (Ian)
> - Move some evsel__* functions to evsel.c and make some pmu.c functions
>   public to support this (Ian)
> - Drop pmu arg where it can be fetched from evsel->pmu (Ian)
> - Link to v3: https://lore.kernel.org/r/20251212-james-perf-config-bits-v=
3-0-aa36a4846776@linaro.org
>
> Changes in v3:
> - Fix uninitialized variable warning on GCC
> - Fix leak of evlist in test
> - Confirm no type punning issues with ubsan (Ian)
> - Link to v2: https://lore.kernel.org/r/20251208-james-perf-config-bits-v=
2-0-4ac0281993b0@linaro.org
>
> Changes in v2:
> - Remove macros in get_config_chgs() and some other refactoring.
> - Support sparse bitfields in evsel__set_config_if_unset().
> - Always track user changes instead of only when
>   'pmu->perf_event_attr_init_default' is set.
> - Add a test.
> - Don't bail out in cs-etm.c if any format fields are missing (Leo).
> - Rename 'guess' to 'synth' (Mike).
> - Link to v1: https://lore.kernel.org/r/20251201-james-perf-config-bits-v=
1-0-22ecbbf8007c@linaro.org
>
> ---
> James Clark (14):
>       perf parse-events: Refactor get_config_terms() to remove macros
>       perf evsel: Refactor evsel__set_config_if_unset() arguments
>       perf evsel: Move evsel__* functions to evsel.c
>       perf evsel: Support sparse fields in evsel__set_config_if_unset()
>       perf parse-events: Track all user changed config bits
>       perf evsel: apply evsel__set_config_if_unset() to all config fields
>       perf evsel: Add a helper to get the value of a config field
>       perf parse-events: Always track user config changes
>       perf tests: Test evsel__set_config_if_unset() and config change tra=
cking
>       perf cs-etm: Make a helper to find the Coresight evsel
>       perf cs-etm: Don't use hard coded config bits when setting up ETMCR
>       perf cs-etm: Don't use hard coded config bits when setting up TRCCO=
NFIGR
>       perf cs-etm: Don't hard code config attribute when configuring the =
event
>       perf arm-spe: Don't hard code config attribute

Reviewed-by: Ian Rogers <irogers@google.com>

Most patches already have my tag, sending this for the remainder.

Thanks,
Ian

>  tools/perf/arch/arm/util/cs-etm.c    | 201 +++++++++++++++-------------
>  tools/perf/arch/arm64/util/arm-spe.c |  17 +--
>  tools/perf/arch/x86/util/intel-pt.c  |   3 +-
>  tools/perf/tests/pmu.c               |  91 +++++++++++++
>  tools/perf/util/evsel.c              | 112 +++++++++++++++-
>  tools/perf/util/evsel.h              |   6 +-
>  tools/perf/util/evsel_config.h       |   7 +-
>  tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------=
------
>  tools/perf/util/pmu.c                |  95 ++++----------
>  tools/perf/util/pmu.h                |  34 ++++-
>  10 files changed, 529 insertions(+), 285 deletions(-)
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20251112-james-perf-config-bits-bee7106f0f00
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
