Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1140862C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188947; cv=none; b=a0nL3W+unGZL01u+qknUXFDY4lkV9uxZMVhzG1IXXEQYeQl7lcfm4ox2Vdxq1xqpFBSfhn8EAPa5L34XbHx3Xeai9pNkQLLeVJxYp/tL96joPSVs9a63t0Qw8axWYAYP9LSbvOvu4I852Nfj7P8tMbPSfJ2zESPDktbtJto9XPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188947; c=relaxed/simple;
	bh=Zw33extgXpcpvAS3lQRBlSvSHViquyVru8LQccJuvUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTYrX7l0wmEo0OkehotoiTVaNU7unwlGRUH2PsovO2qSSEOtSv5QcttCsGQCLJFzfXwBGFu2YXzvrtE1s9vCFJ3vkWXq5y7PIPrdg+CvDxbjAAR13TKAOl0D3oE792C+IKqOo7ZQDjIzyrL0pXxbssegUNoyCzx4XlsaH/GrRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ4XME3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ4XME3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1AE1F000FF;
	Wed, 23 Sep 2026 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188945;
	bh=ddfV5mDAzIAP+AzI1HM39nB5ScCascCAZMOCdL6ar0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZ4XME3boyVEcqwzcO27ud+LI2pzC6SmBdrCIaZSiT/2+GTm4PfVF31BIGGKVcHJ4
	 hp2nvlYKAuVnVKkYNSp/gP1T6+Jg7GvNg5sOeAi5NwU7Fi3nDqJ92QYofmAm9A76Ro
	 V7Mb+7lGJ6bdPpan5RwRAjJoYf9rofPSuXCH9y9MrZ9i9d1M8ByArY4NPi8XNjItav
	 2TnukRLcS8VE884Na1Ltqh+CvWgymxTckV1kBQg3de0gkXO1p3FpVyeL/MEmVOzwOh
	 dyExMv5fZry+64wk3/qYSEap7fpnQ7gLZGSoXcLZiFXuVNW6/oVNUi40II3x+xemOE
	 aVizp6xNJSOSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 42/49] perf python: Port export-to-sqlite to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-43-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-43-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:42:25 +0000
Message-Id: <20260923184225.AF1AE1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D42

