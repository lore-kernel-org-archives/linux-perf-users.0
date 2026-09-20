Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75D3C4565
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882275; cv=none; b=tbh8img15or92fSx03ITVXvpCzZwYbCLbUthNbLM5fWRSOLGWDMv0OwLjt7OEFgI9XMRoXkCpF9BenvYwn1CWo3rUclY4ONB3L/uzTVUarjsQnn6ukj6ludpNqu9Q2RKOGlS5Jk0CJKbFaS4oBPfJ/0tPmibO+BziigDz0+0L94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882275; c=relaxed/simple;
	bh=RAu+mWp6ICcQBQxzSe2el5KdEgNDiJLPXAAC4Pmm2So=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TlebsfP+qewtLU5QkMIKH1kZQPfVNyDMahzoK5bLrDeLb5FFgIxij7YYy+vPvbaU6E2SCtaMg9ZLoa2uF3Sm4n98jmIGC3xcQqqR50od726PcUQGEUD7UBt2SSd/TCiInrlfxCgryIXmu77Ljx3e42IdRqP2ItYoUSY/Hig5L40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvB7rR+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvB7rR+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7351F000FF;
	Sun, 20 Sep 2026 05:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882273;
	bh=UL5BiaGSxiQDV5G2/S+RGtGUm5dEhqC12yCpQy+La28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvB7rR+dMDhbl+JazzhnMSVpq168ANXR1fjdOYSJ4NA9S4IO9F7l6KCwGs7MeVpzu
	 4hncHUrPedyECPqowecWpypX37boxw4OLqQq29DmHNJjYVdWHbvqSafVUL8IEg/KzF
	 g59UNlsHWF0IDLKQaEIqTn+CONaT14qrNkHBA0uFA4g4qzPf7l/n6uZoigbvn5pfSX
	 x/87qcAPl7hX9awLhTSLNV/UZk7+YcOvSJNwJQdf0IozAp21iQo3iCm1EciaBTlTcc
	 OnCYx8zY/7WmLa1o47Yk53GGXh1VZAzuvfwuXgNuMAtKDPvBSaKKQZTT7RDhtfiKBy
	 K+0tgtNy7Sycg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 20/49] perf python: Port gecko to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <186dbfe365f1105bedff503e44eda595ca2a3a2f.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <186dbfe365f1105bedff503e44eda595ca2a3a2f.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:31:12 +0000
Message-Id: <20260920053113.5F7351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port gecko.py to a standalone script in tools/perf/python/ that uses
> the perf module directly to convert perf.data profiles into Firefox
> Gecko profile format.
>=20
> Improvements compared to the legacy script:
> - Encapsulate profiler state in GeckoCLI and CategoryData classes with
>   full type annotations, removing global variables.
> - Harden the local HTTP server in _write_and_launch(): write the
>   temporary profile to an isolated tempfile.TemporaryDirectory() with a
>   randomized UUID filename instead of the current working directory,
>   bind HTTPServer exclusively to 127.0.0.1 on an OS-assigned ephemeral
>   port (0), restrict CORS Access-Control-Allow-Origin to
>   'https://profiler.firefox.com' instead of '*', and restrict HTTP GET
>   requests exclusively to the randomized profile filename (returning
>   HTTP 403 for directory listings and any other path).
> - Add -i/--input and -e/--event CLI options via argparse.
>=20
> Add a shell test (test_gecko_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D20

