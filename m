Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753335;
	b=CpMn/dqX2myAKero8debv4mSEz5Cw8Zl2GrYcVcRqyl4R/rqBgrUscqV4EUDssIQdfI+
	 b8pRk+Y0gRnLxFDaUxBpNbFGtuQuhfQ9cAerLGe6kbxGHcRbH/ALfD2t6bnqQEZTZ4PyB
	 2o22uvYYw1YNxT3s+KKmmYjjKtZa2BOtDDDmoEVg1apKJLfPEsLai3D1Q9kbYS4wNKRE+
	 UXk+V+jPhIX0358uBQkd4+j1GkDIGY7+XeoOcvlt8BP2T/uY1J2yPWTJBP72cD0lW/JQQ
	 g7NEEyYIx09n40BR2MutxNF5vrYT4Ep75WZhe7ug4kfEoC9d0fhwI+dE3O9mHpMljOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OzZC0b0BnG5CuHthXP0LxnoaJ1p2d1N58wH3Pu1gmLE=;
	b=RI8eWw4GeH79yhxHbR33XxXRAxV35kiH4OZtJNUkIBQaC27vH8DHmX17Aq36yYFuJXkV
	 Sf+kMvrR9KFNgiQsJ5LHyRui7jl3n/MzkMGtRH9qS4SoFjbjbWDBE6RE49dnTaziC8xqy
	 E16p1Ezcz/cFUBzspaKBgQr063RrdUHX402E4S5RP20l/5o/F0dann9HvvxH1u/q+1SKX
	 2VrHjVK9tGKKqidtqeum/Im37jYSs4fEmJsiTpGC3cuwkrbtLd4t2JudP+8hGVWggJhQ0
	 MQNV7Up6FcATAwHeCqrYmyeAfS5WH1ZErRN9Vcv7S9G0yUtd9nIeqB1vWi8zBy87iag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTW+vuA8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0524606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTW+vuA8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F221F000C1;
	Wed,  4 Nov 2026 00:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793753334;
	bh=OzZC0b0BnG5CuHthXP0LxnoaJ1p2d1N58wH3Pu1gmLE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LTW+vuA8XpIIFPQ/zH6xAMMeMuWLGLdCxyeAnA2sx9rA2nBil3fpTFFAZFMPRY4us
	 hQIK8CXHpnONbMBoKnZD4za0mLNM37GSB4/wEwsyGU8JdleUORlBGIOghFXIH6SET3
	 T08iqutKYdh3JrcyQn/5ht64ZyoBYMQeUifaS8NNySIlvKpNsW+juNhgdtU0isI4Am
	 /Jv64ZLXaBrEDatym28S4pR/Src76kBCtF3+DtxFAlFxItpLDibWv8VaqcLsjSB0Sk
	 /LfE09/KFHRVEnvWRHY4mA4/YyGNrNPlpfYlk1ax+osrp1O7Kckvo0knpaGEvgK9Ob
	 uy+Nh9DUtoQ+A==
Message-ID: <sashiko-outbox-196322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/41] perf pmus: Introduce struct perf_pmus and
 perf_env__pmus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-5-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:48:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move the static global core_pmus, other_pmus, read_pmu_types,
> num_core_pmus, and extended_type state from pmus.c into a new
> struct perf_pmus embedded in struct perf_env and accessed via
> perf_env__pmus().
>=20
> Rename perf_pmus__destroy() to perf_pmus__exit() to match the
> perf_env__init()/perf_env__exit() naming convention, and update it
> along with perf_pmus__find_by_attr(), perf_pmus__scan_for_event(),
> perf_pmus__scan_matching_wildcard(), perf_pmus__scan_for_uncore_id(),
> perf_pmus__pmu_for_pmu_filter(), perf_pmus__print_pmu_events(),
> perf_pmus__print_raw_pmu_events(), perf_pmus__have_event(),
> perf_pmus__num_core_pmus(), perf_pmus__supports_extended_type(),
> perf_pmus__add_test_pmu(), and perf_pmus__add_test_hwmon_pmu() to take
> struct perf_pmus *.
>=20
> To keep this commit reviewable, the high-fanout perf_pmus__find(),
> perf_pmus__find_by_type(), perf_pmus__find_core_pmu(),
> perf_pmus__scan(), and perf_pmus__scan_core() helpers are updated to
> take struct perf_pmus * in the next two commits.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D4

