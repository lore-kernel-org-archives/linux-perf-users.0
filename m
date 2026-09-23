Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98395379C56
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187990; cv=none; b=ehQZ1qjnFAJbploiTP/Zwbbje8mzi9z7g2DYFWbdFxb5eRGe4EjJnxrH+HKSOQLlPhTUalGHQfNkiWP8KsnMV8zvKq3IM38xWdJDjDdrdHakxsy2pVtbsBc5rVjEht+HUOMStj1xovzD/LjjBCvZA12RdGEusO8QufC3nThVoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187990; c=relaxed/simple;
	bh=Z1Jz4lVhGe5toj0sD4afGOi8jApg4a/kYuemlEisrPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mm4UWXRJAjOdx50OeKFatWXBgbHjHORj68u2HBY/Er/QedTxn6ZtV79YUqAHR6xJrgNiQ6pTHYispsO3ncvXGdz9OWLgc06wVXDlhXpxEtYOy4s8n+BNfdZKFgZWc5omS1aT+7JoaO3FDi76DW772CmawiiQlSSRLcNEa/rsXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op457Kgn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op457Kgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6EA1F000FF;
	Wed, 23 Sep 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187989;
	bh=GG1pkZTtZsAPTx9d4CHPyj6zvYjaOBZoaM/vUX/XoW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Op457KgnYSW9aB2FaPAUKwj+tc/PkYZs6kE2+t9ZyVZYw7fOODgT4loA+h1KfKqsb
	 LgQWIJg11D38dmpUYJU/+ormDAv6uFp0KUbDSuegRUA1Cr1sEvRoMChPuIzXXjyyo3
	 sImxA2OhlJ3YroHHUnKEQOHQ8MBHbOX7Dm9AYXxjgLxMBLbuQU3T7QeomKleUncwyr
	 IpsK6ZOZshuF5kB8MRNEpTKxhwsufeTXECF6N+k+X2YbA8w4TaGgRLAUU4T1rijoCu
	 b+OOZl6PlypY5t/Bne4MptkPe1ynyfmkwv7NdiURDg/igzqN3SgYSRW84Bxahrf6qc
	 zEaubY8/l+K3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/49] perf python: Port mem-phys-addr to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-18-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:26:28 +0000
Message-Id: <20260923182629.5D6EA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port mem-phys-addr.py to a standalone script in tools/perf/python/
> using the perf.session API to read perf.data files and profile physical
> memory access types against /proc/iomem.
>=20
> Improvements compared to the legacy script:
> - Parse the full indentation hierarchy of /proc/iomem into a parent-child
>   tree of frozen IomemEntry dataclasses (instead of only top-level
>   indent-0 ranges), resolving physical addresses to the most specific
>   sub-range (such as Kernel code/data/bss inside System RAM) and rolling
>   child counts up into parent totals.
> - Support profiling multiple memory events in a single perf.data session
>   (keyed by evsel name) instead of assuming a single global event.
> - Add argparse CLI options (-i/--input and --iomem to allow supplying an
>   offline /proc/iomem snapshot from a target system).
>=20
> Add a shell test (test_mem_phys_addr_python.sh) to verify the standalone
> script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D17

