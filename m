Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69B3D1CCA
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212686; cv=none; b=kavQchnlxuuX68JGKoKaGRQqvnnwGR8t3ag513Q9W67M5TwFR0YREtAX5WCG2hyZ3N4/Pec+ImOxjOxu75Z1qAMJ1eCMA8QxrqIBqJRo3QUZ2Hm+7ZGUxv9R/PTaWVoQ7lEowDXBxwFZM0m6lRlYvsvCfj5s8rqgyEUbjihgn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212686; c=relaxed/simple;
	bh=INvYlGHCJVOfiHyzlAYsv+XGOctY9h1EbktIXnge0LU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJ67+vrCcsS16Qkv8rsGrtlsOJTrWyr8yW4ka8X5QdbcD1YxT97QpRVXAZUav9lnScMEZJwJLvbfiEcZLomGUnQjC3bOF0nVzU7xZyBUVsz3QnOcqhrwQ6ca2e/8PR9xMblabCeRRxbzsFd0O0Dyh50lP2DRA8YhZUbH/zRDIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHeO+o9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHeO+o9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71BF1F00A3A;
	Tue, 23 Jun 2026 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782212684;
	bh=xbXWznfLePLTSKZdx3rY3ewYIE13NsbpaWqkWVU0szU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHeO+o9ieIA57VV65d8ZABryWHUsUJ13igvLijUVgLBXIu1eoIpbBLwm6APErSOIk
	 mOpLkvB0rXUC7e65xojeD68fd9x9ARDDxz8ZcNQaZRGaZo5UlNnUcY7Yhg2L7tMCXh
	 hdhr0uZ/9XFu3QA3oA2YyN1Hlh44l489sWq2vaKeEiG1uKya4OFRwOiiPD27RiPogh
	 jKD0sQsAk7zP4GhXoMcK07WKx0h8S+U9s9kvi2slJYEn/ZZIN6P4Y5GidFmItxSvej
	 xUEDJIde5+3fXp8RdJTiAYZISwD8FNs6eJIZzM3lK4/At6uxpgPeDtbcqOm/alnFpY
	 vRgs7ISEpUr5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: Add group validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com>
References: <0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 11:04:44 +0000
Message-Id: <20260623110444.C71BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Group validation incorrectly counts disabled or errored siblings.
--

commit a3401bf46a6300cee39613401a4f3512876a47f1
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86/amd/uncore: Add group validation

This patch introduces group validation in the pmu->event_init() path for
the AMD uncore driver. It counts the hardware events targeting the PMU
in an event group and ensures they do not exceed the available hardware
counters, preventing failures later in pmu->add().

> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 9293ce50574da..15330cbab6a69 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
[ ... ]
> +static bool amd_uncore_group_valid(struct perf_event *event)
> +{
> +	struct amd_uncore_pmu *pmu =3D event_to_amd_uncore_pmu(event);
> +	struct perf_event *leader =3D event->group_leader;
> +	struct perf_event *sibling;
> +	int counters =3D 0;
> +
> +	/* Ignore software events as they do not occupy hardware counters */
> +	if (leader->pmu =3D=3D event->pmu && !is_software_event(leader))
> +		counters++;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (sibling->pmu =3D=3D event->pmu && !is_software_event(sibling))
> +			counters++;

[Severity: Medium]
Is it possible that disabled or errored siblings are incorrectly counted he=
re?

Users might create oversized groups and manually multiplex them by toggling
events on and off. If this loop unconditionally increments the hardware
counter usage for all siblings, could it reject valid requests from userspa=
ce?

Unlike the core x86 and Intel uncore PMU drivers, it appears this fails to
ignore events with state <=3D PERF_EVENT_STATE_OFF.

> +	}
> +
> +	/*
> +	 * When pmu->event_init() is called, the event is yet to be linked to
> +	 * its leader's sibling list, so it is counted separately
> +	 */
> +	return (counters + 1) <=3D pmu->num_counters;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0f2cff983d79521e153=
d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com?part=3D1
