Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E53455600
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393461; cv=none; b=ripzKI+6DWEltN1hR426fktdQZAOm8koOjinu51kIGr8uDs8Vpm11cpEn1V2sUKSLYL/Yd+ZO998tzMoqikbpLZwoMmLLhSP3wh23RmRnUXp/IvX/zf3epIyvzLpbT0vHG7M+8MYWCJW8019GhC6gA+BsP1NCYodhxd2OnjQ3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393461; c=relaxed/simple;
	bh=2/qff+PEFmEv+nLRXydGpPGvVMvtfloKlfChga4M3Cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KWKiZ6Xaxl7n4cIcYzfj/HSu8fZzhRhbE/ZUh7FhlEMpWFxWDFgDNzww6tQat2TZ7IgtvImTgYOPK3gQnf02i55q72KEdzQszLV0RbTipF35C3z7VEPWGpcrc72IOtFW7hDeZ0AL9+uAPQQ8zDLz689qpF7TLdUBTVJuKukX/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocwX4NZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocwX4NZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5231F000FF;
	Mon, 14 Sep 2026 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393459;
	bh=Iehh0JiTmFTNNJGFtbPaduPgRri1pgZ6ixXV36Vng3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocwX4NZXNMs6zqkEyP15mj3PCsdvSOyZo3x0o324JZyHaav3OIHodGdpwhqlRSRa6
	 zzK05wjftt3H2OnGKKIm8H24ONaX38SHWW/QGP0nbnd+zBFCVWvZt9k20eUKazx9Z0
	 Dw5nH+/3xhYojeoYA6SFKMoTE2KP7BzeWOKkt5ClHqc+SQBv0YY+byZo223CtMrZE1
	 GMSDl6dNSHDssqIU+/rdVcogfu1Wq1zJxL34d1l9/lJusr67T8UCvOwcb84xnUKqPB
	 pD2Q+1M2szvNG/8s/SBl7EohfcWMl6Ra3TNjs9YbKVCLrQroDPtS9mRPZM97yrXvx5
	 fA/rlwmNMHGRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-7-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:44:19 +0000
Message-Id: <20260914134419.BA5231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one that is stuck
> in a loop, and when it is stuck there is no way to know where without
> attaching gdb to it and looking around, which is what this does, from
> the outside, sampling /proc/<pid> at a fixed interval:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ tools/perf/scripts/perf-stuck.=
sh -i 15 -n 4 -l ibs.log $(pgrep -x perf)
>   watching 2297313 (perf report --progress -s type -i perf.data.ibs) ever=
y 15s
>   09:39:34 state=3DR cpu=3D+0 (0.00s) rss=3D664295kB stack=3D7ffc3ae31000=
-7ffc3ae52000 size=3D132kB  Merging related events... [ 39.0%] 197574 / 506=
686
>   09:39:49 state=3DR cpu=3D+1496 (14.96s) rss=3D665383kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D1 Merging related events... [ 39.0%]=
 197574 / 506686
>   09:40:04 state=3DR cpu=3D+1497 (14.97s) rss=3D665383kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D2 Merging related events... [ 39.0%]=
 197574 / 506686
>   09:40:19 state=3DR cpu=3D+1497 (14.97s) rss=3D502250kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D0 Merging related events... [ 61.0%]=
 309026 / 506686
>=20
> The CPU time used grows by a whole interval on every sample while the
> [ ... ]
>   [Inferior 1 (process 2342826) detached]
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D6

