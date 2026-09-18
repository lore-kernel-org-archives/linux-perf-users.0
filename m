Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E23A5E84
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713698; cv=none; b=C+dIDrH/NyjAwhOh96SRIK0ZtyVXp6qvO/S9Gln4VW1ayD5sXHP3xgtCRFNT12Rr1Ea8PkvSfkAy/XdC8vsYXeuYbtO9bYOdBMdY0UvAd2NbCfUmp0fwkvW5E82zy6ixlYjpDhdAIKNI2pmQ3fXYxROct7Yg9hh+2Q7uceibdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713698; c=relaxed/simple;
	bh=P6b6HwTZbn/JW/L4irXsLOpWuDOEXnetQf+VtQZbsG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lR2fSRKQCYU4NR6JIQvItm6gebnK7Go3UeE0QbdNeHsu7x9lNxUx4882QHD8WZfzgp1u7kE4ByHqnLc3OV48opJLgy0PZNTbm2AshE73VnJcNczj6hqfu/4TDXm/qndpMM1atDGkLcmFoSk6OYuwCScFxtE2ZvJmTJNKys5Emh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM2beib2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM2beib2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8E61F000FF;
	Fri, 18 Sep 2026 06:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713697;
	bh=P6b6HwTZbn/JW/L4irXsLOpWuDOEXnetQf+VtQZbsG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jM2beib2Jk7vGACXY/Qh5n+PJenC0CMKiTpZe7UGN4CNhPuUpCfScB+ZGCvIUdps7
	 EzdKPPGaw5+FqmAwkF79bTVOKvYrZkJhajcOzPpL+TliZjeL2CQRR5Q9LKEERgX80u
	 t7WSHm7g7oSH+jnHHx5W4AUSs6L2Fy0Zmyf/rhHuWDxv+lF9wyGLgrPK+xWnro0iH8
	 lDJ+o3+dYH3IAKvBseh/fxHR2gbpNLvH8EYKRuTAma14cZtcKXS/DbvXne5O6x6/Di
	 90Y+VDdD74/TdSHPeIlkcffG7HqV0+rG6GJ/2ov7hI86SzFfrAqDH02gcb0hIDzO4H
	 wyYwtrlSoRW6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] perf trace-event: Free the global trace_event
 when a command ends
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918063249.2172589-4-irogers@google.com>
References: <20260918063249.2172589-1-irogers@google.com>
 <20260918063249.2172589-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:41:36 +0000
Message-Id: <20260918064136.CC8E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The tep handle behind trace_event__tp_format() is a process wide cache
> of the running kernel's tracepoint formats and nothing ever released
> it, as the comment above it had noted since the code was added.
>=20
> Add trace_event__exit() and call it from run_builtin() next to the
> existing perf_config__exit(). By then the builtin has returned, so the
> tep_event pointers it handed out, such as the ones cached in
> evsel->tp_format, are no longer reachable.
>=20
> Note that this does not silence every libtraceevent report under
> leak sanitizer. Parsing a print fmt drops a token inside the library
> itself, and as those allocations are not linked into the handle,
> freeing the handle cannot reclaim them.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918063249.2172=
589-1-irogers@google.com?part=3D3

