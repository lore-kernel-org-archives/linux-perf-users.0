Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523134D6C3F
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774022; cv=none; b=teA1lgxy96uu5FBgFQimNSbV9mWT6n8y1rK4HnFTvPTiRLwUn4VanrUrq9pXGjW/tg9CPrsmUt/vajpa4poryajWSU8b8kpLjOvlJ3bbQjr+aFAUqZ5QkpOg5HKjpoXvq1rLsyG/B0CEPEPSwqbzfzQfB7LmTos4sjkg4hwpjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774022; c=relaxed/simple;
	bh=8D4jb11bMVjvzyB4vZLVB50tBO76Wc6Xl43JSXAeI8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIZqPpMqQAUoOR5hktEiK5dU88Gm9b7euOBeV0y++Xy6OCQrUIEVuWKaviATiRLduyPPmbqPCiRGbYZh02zb5KzkDn5tz09USOB9xNAeC65EQ0eM/ieWXRNRTy/fbwAW9vcrz8Q2mdfGVdIn6g4P94P2upSN8EtGUCcA+0ADI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljwjRopO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljwjRopO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A5C1F0089A;
	Wed, 30 Sep 2026 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774011;
	bh=8D4jb11bMVjvzyB4vZLVB50tBO76Wc6Xl43JSXAeI8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljwjRopOX3KSfa9XH769mwKzSSMMwbMYXOC963nvzkqOz2qcZIOptgewFT4/IFjvk
	 UJ12lw+3HlL4XAsynAiimXjF0nDZN719cVti7lugvWHm7TsYQ/xgZmlQ3yguxO2F8H
	 TASNh3UNjrRJh+bXjqq4j69FmgALg9VuBR4N9P8VCJ1n9iIZUD1oeqCwaize98ujBN
	 VETDJs2W0BoyWtQS5/sAEfYrnWMCx0sLvQehMKh7P6nCUgogEhNe/t7118FUMPQdRh
	 bOSP7/aggf43juBjw8eerI3MdmSQsLfGtrDnb56R9VtwFBMAWhlT+h43sUthth27jv
	 DFaxddysP3/DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf test: Suppress optparse deprecation warning
 with older pylint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-3-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
 <20260930-perf_fix_pylint_errors-v2-3-945cd526576b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:13:31 +0000
Message-Id: <20260930131331.77A5C1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Python 3.13 reversed optparse's deprecation, and pylint 3.3.5 removed it
> from the deprecated-module list. Perf supports older pylint versions,
> so suppress the warning on this import and document the reason. Keep
> other deprecated-module diagnostics enabled.
>=20
> Link: https://docs.python.org/3.13/whatsnew/3.13.html#optparse
> Link: https://pylint.readthedocs.io/en/latest/whatsnew/3/3.3/index.html#w=
hat-s-new-in-pylint-3-3-5
> Fixes: 8a54784e708b ("perf build: Add pylint build tests")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-perf_fix_p=
ylint_errors-v2-0-945cd526576b@arm.com?part=3D3

