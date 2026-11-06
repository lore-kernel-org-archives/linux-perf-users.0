Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940088;
	b=F19fd26jaeCDCtnwjwF/hsQKK+UTq6cvN9X382AbsmyWGkalTo+zUdyF7BRwDrYi7MTl
	 wXU3UzG85vGBApcINLqJvIf+hc5Xv9pJGBO/dZXw997ZEoxfaUhBDKCWWzlfTUBvTYzte
	 syRW25CBPdF5y4dkElvs4lzYQeNGUkYNcub1MyuTTK8qbG8C7bs0qwthw5SINM8G2mvnH
	 hFjr1YottipHRR7xOIXhHbArZnkpWOVuWXiTau9W5iZZVcCNlxK8uelrMvk09q8JFm9Ck
	 6VzVX9Zm9tvBgxWJDnKmbegjUKdlep45tJ3CIAYEnw9cWbehPSozIKZS8tMrbCtpk+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+7bdW8RinvolF50gKjVJe2Un+FQomU6jIEsWvLvLSQU=;
	b=VsLFhq7G9zHTaxLg+p4lhBXRlPSeD1nvzkouw20jPsjVdIE91GDAhZY8LK+/TG2fXJ2l
	 bHmALslCWs0t90bIQqjJ87142eZI/3dbGKom5PYMTS+V3MzIeqLE6H8rc3NEU/od1J7df
	 N1ORlxXbvxgoj7OrP0gm+JE9jfPlqPmmZBdDl8iSk1Vd7JJVobHrbDR92KaVhl71lO0Cr
	 gB4qe0foc+7tF0bHipLaDG32RQ7O3oy9NjPjZSpK3X1cEaANE71o9PJpWcA+qltaW2spw
	 1LuKKvpY/saWe/ctszJMKRmmJdDShzTcpW20uyXuldK9lFoyG7No1HXJ2z5IykzwG8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuKLYFmU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD3606D80C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuKLYFmU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67901F008A5;
	Fri,  6 Nov 2026 04:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940088;
	bh=+7bdW8RinvolF50gKjVJe2Un+FQomU6jIEsWvLvLSQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MuKLYFmUsMC+Ta7hzdEySvFfVkNVvdoM+ymKfHs8mOFuSbUUs1bBjanG2GhPoeDbm
	 fedoDFRCUDBfX3kHWehNHzANve8Oj1hLmzBjhiTRir3I/pCj+nnbGJJVsU8zijIAZY
	 q1z9JZJln50WE1zrGkudUhg7QOIg5lg6xwPuuKK/70vV0Jx+NQQmdyf5ms4TQCvPQ+
	 0jzF21JzQqRpBCZGByskPz/ZJjDN4O1+QuL7dghv9pbTcGGhhjPxuNhIVLrZ1Tonm/
	 aPmAIRN56gmi+IzkeVqBDe2xJWnpleHtmSuXa33RfM7JfVhY1tOwqcaWnhMDX6LTQu
	 u/XjA7YDxoDAA==
Message-ID: <sashiko-outbox-200752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/14] alpha/perf: do not update an event that has no
 counter in alpha_pmu_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-1-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-1-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:41:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_add() puts a new event on the list with current_idx set to
> PMC_NO_INDEX, and alpha_pmu_enable() assigns the counter later, through
> maybe_change_configuration(). Alpha has no group transaction callbacks,
> so the core schedules a group with the PMU disabled for the whole
> group. When a sibling does not fit, for example because the counters
> are multiplexed between groups, group_sched_in() rolls back the events
> it already added by calling alpha_pmu_del() on them, before the PMU is
> enabled again.
>=20
> alpha_pmu_del() then passes idx =3D=3D -1 to alpha_perf_event_update(),
> which indexes pmc_count_shift[], pmc_count_mask[] and pmc_max_period[]
> at -1, and it clears bit -1 of idx_mask, an undefined shift. On the
> EV67 PMU the entries before each array happen to make the computed
> delta zero, so the event's count survives, but only by luck of the
> struct layout.
>=20
> The event was never on a counter, so there is no count to absorb and no
> counter to turn off. Only remove it from the list.
>=20
> Fixes: 979f867191f8 ("alpha: implement HW performance events on the EV67 =
and later CPUs")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D1

