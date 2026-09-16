Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6233D7D64
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559848; cv=none; b=mIKXIvvMAdUDySvvROVpGsO3izuciPoeySu1IHAJWyRqeVvivAnOu5TZnQHU2dB9YTZiA+UOu4bUxRgxApiTWvSQn02HM2yH/lIYINo6z+xaXfyJcDOmEgcOmG62IEpn1gFBldGGgK5X5+tahaqFt2ktH1km+nP/mM4nWnWu4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559848; c=relaxed/simple;
	bh=Grf4BEvHHZaDdLdgM5RdMHhPEmEU8FTmC8UOa0Mljno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ulzP0/ppx31+thyK9nhq+u8WKUHLfBT0lv8LWxXElLjI7aVg8EcPUMZIwSg3qJb1zPvf0KMxzukCnVkWsNAmWw7lee9MYvnPstilD41eGAS+x2Iqkaa5myT9gdkBMosfCN9nsVgvQsv4jQi4KQ2/lyghTqfgrGqiwlZFFiEQ4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIDJoiD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIDJoiD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232061F00893;
	Wed, 16 Sep 2026 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559843;
	bh=2W8tF8fScmtB/c0MO4katzBarsoejcN1PvrhRcN1GqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIDJoiD3CF6qc6Xj8Cg0hxiln/zarn+6Kdt59WUjvESTwNgp2P9ETe++/L2mBF11V
	 I2OVdj4f6h3Q9fznbNGYWRoJMlcN1MoJhXHN+LNGs2q+4w4wZUmeHhCsfkFouF/AUX
	 TPQbSdkOnJEuPQO01sKCgNE+KyfwyidUdNZG/5jYphnIyItUTaS8Z8kRFN5A5/TKTI
	 ln8j4vR69Xp9o3TcdG+QOiyGhih7OIyT4UaMpUUcvhszbOXVs0vKPXTYpI6zs5D8ZA
	 Ggao9LbYpMPs/j0f3wDb0A+RPqrN6MTPQXjfy4Ee6ZfH+39/2ac7bJ7ZmHxfI4j5RJ
	 uBThYYN9fQACg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-9-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:57:22 +0000
Message-Id: <20260916115723.232061F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D8

