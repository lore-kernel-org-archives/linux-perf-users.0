Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3873A9630
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562376; cv=none; b=gmNThuONcdfp3ElTZ97wSFlDE7fY1JlkMcCFwgmDLqv+hyrwzcd/fcWneCP0klH9u5uSvKN9HThzM1tzytuHHsQV/WGnISjL8iKskAMWnGfZsw3essLjbw/m4x9QC0k3YM6EUYlj0++/RgkeNfpgZM/GgORGapiywVcHmivK1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562376; c=relaxed/simple;
	bh=LJpj1PnQwNhmuxUpZJfJrnizhShfhA0kVDmQY+b6ELc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kkLhIXbnDLeMqZVMVROf7Ad8R/1vMJZpfHw0gmSLns7U09wNbtjh4xJpqxaXwfKm2SMGSLWMjUZPdESe+vmZRS9YqQT6/VHBsi5r6WhF9lzRp018uV5Zl8lwb/6BFKV0xSSv4Ey7YCWSsq5YBBy/kWDpxTPUalAFmqOI9XZnPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFmdhfRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFmdhfRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9809B1F000E9;
	Mon, 24 Aug 2026 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787562374;
	bh=LJpj1PnQwNhmuxUpZJfJrnizhShfhA0kVDmQY+b6ELc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MFmdhfRK7KYE7B1rWsV2Ed6ufTByrfE3iKmtu+HKpMYltG4r92c2boyVNmyJUf5XN
	 AF/f39eTLRNm4lb0ZhSlNR2PiDbaIbTRs566W/eHfMkonKOFsBa5owBc2KIzmwK0A4
	 R9vOlByiAyIIA1JWfPIm2fmSs+he+PNEFHXeHsrkLWyyS4OFmG2nNrR4wDloDVOVAr
	 SdaAOy1ehvSIvTizrTHhMmbZDKDlQrKFTVxig9Iq8NGxSeQvIcjVCNAtq5Xl4BabIo
	 pYKItY+l1miyN6DuXuVll32tvcip+DOjhLZg/scx1MUMORNbKMI5fC7/2s0L7nNvQx
	 8LzptxFQLz9Mg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 22/23] perf/x86: Activate back-to-back NMI
 detection for arch-PEBS induced NMIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-23-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-23-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:06:14 +0000
Message-Id: <20260824090614.9809B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When two or more identical PEBS events with the same sampling period are
> programmed on a mix of PDIST and non-PDIST counters, multiple
> back-to-back NMIs can be triggered.
>=20
> The Linux PMI handler processes the first NMI and clears the
> GLOBAL_STATUS MSR. If a second NMI is triggered immediately after
> the first, it is recognized as a "suspicious NMI" because no bits are set
> in the GLOBAL_STATUS MSR (cleared by the first NMI).
>=20
> This issue does not lead to PEBS data corruption or data loss, but it
> does result in an annoying warning message.
>=20
> The current NMI handler supports back-to-back NMI detection, but it
> requires the PMI handler to return the count of actually processed events,
> which the PEBS handler does not currently do.
>=20
> Thus, modify the PEBS handlers to return the count of actually processed
> events, thereby activating back-to-back NMI detection and avoiding the
> "suspicious NMI" warning.
>=20
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D22

