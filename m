Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131363EDE54
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006464; cv=none; b=tsuWwcuT10Nb5KWmaC5szF5t7tKbtuNsXxpjHeRtwru02ZniAbTFb2IaT4DfTUvD8Bgj/RmTCPFX5/4SrQL2e9uksicuzJJ/tQMG34YN+wDO8YuwUNm4o8wMoDVeEyOxKWOkkMldrlysXAKWpggqRtgrQiIhWlEwZ32QvmHU1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006464; c=relaxed/simple;
	bh=i1fwicbj8mdkdbOK0MNOl93FAKIck9AN6eK7KEPFC2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELhytR7GDwBc97HrcFS0st13qtRL/ScEw//aWb78fjrUpyRR1bsFZeUSzcmEnOs6WCYZjWN09ORAqMjESuNvLAj63TqLYQL7yM0i/eDe2Shh4tn9apVoN3Ivmq9bYvm2TXqr/WdFEmfG005muTibEppEiQ8OcP3X4L4n4uS83I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzM4Vs6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzM4Vs6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E41F000E9;
	Mon, 17 Aug 2026 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006463;
	bh=i1fwicbj8mdkdbOK0MNOl93FAKIck9AN6eK7KEPFC2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzM4Vs6QJf61A0t1Bt9CDcFMAaTDUYtxWVvd0ju4B/smNhUylIzjwU/2Zv+jCPP2R
	 5VCdLwpsSThzQf5uH1FdcIZGIUELPtFs6vZbMXwTQVRCgDFEpkICCxMkjiDWMHMDD9
	 amvyk3ZafdAE+RdV34IpOGYI6x/pKgJSsQU7ECVIvZ6EE0GHjDxyYSRiXlkGLGsz6H
	 flR7Edb6b1M5np2gpYaLIIKXrsdFJVOtRG8TBTFSpGKqmW69zBL0Rq0aLN2MK6BA1n
	 D2kiTe6A8wQ0KAFO2iM/adDQtk5hSqDqiBaMMP00rumqF05q0I5YGjKtT/FPiC85Z8
	 HSVL4PbfUbEdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] perf cs-etm: Add branch history to existing
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
 <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 22:41:02 +0000
Message-Id: <20260817224102.C97E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Implement --itrace=3DL for CoreSight ETM: decode timestamped trace up to
> each existing PMU sample and attach the branch history that led to it.
> The sample keeps its own ip, callchain and event identity, and a sample
> that already carries a branch stack is left alone.
>=20
> Samples are correlated with the trace by time, so this requires virtual
> ETM timestamps that are correlated to perf time; timeless decoding is
> rejected. The decode loop, which the previous patch left on its own in
> cs_etm__process_timestamped_queues(), grows a timestamp argument and
> stops once the decode frontier reaches it, so on return the
> thread stack holds the branches that executed before the sample and none
> that executed after. Attaching then reduces to the same
> thread_stack__br_sample_late() call intel-pt uses.
>=20
> No explicit sample-to-queue matching is needed:
> [ ... ]
> can actually return n entries. Kernel-inclusive trace gets the same
> conservative 1024-entry headroom that intel-pt uses.
>=20
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787005265.gi=
t.aaupov@fb.com?part=3D3

