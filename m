Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC518569F14
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970229; cv=none; b=Peot8+THD+yNv4ssqgKOAdQ6cO+VQSNdBq9tX22YS9AvOB25kf10ttDPxdofyxsFUvNZe2GR+v6KTVZAcWBaVBKg/lR5PwV5UUlpprT+1Ib4c76RBE0ujJ8KdO5ucGtGBBS0YsK+OAgeLb6GelWwEFCzy2RzFkrmnzz8ZaBYHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970229; c=relaxed/simple;
	bh=NLox4TvTLuqEjAVYR+LxwqEBaWEBJ73FiOtXGx/v1lI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDBIZ63u7CeOOW7ChswfVMs6SDWp/54g5M7m914c4arniDlxaVX+YBfe322gLausQ9TI/pbLb0Mbb4xXNF3gpcCrLGY+6FKorNuSXUzIjojWFBgFn3JbySyG0YtA5L3JSVSGaP4NJYfZQR2DrD8A1cVUIkbLGI51gx5U1ycyPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW/+OGsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW/+OGsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731441F00A3A;
	Wed,  9 Sep 2026 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970227;
	bh=NLox4TvTLuqEjAVYR+LxwqEBaWEBJ73FiOtXGx/v1lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nW/+OGsEd+kvqhkbSSksT1j7P35lCOB4Y4Pf9TCrW5FEoRMZyXS681yUckjGrETQg
	 9IlDEOcpdoTouWmc4g5Q2y7IOp/cn/y7Lw9ZYwhBgWDz0k4gdCe3a7NBxsLHIQQGjw
	 kuESKh9RCaILqGXQriqO4Xk18oMVqiCt+46Ik3GurEBGK2LJrv+5rwZfSi/yMhXxjg
	 28nwW4O4GYZYFaRes0yVP18hLgfcdsPdSoJPxUhcaC4ACH259SZkr23DS4TWhS1NWP
	 fw7gC4vCQV005h7g+AmPYtttANMde0p7pCro4ZWYgaAdJU6sNUKe0ZP3G9uelJFVj3
	 XJifu1vbLcxzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909160218.174928-3-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:10:26 +0000
Message-Id: <20260909161027.731441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
>=20
> The L0 cache is newly added a small piece of cache which is
> the closest, lowest-latency memory cache tied directly to the
> execution pipeline.
>=20
> The table "Table 9-4. Data Source Field Encodings for Panther
> Cove and Coyote Cove Microarchitectures" in the ISE doc chapter
> "9.2.1 Panther Cove and Coyote Cove Microarchitectures Memory
> Auxiliary Field Layout"[1] indicates the code "01H" means the
> "L0 Hit - Minimal latency core cache hit. This request was
> satisfied by the L0 data cache."
>=20
> [1]: https://www.intel.com/content/www/us/en/content-details/922690/intel=
-architecture-instruction-set-extensions-programming-reference.html
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909160218.1749=
28-1-thomas.falcon@intel.com?part=3D2

