Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9338E5D7
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404488; cv=none; b=olBd0VRasshTmQyTf3IQ58cNMk8r3hU5pmoMwvjy+47ro39PiuzU1Z6d8Lw2Uw9FIYcZajyGKsZiGWj/MO5A5quIFBsYwKLg81xLAuwCPgXCmkslvs1H2ryEbPusxX7d21aqN1hAQoMhJSJGRPTI3naakcgi5yrkgCnw+0wfZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404488; c=relaxed/simple;
	bh=9fuTJCNvg62qqc4mj0LatWk0oAUCg6bq3vaMmWCtFRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3kwU8nqe+jNVCT10oDRP2PEqM9MD7hyBwQgcDzryX6roIL2iI1DVLeHa7znrxP1Uwr9vmNsRLqLTLfHkErqMxyPTM4WoeUDd02KVYEIgKajZ23R1jUUqfRI+UE1nXUQKv1MJuAXk+UF5cPqvr5aesD/hu6M46NJdrwsEGnkveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keVE+VLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keVE+VLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FCB1F0089F;
	Sat, 26 Sep 2026 06:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404486;
	bh=eIbIa8IRMZp2utvQLCuCnhepTajgnXGPgEyvCkbR3/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keVE+VLVGfJZ9MsicSDHzoDAbYw7Nvy/ZH9twdTD+gjUwEMx4ilVlwZaQ1f5U7Xgw
	 BJExTdO6tkSTWi87zBvi1d+XhnVs9U6OiZ50aZaVF3Z/y6z5kuH5jyiwfEe+UYIKpT
	 WDrSobIf+iIsMRW/BKeF7KvJ2Iy+73YAzyj1jpK9B0XRkJ6OC+cnXE6kRoSNrZVu6r
	 4A6lLCCDfQSBfF9KyWDWaz2vWHRl7dHN/FfxYlcF2QZpAqYJRc79oHnjX/qqPA1DFg
	 a5/8LylboUIA2PqfRC6vojSXF1N+dSDsIlbTvxIow+VpqihXbq4hbfGdVlvssHi2wW
	 dVety0OgwC/Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 28/49] perf python: Port rw-by-pid from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-29-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:34:45 +0000
Message-Id: <20260926063446.12FCB1F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-pid.pl with a standalone Python
> script in tools/perf/python/rw-by-pid.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Convert unsigned 32-bit and 64-bit error return values
>   (0xfffff000..0xffffffff and >=3D 0x8000000000000000) to negative errnos
>   so failed read/write syscalls are recorded in the error table rather
>   than inflating bytes_read / bytes_written.
> - Add argparse CLI support (-i/--input) and full type annotations.
>=20
> Add a shell test
> (test_rw_by_pid_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D28

