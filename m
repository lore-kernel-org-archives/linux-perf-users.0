Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426A380FFA
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215828; cv=none; b=mTNINNW9cahqaB1pni0VXUQWKra+xjsNEnxbU80fbTMFg5CbOiPzAmAewVHEeB/StF5LfL95+kThCjEbuIC72UQhKwevHMfojCGBiJB3dF4Nm8Ci4NCxnP0oRrcm80e1L+SqmLdtqo4bW03ehZ9qdGWlzGTR6LxbqLyrada3Jc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215828; c=relaxed/simple;
	bh=p2wv8gV7odTWx9EKx0vRO3TQhr2YmkZKfUeuMGQj9/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2ZKLp/+AcCiAcpGCY2uPOyt5QGzcrV/+43XISpSjufMC7y1pxBLbnI2xsPkwXfw4FvzNtVql36fNcQJR4fyrGgXjAIiWhOTvCR+OhXcdnFrAwcFDQEi0xJi2WnWAn8L11z9EtyNPDyAl9FIOBih3bxhGTate9h+6/KQzh8Mxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV5KDy0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV5KDy0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB671F000E9;
	Thu, 11 Jun 2026 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781215822;
	bh=/H24MyBVD4e/rEkV7URB0UFiy7Zj160t9DhcL4aA+Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MV5KDy0qZLR+cZz2NrWH+p7StpbmlbKJMd8e/Pe1HZPhu3qaU/nBO9c4d/nRZk3G7
	 Ki1NlvAH/BnF5BNwmv+io4roq/a3eWR9QObAmQ7HLlz+4K1sAW5/YG182Y5fh46CA8
	 fKTyyn6W1x6Rf2q4yCzmexHvOn1zzhHLvMkTUiWnJ31fd+dEjCDRhVNpJQbT02fiGf
	 69Q0Jc+TuGzWgfoYOg9cLnv26VM1bGIVDneDrQkOUi3rZiYFUN4qGQzEEP1nBSCN+0
	 Mv6Qi7MwW0Kswk0O2Z+up/NJHDFcMMb6NqByc55tiD+fOvsE+IzlFMLvrZ2PHxiKE0
	 ZW9BKS1fHBdyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf stat: Fix false NMI watchdog warning in
 aggregation modes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611215632.562900-1-ctshao@google.com>
References: <20260611215632.562900-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 22:10:22 +0000
Message-Id: <20260611221022.7AB671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Directly accessing `counter->pmu` without lazy initialization su=
ppresses the NMI watchdog hint during `perf stat report`.
--

commit 8ecd592e1137cf0841158570884e6514049ebf6f
Author: Chun-Tse Shao <ctshao@google.com>

perf stat: Fix false NMI watchdog warning in aggregation modes

This commit fixes false NMI watchdog warnings in aggregation modes by
restricting the hint to core PMU events. It prevents the warning from
triggering on uncore PMU events by checking the event's PMU and its
core flag.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f442..b576776917353 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
[ ... ]
> @@ -823,9 +823,9 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>  		ok =3D false;
> =20
>  		if (counter->supported) {
> -			if (!evlist__has_hybrid_pmus(counter->evlist)) {
> +			if (!evlist__has_hybrid_pmus(counter->evlist) &&
> +			    counter->pmu && counter->pmu->is_core)

[Severity: Medium]
During a perf stat report on non-hybrid machines, will counter->pmu be null
here because it is lazily initialized when constructed from perf.data?

Since evlist__has_hybrid_pmus() immediately returns false on non-hybrid
machines without iterating over the events, counter->pmu would remain
uninitialized.

Does this code safely handle lazy initialization, or should it use
evsel__find_pmu(counter) to guarantee the PMU is resolved before checking
is_core?

>  				config->print_free_counters_hint =3D 1;
> -			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611215632.5629=
00-1-ctshao@google.com?part=3D1
