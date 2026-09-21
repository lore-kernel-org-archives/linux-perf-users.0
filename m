Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6759356771
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969300; cv=none; b=EiQYvUTfapvJ6TqdIiY/cJBMhl04z1fyly1QAuay14cWGfOkAJop5tLd43xOw+OLyIrAyGsTPJ2hfXf+fJkGgisBBMVPOk20E+q3dPiED6+D7yMuiwk7kil0o/iLNjFZikedlDy+q7BDZFZx/SdLE41lMgTiAxsFd8gidxTYs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969300; c=relaxed/simple;
	bh=0DSO5Pe+C6UYgjyc0FMM+Ui0YTsjyVlbD/1elfLZuIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfLOuEeTrrcOv3eJsHLfHHFeDABjpPU9TB6T6YC/U7yZ5QT02dPva0mAJMQLqctI6IeqztSodpuwwhTeEh/8e1og+LHtoWLsbHjZAstoYQmEhod3MR5SJgr0lGEkOu6lQ6DinLMzUBgV1oJI9PwdxByKsy955qM0D/cLdvn6How=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7AHLdCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7AHLdCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C661F000FF;
	Mon, 21 Sep 2026 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969299;
	bh=P5WQATRhBL8/8GEYc4dQz76AGQZ52JGjWdIduB8YgjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7AHLdCBF7fAtdGCLXtap0Jpp0iNGPE+WlPNDWdP2EpOUmWEbsGqm0Sy0d+y9Eq1l
	 qlcTkMg3r8L3FfURXbtMruPmnnWQ9SA34wnaGMdho871iZnkIT+wHsnp/3V30TkbcM
	 u3P5J6O9qKwg2ZTLmxHR4QWCCFxhf9UCfMxPXiSLRYk6gIrxULvDbmh0T1g9SDnex6
	 xAOfArRdK2sQgSb7r6bKGzX37NevWbIWPWeuKoZkeoPWSTXWV45FyNeTqwAg08t2XP
	 58zYeIzrxvt49oNljwlvqi4brauBm/FDX9HRFuuCdYj7kcn6MuhGN8eWXSvhY1AqGl
	 CVAvjJwUno9Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 39/49] perf python: Port powerpc-hcalls to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <50af27df3c43bc14dea870adbac3aafadfa008a1.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <50af27df3c43bc14dea870adbac3aafadfa008a1.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:41:38 +0000
Message-Id: <20260921054139.43C661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port powerpc-hcalls.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/:
> - Refactor the script into an HCallAnalyzer class with full type
>   annotations to encapsulate per-CPU hypervisor call entry/exit state.
> - Use perf.session for event processing to track hypervisor call entry
>   and exit timestamps and aggregate min/max/average duration statistics
>   against HCALL_TABLE.
> - Add argparse CLI support (-i/--input) and remove Python 2
>   compatibility code.
>=20
> Add a shell test (test_powerpc_hcalls_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D39

