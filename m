Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944310;
	b=eYWhANqjx5gC61/GyGge9OIEMFo3Ipq1SU9FnI90xUNwpekDBdo3Pxk18gR/lHc6LgiW
	 TTKJiRBhRQZuN7ST+SfvOJiw042cgcD6i5EuDFpYPBB8dyDT9FosyMRl5Nqgy6/7X90Yg
	 T18U98IdwocUInnMu3dem2K8ghXBqE4Ob/mnxvYLQzxyXbuFwyZxfSY41tQssWexp5vef
	 ZGoYQtYkQ30pQMsCMf1tT9DuKc26wTW8xYc2LUmhpA2N2qncbwZCvuvcNhIElqVQ16fip
	 7ttLeX+zr6qoehoMc+axvGuE/zEtHxJDhV8/zuWJ8QoT+5hkolJ5isd0oyuMaD0xkfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ipzBoELnJEakX9Vsp56meehvYZHOZw07EkphVLZ9Jto=;
	b=OBD1sPmKV0yQKoajO+aBHSdLBfeGyPhhFH8pSZrhhSeD0cgbjdISQ5gIB6cA9fBcBQAe
	 WGk16U0fWG0N77519dole/tgd3IYVvyFRMh9/ffYBC52E0OdmN9TtSYO4gIDcfK6qtxmB
	 uX55cq/T2Uq2Yl1kBKdJKnZ4pULOHu+v/eCFV0nS0vfxTX5NDpNhM+PuU662UHykfuW0Y
	 nzht3Nd1RbYNdUY4XkKJaWbJKOGuzCOtfFD9Uug01Ww0dNtMfGNSh58VGrAn8lNikbOQX
	 KXA0ryTh93fCX0DE97NcDQNo0jbZ0BJltlKaCRImmfbo/gWu9c7Bkn5aahup9x7M/Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WecLW4Vh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E168606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WecLW4Vh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97211F0089F;
	Fri,  6 Nov 2026 05:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793944310;
	bh=ipzBoELnJEakX9Vsp56meehvYZHOZw07EkphVLZ9Jto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WecLW4VhrcGwfBgGGm9cySfXz6T6rTRcQmndCnQXdKI73Xan/90K8bHFGhDbWBx0e
	 7QY1sXc/y7KI/pbW8/GmGnA4McKpbHAr4giCyhYi/M57XVuDHjvy234FtOZE9J/WZq
	 RYU5I9PcWYXovGEu57Iz5VH1p4sDJgHidz3M5fy8SisosPsn7HORZcIQzmIaTjCxm8
	 xyNH4vfvuH4MHOmyZ8wqlXzgmXWw5x22c1tl1hrmR4kSHeuzYQqbosXoPPskQYmqjp
	 J6CMJh+p7OBEyQ3aGIA2AMWnb9iRTIEwOvvXsVfSJ9lPfbx6aFkXtoESwR4taG+f99
	 UNcQ/Ji5fOe+w==
Message-ID: <sashiko-outbox-200867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf test: Don't starve per-process tests with
 system-wide events
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-perf-test-fixes-v1-4-0b279bee5830@linaro.org>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
 <20261105-james-perf-test-fixes-v1-4-0b279bee5830@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:51:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Some tests intermittently fail when run in parallel, for example "Check
> branch stack sampling" fails with no branches recorded at all.
>=20
> The default event is cycles:P which there may only be 1 or 2 HW counters
> for on Intel because it's precise. System wide or per-core precise
> events hog the HW counter leaving other per-process tests with no
> samples. Rather than make all the tests that use default record commands
> run serially, just make the system wide ones use a non-precise event.
> They don't need precise sampling anyway, so use plain cycles which can
> go on any counter. The per-process tests can be left alone as their
> events/processes never run concurrently on any one core.
>=20
> The LBR filter is another resource shared by all events on a CPU, and
> the system-wide LBR test uses different filters to the per-process
> branch stack test, so mark the LBR test as exclusive.
> [ ... ]
>   ...
>   ---- end(-1) ----
>   138: Check branch stack sampling : FAILED!
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-perf=
-test-fixes-v1-0-0b279bee5830@linaro.org?part=3D4

