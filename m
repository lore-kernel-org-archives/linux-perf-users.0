Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189883876C1
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620714; cv=none; b=RYHnSF4XZjAeLveQpGyE32KuNpycQ9WrqKARdbaOg8lKqBSiM3FPIeDieE+raT+cm0n7HS65MV7y0GtRAQ+edd+RJQCUmJMdlU5ph+LjMJSzouD7p94PnY3nH8SZ8gdoCUJ/zn7+pw+CJvf5NE1shnskkSo3pgBq6U4+4OhrbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620714; c=relaxed/simple;
	bh=wiGB7Y7KtAbi5vOE/yeMebTE1FYebycBgPciSqp8ssI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tv2aUizXbKxRqI3Gp+Itu/BQ69KPMTy/QGFakr5OID5omAETZ3gasTbGRj18DIhoCosdWpUX5DJOiywtLKYNsx9AGwM7Tv/qiFehAL9NyHzjwGm8N8zitmq9Fuadk0+dO11TaVUbwRYJeCKPrHAonByolg/GMTIqTes6OsX3plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5nBJpID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5nBJpID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD561F00893;
	Mon, 28 Sep 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620711;
	bh=wiGB7Y7KtAbi5vOE/yeMebTE1FYebycBgPciSqp8ssI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5nBJpIDU167BaTAqCsxGVLHsESY63lxmnua/8gLcNINQXkMS0JrTtCq/41hGMO4d
	 jf4BhLTf/zyi9gzT4lDfsaq6PkiPCBTKQtXibPk154lx3NkTP0EtvRWP3slsEA7phI
	 /fVhShYr+pUohfe1JKgrhaHywtp1U+65xht+Cr2sKgI6RNhfSyeWSMsO9k1Y7C+pT8
	 32jwiGEvKyFsRGUrXx35/WcBvNVffvqGso99XnMW03XRW2KCMmszt7KGvVFpPy5wP6
	 UO3NYNIQQhEv8YaSe+oTnWgVqug2l68fnpvE36jF+EivnKqYWTSMKtMRFUfHs7ZaC/
	 1f8umLb1blneg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/26] perf trace: Include the augmented arg header
 in nanosleep's payload length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-3-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:38:30 +0000
Message-Id: <20260928183830.ECD561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Unlike the other augmenters, sys_enter_nanosleep() leaves the struct
> augmented_arg size and err fields out of the record length, so the
> output stops 8 bytes short of the end of the timespec payload. Count
> the header.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D2

