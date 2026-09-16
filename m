Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5B4E3ED9
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560031; cv=none; b=nGi11MxfqO7+YcH6IHqKORX8hdbk/5GnHLh2elNTgi+tt6UWgXGAo6EIv6yWu0ej3TPGqgZC/t6/DN2jTemmXVxJzXsA8p8mFmqIqvTO3G1jvQsUGJDWWJNc+gOr5hJud7DdAgURsQ03QEQpauBIm5FP5kvtJtejh4Irv/1KKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560031; c=relaxed/simple;
	bh=p2FlWzGb3M9Xa2P0RPsWae85+AZHlhyNojpuTSd/IWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZ28M0D7d2YSTzmECe6vrXyxSXItuUZdDsp/hEntMVzt3vinpdjGsZ72+P5AsDkRAz1vOY4x0DxpznGpdYgB2Io3lPuvreCRlb3jOyM+Q1EcqJ+8Qwr7P0aYi8137N5kr4eIrjN4ANAT4SM2nhs6IIr0YsVj8m8W+lGl+dBzSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq+JgZuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq+JgZuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19601F00893;
	Wed, 16 Sep 2026 12:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560026;
	bh=6ujJSYJYP6B/Xr8kFKv3Oga8hNOfXScO2TkMetWWDRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oq+JgZuRi41fNUKsVFuztkR9vvgMqjNAqmH6Sncx1yMpe4FGtXAbEEbieMCJwQ+QP
	 l4MBvrpmlNe1ZsesrxJVy1pNQTbStr7Jp1pRtOlx+crl5EaEcxS8gaPrPgCeI88GKx
	 wxg7O5+aEp4RuKCiWCYDq3cnS6JtklmMQkFIZaA10Uo3SmgUdh98BzUilbqm2zKcgC
	 3aMJ0GHhAxDyGCLrvUK71++aoLAXjyaIJN0w1NJquZ84rf9W0CA+KV8sI45HJMS04g
	 WQNgCj5mjMWDZ82FqGmrDhMKdDIPoCcKyrUVuva/3H5byjK+8nUv2Osr4O0UzplEXh
	 sFIxHsdIN1uIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-10-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:00:25 +0000
Message-Id: <20260916120025.F19601F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D9

