Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604A46C4B2
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145365; cv=none; b=oWPVv1wto3jposSxILATeWXCdUKrrpmHRkyxRfaOwzMcaQfPAKFFtSYcWCnUpZ/LLJWR01CNd1ene6d2Rggk43IbjZbQJ9KQYJTUb6lb+NGpY9N0uOhSw25fA3WUuBQ+sXODcZP0qYgTjWeYX5m3i71LDga5gJUe/QS6Gh3bOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145365; c=relaxed/simple;
	bh=PVtIIVoRqvaL4J89yZeEwseaf7vioVsLPGhWpQCxDbo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iJslRE1bOKSiRZybJzbRhLnT3mzaY6xfGU1d/g112KDECi1nw24QiQ1oRFNNRXAasVQXB/Taaoi6D5Afb2rTXmwf9JlWAT8BNjA7iEYVMJRUe0qhqNvzt4zcRPnBEAzLYcFyingCm68i+gvBvIxEkr7+bYlK8sCertH/MBd3PPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDntheMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDntheMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFB71F000C6;
	Fri, 16 Oct 2026 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145364;
	bh=wr+WEDDYBvyeNYvuIGi4+RpQb/r5OjkoigJFCtwdyps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDntheMnwiXYpz9tqR538gPSxCTurm95FnG+INu1KX0pNO8Z5u83bgvie83BfjlhI
	 SGN3nl0lDFDkDhEcTL8i32XSqc+GygkNOtPTUinG0RLRkUoLZCenJr1KU/xElcKdMu
	 8jQsU/NpIPJe2QYmOtrIxJLjWnsWbWjzsb1n4vDdPUlzvxSSLJmi5YKAMLSb3vvLuR
	 +DPgXFA4EEJ1xR5OpVuUVNcPQ/n0YhMd3GhDyWwYb9GnZj+feNQCiTM6ycd/YHoziI
	 Ikkhqa/7aWyYoAz8aW9BA3gHoa5BQ+mXwqisIetRtJ9NC3f2UkQxhx9u5qIkic3yLG
	 oIXUnq4Qt1ruQ==
Message-ID: <sashiko-outbox-174124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-monaka-fix-for-upstream-v2-3-fc7ede7f9f48@fujitsu.com>
References: <20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com>
 <20261016-monaka-fix-for-upstream-v2-3-fc7ede7f9f48@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:09:23 +0000
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
> For example, if the following conditions are met:
>   1) Running perf to count an event in user space only
>   2) The event can also occur in kernel space
>   3) The counter value is set just before the overflow
>      (when using the -F option, initial counter value is -1)
>=20
> when the kernel is about to return to user space after enabling
> the count, an overflow interrupt is incorrectly triggered by an
> event that occurred in kernel space. Since the counter value is
> not updated (correctly), the interrupt handler does nothing and
> returns with the same condition. This leads to another wrong interrupt
> and results in an interrupt storm and eventually a softlockup.
>=20
> Work around the erratum by avoiding programming PMU event counters
> with values within five counts of overflow.
>=20
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-monaka-fix=
-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com?part=3D3

