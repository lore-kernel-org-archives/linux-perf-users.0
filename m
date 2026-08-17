Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C03E49C7
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960791; cv=none; b=J0GxILblgZ5E2hTTLwWDfOWbY8qsjRQgS9yC0XWDHVmgj66vM8ep1FCV9asqWsWoFN1jLXE2T29j2kzQcoCy5SCdYe5sd/1+ppWj5CtPPJCFRJOkFJpahUYa2YWEzY0KzTdnPcNysyOW6gZCaxYgPDekK3UXaklymuJiiqNecGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960791; c=relaxed/simple;
	bh=tSQ0fpZG+4hRYeLN/awdtDxbU9/c3saeYSPHKSjXZuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZ2XI9a4y2XIjMa0YroA017d4ECBUqne9Nd3wvJJCNMdsMHXHc4RemsGYk3i7TYg+Px4hgExy3XlVVi9EsRwwgVV087xzlI3az1gtXdfcMABlgSh4E0MYb+XNutVVaKEQAJm1tcM8QI1kL49xMH+yPyaPVtGRCnp/+JpRLk5LWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur3/2kTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur3/2kTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19B1F000E9;
	Mon, 17 Aug 2026 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960777;
	bh=tSQ0fpZG+4hRYeLN/awdtDxbU9/c3saeYSPHKSjXZuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ur3/2kTSLpcGSjwX83Dd+u99x/CfMa3kubuYylhDwQkoW4k2GKaHa+xCfhuIAtvb0
	 3310wUTI3EZyE7LnH9PNjULXWHqChv6H2a9vejYGmACJa+btmtCQJL30uRGYO+ZMKd
	 VYW+fdS0NYJtHiE5JTYEZTkas0y74jBKNDFymIAlb/EDS7EMSXG3l9LdTHTkGoygfj
	 3ekhnU4Yzqdt0IPOGtkhnu4Puvm+ILQKKe94bMmOMBvTyDe6GV4gtBmtx4Cidj8aJj
	 Z/kCQdfMpQ7tKpbWWkzpXLDiIUpTnryEt+5Egs4+lM67Y2OKt6GCKTdHNLAHrjt/CD
	 F4yC7eE41vC3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/9] perf c2c: extract shared data structures into
 util/c2c.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-2-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-2-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:59:36 +0000
Message-Id: <20260817095937.4F19B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The function browser belongs in libperf-ui.a, but that archive is also
> linked into python/perf.so, where builtin command objects are unavailable.
> The browser therefore cannot depend on types or callbacks owned by
> builtin-c2c.c.
>=20
> Move c2c_hists, compute_stats, c2c_hist_entry, and the shared column
> formatting definitions from builtin-c2c.c to a new util/c2c.h. Move
> c2c_fmt_free() and c2c_fmt_equal() to a new util/c2c.c.
>=20
> Keep struct perf_c2c, the command instance, and
> perf_c2c__browse_cacheline() private to builtin-c2c.c.
>=20
> No functional change.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D1

