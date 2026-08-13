Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DB3043DB
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582769; cv=none; b=m04FM4wMoQW7BuQ2ADHe/SxfYC2QyWSm+K/tvjmDFn/qM9/0nSqO179EemKpMLppSqj1S6bUeYd/tyUKDiLkDfGM8x+w/PoyG9xigqL4528LVdOvtbvy2ge7yg2mH/VZ8Ya9/kUiJkwneBIpKtBJyKKJZ1GVv6Qj7sQrxwki+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582769; c=relaxed/simple;
	bh=Pog9RmunJd/6KaNafVYMaI/4pWwVFkSXNvaAoLfye74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BpdW3pAhTNlVXgrC/Dfv16a1SDeZB4hs66iwOonm1gmlhov1A4OIFDNfT4dshRPXrbvAsCBc8xPITTTxFGFixJFxFCgENoL9vyoN89Lv/fKGvnV62eaw+diOkeISQzWgVVsllgpWCPJRnOjeFuBcj5coTPh3fVNtgCv2lHFltKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThYRzDYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThYRzDYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555DA1F000E9;
	Thu, 13 Aug 2026 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582768;
	bh=IbeCCa4nr/Zmdc4hwnc/iaUqId8QE4Q85JPBafv4JDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThYRzDYy1HD+F2FrAlZPhNSysXLSY2+1IYYv0YltE2HzIf1GcG8Yxo00m4tHW+Ifu
	 ZUfmqY8O4I4H9N6bMQZzTATqvHrtIbnDkfRdkITwC7aS61SXSAij8EAs8lMjKhKKTz
	 qK3w+xcxq9vT/snOQJ5C3dds6MS4304kU9Ow1k7JPlneamBjloE5sFRht/LVyJWTpN
	 b7A4ex6nyNVOKpeNL9dCMO7p1jHsjlLa/M5sZru9CtMyIBvRhcMNVj+tlnzct8Ajqf
	 cvSD25muUSQalyw9Oh7mbMjzLhl+cF5Yu9Sz3wbXF9pI8v4Tg9qkI2iQ4wRUQffeRv
	 RK3JRoWVgGZkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf dso: Replace assert with runtime check in
 dso__read_symbol()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813004927.16738-6-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
 <20260813004927.16738-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:59:27 +0000
Message-Id: <20260813005928.555DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dso__read_symbol() asserts that len <=3D jited_prog_len, where len comes
> from sym->end - sym->start (parsed from PERF_RECORD_KSYMBOL in
> perf.data).  Both values originate from untrusted file input.
>=20
> With NDEBUG (production builds), the assert is compiled out, allowing
> an out-of-bounds heap read when the BPF program buffer is accessed.
> Without NDEBUG, a crafted perf.data crashes perf with an assertion
> failure.
>=20
> Replace the assert with a runtime bounds check that returns NULL with
> an appropriate error code, matching the existing error handling
> pattern in this function.
>=20
> Fixes: aa04707f507e ("perf dso: Support BPF programs in dso__read_symbol(=
)")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Song Liu <song@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813004927.1673=
8-1-acme@kernel.org?part=3D5

