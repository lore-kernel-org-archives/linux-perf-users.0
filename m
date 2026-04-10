Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A530FC03
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783336; cv=none; b=aQinKK0wLv7ap/rAORLL/LKvgRWmYs15hFPUvUw8AZ/mMeLYMHXxDwi6UDL7kWwv64m3OITLqnm2DFwJSrZbMsbAxvCw7AoVXzL7dA/n6/IjfBRyUU3D1H04eIEn8/gsk8bf0PaVWtRgyVBG+Z6TGhatC10/ZdXDgrzYU3GUOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783336; c=relaxed/simple;
	bh=F0P/k7OOfgO2SqUoKlXziqw36UocSbp15z1TjABywo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/dDUZT984TU3U4lFEGbhGnF17QMS/2Qv1dh5DWnUf8J4rMLcqllyhAa5y6I3W32oiOgnTYC5oMZCLUv3Pv7u7JydS6TZZp29CeXalE1B+P0DpFz1s4jtGJ0DBx7j/8BUOIRHl5mLWLk6691nuGjdkTpHRa14qKz6Kkjh6xNwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htvg9IqW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htvg9IqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18522C2BC87;
	Fri, 10 Apr 2026 01:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783336;
	bh=F0P/k7OOfgO2SqUoKlXziqw36UocSbp15z1TjABywo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=htvg9IqW3N57OIpWA1zGl2r7z7drs7TXWsWTRpjaO6245Xmvc6b3cI/deSGCrwlhc
	 ieUR4bnsFntSGxVi+qxEq1lfUOqf/19Mp2Uh7LK1a87xpiAEubnY4XiTRsHSHFiSfy
	 wVPZoWcmN6zlb86JzL5OjJDGwjiyYfoCuE2d0CFIve8Q25zxTHs392fbF0myLC5Mlv
	 8LwzAxtf8SU+MEIUg9kM+0ZALgMtVLGNbjvZqV17lBY/jeY7ujl9JWDV95oMZjJfRI
	 t81CdvVvux0C8L4l4ShM8ZoFxuNEb5+rPZgrIMG4hducV0av8cadvL/fIBbXVxJ9u5
	 gz7ZAncvYzQTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] perf header: Bump up the max number of command
 line args allowed
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-3-acme@kernel.org>
References: <20260410004000.148138-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 01:08:55 +0000
Message-Id: <20260410010856.18522C2BC87@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Heap buffer overflow in `process_cmdline` due to unbounded file re=
ads into an undersized allocation.
--

commit 3f19c967de1b22045b10b4bbef5f04c6e3827352
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Bump up the max number of command line args allowed

This commit increases the upper limit validation for command line
arguments from 32,768 to 1,048,576 to accommodate large wildcard expansions.

Link: https://sashiko.dev/#/patchset/20260408172846.96360-1-acme%40kernel.o=
rg

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a2796b72adc4d..22c44b6f0b098 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2795,8 +2795,11 @@ process_event_desc(struct feat_fd *ff, void *data =
__maybe_unused)
>  	return 0;
>  }
> =20
> -// Some reasonable arbitrary max for the number of command line arguments
> -#define MAX_CMDLINE_NR 32768
> +/*
> + * Some arbitrary max for the number of command line arguments,
> + * Wildcards can expand and end up with tons of command line args.
> + */
> +#define MAX_CMDLINE_NR 1048576

While this patch doesn't introduce the underlying issue, does bumping
this limit exacerbate a regression involving a heap buffer overflow in
process_cmdline?

Currently, process_cmdline allocates the buffer based on ff->size:

    cmdline =3D zalloc(ff->size + nr + 1);

When parsing directly from the file descriptor, do_read_string uses
__do_read_fd, which reads lengths and string data from the file without
capping the total bytes read to ff->size.

If a maliciously crafted perf.data file provides a small ff->size but
supplies arbitrarily large strings in the payload, could do_read_string
read them successfully, causing the subsequent memcpy loop to overflow
the cmdline allocation?

Additionally, since do_read_string lacks null-termination enforcement,
if a string is provided without a null byte, could strlen perform an
out-of-bounds heap over-read, further inflating the length of the string
being copied?

>  static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D2
