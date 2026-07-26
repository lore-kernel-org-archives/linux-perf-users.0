Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC0175A7C
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109745; cv=none; b=SFOOl9DmJ2H8MCL7tMesY43YV46+GCzfpxKNJ7VFTdA5DtdMFB9541hEAl65Mg4zISI7lBHlHeQQ/uAqcJuaaFpWKv0ZdbtnAY+7TvjB7kzjt6RMB7QxH5PzjeR+TYKY7yIVcgD9usFNkvfY/prmZ4Gjb/Ic7YzeBqOLt25+H4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109745; c=relaxed/simple;
	bh=N6XirMYRc6AwfgYcC3b/G1CQzvHDGX3LCylBldYvMmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mUYYAw5MyhTyRKkoMvX87dLJbkvniBq7jngtN3jv1uVDZuopi2LFOafSwoUqjSaPyF4qzdxL15aw6T4WttzRk7uCuqd/UoTYqT0VrEzk0P0NE1ElZs2VYSRKqERpKuJi4MVRYLaG0gTjmQaDpLAiLgHX2mXnka3GyW88FhmeAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liTfVuXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liTfVuXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335061F000E9;
	Sun, 26 Jul 2026 23:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109744;
	bh=FtI5GVNS04GYL7IQMN25pUr2fslUgYnVNOIHCNDIywQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=liTfVuXbc7vQ6uBKajkT+LGUeTF/3xquB19BzsUtQBEbltxnyBZCwgim1Xv5WEVfJ
	 DcbAMScEK1o8FXDybuOAnzbMDnJsFwwx/k4shDF74a6T9MTDhSSnYKUd2yXMKQh40E
	 6zpyZhhMwfKTecmRmjlSYpDremgFU6rvQrdHtERBbrEgOCF8z5odk2fCnxwgnZDE3v
	 ohffWI+D5F+7pwacUtgGivtuJ56jtAAr44+gAIx86dmmsSaGrdqnHw1UqbbrVC1vKK
	 BmNVxWv8qBKq5ubzRnSPNQHvVo9Vw1bEEDUfSmQgjiXYoZ+i/Ke0NQHl/i4hJLJgTa
	 +V6uUOP212jJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf machine: Reset errno before strtol in guest
 kernel map creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726234014.63111-7-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
 <20260726234014.63111-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 23:49:03 +0000
Message-Id: <20260726234904.335061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing explicit POSIX header inclusions for <stdio.h> and <limits.=
h>.
--

--- Patch [6]: [PATCH 6/8] perf machine: Reset errno before strtol in guest=
 kernel map creation ---
commit 8cf9920f21a3b72d2b6dbb2087000cbeceb43bbb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Reset errno before strtol in guest kernel map creation

This commit resets errno to 0 before calling strtol() in
machines__create_guest_kernel_maps(). This prevents a stale ERANGE from
earlier library calls from causing valid directory names to be skipped.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 83d38637afe34..1700130adedb3 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c

[Severity: Low]
This is a pre-existing issue, but is this file missing explicit POSIX header
inclusions for <stdio.h> and <limits.h>?

Looking at the include block at the top of tools/perf/util/machine.c:

// SPDX-License-Identifier: GPL-2.0
#include <dirent.h>
#include <errno.h>
#include <inttypes.h>
#include <regex.h>
#include <stdlib.h>
#include <string.h>
#include "callchain.h"

The code relies on PATH_MAX and snprintf() further down in
machines__create_guest_kernel_maps(). Relying on implicit header inclusions
works for glibc, but does it cause build failures under musl libc environme=
nts?

Could <stdio.h> and <limits.h> be explicitly included to ensure strict musl
compatibility?

> @@ -1258,6 +1258,7 @@ int machines__create_guest_kernel_maps(struct machi=
nes *machines)
>  				/* Filter out . and .. */
>  				continue;
>  			}
> +			errno =3D 0;
>  			pid =3D (pid_t)strtol(namelist[i]->d_name, &endp, 10);
>  			if ((*endp !=3D '\0') ||
>  			    (endp =3D=3D namelist[i]->d_name) ||

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726234014.6311=
1-1-acme@kernel.org?part=3D6
