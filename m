Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119B3D9DBC
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583914; cv=none; b=aGTH2rcqqf3I6L56HZhUG71l9rEehKDWi+cSa1+eqk13odeTrTxNeXZNGDOw1Yeo6sx9rqATAYi0tX08Gwb3nbSTG/uVpJQoy5/aFK5J7iduZWhZ8DVJaZDoPztORcmxbG6b7K1P0rwenJ3RGmSd+vOqXOKwgOOC/Jk1i1xjBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583914; c=relaxed/simple;
	bh=lKCh1WBGCmmvzxcpZ45mKHAAPvBPWsmPMZDJhBisQZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZcHGqw6btWXmgHqcZ6uJZ8wjDpCEutwLFnlpRcQIu0eP2VFBF4zpCs7pfkXCXlC5rcV6ozJZ22Db8PzDGDXz2pNhW/Ij8Gc3zUCK18DtXjCLjVF69yItjjbDGaQI9fvVwMkGTIDaxSnCWzmY/T0ZDfHB9el8H8BKdzFskT3unE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoQk4pJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoQk4pJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6CB1F000FF;
	Wed, 16 Sep 2026 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583890;
	bh=TcqBlKY6fdRiTAzgBH+OLix8Qu+KGLSiq7FL55XASDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XoQk4pJLbFmCL/ui5vdN9NGxniMWXCPD+g4oykyug9Uy9zF2oXStmn5nOFBJ9jcay
	 wRaKWm7bjWDcbb357cubZ2T3lsSLdjq5l8reYig+FgRh6O/u8SBB3Qn4EtC1tHR/sh
	 Ba81K8sbDtuVRazNeojgMxhxHC+AQMlKgIGZ+htATk8aP+Vgt5R4kK7/nqyQPoh/IC
	 zQdXEtoGSJOml0tgYLs1aLtbHO3J7vEOZO1X5LZuGjdV5kbQ6StbtwfvIrCvcPYnO8
	 7SPHWghsGchHMnMMb37qZyZskKtvkfeat2OnhB+N8tWEJEGublY181bWzfO9GSNtnj
	 3RMoXLijCbA0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-10-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:38:09 +0000
Message-Id: <20260916183810.1D6CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one that is stuck
> in a loop, and when it is stuck there is no way to know where without
> attaching gdb to it and looking around, which is what this does, from
> the outside, sampling /proc/<pid> at a fixed interval:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ tools/perf/scripts/perf-stuck.=
sh -i 15 -n 4 -l ibs.log $(pgrep -x perf)
>   watching 2297313 (perf report --progress -s type -i perf.data.ibs) ever=
y 15s
>   09:39:34 state=3DR cpu=3D+0 (0.00s) rss=3D664295kB stack=3D7ffc3ae31000=
-7ffc3ae52000 size=3D132kB  Merging related events... [ 39.0%] 197574 / 506=
686
>   09:39:49 state=3DR cpu=3D+1496 (14.96s) rss=3D665383kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D1 Merging related events... [ 39.0%]=
 197574 / 506686
>   09:40:04 state=3DR cpu=3D+1497 (14.97s) rss=3D665383kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D2 Merging related events... [ 39.0%]=
 197574 / 506686
>   09:40:19 state=3DR cpu=3D+1497 (14.97s) rss=3D502250kB stack=3D7ffc3ae3=
1000-7ffc3ae52000 size=3D132kB stuck=3D0 Merging related events... [ 61.0%]=
 309026 / 506686
>=20
> The CPU time used grows by a whole interval on every sample while the
> [ ... ]
>   [Inferior 1 (process 2342826) detached]
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D9

