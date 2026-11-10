Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279193;
	b=lhV553eGolIHteyONQxIs4WJt6HttRjHmb4uC0y8XEjcuF31ayPEc1vh8xrvSV++nMJr
	 ErK08KHPqE4vIXeXzGvPJr0P4pYmnWVsYpxONy2JRanWWiC2Zs+zC7ccJEmgsF+vQ6J7k
	 BLc/5EqUHArabfQyURXPPAEjPTjcC2EJb8nlyBzOAyET5gfDLe9xjt4Yb7YFfDZ4w97Mf
	 TAv4ZZra9mvWs/uoeFbmRPqhX0gQn828B92OAMyFUHB30wLmBzY9vO9UVh+QvGtXgzykh
	 yh2wmMvuK0EX6sv5dLfd24vEeIL2c2J18dmN0RN7cMzEdgvJZImrugQCC6DyxwVrTJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279193;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=pFkAgbUwMOH3n//6diqGv//+eQhSdg06FjdV9LR67w4=;
	b=NcG00Gd6StpaAvHJJAVBos03o0YSv+xWchJNQkKdR7lR/ot2hikcH4MI8pGfhqA0mfaq
	 xcbS3CdcnFu5o6OfQ7HgRHFYP8HGe2c94e7UJRHwpAbBfBuuSP0TiYAck5/bcA02TtiYY
	 IRXAt3q2BV1AqTv6+yBWq/BKVfQ7SrQfv3C1jAjjcp1E1W9UQSA+NlaPT6j9v3g5NIfb2
	 iHazB35TPqFNsw+6t9h1x6/+yBuqzqcnQJ/20M5gTS71FdzNqTpsA0bVw5cBKQgDzl1V5
	 coZ6MSjRka8zF/BqWyYRkcPq495N02RL2WgQsml5MFAYa1tInEWycQdRu5NLsLHhBmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZUVC/uy9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F960A3808
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUVC/uy9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F5F1F008A4;
	Tue, 10 Nov 2026 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279192;
	bh=pFkAgbUwMOH3n//6diqGv//+eQhSdg06FjdV9LR67w4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZUVC/uy93/k3d07pL7n8jsBNwDPJJDDSEjId9AhF3tvA78bygfou3UN4RKZQFGN93
	 Ak9GZ8nJn/i8KjBn/E2s+TbqvexMxVZEb3qlWTZpxUG6MQ9/kpG8otORW53K01WjVr
	 fkROdj/7RJk2lT04/ODz0OkQvKGD8Wb4iYHCnclhSfqErYTUBJbrluMiSeAn42uFgN
	 L0n1hgbbs1SkgT1fxkvkfEclRr2KPTacKb6q50bIOA7H2/LImYiNtqOyCREmgWstsP
	 fZpBvQsxoBDlqu78hR+6+KoD6JYrhY8gs/GOxKFfM2eX2A77vSZ0vBHeydsssIpowg
	 VzuNh86QVimfw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@redhat.com, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/3] perf: do not call zfree() on uninitialized
 pointer
Message-Id: <179427919177.13760.15866804714797157945.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:53:11 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3

On Thu, 05 Nov 2026 09:33:50 +0100, Jiri Slaby (SUSE) wrote:

> In add_drm_pmu(), the check for type > PERF_PMU_TYPE_DRM_END happens
> before "drm" is allocated by zalloc(). The error path nevertheless
> called zfree(&drm), i.e. free() on an uninitialized pointer, which
> can crash. Remove this bogus zfree() -- nothing has been allocated
> yet at this point, so there is nothing to free.
> 
> Fixes this compiler warning:
> In function ‘__zfree’,
>     inlined from ‘add_drm_pmu’ at util/drm_pmu.c:110:3,
>     inlined from ‘read_drm_pmus_cb’ at util/drm_pmu.c:174:10:
> ../lib/zalloc.c:13:9: warning: ‘drm’ may be used uninitialized [-Wmaybe-uninitialized]
>    13 |         free(*ptr);
>       |         ^
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

