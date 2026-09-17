Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA34EFFBD
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661135; cv=none; b=Gz2vAAKM/NIUr76biguKqSbwwjH/AXGaEMPJrEdIeV52xGkzzNIUwog4oaYzUD7+qGoWAYjmYU9Limq7JQZWRrhv8bAJmRvMGcCyGwUo5wcqqbTQfmEtH0Z4zgnHGNCz9x6KZmPj4hi2H5ZETkkxngxa/2Sz7pMljsyIfj1+3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661135; c=relaxed/simple;
	bh=nZdF6VpzJFFBpihI6QdHcpb5wE1604H9JHolpk3SrtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NR0qdlVUgHLmhIPX2IePpwI3YnndJDDceUwCG9Xkz/PB1FrfGRWfun/bqIFBtVR8ckOMJfoDMiixtHfb1rV/vxZ947qXG6dwKJ04dtVXu7UkxDDWPD+miyY2n24kvwcic9m0HnFRWGHDLbNEuUMRMTLhai8GJKPIg4yY8d7WGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imh9ehm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imh9ehm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501551F00893;
	Thu, 17 Sep 2026 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661133;
	bh=FI8Z9FHHLLoFDtPRSnlBMi0RMe0up0lVxbw1FRv+rwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imh9ehm90Q8+bE4Ht/gnhWe68T7ohA6p7/WslvzwEsgmSoF0FpW4ME3EVPcPOuEkr
	 37iT2tqvH8jUa67sLOloK6IvfcNOf8CRcQMwMf/IBbt2mn4Xix0HuJMVm2RCXtYtSj
	 FFYneMNeHMVUytFYQcm3NjjQCkAD+5lb33/9aP4kTxYywtEO1f2gRm0VCW4PYPf+8W
	 0FFbiYnFAkKsEe8LT63oprtTtRAkNRVo/8HhJ9BsWE2ZtpfqV6LBY/4pVMC+x58QGI
	 X1drGyQr/dd9rty18Jb01fiVdqfYO+dsbjDqbFyiK5I/cII5ewC0jccyD1P3b6e16a
	 X1CL+Rw00H8rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] perf debuginfo: Let the user skip and disable
 debuginfod fetches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-5-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:05:32 +0000
Message-Id: <20260917160533.501551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> In the stdio case, while a fetch is in progress: 's' aborts it through
> the debuginfod client's progress callback and remembers the build ID, so
> that the rest of the session does not ask for it again; 'd' additionally
> disables debuginfod for the session, emptying the DEBUGINFOD_URLS copy
> perf owns (libdwfl's own client reads it in every query) and writing
> core.debuginfod=3Dfalse to the config file with
> perf_config__set_variable().  SIGINT, SIGQUIT and SIGTERM are
> intercepted while the terminal is in raw mode and re-raised after it is
> restored.
>=20
> The keys are drained with read()s that do not block: the terminal is in
> raw mode with VMIN and VTIME zero, so read() returns zero when nothing
> was typed and the callback returns to the client, which carries on with
> the fetch.  In the TUI nothing is shown yet, that comes in the next
> patch.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D4

