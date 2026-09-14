Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A40476CC7
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393072; cv=none; b=duQ0W4CC1kurFwOT1+WrLnLAuuiAnTm4WUyv6f4SLCKOeKHp3n49LcaASs4PvdoK0iUis/hJKiEMeC+249ezm9DF2kBZXhxQp3eVokpriVME6KBDhQjb75FCtM2Kd9lVw3C1l+UZyAK/Ae6TQ08Ze7Qdjdw8OLqpSdyBEwq6wN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393072; c=relaxed/simple;
	bh=ASrodGYQo+d1XwWbAD+C33SHoJVYFjEzzcXusrMbNVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLjZow0WHqeysnxXMDvDx6S6U4x19uthQNSYF//aACXL9D7OIPmCdSoUuiPk2XQJBadEpUDmul0oYQESzZ4UdZEoQV9vgKRJqvgakHfdJZm/iL5nTH5iXrmXpAlsIc5LJxV3i6dDCWfbz766CVycQw4Sld25okbW34kndcHcpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKG/s4Qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKG/s4Qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5031F000FF;
	Mon, 14 Sep 2026 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789393070;
	bh=vNRUVEs7AZeSABnGZPFICqTqqn+tJjjarTVDPDk4TFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKG/s4Qhb0rhRL7X+84z9g1kV/b7rf/RjOyt36PBGnIfpyrUQIBKGYLOsZwYYcGqr
	 msJ6Glr35JmT8PeAz6AM8QVfGfWPfWJa9Pg7g95FRHEePVCFv2gRgz13CW1Frt+ZN9
	 YV9Y878uXGEBikGyisqSMg2fT54YbmZD5qMIG5Cm3fEKJB7MmoZYUt2/lFZUYgMjBs
	 wDx14Tvqn/OYgV45tNFtkK+VO0U5xTSmYokt9UX6ZOBBSWjZyh3VPF5ftnuvMapo1H
	 lbJkrmcgMilufW9k1eX49TtdqmKfmWJNgwMM7zTdq5r3rYob8fT7h8tJz0Ss+szPZx
	 AyqUN2B7FBsyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-6-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:37:49 +0000
Message-Id: <20260914133750.1D5031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large data type profiling session, e.g. an AMD IBS one, can
> take a long time and, when using the stdio output, 'perf report' gives no
> feedback about which phase it is in nor about how far along it is: the
> TUI has a progress bar for that, but in the stdio case the ui_progress
> updates, that are already there, are dropped on the floor.
>=20
> Add a --progress option that installs a stdio backend for ui_progress,
> ui/stdio/progress.c, printing the phase title, the percentage done and
> the current/total counts to stderr:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>   Merging related events... [ 61.0%] 309026 / 506686
>   Sorting events for output... [ 98.2%] 14132 / 14387
> [ ... ]
>   88: Test that perf report handles truncated perf.data gracefully (no cr=
ash, no segfault =E2=80=94 clean error exit).: Ok
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D5

