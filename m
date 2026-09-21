Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305F242D89
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968616; cv=none; b=lvo8TgqXcqcnuCVna8q+DGhrxqTOnWHUDjYiImR4GvULYxjuHafQKmXia+LcWs493YCEQG8BtG5UEZhCpERNnWY8BehZESksuV/vZJHLcwutYQ+tetWZKnbP1vmYCaw8ixcj4pxUDIJBmgoKgqwGvcfUFH63nz7RVm73xpvYeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968616; c=relaxed/simple;
	bh=meaZjmYjsuneUt8+R64X9a4CAB+isnhwxfRxhXM2vk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eTEHdqdwtTgqWUzUyPuvWAOUTOJFl8LE9clD21DewbixHMsM510CkoQMDkiQSKYd/DuyBsU+XTb4JsquGYFL5SjO3QhUTcBt5eraFjSbvxOQvvSP2hn2wc9eOyk0yBQ+Q9lTUCxyuUyqTaGRQrTJ4Syr+I6tPvE4tENEBGKSsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7k6nngd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7k6nngd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2341F00893;
	Mon, 21 Sep 2026 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968615;
	bh=bvzIHqaTRx9Ld6bZ1JUU4HeA/wwn+jYxKSPA+RhMCD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7k6nngdDcbCebLmATQT0xUzxmaVctwHcL3hv8sJC61gV05+zCi7YekS0jVyyPb7E
	 /3iJI8jDEIhzrgJeAmit5tYE1pa2HPcrX2TLtgWYqwf19D13sFTsJ7jxZOgCg8zLqy
	 DinIHH2yMxW2YbEw7TsYzFV4CCgWLcGf6j+p75VYIXBfsLSzFGC89DOE/PUCmiZC1M
	 RJg2TsAPEwYuvjTiw+IZHKg7yfx8u5Jh/bqWT1RHUDfKnieei/wOPQuaP4+tG2ITe7
	 Dk+Efpjsal5fOJFvVf2GjXF2nSBhat/uO+DpIreDtLL4c1ApwXRL0XKIyyIy19dvub
	 ym03C+63SxeEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/49] perf python: Port mem-phys-addr to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ffa61f429eb4e3032934c12a053488dc735bbf84.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <ffa61f429eb4e3032934c12a053488dc735bbf84.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:30:14 +0000
Message-Id: <20260921053014.DA2341F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D17

