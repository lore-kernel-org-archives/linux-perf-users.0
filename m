Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636B3D47A0
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912629; cv=none; b=fONICLrRkzz12DN47UIn9lmkpI1n9i0Rj5X6o2dcL8dkwoc2+Z5L4kKeOo67GnUuUiY1ct1Ky7gXQFejVKQ7Db3oVh5MDC9ItYwSLwHhHRVr+m1ON8xeEJQG/ulpg6rMlc4Hf0ZUivZ71JJaN6XorVF6YdtsnyBIDwVXndAkyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912629; c=relaxed/simple;
	bh=nvcD1y2qKPmlMNgJ2b68R7znl3mXezVbr6lCvWGbvxU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DvJRKlf8IwHqkLbEUwM16Ugj2gQmg2UIglpGZ6eBNCa6fwMyBrnovi/z6qkn66vE35aynQUGkJjfb6+EDVmo4h9zqN6Fpa7BkfOcHEW/rwMEJsiHG8fdiohSEHEUYynSFN+Ty3gGAzFxPLKcfrHR4AiVI4XDoDhZkcLT/tcD3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9TqqdBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9TqqdBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43AC1F000FF;
	Tue, 13 Oct 2026 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912627;
	bh=R6h8ObfBPKTfIOYKMdlGuZiCgfR9sGbOTmZ7zEerkJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9TqqdBFa+6b881csov9ALEt+85g3wFSkqzFh8CfGlFkDKykvOS6eCygfTkMnekHB
	 9DFR3TG1BeWFZ/r1dKpkmnLSZrsGaOjPkDs52EcXYqV0FjrNoKjvz6/8bnlm3jX4FY
	 YWbSyRJhWt2IHjUaFbSekNqF7WAPqlrbTgOlZYPdoZItLpiNUg5YErTtQfuOFEPvRI
	 01iglIKAY3SI5Ma8ErmnMtFEMfycuPAl7/niYjb8B76h2ZMaWSWnYMn9iyrU9NZWCj
	 9r05XTAITKhzjI/afHXjmF39OMEbmy4BfjGw4TeoY3XDql3GpqZCiFOtRr+4LfWxW/
	 nfbRrFaAs70mQ==
Message-ID: <sashiko-outbox-170229@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] perf test: Fix dso data tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-12-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-12-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:30:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now dso__binary_type() requires that the target file is a valid ELF file
> containing ".text" section.  But the test only checks cached read/write
> operation on a file.  Let's set the binary type to bypass the ELF check
> to read/write the file properly.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D11

