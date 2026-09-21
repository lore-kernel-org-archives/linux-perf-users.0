Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B078F3A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969306; cv=none; b=bzEPPdoMFPPkEo7CxT6BPWX9lKWsPLmgKBsQqtoq45m+Q2SICAqx4cKnl9od68lsnn3ZxFCDfL22uuzuMMR9xqBJAxZa3ut1HpLLbTpdyKUj3i9MPYrQWjS750I5yXOfCV5ktQjx9PtyHlEVkuprvy8P5Q3AHdiXDWrPn/Y2/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969306; c=relaxed/simple;
	bh=OWyBCse120iohgCN2SN9NjzvRSHSc4gTSDvRFAdd8B0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSJwOSx/wH+I8faMIgxBPJuPySXXIcOQYlXGE+gE1artPBdO2EqMbFlXFCg579vWhXAjTVz0y2tqVT6KrjeYqcAJIKNY8g1sc3ncXHq8+dKroERhl/MMoq/KyxbJWaHTYzh4hGmeLobud90hIcEYUqlMrgHaEn7Xy4Jd5NFQkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDfK+8hQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDfK+8hQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139201F000FF;
	Mon, 21 Sep 2026 05:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969305;
	bh=3Ntb9yxhWK1NFANVR5ZTnf0qu8OXv6KXq4o/Yies3ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDfK+8hQWYhJliJyx4C9j4ck2069fJ+yFb07+uv/8wbl/UtNhYzWbxni12OiWDk62
	 lWR6VFI1udEhNrBvlbtXw8pVtIFhKASwXN8amMpoxKjS+fCuYk02DLQkrQ86GYIbe6
	 xmZFj2c3Fpsk6Mpr506N617BV7Lp9+8q+LDeeaxRzeHN/S05/cG/6KGTU9WyIWGLAr
	 n7NHdTwEtr5s6vY03DzdRwSch1eCaHr2Auhnp3dbIKG3+AycC4bxNOi7JojcGS+yam
	 o4/ezIHbxmJ7FFyhQ4UhyXGe6f6vb2zWTEneuQ34EX/acwCXmLJMYj6TRTdFEf5cgC
	 lJh4VA2veuSRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 34/49] perf python: Port compaction-times to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f0f213baa26426d26a0254497c140546d81542c8.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <f0f213baa26426d26a0254497c140546d81542c8.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:41:44 +0000
Message-Id: <20260921054145.139201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port compaction-times.py to a standalone script in tools/perf/python/
> using the perf module directly to analyze mm_compaction tracepoints.
>=20
> Improvements compared to the legacy script:
> - Replace Python 2 constructs (such as sys.maxint and raw integer
>   bitmasks) with Python 3 enum.IntEnum (Popt) and enum.IntFlag (Topt)
>   types.
> - Access tracepoint fields directly on perf.sample_event and add
>   -i/--input CLI option support via argparse.
> - Add full type annotations passing mypy and pylint without suppression
>   comments.
>=20
> Add a shell test (test_compaction_times_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D34

