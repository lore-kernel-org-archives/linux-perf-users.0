Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF594D9558
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584225; cv=none; b=gyZpnzowKMEo1vRPrq3V5b1nlOqfybErCsrCeeZkHcu+YhrfHNklR6nYX4UVOqdlQCi89S8CZDYlUZed+4e+9IvdVfIUk0bNMoKLip2QX3eoTrOqsdFGbG3U22td2gQJ39Xk3hvFVO2Kl+crOM9QBTJAxvdKmweBkAExYGj0Otw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584225; c=relaxed/simple;
	bh=ADvW4berMe0Jemo7TC1AU+KTmC1v4/8u+j/u5+rx7t4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYqJuUnfOdwDeoN/7WiNx8LW2iT01dw8y+tIKPr2U86e365PJppb0wgK2EvxXhe6pNc6p4d8lmN2BE5PBuF/x6p56qV+Iir9umfgjhrQuXqmRm4h3N+b/2P7AKu4aTGEEC1OPP5DvhRUbNcQVTlGTUwcZTZMhtVwSu1q3Xwd5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnlQi0d/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnlQi0d/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625E01F0089A;
	Wed, 16 Sep 2026 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584213;
	bh=TWI4Ixw7SNqQNWCFM+NFBTPBEo95K+muYGQ6dgPOWkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EnlQi0d/HZEtawGqQQI9g9/A0Z3W/rSqK9B2pbKgzk8oCRVltfUsgxmRaclflV941
	 FFpp4s50FUrRaAKFDOO4sdmwUAPc7UdqcrFidu/FYAFGKsByY1Jt0t+UP8RL3XS1wz
	 xUqX0zT9FGXkTlKbCkddioxV+3t1J8e22J7vt3USwki3+gltkLDZR/HuGoVhWS9s1E
	 kaKRTwfj4pivI/I6qvgIcWUkQg7FWMv1BUwMAJddkvPWeXd2yXapEebpP0p1qifGQc
	 78Fi57sp9OoI72vcpI2lahNIzRyBm2RZF9wTX6J9uV/fBU+duIflWH1CDe3DHNuro4
	 vhxPhmNGkpHKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-9-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:43:33 +0000
Message-Id: <20260916184333.625E01F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D8

