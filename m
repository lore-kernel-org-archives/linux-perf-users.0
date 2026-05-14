Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92732ED870;
	Thu, 14 May 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719815; cv=none; b=ZggXRXZo6Hxt6yGJe/UZK0qh6hpJwVz71dqoeYGGTB+AgpHG7R7xSOK33CJFVSeENgRRpU8B6GcdTVKilGKRyqvskuDgYR0V2d1WhRcmE7CEmxoBtTr0ucF6HiOOD9g0rmvvqzTrDgoEF1U/EN0Rsx/DXjS6O38E01QedSX/uRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719815; c=relaxed/simple;
	bh=c7fl85p+dHqJaJt4mkFQOqOPrf+QqNSoUyC8UhxH4XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKrlJOoHP1jCtoCJ8NBTOu4uygbO/Y4bnu41FaFo0VHQm3+bEB5gcKJ9x/boqEaeOTexdp2SL6UyJMVMBirEavVJ1rZLlvuAEGCST5mI1MSVtYDPvthYJlE2Ip6M2XgMFIhY7++/Xfii2yQDxy2VxmriQLqqUkDUVs4f5jZAuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WveADRI1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WveADRI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF75C19425;
	Thu, 14 May 2026 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719814;
	bh=c7fl85p+dHqJaJt4mkFQOqOPrf+QqNSoUyC8UhxH4XY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WveADRI1lmgJuxJpInrK6XjCpofZFSAV9JTRYLS2bNn3BTtKFQdjhSHDnkSOO4T2P
	 oskdNFmsYIDwxuqglSeHFlyhpcNynR79pMmZFO28U3yfkP1TfYY7qRJ2sQ+43lT1N7
	 wA8s+M1ac6m8xHEwhOkd/YxtZAtjw7b5nDyIUgnJF4Mb8ks9jOIof1My0KdC+/OKOg
	 POMLkCdROM1x3HaUxKc72qZwEnqWqfqzse2Qd0tkBGRjVmuclLoRQTyjLCG/dnuYXt
	 dYadPMzxqUqOtE3fu467NDbZVzjP9iE0YxqjEk12EYWyxyMlKkATb+z5+ivRtBTGEZ
	 17qPp6OGXIImw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/18] perf trace beauty: Make beauty generated C
 code standalone .o files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512174638.120445-6-irogers@google.com>
References: <20260512174638.120445-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:50:14 +0000
Message-Id: <20260514005014.6EF75C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to add `perf-util-$(CONFIG_TRACE) +=3D=
 trace/beauty/`, but the actual patch uses `perf-util-y +=3D trace/beauty/`.
--

commit 64f2b861c8affb434c0dc658c744d4faf0fb24fa
Author: Ian Rogers <irogers@google.com>

perf trace beauty: Make beauty generated C code standalone .o files

This commit refactors the perf trace beauty framework to compile generated
C code and formatting scripts as standalone object files, rather than
embedding them directly. This encapsulation improves parallel build
performance and cleans up Makefile dependencies.

> 2. Create fsconfig.c and flatten embedded beauty .c files to compile as
>    independent standalone objects via trace/beauty/Build, exporting their
>    formatting functions via beauty.h and env.h. Switch arch_errno_names.o
>    and syscalltbl.o assignments directly to perf-util-y and add a top-lev=
el
>    recursive kbuild hook (perf-util-$(CONFIG_TRACE) +=3D trace/beauty/) to
>    compile them into libperf-util.a, resolving remote linkage for standal=
one
>    python extensions.

Is this description accurate regarding the recursive kbuild hook? The messa=
ge
states it adds perf-util-$(CONFIG_TRACE) +=3D trace/beauty/, but looking at=
 the
actual patch, it is added unconditionally:

> diff --git a/tools/perf/Build b/tools/perf/Build
> index b03cc59dabf81..e18c80a5c1bca 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -34,6 +34,8 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    perf-$(CONFIG_TRACE) +=3D trace/beauty/
>  endif
> =20
> +perf-util-y +=3D trace/beauty/
> +
>  perf-$(CONFIG_LIBELF) +=3D builtin-probe.o

[ ... ]

Functionally, using perf-util-y appears correct since arch_errno_names.o
and syscalltbl.o are needed by util/env.c and util/bpf-trace-summary.c
respectively, which are compiled into libperf-util.a regardless of whether
CONFIG_TRACE is enabled.=20

Could the commit message be updated to reflect the actual implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D5
