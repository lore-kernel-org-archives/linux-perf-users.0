Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599962;
	b=Vc1+OaSW9Y5FscxftgoZra5qeV1XkGEs+2oDpjokLVybJy/ASJSSHD753ngLrHP0HVbr
	 OfSBnErPGZkfgf5xJ3AJE8GAL3JRKQaQbwe4/rFH/NzFSEPeEj0fSsWNhoreP4CYoq4rZ
	 x9yQHQz/RC3Dkhzs2JknFUi2CVBoPm1ew5hckyyT6nwaItjXAMuJ9eD1Hb3J4fP2z//5g
	 mkAeFtgf7NZDfQj/bkox2fv/STFTi0uXa9qiI960Nudcx9OPsApQmudqguecwd4wVPt6C
	 skW6HUQB18If89DjTeo1CW+Hy71X7UY8VA6iFSTsM6mq+OjlUa9zx19inZ347sANVyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mG70MyN6gX/+qqSgfdzNQSnAPJydO6tol8ZSQWkc35c=;
	b=HcfTYG6BRlkZg0+PsI6IqbmzmhUf6kyInPaGPEU5qlTuyvyIad5oP0UH0ZfM5HeLiuXm
	 P6nbwgPXZ1ZveOq4zBHUXUW63zQi2CSAbVaB+1pr0QUQ2VO4kU0D0loiziH38LW+hL8NW
	 2xRHJFtWHgPT6JTI85f3AhSP9huxTZOeeLGDTNYTDzzVJEyFzTJ5r8pN67zPdVPZ2SrKY
	 sO0MNaGkHjgy1A47hw7AVg8Lrn9VrSOYwT2lWk7Wdc83DUqOOcl2Xh/fd6W63ZRx5vLjr
	 Fy1n7lrEu4Dclpa/IZDk8h8KH2KsenKbWt7B6QF5gg2YH7vGx/iKDUDA0dr+KFwi5VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSb7I7MF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39C606B574
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSb7I7MF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2AB1F000C4;
	Fri, 13 Nov 2026 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599961;
	bh=mG70MyN6gX/+qqSgfdzNQSnAPJydO6tol8ZSQWkc35c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iSb7I7MFg+lQNyUzNl72gupvf7SZtlGtMuIXw/eh5HNQ3Pp5zZQAML2sGZ1Kgglv8
	 VCJXws5eUb6a1bf2DrFiBJxCF/qG19HlANgSp0mQC8tRZLA0z5/7crM6txG6w8N8Az
	 YyJ8Vjy9/0Yn1DV5HeFgLV4Eit1vWNi/Ii+v0FSRAgEpERHg0kWk2FyCUlLcWaIckS
	 4rM+TWMPADWcMhehSJW5SG6+w466QUDGNOTB8x/MjItMKo3s+adt5yP0/EdXvh3HWq
	 x2o4hXT+bm8k2+l4GK3+U5gS7TzSmHp8QLNXlUXwLh6BnR4HKuFM1XZ9r+koNh5o1p
	 8okKnuerI8bJg==
Message-ID: <sashiko-outbox-213594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/30] perf metricgroup: Don't prefer tool events for
 displaying a metric
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-5-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:59:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> pick_display_evsel() selects the event of a metric that perf stat shows
> the metric alongside, preferring an event that isn't a tool event, such
> as duration_time, and that is used by the fewest metrics. A tool event
> used by fewer metrics replaced a non-tool event, so whether the metric
> was displayed with a tool event depended on the order of the metric's
> events. For example, CPUs_utilized could be shown alongside the
> duration_time tool event rather than cpu-clock, and cpu-clock not shown.
>=20
> Only compare the number of uses of events that are both, or both not,
> tool events.
>=20
> Fixes: c8035a496141 ("perf metricgroup: Add care to picking the evsel for=
 displaying a metric")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D4

