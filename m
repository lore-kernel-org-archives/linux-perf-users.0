Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79653559D6
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832196; cv=none; b=SArfN1e/lOcst7cX7MTGhz75hVnevNvfd1PD7o6VNOSdA8hA/gVWCp5ABhlaNHPn61bfjpw8/1KQzSTEIvbQ53GzBDHd7oEkyufF6DEiTF/DrGfNrX7ZKM7dQP3C6zxyXVMTCcjy82DUYuYVN1MatSR5XchSuyvSDUcp7kucJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832196; c=relaxed/simple;
	bh=91u4s/GNqPQDOpGCmi2dGyW1q24yaiRhjgdrcqe8kmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxA5XsGbdt47ijobQH9jBh3anG2e/hh/8H5T/Wl/t1ykRtBJjPM/80txvUkb93/0yKgYdUBhLq2QH+PMOJauTIBIsV65aAVkVHZd0oxVvsAxK8C6OP+L8fo2DbCr3tmNUOt72ks4eZS73wpgr6Z4D2oDvHIaMgK9P87H+2fOJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k48AUZf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k48AUZf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120DD1F000E9;
	Tue, 26 May 2026 21:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832195;
	bh=Lt6w77JOjgtyaX8WgtX14BXbx5hyCmaduvTGdQGco9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k48AUZf2BupJS0zgPAbcbNC1lOkp00D1KOlsk8Fm/qAxktRzQkS52xNTw/URSkNPL
	 72CtUBsi9goYaTRKjKTRuMEE9jRS4MHxR0sNowYNVm6STNDPXb3F2J2sPBuOk4Ny+Z
	 XDYK3fY8fTNyNb+QywZymdHaun6wionsxLYxbaliDYbqST5BUmhUdrETAErKHhwpPf
	 eEmCXd3pfs86OilG2oBNLk6NTCuN4+ykFkMYpnhlvlfJJy3eHUI23LTq14qN5jimef
	 dRVkM5qQuU8j+JNDrZLHg2mJbdRntxSCHrXGgawI7jZtzS/pY0N7gloSz9/q2DNzYC
	 LAq5ecfIW7s+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/29] perf zstd: Fix multi-iteration decompression and
 error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-6-acme@kernel.org>
References: <20260526211806.1193848-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:49:54 +0000
Message-Id: <20260526214955.120DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing O_NONBLOCK when opening potentially user-controlled file p=
aths, which can hang the process.
--

commit e38284f65bb9657e0257bfeee414f3d1b5f409dd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf zstd: Fix multi-iteration decompression and error handling
   =20
zstd_decompress_stream() has two bugs in its multi-iteration loop:
   =20
1. After each ZSTD_decompressStream() call, the code advances
   output.dst by output.pos but doesn't reset output.pos to 0.

[ ... ]

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index ecda9deb53b73..21a0eb58597c2 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -123,14 +123,26 @@ size_t zstd_decompress_stream(struct zstd_data *dat=
a, void *src, size_t src_size
>  		}
>  	}
>  	while (input.pos < input.size) {

[Severity: High]
This isn't a bug introduced by this patch, but functions that extract build
IDs, such as filename__read_build_id() in tools/perf/util/symbol-elf.c and
sysfs__read_build_id() in tools/perf/util/symbol-minimal.c, open file paths
originating from user-controlled sources.

The underlying open(..., O_RDONLY) calls lack the O_NONBLOCK flag. Even tho=
ugh
checks like is_regular_file() exist in some places, they suffer from
Time-of-Check to Time-of-Use (TOCTOU) races.

If a path resolves to a blocking special file like a FIFO or a hung network
mount, the open() call will hang the process.

Could we add O_NONBLOCK to these open() calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D5
