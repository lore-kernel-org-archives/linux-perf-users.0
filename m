Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28527FD74
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792169; cv=none; b=rcScJtr7UehFpPbP0S++hWtzDI6EnsA4mo+as3RDP/FstouhkfJ65o576cH9gmeuVbCq+ehSo+Rx+MlDJqrvg1VA/PYgSBQFT0WaA3EExnPZmFHUMWiRRSf77q/ceNpXUNkTQm7J9hPqlkDN9fswwcU6j5IhyJdz6ahr6P9yJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792169; c=relaxed/simple;
	bh=rjAIDNeNP5DWsCrpoXgc2wVrVkn2/tUixpvPUAQ7OQ4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uJA4/8JXRCvpzdWxDmxY7MU4hdusW/vlOUJb6wIVsI91KLfNExDlsMkByRTEPVXjWHoNnN9+dRTgC04QHRAnt2+O69FpUr1dMH4qouQ1UPFFQfUbL9JTJ8IZOfcLK4jBYJ4uTy2mjMTNGJ1Yz0JF31Da4Umr4dL5ur7kmSMDydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfswSlXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfswSlXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B621F0089B;
	Mon, 12 Oct 2026 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791792168;
	bh=rjAIDNeNP5DWsCrpoXgc2wVrVkn2/tUixpvPUAQ7OQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfswSlXkGcH/IHT32rYMSosAEaQrX/Xpz9qeUS1raYe+UYq3HtQB6NsWGJBi2JwEh
	 O9VP930TkWXSL2kqjLG7VmCS48Aq5VlHggJpD868r5QaulO8CiFqTW03ekvJiKOokX
	 0hkCQa388D8JxNGHS7lZnWNdWFSiN7Jt9Z6y6rPp3AZv1/OYW3Q9svlv05tzpFCuVN
	 wcRpTqkTxinRlHsvAN5cG7e/tdrUKIJFJtL29DsvftRA7NVLRZQ8qHItjV10ZZYLFH
	 XFmUBDG+CmCIrWfRZjS0NBytDsEktm5wS4UIvMYPOQbu1josIdcUg3xO5tvf8ktEmh
	 2fLhTm6l0xggg==
Message-ID: <sashiko-outbox-167820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf vendor events amd: Add Zen 6 data fabric
 metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6f975087e56e652ae49e8a410ad31b3e76a34b9a.1791791463.git.sandipan.das@amd.com>
References: <cover.1791791463.git.sandipan.das@amd.com>
 <6f975087e56e652ae49e8a410ad31b3e76a34b9a.1791791463.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 08:02:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add Zen 6 data fabric metrics sourced from Table 193 in Section 9.1
> titled "Guidance for Common DF Performance Statistics" of the Processor
> Programming Reference (PPR) for AMD Family 1Ah Model 51h Revision B0
> processors, available at the link below.
>=20
> The metrics are primarily meant to monitor data bandwidth at various
> links and interfaces within the Data Fabric.
>=20
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D311021
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791791463.gi=
t.sandipan.das@amd.com?part=3D2

