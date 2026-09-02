Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794B3DC4A0
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365267; cv=none; b=Wm/w7SHDy2FmLBZAryaC6a5uYJPG+5Bgjt0aW+oOy3kIipSUp7AT+jKUparBL28ZNqZyYA/rDoyfk2IRoV8f7YtKuRF7j1CciwXzEMHfSPPKdM1zL0OP7hGRH2NIKrEvutF5jVLDLnRtxVdcVDCgTYy7u2a7/kqORpRvQHzc7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365267; c=relaxed/simple;
	bh=/RmJoHv2l0GPPb67BPl7iUPrNrNWOaz7oCYHL25Iz6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htYF9Arp3fP+Q9sKoA8RmD/rVefGrcWGvmVGfAnlg89O9BEIO+hNsltIohvyFIEsA7lFeDioC1gSgJFWUzuSXX01ic2t18Sgfd7f5frx5k5vmhedKF1ORYg3tKSGeKOX+UkPrQD+suV0teJ7GAyH/QP0BRSSQKralxbm5kYf7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8d1T3X8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8d1T3X8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5E41F000E9;
	Wed,  2 Sep 2026 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788365264;
	bh=oAWREtwh7UoXmbIGCE3pLAAitVnGsjZ6OJsPfhMzw+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8d1T3X8awccLUUyDNy6dxZ+sUJjtOfS4qPTi1kb513DTdT7klsL3crVfAGEuLQxL
	 0//IB+IsYRSn7LJSnUn/OSO6jC8GaCZLo4pZ1OUYm4liZV1j4r9mOOZ3TXssLHtie1
	 Ic606gKXuQRo3fH2G2IMeQaPbCdpfo8g6++HEKEFpSAY7/Q3MR5CeyecSuXIQTRDUi
	 O/9WhWbXjqVKVlTU7zVcFinzcD5ZW2GobPez6qS78w1HVPEwJD7CHMNXUDvPTet4Ik
	 fTNwn9ZEIxS+m4SM2w30Rmwctgjt2g5Em1Q6G5Ztcp8PcscOlsSSjksdgiYnHkdKm6
	 qjqAiUxCFxfDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] perf hist: Remove keysym.h include from hist.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902154858.2078885-7-irogers@google.com>
References: <20260902154858.2078885-1-irogers@google.com>
 <20260902154858.2078885-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:07:43 +0000
Message-Id: <20260902160744.6E5E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unconditional inclusion of glibc-specific `<features.h>` breaks mus=
l builds.
--

commit 7fe3edc4f61ded07ac7e2f802a9ada49f3daa101
Author: Ian Rogers <irogers@google.com>

perf hist: Remove keysym.h include from hist.h

This commit removes the keysym.h inclusion from hist.h since it isn't
related to the UI. It also addresses the transitive dependency issues by
directly including ui/keysyms.h in several core and UI files.

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index f208ff5132388..a4c014a1d28fe 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -24,6 +24,7 @@
>  #include "arch/common.h"
>  #include "builtin.h"
>  #include "perf.h"
> +#include "ui/keysyms.h"

[Severity: Low]
Does this unconditional inclusion of "ui/keysyms.h" introduce a build
regression on musl libc systems when slang support is disabled?

Previously, "ui/keysyms.h" was guarded by #ifdef HAVE_SLANG_SUPPORT inside
hist.h. By including it unconditionally here, it pulls in
tools/perf/ui/libslang.h for all builds.

That header contains an unconditional inclusion of the glibc-specific
<features.h> header:

tools/perf/ui/libslang.h:
...
#include <features.h>
#ifndef HAVE_LONG_LONG
#define HAVE_LONG_LONG __GLIBC_HAVE_LONG_LONG
#endif
...

Since musl libc systems do not provide <features.h>, can this cause the bui=
ld
to fail if slang is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.2078=
885-1-irogers@google.com?part=3D6
