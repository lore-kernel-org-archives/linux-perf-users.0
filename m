Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCD263F5F
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918847; cv=pass; b=oj99hNI0M36Q+D9VzY1jZNtCC2RU9DPsAUxX2HauHiFNXXtVoUY8IKSjJGFGD24IFqEQK84lIAoq2xwWPE6kZrRb1uXSfxyGDxKhCBPZ8XBTp5ge0AnnjZr1j43dj+mv0mv4RZtBrdRwOovNIP7AuOPJQk+/8wtKkxU4q5VB+Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918847; c=relaxed/simple;
	bh=XTImjS1EwCLUHY3E11lGjKqs8FBOGAhXZFU7abt2tjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTsYbcVGKUwqq2Yb3l5Qt9cFe9L3OVp6zMoUiqNmSextbtppqkg0szPateYhQqfZmi2mzydhJjwBFJKMS9bBv1z9NekmRAKLAAlp2qWzX+1+ADVpwITfceNJ2iqwWKrFRSaUkyF20UjtZOXMKeywaTitfAcEZutt5xMBtmdG2uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCk95Waf; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCk95Waf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f02651fccso44215ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 13:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765918845; cv=none;
        d=google.com; s=arc-20240605;
        b=AMZWMJiERVvl/5V1gQCbWz3C8RRiDpbD5mAjetyOLeC3yKhLvLYmTtzneq2d1qSreV
         LDilNC7wfAITSv3PST6zBVsbsHrGT9n2p+QMcDx0qrmbuu8sVu9UVi5T5UeKhSx0GCMy
         lhBYpHs0Uy8vLuNULfb/l9uuKYfwERqI3ZC3riT56Dn0YNpNYzmAY4ZjpKm+L9ba5wUh
         zbU28D4YtQ8w0lnbGm5eiWkQQmUNZ5lQpySfBqpUrNwRON3CQm6DcaCrXVp7l0oEJNf0
         wQ9kMEZ4ZURwkG9rLZLK8nIm1OcVhxnrLjBPWTkZP8OMojwP9ot3ChMjoBBmyYz2IWK3
         uyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MPgDgTzJlPC+y/csl8zb48BISjPd8hzRdgiNPsiDEYc=;
        fh=4FfQzW22lcCzeledCbvVvKPL3e2MiD7S3GPbpdDvuh0=;
        b=LD9S5E4OZykcE1YFLjjGLz9vMUQM1yw6VUVhY3yayIfGPdBB4u7bIRFG9CDxnCT5M7
         JcPcaAubTPnzqyqf+QYj35nv+C0P51SpRIuLeGPH1ZCdN1ghjU+yksrRBoaNMKmkRroV
         YFhp/1fwaBM7WiU6G03ky1scryY3u909xJDH+E9W9mc3p39roSooVgXvdQsDRuln120y
         mrFZfeB1JuNT/s+wdDUns4CmIZBLvVId5a0wjsSM0313Cwoi9kzX0nFG+wFtjWNlQCvx
         ksfPZ6hSQKe4r2UxWv5GgnAg0jpsFJuuVPlPdgfB2z6/nJeq3zkUx56Ps/vYipjKCfds
         8EGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765918845; x=1766523645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPgDgTzJlPC+y/csl8zb48BISjPd8hzRdgiNPsiDEYc=;
        b=jCk95Wafq5X/4krbgWaDHwaFw2Swr8DIleN+AOLtxrrkqIn6Nj/BCaNfqk8vA2KhwG
         dWUnuznssQvX4C0y+VV4QUpqEF33rgvyqLgaXDIfC1hRctYV/SV89vPfn8DrwFfVOITE
         Muv5lOqEEPXtQB28Pu2gzidMLh+Ckb5r0DE/r8N6JzhdbezA+lfFP9OZkos9Ub08guFt
         nSn77/ZzrcaJb37pn1UHiq+oa5Ibh4OhT4wJpe+pVcLTmD5oMACXAVU7Fy40uU97g8yM
         GRJxahLkDiRiz5hN7gaJNMjBZ0mEjDD3lWSqzqDpel9waKJRDwLP8+md73goos4WsZYT
         /8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765918845; x=1766523645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPgDgTzJlPC+y/csl8zb48BISjPd8hzRdgiNPsiDEYc=;
        b=f0vHBtdO2vWB2+5oGX6Il6qTTtNds/CAaNYDMfvu7F6gxezQFSxs8DwJlbRFeZrdUQ
         XN/oKpaVtedT1wYvMn5WMZyPqc/8f1yD1kGjSmXgXN7NZmInIxsU4hpFKplj4TMe3lht
         LCfHoFvCYlN8AT4I0DbUDYUlkDHjt+aGaIuD9XJVFqyUMLFu5GpR9yN00NSKlUb1lNx9
         M5dRY/Vu52Em4YK3gbHQfqxYCvmICvyWzWKxUYBNug9uuMe8Cm2w0eK0EMg6o/4I5qms
         r9LfWrtOpcM9E/8maqdRawfyxFzFO8gQb8gxPbD+B17pAc1kFCLaLlKePKMVaoVtA/D3
         jsMA==
