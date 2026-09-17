Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE74ED19A
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664280; cv=none; b=TucPEGeRQNyASO37w/w8dSrpnRjLjuz67KTJuuxIa3Nadmya2r5YTlyj6Vipst/12es0cPm8A56iLK7hedubwBt26F7HHSostieQiAtVrtUj47FNRgTA01YeFa79tUVCm9+BW3R4BNoAKESxy6hYjPVvoFSNLkZzuJgDT6DR2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664280; c=relaxed/simple;
	bh=PeEWcNALMz+DqHPvH02FxUgR2sFKNuORtR4vMaIbBDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o1Tha9vBMLFd5HFfuQr+whYA4alkugh/liEIp0kHdhxoNOT6NjjXo6TDZqL92AhHs2i3T3bKKHBmfgqceJ64v/X9D3Kx199t2KhKnRfPsSkUMTy4t7cFRgrB4i/+LXQwreLDU7zcXg0Qx7tHMaHi261JiccBA/Vkpg1mXlqF6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY6018v/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY6018v/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C8A1F000FF;
	Thu, 17 Sep 2026 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664279;
	bh=ty3fqonc3+VVy//ZIJnCf+vtxPLNsumAj/r22ZRLXag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nY6018v/sG92HbQQCOY9zIvzS+5qV2Uj51MmM8LxVbWp8h7zgYmxlqUSMEojRHg2a
	 V6QLCB5w6FgA4a+99ocmwtjd/KiMeFPkYe5GO/GffUvLiDO17Rz61E9+MM6up0fDs2
	 7G5rHZI230Rscg/WV6dzocSM2izv9ySuVCVj0a7bPtbrmusS2o5nrsZH0nV8gZGeyM
	 40oRzcWuZRIwV3vvqtGp7TLsJNO0zIDo3E1bzoK4M4SJNeCDK37Pq4sph2/I0UcOCC
	 XPgTLKyIJu+HRtE1R4Tf8i9qzn33Nx03U5ZuIemwcdbliVJ68n0KKXN/OY6ykrvrqV
	 znC/3F+uJGF+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] perf test record+probe_libc_inet_pton: Scope
 event to PID, add retries, and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b44b7608adab8e5575bc458a8d3e02105d199afe.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <b44b7608adab8e5575bc458a8d3e02105d199afe.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:57:58 +0000
Message-Id: <20260917165759.02C8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: missing retry loop in uprobe deletion causes permane=
nt leaks
--

commit fcd4501f2721d617618e1b6d7a9df07bf2b93da0
Author: Ian Rogers <irogers@google.com>

perf test record+probe_libc_inet_pton: Scope event to PID, add retries, and=
 make non-exclusive

This commit adds a PID scope to the uprobe event name, includes a retry loop
for uprobe addition to handle tracefs contention, and makes the test
non-exclusive. It also introduces mktemp for temporary file creation and ad=
ds
trap handlers for interrupt cleanup.

> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tool=
s/perf/tests/shell/record+probe_libc_inet_pton.sh
> index eca629ee83f03..3eb51426373b3 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh

[ ... ]

>  delete_libc_inet_pton_event() {
> +	# Ask the kernel what is actually there rather than trusting
> +	# $event_name: a signal arriving after perf probe injected the uprobe
> +	# but before the assignment to event_name completed would otherwise
> +	# leave the variable empty and leak the probe.
> +	local probe
> +	for probe in $(libc_inet_pton_events); do
> +		perf probe -q -d "$probe"

[Severity: Medium]
The commit message notes that concurrent writes to uprobe_events can return
-EBUSY, which is why a retry loop was added to add_libc_inet_pton_event().=
=20
Since perf probe -d also writes to the same tracefs file, could it hit
the same -EBUSY contention here in delete_libc_inet_pton_event()?

If the deletion command fails with -EBUSY, the script would continue and ex=
it
without removing the uprobe. Because the probe name is now PID-scoped, would
this turn a transient deletion failure into a permanent uprobe leak since
subsequent tests won't overwrite it?

Should this deletion path use a similar retry loop to the addition path?

> -	if [ -n "$event_name" ] ; then
> -		perf probe -q -d $event_name
> -	fi
> +	done
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D10
