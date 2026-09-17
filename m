Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209A25333F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603422; cv=none; b=p6G2Vbvj/TpKij+VM4N1D8JOSwEvsRizyxvOX73qqWHfgecSLOJipf3yfq7E8c0EH+JagbxATk4/sdDAhgGF9QRhGkevs7eBE7MUDCukfLwX+Q2TcXeGmajiiO3FyfPbCf8rfT4LxQcmVCNqK5c2n8IqnL6xZF+Uczot4PQrZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603422; c=relaxed/simple;
	bh=w2pJoZb7cWEkmN7/fWxEndNic9nRdm7Bvi2e/pVuQBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GUxSCTb+z0l9R18UenhfxJhkRO7z7xACAsVK+mbcaZNe2FBalzFO1X3q2huTSDF75L8p6zUvqYDVNhU6KX2r6FPvjQmaNjL5nJEWw149uRL8VtiSyrOjHHiBhFuqWwx+cttqYn27geGqPxRy/AS9wtilNN8OtFfPXn2QTAyDrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqBZSRNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqBZSRNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0601F000FF;
	Thu, 17 Sep 2026 00:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603417;
	bh=w2pJoZb7cWEkmN7/fWxEndNic9nRdm7Bvi2e/pVuQBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqBZSRNmL1pMLOOysW+MAmrMCTFjoSxjyGWw9vjlBke5yffhENSYsfhpGiPHJ0mr1
	 wIHeXcDF7I1dTbb+aYPSBEm2Bc6F6+Wd71OzTz4xNAmvjBHVHc7LjEgrR7v5C1afFQ
	 hUDYxq1/msfhaz2thSBjfRwMj8aG4EmhmlkGNlqfStZpojCUkd17TDmYxs1R3E7F0k
	 Zd8hJ3dS9bYmkNxopFssV2FNdD7N1Umn568CRKvwfBv1+FUbKxeYpsmT5NJyeoGmcl
	 FUdbJkDFQteXDKpuMjAPv4V5jRYDgDLvw3pe16wFctKXDErp+rSZRv/f+TRVm9SDqh
	 1suNCKOgyox3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf libdw: Fix Dwfl discovery with split files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234402.437113-2-irogers@google.com>
References: <20260916063545.3103314-1-irogers@google.com>
 <20260916234402.437113-1-irogers@google.com>
 <20260916234402.437113-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 00:03:36 +0000
Message-Id: <20260917000337.0D0601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> dso__libdw_dwfl() opens the Dwfl with dso__long_name(), the file the
> samples came from. When the debug information lives in a separate file,
> symbol loading finds it and records it as the dso's symsrc filename, but
> the Dwfl still refers to the original file, so libdw has no DWARF to
> resolve addresses against.
>=20
> Open the Dwfl with the symsrc filename when one is known and fall back
> to the long name when it isn't.
>=20
> The symsrc file is found while symbols are loaded, which can happen
> after the Dwfl has been created and cached, so drop the cached Dwfl and
> the addr2line cache built from it when the symsrc filename is set.
> That teardown can run while another thread is using the cache, so take
> the dso lock across both the teardown and the Dwfl accessors, and
> re-read dso__symsrc_filename() under the dso lock in libbfd__addr2line()
> and cmd__addr2line() to prevent a TOCTOU race with cache invalidation.
>=20
> Fixes: b7a2b011e962 ("perf powerpc: Unify the skip-callchain-idx libdw wi=
th that for addr2line")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234402.4371=
13-1-irogers@google.com?part=3D1

