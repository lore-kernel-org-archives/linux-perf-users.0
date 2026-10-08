Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827433B14C9
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437627; cv=none; b=l9omJm8eONkXwwrLVOASAeIdo1NfA/2vpUxSoSDD2pF/iaa04szluSMpU/xi1pO75F4p/P/lBVUrQ8rbRP4uiLztIpeafAAZD0jslMXorTboMdmEjcv6nNfZUpz2nSmMDNNKJuz4rf8OwbJX/xd1T5RCOQVQA8ZsyOfXg+aad5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437627; c=relaxed/simple;
	bh=fEw6FpN8iVBT/W/14qB3xSxttZVgI8K0hrjAFmSB6Nk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NITHK6jMergh9DZ1Ocm43Rq6zyFaWfqvHf0VDc4p/6wWQXIWpf4WUifXHgReuuclYOmi/9roMzcT4zt5QrpZoklX2Z31EWu9qpEEQ3zy1abNVvYgYb7rCEIYRyCcivU9KV027Pk8wTQAH6ZKxVGObkSP1SQzG/WjClYFvXnwOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW91C5j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW91C5j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0247F1F00898;
	Thu,  8 Oct 2026 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437626;
	bh=fEw6FpN8iVBT/W/14qB3xSxttZVgI8K0hrjAFmSB6Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gW91C5j7HON5B+aktcW45wg9wJgcuVjhA4EMkfc49YE1LNeKgtTZ2ZfVH8knDP+Nu
	 hh/GYjl7ctkgioZMWQRmZ3EwsN1O1SQpqTMGAALAINkbEImf8LFV49pOFoFX7fRoyk
	 hgWO5EDFnWsplR+GndU0p9GA01zlwtUpC3B0/E6sQZCX1UX7Yv3n7D9MC/x3XXU7wV
	 KNpdP+EB1B/ILglgYbRX35jXUmSahM9w7osbHjF+ubZ7o131e95XGdy16HcbYfUHn5
	 7pvAjV/n0VE95aFO4ybT4mSiw7yLlWNxp25B9kwQIWHj2Cg2jRjbtdBJuZ0hNjr5N/
	 CesnPwkO6bh9w==
Message-ID: <sashiko-outbox-163628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix DMR CXL CM invert filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixiong Wei" <weiguixiong@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261008051953.6293-2-weiguixiong@bytedance.com>
References: <20261008051953.6293-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 05:33:45 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The DMR CXL CM PMU places its invert filter at config bit 21 and its
> 9-bit threshold at bits 23-31. However, dmr_uncore_cxlcm uses
> GENERIC_PMON_RAW_EVENT_MASK, which covers the threshold through the
> generic bit 23 invert field and bits 24-31 threshold field, but does not
> include the relocated invert bit. As a result, uncore_pmu_event_init()
> silently clears bit 21 and inv=3D1 programs the same configuration as
> inv=3D0.
>=20
> Add bit 21 to a DMR CXL CM-specific event mask so the requested invert
> filter reaches hardware.
>=20
> Fixes: 6daf2c35b835 ("perf/x86/intel/uncore: Add IMH PMON support for Dia=
mond Rapids")
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008051953.6293=
-2-weiguixiong@bytedance.com?part=3D1

