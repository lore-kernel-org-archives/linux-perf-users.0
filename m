Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8E1E505
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335716; cv=none; b=lSyJ0PztczORaF9EoKUUIU8++Tiyb6CDhIor74lmT3QRtAMYb1Dmob2VHsbWWU8cCevguknuqId02XM09JQunWnDdWgNA7otZSMLdlbE5fhf90+k9HyJzVfUItreadHWLOrl/qkVRqMSfa7EGQ56Bk4/XE66CmbViKrL8oJkmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335716; c=relaxed/simple;
	bh=67dW5c+wbUNS7IBkT0g2DrzqD7ms9A6UkcvP74t1RVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nX8fEL3hyJGx7uqoZog5qAb2Q3Zw6ruWPrv9Dfo9TzDS/YuDvbi1lhmWNWYFVKmNteYvLBasDIfGaHsmf28nqhMnEyp9UKfLpKKp2G7DFhf0yfeyK4LP1Cpau0RJUFqZwJEfFPhJixt+xNPzM6Aee7//bLyBmyjBhtsYyKcqNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvXWOgMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvXWOgMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52501F000E9;
	Sat, 13 Jun 2026 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781335715;
	bh=5oz862LWKp/87DtEcMZwA6lNfd6TCAePXgWC+Vqsgp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvXWOgMRrRBTkG0HuGJqkrDnvv7GKZDMwaT65EhjSFbKUitwCfAkIYyugxK8jcHK0
	 ABWpHwI9fAGPf6gMD1yXhTN9XrBzdvoUx66UO85IM0Vl/EGvf3gElVVvbQ/3DN1iig
	 wJinCRQU2nPIWZGIQX1WgRa2PTWDs+GjHy+QYIQ3U1f8CnMlTTHv8jd8b/IvaZQ+4S
	 9SIDHTHfYTaCL/j38OZlZ8hIIY207+Ba5fT+zCCr7GXZCP03WgBzjfmdplcSwJGyDU
	 67vBLByGo1UvXCAB4sm8+qMC3I+mf+0a8h7CM2osQ49aPMQT1ms9Va9diCwSS8GCF7
	 HRKJXvsMr+EFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/20] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-12-irogers@google.com>
References: <20260613071100.1508192-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:28:34 +0000
Message-Id: <20260613072834.D52501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added lazy symbol resolution (`pyrf_sample_event__reso=
lve_al`) hardcodes the host machine, breaking address resolution for guest =
samples.
--

commit 19122c790bb2e4a31750b5a3f83fc3793b7214b5
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit refactors the Python perf module to add a common evsel field for
events and limits sample-specific fields to sample events. It also introduc=
es
lazily evaluated accessors for sample events (like symbol, dso, srccode)
and ensures memory allocation is sized appropriately for the copied events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 6c0725972cbc1..e64b83a10067b 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -394,6 +449,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyO=
bject *attr_name)
>  }
>  #endif /* HAVE_LIBTRACEEVENT */
> =20
> +static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
> +{
> +	struct evsel *evsel =3D pevent->sample.evsel;
> +	struct evlist *evlist =3D evsel ? evsel->evlist : NULL;
> +	struct perf_session *session =3D evlist ? evlist__session(evlist) : NUL=
L;
> +
> +	if (pevent->al_resolved)
> +		return 0;
> +
> +	if (!session)
> +		return -1;
> +
> +	addr_location__init(&pevent->al);
> +	if (machine__resolve(&session->machines.host, &pevent->al, &pevent->sam=
ple) < 0) {

[Severity: Medium]
Does hardcoding the host machine here break address resolution for guest
samples?

If the perf.data file contains guest samples, it appears this will resolve
the sample against the host kernel's symbol tables instead of the guest's.
Should this code dynamically look up the appropriate machine based on the
sample, rather than assuming session->machines.host?

> +		addr_location__exit(&pevent->al);
> +		return -1;
> +	}
> +
> +	pevent->al_resolved =3D true;
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D11
