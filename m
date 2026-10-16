Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6918DB26
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110362; cv=none; b=UjQvNcHVbCIK+nexS99y7IpZw0TKwzZMZ1trthkHfZot6Nq1xypBHVDzAzs1NTOCq8mHAHzALP9Ot08HjBqXLSFExYnP9ZRpEAOkTmnu5eIH/sriSTjTFvuhi44eW/hKpstcNxzZ92Nxzp5OBqVp0MZIWl+8W61MGUtIRC98sJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110362; c=relaxed/simple;
	bh=4yQVhDzFS7zYycvjfnttsdOJMkMrp6nSVNt0jVFc24w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FdG3PEw2K6apDqJvZr4B0DGdyBdamUk9eyd4/wN6Kt5gw3C2ScgAJxzJm3/YwHw3jWm+1jOkBrfoe7juyvvB2R45dDnR/jtWYtiNzcr/TkfeNbWWM1lLe39t7+Hyb3atzfTcmQxEn5z6hVsLsL86Y5RmKE7wHOgaghfIQsHbbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S514l+C7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S514l+C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8F1F000C4;
	Fri, 16 Oct 2026 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110361;
	bh=4yQVhDzFS7zYycvjfnttsdOJMkMrp6nSVNt0jVFc24w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S514l+C7/NGwsZCiZeSzzF4GcAa78N68FugiXe8TvkweGDdcw0rvh5OmIl8wuUMyV
	 1ME9Ab4WAZSp9kxSlX+wgt8UODfBJ/mHt9HD1Q7grDR/9eDzQ+zJEtbRyMD/BhsdE3
	 4o3ADKO4AVUpyCQP5Ne72g3esu0AwT58l4m4GhSIF8/M0GVDz3h73qtNZyMZ/l9wmJ
	 yeRQiIbGKoFs3zVI6LF3koqcO0m8+lGEcn7bLWXX5Ph2wCfyrNWA7pjvjqH/O6i8JD
	 rIVCiKwCRHSMgQkrXYvTFluxoJJ36lnvSgH8QWC+gy92BvnK0nK4libhxvMFOfxMO5
	 emzdxFgULQ0GQ==
Message-ID: <sashiko-outbox-173524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/19] perf tests: Mark the shell tests not mapping
 perf ring buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-18-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:26:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Shell tests run perf, that maps ring buffers, so they take a turn using
> the per user budget in kernel.perf_event_mlock_kb by default; the ones
> that don't map them, like the ones running just 'perf stat', say
> " (no_mlock)" in their description line and thus keep running in parallel
> with the ones taking turns.
>=20
> The 'perf sched stats' tests are among them, they synthesize the samples
> from /proc/schedstat without mapping a ring buffer, and the tests already
> marked " (exclusive)" don't need it, exclusive implies every other
> requisite and keeps them running alone.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D17

