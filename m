Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF7358367
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186103; cv=none; b=AicVAoyZ5Tq0czInMZRE01hEMGuwwsKFLpcI+aIVsqZ5yOaC+TrLYvH7v9cnhNvv8L9PtgaTuf3U9NvXs5H+XlML1ZjfgVu9azqh6Q3we5NgsS1othlAzT700ddgLTDwfMY4k0gITwYoF3fZk0N2L+dF25ozNslR5IYTRwxSK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186103; c=relaxed/simple;
	bh=n+VljNUgu32vD7/CMJueazkZwtTOvN6oHF5qvml1cJU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QATMfwoo8nurr8iYouM3/K+ckoH/jo6ilSGxM7/C6QAc+orh+VI3vBSbwF03tTqiRpLzVgxJFQ53lYoRwgO1nfC6/F0WjDyx191me6FuSCuUKF/L3RbWGZVUZLrT27nLxJsxpDy/yFXPeUHF5fuCz92IgvBX9i7xQ2lezHghR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcU+KDOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcU+KDOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BBE1F000C4;
	Fri, 16 Oct 2026 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792186102;
	bh=zBzxjINcsch9gjYrE9bab1sqP0wYQUy5Iukq/gNtZew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcU+KDOo7gWC/2c3DOBWjRzU/oLU56H5tJZow66+hL0CyEZGhOZ1g1tLC33Isd6ZV
	 h7lHAa+rutlIIu/yDCs7pwopWJt8hI4HEO6ZceLdZLADRz461rnAWPZiO7HDIifcDt
	 bueAwW2xYCGSR+4yYpBHFR/iFvWx4bHOHv8E75rmUSA7YNdnKeJJzxGlp3kQS2Cfx0
	 zF0SNoeItE/rTz9AxO1PuM7ycuus9PKYZlgv4TYqYEvJoQWMFMC+x2RAqLcl1gCWIi
	 GzZmtDixe+lJiV4i5aDNWiv4T+YSCgYnRGJeS1NgflfbqJNa6ASMU+znZnN36s5F3L
	 6fieHPWkVRTMA==
Message-ID: <sashiko-outbox-174971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/21] perf test: Take turns using the perf mlock
 budget in the mmaping tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-22-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-22-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:28:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The mmap size used when none is asked for is derived from
> kernel.perf_event_mlock_kb itself (see perf_event_mlock_kb_in_pages()),
> that after rounding down to a power of two number of pages ends up being
> about all of a single CPU's share of that per user budget, so with 'perf
> test' starting all the selected tests at once, any further mapping done
> while another test still has its ring buffers mapped fails with:
>=20
>   Permission error mapping pages.
>   Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
>   or try again with a smaller value of -m/--mmap_pages.
>=20
> that then shows up as a failure or, worse, as an "unsupp" skip in tests
> like the attr ones, i.e. as a false pass.
> [ ... ]
> this machine for, and the BPF metadata collection one, whose output isn't
> what the test expects, are not budget related either.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D21

