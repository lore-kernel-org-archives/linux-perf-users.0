Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB338B14C
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404701; cv=none; b=dX5orFYGWQE1ihwqD14/gRo5NuBF/M6Yf5SooGLNskL79Fc/Z4n5EjgpowWu1fcC5HZHsHC1RedIX/wX92jEsAb/v0pB3MvIqc6lw2kI1V+TL93ZujCCg5TCyJgVk/nUTvWYMAGO8d+g7Uk25i6zekqrPHeERKyvrQiHptTIHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404701; c=relaxed/simple;
	bh=UL/iytY1xA8puU30HoVmCX87lPmsEdDwCoW+fWuGLek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JbEx9RflVuim1lp2eXG1hurIkUmTB7P/axJ3EcSErQ/hLmifvuNDb1jTR1jx/rs0Mo4fAXE2LyvKE9+S3RuWxw7TFDwqzxb6+oB9sz+bcgZ97yTtPCKoC+sRXz1BsJkQAksJPjI8ALYfmb6Rz62OXSTeyDgwXft3aXdu+ij1vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmfv6HzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmfv6HzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC951F000FF;
	Sat, 26 Sep 2026 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404700;
	bh=8Awv3Af+F4sH6Y5JD3TXPghkd3Rs6KNUaIcmjimf3d8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nmfv6HzVmFzcJIH0KGLT1wSPhcegmJaSHX8RHB07YegrS31EnfpEOs1CJ/EdzBEST
	 /YoL9KSHts22+uzsN5MdwH8i6CqIbtDHFJ7xQ4tQ/bCJqh0LVRe9JDAkGBthoz6k+e
	 yBZc3fRkNhILLD64iHkEvWnToAseZ5fU151rNdEho+2o0repmd2w1DGME2bwaBp4BA
	 M9LQdPBdujhqmBnwNKebmdi1126gqMqNNI2cD+03+hinTuGeX/8ntE+UAZzgjpz2BR
	 IeBeABmts8ZuYI5bouWhn2s8ydDHFBp8NyeQnwKFYOuUcuW6n4pzs7mo17ENVRHsYE
	 6dqPclhuzMtuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 42/49] perf python: Port export-to-sqlite to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-43-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-43-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:38:19 +0000
Message-Id: <20260926063819.EEC951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port export-to-sqlite.py to a standalone script in tools/perf/python/
> using the perf module and Python's standard library sqlite3 module.
>=20
> Improvements compared to the legacy script:
> - Remove the dependency on PySide/QtSql by using Python's built-in
>   sqlite3 module in DatabaseExporter, allowing SQLite export on headless
>   and minimal systems without Qt installed.
> - Support Intel PT and hardware instruction trace export via
>   perf.session(itrace=3D...) and perf.call_return callbacks, reconstructi=
ng
>   relational call_paths and calls tables and decoding synthesized PT
>   payloads (ptwrite, cbr, mwait, pwre, exstop, pwrx).
> - Export context_switches via perf.session's context_switch callback
>   and map thread and comm IDs to their relational database keys.
> - Manage temporary staging files inside an isolated tempfile.mkdtemp()
>   directory with guaranteed cleanup in a finally block.
>=20
> Update Documentation/db-export.txt and add a shell test
> (test_export_to_sqlite_python.sh) to verify the standalone exporter.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D42

