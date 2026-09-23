Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA995446BFC
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148475; cv=none; b=N80fdtD+R7+BLM3SbD2WPloc8Qx8+/4dUANMbCYfMhT63Iw/16zFXjTiBpJkQXQTHwpyD37O/QvFAy4FFSe29ibLTciyuEjDHJxlVqfYUdMFkh5WdEqmgUnIKsDrrW4f19noTri27A7boN02VJleYnPOsRGg7muIzSQ5s7jVKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148475; c=relaxed/simple;
	bh=6wjX6FN94j3x8qskO81i5mWgZg4H9hVmTCfV3ge1Kjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B6x6KRYNBVXp1yUaVo+9VXFMO+eZYOewwr1VFzvIO1+9zfTIdZqqtz09sMMUnvqTjP/m0hjYC8oyscdi4Ifg+MrEW2LCaoOPZ2CoP7kYSIBFLbr9O5oeAKwHsnj8w6xX/fNX17m4r8J9+CIIT6rsUkjZ40qNT/JusaG5+CmaQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emD6eNac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emD6eNac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588571F00893;
	Wed, 23 Sep 2026 07:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148472;
	bh=6wjX6FN94j3x8qskO81i5mWgZg4H9hVmTCfV3ge1Kjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emD6eNac58eUwG/FuBkWS0Y1wT/WzBxx2TN6Gx1GEx/a1gaJ9BgMcrHS3/jaZEF2A
	 HtVN/99Qo1SMBdBKnVy0SGF9kdhB4QMKH3kMKC76wDhPfCNMfJXyqsS6WLS5EI9VMO
	 BVmjP5qdukxfRZd+fQWKyV5/FcrtTa8YyJAYrba5XXsmqDBBlmqNAAd2vR6Baeh/ak
	 e6Ugmmw6W+0jM13nf5Ksf/OJ2mkBKUBbHIzYJtOfc8EzrDLT/v/H3L6G4PKQRMXcH5
	 5X3gYWn8Mpf151zO+TH/2qMS9VGMEN6bxYHPFccuKSpdz1BSmL1CzCliK3q8i1crL8
	 tHwxkCwuY/ERg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/23] perf test common: Only disable probes in
 clear_all_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2b33d9a499901d59d15cad2ed84f5ed181cb7e2a.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <2b33d9a499901d59d15cad2ed84f5ed181cb7e2a.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:27:51 +0000
Message-Id: <20260923072752.588571F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> clear_all_probes() began by writing 0 to
> /sys/kernel/debug/tracing/events/enable, which disables every tracepoint
> on the system rather than just the probes the probe tests created. When
> tests run in parallel that also silences the events of any concurrent
> perf record, perf trace or ftrace session, so unrelated tests lose the
> events they are waiting for and fail.
>=20
> The write cannot simply be dropped. Clearing kprobe_events or
> uprobe_events is all or nothing: dyn_events_release_all() walks every
> probe of that type first and returns -EBUSY without removing any of them
> if it finds one that is still enabled, where enabled means TP_FLAG_TRACE
> from tracefs or TP_FLAG_PROFILE from a perf session. A probe left enabled
> through tracefs would therefore block the whole clear and leave stale
> probes behind to collide with the next run.
>=20
> Disable the probes and only the probes. The set to disable is taken from
> the kprobe_events and uprobe_events listings rather than from a guess at
> which groups perf uses, so it matches what dyn_events_release_all() is
> going to inspect: a probe an unrelated session left enabled in, say, the
> kprobes group would otherwise still abort the clear.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D17

