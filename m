Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F437DAB1
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991222; cv=none; b=flR5De5I4XyZxE2vSy9+Of+bQNtnMCsnwOwB5YSe8GWBCHr/IshSqi0LHKhy15Lfp46GoUB+8C8iFaLnjye3scdp6E8+JL1qFgh4VWLoBuozcr57aX8reM1KyT7D+u2N9dnxc6MMPxoxSQWAekA7eE6UyJ0NgsQzdfQNM2Fq6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991222; c=relaxed/simple;
	bh=/kq8ZfaExWBESyofTr7doRd2DVJdbmoLB9fqgJqoPjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sAjFDmHkSmGwnkiq9E9b4fCZFg3Y1gPcv8Ri3o+2+x3EUfTZda4y8Ii2uDcfidWWtW5xsWw4wIfbB4GramzfXM8xH/EAjgIwUxCIB6M4vgVuspnEBpOaIJWOrpM5Dv3Yj9TrSPgTAy7v3BeDkUEK2i9nPlWH3hI/FVteFva4dgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH3DgoPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH3DgoPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2961F00893;
	Sat,  3 Oct 2026 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991221;
	bh=/kq8ZfaExWBESyofTr7doRd2DVJdbmoLB9fqgJqoPjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LH3DgoPBsKWzQvzC1hO0jxy3pzBBWIRoohoDyY+lrgLqtKOJkynYbJr9Il7zJeIsz
	 jN907Dm+OP8tlfaWFS0Mqcywwaz33YB26VG14vgt5vqNsxkbiK+/f1Rif8z++Y38Er
	 Tm6rQejwqxQC9RiaEJlaoVOabw771UwRHbKUZqJcTHm8RJvY/bEwEy5pMBibLgC2qH
	 nriuAHw6v6XtZ3g/WQGfB3Po8IRSyU/WuQuAUPvZCZwbE6AH7zkdxpicdVTlHc+U52
	 FY4JGPFu90re9j5GCrL5dJmRIrlbnwKOg4y4LlC4zrz7CkpEYjnafv43YT34ZIv1Dy
	 t0a5Ob3J6yxTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] perf dso: Allow reading DSO data from an
 explicit file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-perf-symbol-memory-send-v4-2-0a592bb2539e@uber.com>
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-2-0a592bb2539e@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:40 +0000
Message-Id: <20261003013341.5E2961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> The DSO data cache derives the file to open from the DSO's binary type,
> which can resolve to the runtime image rather than the file a symbol
> table was read from. The lazy symbol loader added later in this series
> reads symbol names at string-table offsets in the file the symbol table
> came from. With split debuginfo, the data cache would apply those
> debuginfo offsets to the runtime image.
>=20
> This patch adds dso__data_set_path() so a DSO can be configured to read
> from one exact file while keeping the data cache's descriptor eviction
> and reopening. The path is used only when the data cache opens the file;
> dso__get_filename() and its debuginfo callers are unchanged. Such DSOs
> may be owned privately rather than being part of a dsos collection, so
> the patch also drops the assertion that every opened data DSO is in one.
>=20
> Add a DSO data test that reads through an explicit path, closes the
> descriptor, and reads an uncached offset to exercise reopening.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-perf-symbo=
l-memory-send-v4-0-0a592bb2539e@uber.com?part=3D2

