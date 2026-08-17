Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B03B19BB
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005990; cv=none; b=s/nTpH+zeFrQSX6ppHprZ5zI6czqGITBAxxNSetWABDuYjH7wae2k9L7rk8GnvKB+qKD+YYZ7uVxrVPS41heqfed0TuYI0ZHrrkavuf+EFfhgZhkp4L0lde+kTMiMaS53s2mOa4xujOjjN823jkA8XyaWoP8SG+HHienh4ckPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005990; c=relaxed/simple;
	bh=/ffcASeFiSvX5nTuoFtrYCrE6ebHTNNXPNmSHHXGn3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8m35jEDMoirdIVkRzrKNDfdBVImtVFtEG5gUlgFTl/dffKACOGCVWNjRNChngRpaAW+dMCG/vcbvSInVoNA4TRaL5OudYOTu0ErtPzRUYzLgqAZ75Wobg1toSayFh7Q/e9PSk5ehOfzWj4//mVv/E3eXI0c5NMuZ1xNH3DCwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehl+ZZYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehl+ZZYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCB81F000E9;
	Mon, 17 Aug 2026 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005988;
	bh=/ffcASeFiSvX5nTuoFtrYCrE6ebHTNNXPNmSHHXGn3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehl+ZZYQJVvTeIeOJ7tVM08dxG5pj/IE62hUc1BqAL8rz1lxlH/YtXqGQT6yuNExS
	 xVPuhu0LIve5TQfrHLur0N4oLBi8GvOMN/G53HMlySrg05tGHMQRwVhqoV/2udzodm
	 DOBWBMAZNAjyORqqHkpk1yTPJfPlNVsILvlb3UrxF14Ht5IX/QKKLP4NyVIF/p7h6R
	 4uJIK29uwZWs/pLFNMfGyo0uJ2aM8lHmW/qVtBOPSBHFi12DEjPjboLOzQX/8TVoKC
	 ERXX0oEg6iEEt8erUfA4M4+Eo7shTrVPviikiLzyte/26WSrWom7V9g/OYDsOCtNmE
	 EG1AeyxdDg/Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] perf test cs-etm: Test branch history on
 existing samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <70f7ccb31e81282212161177124dfc3beff24ad9.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
 <70f7ccb31e81282212161177124dfc3beff24ad9.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 22:33:08 +0000
Message-Id: <20260817223308.9CCB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a CoreSight shell test for --itrace=3DL. Record timestamped ETM trace
> with explicit -T sample timestamps and AUX pause/resume events, then
> check that the pause samples carry both a multi-frame callchain and a
> non-empty branch stack for each of the workload's two processes.
>=20
> Decode the same recording with L4 and L64 and reject any branch stack
> deeper than the requested depth.
>=20
> The test skips when cs_etm is absent, when not run as root, or when the
> recording turns out to lack virtual timestamps. It exercises the
> timestamp-gated path and the requested-depth bound; it does not attempt
> to verify that the attached history is correlated to the sample.
>=20
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787005265.gi=
t.aaupov@fb.com?part=3D4

