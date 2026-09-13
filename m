Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC03009E2
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338921; cv=none; b=pxeohedQbBMBvkBfVcYooLTH/3EkywZwfwTvwzwOGgSVYkHwddHmqujaZ4x9R5eyBiWvmgipiWCOM9Pz8qt9emumMoXn7y0d5dsS+8bS1n/HnapxM43Dzm53/eO9Y0oetjCHEJpSTiPFo8REPhEtg5Oyf3zHut8ev8zLkohhCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338921; c=relaxed/simple;
	bh=os0WYR391SucBzXSRyzeZ4B8EGogSKVG0GOwVbMg5xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5pEX/Wh7sVRKIk8zASOde6bbQNfkAVJGxRrwRNji4nBB30U530RXDsBFNJ2gXQ8SZOYjcW2Eg/Gve6V1PPm4PVVq+6+3/AR4A9IeA9c0CakfbhtYFEaFx/V+sYJLJuk/I0TYAbDWTfDGySFFMzvyk67uE5CURdj+BloUd/wkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDNTH7jN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDNTH7jN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF91F000FF;
	Sun, 13 Sep 2026 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338919;
	bh=os0WYR391SucBzXSRyzeZ4B8EGogSKVG0GOwVbMg5xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDNTH7jNwqV5CCGgJeP1YBvLcB2Ub+xlEzdzRdiBN5bCrfFXpKJxtLDy9EDtSicWl
	 lNa5xSBOuVi1zexAivVsK8jeJ/ruvcKgGgkxeByuvXW/hcjnIlqAXAZyUl25T7c5+C
	 1kc4Zg5wWSsh+MnXoPJfftChTigcrT6IMvX7dhfFDRwX8eMEL0fy69d80q5LJTwagg
	 m0dlkHDttuIjZyu+yNklvILuZpEvtH0vH5NCRekKxywXL4zZXMI8lcN/nvrqL/5wuJ
	 xHj3C7GVdgrA+pF8+a+a65T7nInA3ILdJjyEG9pxd3XQllgJh7J153aNa0+bLb0VtO
	 cemJ6FRrUoDig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-5-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:35:18 +0000
Message-Id: <20260913223519.1CBF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data-type browser has a samples view, selected with -n (or with
> annotate.show_nr_samples), in which browser__write_overhead() prints a
> local nr_samples variable that is initialized to zero and never
> updated, so every member is listed as having no samples while the
> period and percent columns for the same entry are filled in.
>=20
> Print the histogram entry's own count instead.
>=20
> This predates the load/store counter split, so fix it ahead of that
> patch: the split then only has to adapt a line that is already correct,
> and this fix can be picked on its own.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D4