X-Forwarded-Encrypted: i=1; AJvYcCWhRKusjBpxGbi3T3o6kDGiSnmHhvhc/x0+qoiPwsMMEetgkLWrF2+LS4qSpEF8KHSXITf2m6UUR67l+vLCzeGD@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDLypTv/879veRtdLte37Y63LWUETn6OGa2QzptqDyCM93nnK
	7deimzsDnoNbuLGPRLwuFT+uSbott5+yHSKXEqMwd+If651xvFDp60FWewEujHsl8Zst4QTPfCz
	/tFueo8ltXCE/+9eRLSL6e1BMF9I9bc67XRAA2TOv
X-Gm-Gg: AY/fxX5c/p84EX3pMrrOlvwTcwKS2PPuyH2KNHnNDCiQuYwhGP6Je4yJVECn1sT1Z2r
	URWT7rpBk2aPn+ueZdhWY1LsYbZUWzskzfkWQ3HFAXkg1E7hEj3PI+hfm+FS2omHf30SDFb7gj0
	h7U1Ipb8jWS7O0xqHzo4OYzpgYltv6faWWE/Bbr1xdgNdIPo5fZh139lfo4Z2bBjBNUPhjuscGy
	KnqGp1Z85zuhgxwkLGf98226t2N/jzza7DhHzzq1IzmOtJ43pvBQnhQgY3Ob6KEeaymhSp9ImNr
	2q4gOKtig90+I0WV2O8DqXZsLg==
X-Google-Smtp-Source: AGHT+IFeEj1OTrXPDDAW4OHR+SODf9ucb+7BEaQ5zy/HBN2Rk5K6JqhJvXKHum/u4HTb+/5gQFpjNCBexVtov2LLHZk=
X-Received: by 2002:a17:902:cf0f:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-2a2060d67a4mr1545ad.5.1765918844260; Tue, 16 Dec 2025 13:00:44
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Dec 2025 13:00:32 -0800
X-Gm-Features: AQt7F2qUL9uG3NkQvcPif7vaaI5zxe2jzk3wSZhfi4NFBM5CaA7NejrbSWS7En8
Message-ID: <CAP-5=fXrLck7XACML16hzQO-pHGXA+qAM69kDDC6Za4O5S=SmA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] perf cs-etm/arm-spe: Remove hard coded config fields
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

On Fri, Dec 12, 2025 at 7:32=E2=80=AFAM James Clark <james.clark@linaro.org=
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
> Signed-off-by: James Clark <james.clark@linaro.org>

Outside of some nits, for the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
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
> James Clark (12):
>       perf parse-events: Refactor get_config_terms() to remove macros
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
>
>  tools/perf/arch/arm/util/cs-etm.c    | 193 +++++++++++++++------------
>  tools/perf/arch/arm64/util/arm-spe.c |  15 ++-
>  tools/perf/tests/pmu.c               |  91 +++++++++++++
>  tools/perf/util/evsel.c              |   6 +-
>  tools/perf/util/evsel.h              |   2 +
>  tools/perf/util/evsel_config.h       |   7 +-
>  tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------=
------
>  tools/perf/util/pmu.c                | 112 ++++++++++++++--
>  8 files changed, 460 insertions(+), 214 deletions(-)
> ---
> base-commit: 2eeb09fe1c5173b659929f92fee4461796ca8c14
> change-id: 20251112-james-perf-config-bits-bee7106f0f00
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
