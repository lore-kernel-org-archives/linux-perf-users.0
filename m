Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250661;
	b=xq89oQ7S8wThfjhT7ed+NDtrutxuBBcGyOjuaQG4QBmktvUEJkmy0RwxgON6dPkjXuT4
	 IOIyRqfjSp4NkRW0YnyqmODHP6FD2YGPKN4iopxtyj4ZinhvHIp/YT25wTGWo6IQn41U0
	 lOkCHPhIny2Me9bC+MPLw2Tz15/KCgcv/XyTX7f918v9Z8IhOCDRouAx0xG12/p5wKxGb
	 cmB2M5n0vdwin7dlMPLgSXs5368X6gvU7WZyBcWEi716R9lSxdzqmQDMmcIL0fUaOgnLq
	 i3pq9l+5Es+/UlawopsIAoEfZaTbpMRCBTll64H9YJ5Wnw7YWCthkU1l2DnCABpYnFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E0bF6a6HuqMl7RCepBC0joxe1eQ5Kxshoe2wclUDEf8=;
	b=wSKxiDv68jXBJWqk8oN/2W+JuGinSKjT2huDVbFl5GLLyYiVXkSX0R/hOzu8ySP7MTVr
	 GMs89CCZQqSAUW7EsO4dwXAuBu44I+N0AcJphVRyJVdgx3kUbvq+hkdVUxWsWddagh31M
	 LUrhrUHPoxNmd++lyHC4cC42yDIIvUQI15OoSOUkQ2WQHV1TbGjPSE9JJQxZ6jtBQjdZv
	 Mzwq9XfgSD9F/QeVCBOxQt53zvjgD+6YBZF1EfKbh4CFxiZI+ruv0CvusvtZp4e7EB8C+
	 cvdcv0bpX1L3EIDjhIZz9Zj4ZNoyqMxDk4WXbYSdA+cgBK3eTOeepHWQ1RoFIJVIvRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i+Hxg/f4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47A606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+Hxg/f4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624321F01828;
	Thu, 29 Oct 2026 05:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250660;
	bh=E0bF6a6HuqMl7RCepBC0joxe1eQ5Kxshoe2wclUDEf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i+Hxg/f4hF1WOj6N/He0FSGEGBht9wvTDqLh4TOEygQYJ3lI3k6W/qjyi+GHq83JI
	 xescH3zGYLSW2dmiPMMf/EbIPbiy4+C/1PmKWuiu1AK15hd2bBDlgTbCQxfL8abUMp
	 ge3QWW4yw5yw9fyNA60gSN0Ymi6ThV8VuGky9XEEh8JdANn7Vyjejc8c1nVrfzgoxH
	 DAZK/r3OIJXjlXNRPnznmZ54TGz7/fLHiy2XnAfK4pCF/i/8K8B9Z1yEOgukIZPfMB
	 wwGcfZpajtAwXz9hAlpkf44FAeRKWgZSaaXc/GrDB9Wt9gQhMC/Nscb1QpIOCtxu6j
	 7+AzTdOiJp9KQ==
Message-ID: <sashiko-outbox-188735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 05/18] perf/x86: Add lbr_enabled to track LBR state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-6-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:10:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a lbr_enabled flag to track whether LBR is enabled. This will be
> used by a subsequent change to avoid blindly re-enabling LBR in
> perf_snapshot_branch_stack() without checking whether LBR has already
> been disabled.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D5

