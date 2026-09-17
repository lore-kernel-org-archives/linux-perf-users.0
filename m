Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1E434992
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627949; cv=none; b=Sjp/qPDtPIZa4cTvcpX2DxMZ9ZgMrdLo0LgZbymXZDAaNAjCyszBZSIUX1Wu3xXI+IYnaTx5DR3AWMGiG6mwB2cRezoqABDXtimXPfafYcFXGIf81jQy4tiuTYHFxSFR3928MIffZEpuizCdfcwysuwJrUPJAcKjBQV5D01P/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627949; c=relaxed/simple;
	bh=pJ2BkBEVBKgAVVcYe84YHohZZVU1pIyz60gT/LfbVuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XL5mmYVcSXCKkN0w6S5ouRVZ0SttA9Gb6wvGwZEuZJlbhd8qbTgtrijNbBdPy0pyzsJ00i560ZnkJjoVsHDV/G63tLvUPDymHveuvIDwzko1NcnFRmSOogtfdCdIw2id03n1GggsfQRRrBqn/dv7Ex9lT+NKCtpHRr3Jxj+6qNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/XYK2y6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/XYK2y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1C81F000FF;
	Thu, 17 Sep 2026 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627948;
	bh=pJ2BkBEVBKgAVVcYe84YHohZZVU1pIyz60gT/LfbVuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n/XYK2y6jEfnZGl+k8E0p6XaAFhm2AOdSG7bv0gOWwO/Wm89bDqU6QjkhruATDruT
	 qsZSj59NOvIuJMoPtX7JRfsdTXKKEf/ANuhcxisb0VYKSvpBl1LB7Hy1eDueiZWk6j
	 i88+dEnWKiOnAaAamlSzvP769Qb8EGcfyCqrKKdS9tzz5wA1YiEd+pejHI3bQgwLlI
	 BKFsglpGOX2LYgi3EHM5feJo9IeZxnrQbAwHAKpAf9PMcukDAl+Iwlh4GZw3NnyQX+
	 VjcZd3I7FuWrZxDzBZf6P7ezeyi1A/NOCLyHCu2CfA1tzgkxvl/Qr6amxZaGHdT6ee
	 LpvbBOp5obbGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/13] perf test trace_summary: Make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <3c8cb15f2d1ce25de658a7ea65bab2a5493c22d1.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <3c8cb15f2d1ce25de658a7ea65bab2a5493c22d1.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:52:27 +0000
Message-Id: <20260917065228.5F1C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_summary.sh tests various summary modes of `perf trace`. It already
> directs output to a unique temporary file without polluting the current
> working directory.
>=20
> Remove the (exclusive) tag so it can run concurrently in parallel test
> runs.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D12

