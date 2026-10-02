Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E347F3A1
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937352; cv=none; b=uaBqq5vBD/J4iAfxI4p3Sq/vKOs2s82bOVpdAZZUY+WJmiT0qvJN4DcPq2OzrVmwsMIPj/GJf7POjBBZN2P7UsCcnkDiWr+KJ/0+rqcG78ftX5sdmMXzRFjws6CsMM4C6bTXn6Dr/If2J1FR3W7IU2MabZirh3FE0x200c7kN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937352; c=relaxed/simple;
	bh=JJo/2/Uj53BOwNUy6ETaLity0Zfj3oqKk8OJsOqczA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XzBzT1S0DDSqp7AyQMnw2QpbUYKHNSMyiBeRyNIaXJWDXQlfbUitkqu1EfIy/sS+fSsC39HJg3yevtXAOTgQcP1/l1XbWiu6YjCc5nD1r01fFtjEmiBRzd6CIUmF08LMQ2QiX/Gs2vw8gXwP3jSzg65VuQBhDtYdTh0zylyn7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU6OmXpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU6OmXpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C901F00893;
	Fri,  2 Oct 2026 10:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937350;
	bh=JJo/2/Uj53BOwNUy6ETaLity0Zfj3oqKk8OJsOqczA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GU6OmXpec/DS5pobpuFsQAhjJXONARrHAnfjZOuHclRtVT7hIx3zBSsCcPj1tpU5x
	 TqCGA0GvpGLdOalrVFV+uYNGpr2TBmpCUDSKr+1oCvVPkRaJJzlOcp22HByx+c80Dn
	 z9AeZbu9w8f8ji7HfCQweEP/f/Jub/ZaKNFSIshItuqdKdo+IHNkpG12B5Sh4U+E04
	 L+RIWgnh+wYi7vLSHiYnuHEFqhwcjf+/QDhWto2AFd+CL5D1dQLMCuiSgwWW5XybRE
	 zsN3ftCFLWrfYkWDjOmEVIJVbk1ZwY4nwGCdwM7nDN9IS7Sdrkegup5p6F6p4wJFeF
	 5PD9kv0GqFEnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-3-4aec0b0cbe34@fujitsu.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-3-4aec0b0cbe34@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:35:49 +0000
Message-Id: <20261002103550.36C901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> FUJITSU-MONAKA Erratum E#030002 affects FUJITSU-MONAKA CPU.
>=20
> On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
> stopped at a value just before overflow, an overflow might still
> be incorrectly detected, resulting interrupt storm in some case.
>=20
> Work around the erratum by avoiding programming PMU event counters
> with values within five counts of overflow.
>=20
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-monaka-fix=
-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com?part=3D3

