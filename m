Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD84D5989
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584427; cv=none; b=sp6JHk87QOA87a8BeWw4nafyUqNto1qlKOAp/xeaXyo0dtVOyeyY6GnUWCMujPt6SRxSw1Rx0qOzVUYQ+iEaklvEDQxNYZPLQ78eXoOMI4GqnLfWgltvEjB3e5qTBIIV86uk4WrikJdUIIi76DT/TUO9bwifDDgh/vQl7CSk/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584427; c=relaxed/simple;
	bh=J1WV0cxVYnKMGp3f+hz62klhXvo3wP1GOjm2d8nDoag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjU9hGM9L5iOyTnQgxYOz8IiR2U7BF7vl3//4iRYBrn/sq1lIS9wrNIM+8tm7o2CY5KaWEfVOaMy8MjqGkqwIuovOeD+bsOuLafTlvJSgwMzXD9tI9Ujgptr3smdjInBiVIegksmUG7ruBtUzFICQAkWGRSEJwMAB4M97bWt1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etFJaImX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etFJaImX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D56D1F0089A;
	Wed, 16 Sep 2026 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584423;
	bh=UAo4WlcTRtQrnDGC4jkT8+ylnOuy87TwH/DWsXVFVi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etFJaImXDc7Ihs/aldTuxFJ4RFIVB3R/dl/U+KFZ16fHyhWPuPGZtXauT8RN1XYpW
	 1qFpX+Fur6W9MF3LeIUsskzAbeynnCcrppdhc+6ct8pi/2xhyx/McDua6rcgmCIHap
	 tKouY4n2bAflXPwpLzoJ16HGZg0SfO5rzIP9OBPyqryLO4+qi7PSN4c2bVMsgqJYep
	 E0CS7qzls7fvpGBiuVcP56eWmuegNqqcGcHM8k3JIp4rb3HPUXtO2ZvENEaSs53viw
	 /pABESMaKxEyGQ5LnVz9tkS6SpIWon20yGKz1W1sEZgdc3rDBjs0w15f5DHJcPleZr
	 q8QtloK7emyWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] perf symbol: Fall back to fetching the vmlinux by
 build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-7-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:47:02 +0000
Message-Id: <20260916184703.2D56D1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A profile recorded on a kernel that is no longer installed, be it
> because the machine was rebooted into a new kernel or because the
> profile is being processed on another machine, can't have its kernel
> symbols resolved: /proc/kallsyms matches the running kernel, not the
> one in the profile, and is refused when restricted, e.g. with
> kernel.perf_event_paranoid > 1, while the build-id cache may carry
> just a kallsyms copy with zeroed addresses.  With no kernel symbols
> the kernel samples can't be annotated, so they all end up in the
> '(unknown)' data type and the kernel is missing from the data type
> profile JSON "dsos" entry.
>=20
> As a last resort, when the kernel symbols can't be found locally and
> the user didn't specify a kallsyms file, fetch the vmlinux keyed by
> [ ... ]
> struct tty_struct, struct qspinlock, etc, with the kernel DSO, keyed
> by its build ID, appearing in the data type profile JSON.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D6

