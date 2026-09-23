Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39302563298
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188853; cv=none; b=H9uPyyrj/lP50snSnY68BzCEhtrEGC5ETxsADFmP59SovSuLxYDAemxrfH5iEMrfF2T8yq1QukJD4U+aGlrApLCM6oLdfMPb+iwHL2gNHWhB5hF7kFuVDOuOzH7bXtS8H4wqxrZTlVRtvSt8TPQLKaEmFUl0dGlJ/PKHCT8aHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188853; c=relaxed/simple;
	bh=C0UYnRrEBI3JhAt/wMbdFIDA0RDQwREsGYMSi6oNo+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=om8797Rx/pRF9Freou5KUWaIt/cdCVZyJemR1VLtev787t6CG+raF5XEXNV6982EqipkB2qtRtisVBakgzJVWaT2Z7FgKZ2w6y2dGTMT/qX7T/AWovLlGSAB826C4o3ZnNJF1rHf0e6qaOIyuo5ZTSpoxGTp+BnDeqChrlGwo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMW7TfTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMW7TfTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB61F000FF;
	Wed, 23 Sep 2026 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188845;
	bh=xWMrymtxrhbKsVeQHxVB5CC7A7SmrWo0xLmqrIVBMWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMW7TfTjIGseOxEd31kzeqFdJn42G7cKSOMjUvKNLWEejHpKCOVWrtOrorEqyQZ3c
	 tQJ/9xL9lbnlFEcaO2aUBf4S1zdQOz9Gb1YZwz9IJf27EFnxlUS5cjUGp0oEj3eCL/
	 INt4L4ePkQ9fsKCPhjILCwN1ejYCF7+C2Inc22AcSMqa4LXpAAeHg6h2hAcbP4yryP
	 BCF9T3TBOJudIRwajb7lYyrU44uKIjwDTOjwUrMquH/mHuHTV9ByIv72XA2+eZDAGd
	 IL5rgeHmOjzsyfxIkRNx7xPaaRm/W5gefxtVUGjKSNnJZLvvRqB83f6QVjweSFKHZV
	 RAdIWGh5zczvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 40/49] perf python: Port intel-pt-events and libxed
 to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-41-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:40:45 +0000
Message-Id: <20260923184045.67DB61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port intel-pt-events.py and libxed.py from tools/perf/scripts/python/
> to standalone modules in tools/perf/python/:
> - Refactor intel-pt-events.py into an IntelPTAnalyzer class with full
>   type annotations to encapsulate trace state and stashed output.
> - Configure instruction trace decoding directly via perf.session's
>   itrace option and context_switch callback.
> - Dynamically select 32-bit vs 64-bit disassembly mode in libxed.py
>   using session.is_64_bit and annotate instructions with source lines
>   via sample.srccode().
> - Rename methods in libxed.py to snake_case (instruction, set_mode,
>   disassemble_one) and remove Python 2 compatibility code.
>=20
> Add a shell test (test_intel_pt_events_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D40

