Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93233469FC
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305717; cv=none; b=WiRTiQ8dmRZNI0rlSdDSWGZVK0kjrFZMGyGSyRxp4dfbBWVPPFr7YnwZoVMF+5TyJOWQYDaWAchhSGvknceF7bpRAMB0hCqJVApR2/4qOdsm5COImmiVWaxddG0yzQr3tl93WXD1smcQwFrJJkz0FvorNR/nJNe3GtsxKcpajOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305717; c=relaxed/simple;
	bh=IbrcoJZR8/+k70Rlh6uohsZ33pTVmh9toKGtEVib0L0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f675Axvbm9EcrLt1U239pDGJi+EUi23clygya2Bbc1hDN4h9Q4E1igK6W2fg8WMx9oJ96eziusCZSm2b33CvYozccVzWHTxvxH98PJ+axgyfg1eU4pxKc4BUJc4Tsb7p7/p5nGIN7JsbuHBJNKQDrlD3iw14+tcyJpAEa8ob3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q80h6mKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q80h6mKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD8E1F000E9;
	Wed, 20 May 2026 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779305715;
	bh=zfqtjfaUqnJlDl/n6ovdOjntE0WYwVAE+a2GSDcQfFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q80h6mKVS7+5toBIjFLo1ZqwQ2vj4/ZjkWGTMTHSKinK5JPSWWD7yVCO+Ks8ILfDb
	 0Xe+CEV4k7lc8/cHOovCfzTw45ARFSR/QH+JHawggF4pAk2KOI5MCNfgzg5tArj9tH
	 R8SWsreSfb9C4Z0HLzCsTi4bWeq+bHGP3Vp5SlXIma82irUii/XK4/OoMsqyh4mWmz
	 37pTNlLQaMma5dmZC9E3fypWxrkmSyIHj8ig6zvkws+YrPUPtK03Gni5itpFj7hEtR
	 a57GeDr/j76YDCPvDfMaxNyl4Ha5JK5JoffOk1d0LdedLm6QmStCBMY5hiMmLBSiIj
	 nzGEXPLSAG/MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 16/32] perf timechart: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-17-irogers@google.com>
References: <20260520190538.142018-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:35:14 +0000
Message-Id: <20260520193515.6AD8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Freeing the memstream buffer before calling fclose() causes use-af=
ter-free and heap corruption.
--

commit e026d352d2888e166740c26a9158bb9831a672e5
Author: Ian Rogers <irogers@google.com>

perf timechart: Don't pass evsel with sample

This commit removes the redundant evsel parameter from timechart-specific
handlers and structures. Since the perf_sample struct now contains its own
resolved evsel pointer, the tool can directly access it, simplifying the API
and eliminating the risk of passing inconsistent evsels.

> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 034e0ba3f9cbc..1d24d8738519e 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -567,7 +567,6 @@ static const char *cat_backtrace(union perf_event *ev=
ent,
>  }

[Severity: High]
This is a pre-existing issue, but can this cause a use-after-free and heap
corruption when the callchain context is invalid?

Looking at cat_backtrace() earlier in this file, if an invalid callchain
context is encountered, the code directly frees the stream's internal
buffer:

    zfree(&p);
    goto exit;

And at the exit label, it calls:

exit:
    ...
    fclose(f);

In the open_memstream implementation, the buffer pointer p is allocated and
assigned upon stream initialization. Freeing it before calling fclose() mea=
ns
fclose() will attempt to flush the stream and write a terminating null byte
to the internal buffer, which has already been freed.

Could this write-after-free corrupt the heap? Should the buffer be freed
after the stream is closed?

> =20
>  typedef int (*tracepoint_handler)(struct timechart *tchart,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  const char *backtrace);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D16
