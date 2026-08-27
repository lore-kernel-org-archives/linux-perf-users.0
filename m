Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26253463B84
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840909; cv=none; b=hN+A010HSy5dMM+dvsSurb7JxpX4K8AISWlapK4vhhBt8qwXvBfjO+Iov8b5tSJnRdBdXf27rgSpwiiKscnLVfRjpOzlwkxiaz3mHQHB64Ycaenckbx9UNWEUzauzu781gY87tjjN8igKHma7pj6/1XXuROXRPEPzd/lGSjlx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840909; c=relaxed/simple;
	bh=GKPWKAx2Ce9cFVIbBwR+PvLny99MBRAKKpnyvNv5qmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S6r3Aa2xL4V6GJjErR1Q9kf/fKC/i6o0tlWLWeJvW10mOc9bIFPCosGiUJagcKZ/G7ByupAaN633cgfpadyLcswHpqy4Dzl4puFYzf2ifkBPVII8uCgiscXr86WSHuaTVX9DnekG7+afauXpnbrj2efRzknMRiSShT8Z9suszds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSEt8LWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSEt8LWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7C01F000E9;
	Thu, 27 Aug 2026 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787840903;
	bh=j9R3r8T6kdR3mi46RIvVT8+9mhwrUSvCrBplIgoCIew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSEt8LWnH6eyVIvGGjFiLrteg6GPNjDgi7e6WUqM5ZwqaLQpdfOx+hEOFI0w8TQdq
	 LxciEANSV8yk5Uu2njFt+UjY9AhDKtTa/0LArbpniQdugMHLTPSokS447Oo5xiGQQy
	 iYBDC9tmmaJ2Ui0QFSfc6f/Zp3ID7iqvqZhPLzezM5KEXLtFI3v8rLZ4dttYIkZ+qM
	 K/CezElivbLAjAm/HOOCTHiqAz7M1/R472cZBtNIGSuCJ7dDw7gYNgWE+g6MGWpto2
	 oiKHQuOsQRdIDqJaV4KRfp8VmxikQrBPv5Nd2GnhPg9iZZ89qSP9qomvlntO9UwufR
	 1sF48GRnPHtVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Skip empty AUX records with only format
 flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260827-perf_core_fix_zero_aux_records-v2-1-c41f2e7d056c@arm.com>
References: <20260827-perf_core_fix_zero_aux_records-v2-1-c41f2e7d056c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:28:22 +0000
Message-Id: <20260827142823.6B7C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_aux_output_end() emits a PERF_RECORD_AUX when the recorded size is
> nonzero or when any flag other than PERF_AUX_FLAG_OVERWRITE is set.
>=20
> PMU format flags describe how an AUX payload is encoded. TRBE driver
> sets PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW for raw trace buffers, causing
> an AUX record to be emitted even when no trace data.
>=20
> This is noticeable when tracing a task with strace. Ptrace stops
> repeatedly end empty AUX transactions, producing many zero-sized
> PERF_RECORD_AUX records. For example:
>=20
>   perf record -e cs_etm//u -m,128M -- strace ls
>=20
>   perf script -D 2>&1 |
>      awk '/PERF_RECORD_AUX offset/ {
> [ ... ]
>=20
> Fixes: 547b60988e63 ("perf: aux: Add flags for the buffer format")
> Reported-by: Tamas Petz <tamas.petz@arm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-perf_core_=
fix_zero_aux_records-v2-1-c41f2e7d056c@arm.com?part=3D1

