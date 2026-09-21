Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77644CE691
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007843; cv=pass; b=o/T6sSPc+CPUjQ3dn7Nf3I9GTRawIug3lUvjv4Osl6JOBLJ2rKs6yDCaGTo/eOFLItUDDBSzCvQTcjXsxORM28krzFnIubfG2PiXzoerWKrpcMZp76j1nGhqTC/Qb+NWcoofWwEGptmthTCQ25ru+BUJTDIQtODVKTxb0yVkhng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007843; c=relaxed/simple;
	bh=2eJZABd1KhDaqH5R5RatQY64qEhnstOQkvcGNYCrxaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gm2jyWICLbX/Be3LdhpTw1wOWG/eymnovHxAAR9eTKBvb9u+DEIVt06mbe4ud4HH+Rg0nnidpy9g8UsEWtqd1sPmHO4pv2W3HfzBn+23vfFnzovaN8ySHaWXenhB15w5hynTveg3Z8TlTszjylGTZAXZpKE1joTsvWfyQxVb+2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7MCrCT6; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7MCrCT6"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-530f6bcc301so398561cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 09:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007838; cv=none;
        d=google.com; s=arc-20260327;
        b=AjqYwsmvg3aH+NQsCioP0rq8Ke09/e4Zx4Z66wLYh0ZoTleNSwN85/Y/oZ8joUBYKx
         tb6MqP3izAtZ4say4McECnL7leYc3kQ7uQzDRGFO0iE2NIrO090ItznW1aZcO1FtDw7D
         C3JSBv5ygj6GUUOsgQcfXxRuToU13t49NN1YvrGvLJg3jO/5jPtXe4aZKgtCVwFBC3eU
         ETjq86/blBATh8xvZfCAI8Nb3/hFIjgcSmLpGw+fvQkVQvknYVTtvqghZe+XSwiU6ObA
         iUML9QD1t6BBiCUT66tUXuwqp8e3Z6z6AgSnOIOMOrb4ZoP0zeNJHOrGd0YfBkgrYMxx
         Cuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DIxL0kqk4j8Y34L+nTA86vhyKtqo4LqqAJTpMKBQ+Y8=;
        fh=MZL8NFkN6gnOMg19nkWdUUb8QopZ04CIKQbLaq1dA00=;
        b=KpWj/qgVA8MNod39OFJGQOvEsEPfDgIH88VnhMB37Xcvc8R4hGku+mdDNwWzHuuw4s
         4/ir9tEUrXBsNUH2RVAsPFkOIyBdsBTrBfw+Y0G5umqzL0HaRMR6bXIFS568hXffjogl
         xx8JUGp25RQhM3nWqeR2mEQFPh2SZv4PheBVgr7GQCGZ/0IgZNc9+AhtaM64Uteq7lo6
         deuGd0BrxEQRnvgrGh4mSdxh+nZL9XMgTacupB3/v/NfJ35a4C6ODSINaFBXdyqbG0CM
         qu24k/PfywRE+7R3D+DZYytCBcOfSbUWyF9xGxpzECs1I+OBlT7eMK2spou0h5rKVkEE
         izvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790007838; x=1790612638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIxL0kqk4j8Y34L+nTA86vhyKtqo4LqqAJTpMKBQ+Y8=;
        b=I7MCrCT6OseDgQKd8mf7YbSjRo5m4cCXiBPr5vFYUB08yJRmYXV/xSpzZSvdljAqfM
         85xoo0aX9ac9BeblfjFOSZO/ruStgHEdTgOO6aHDUWijHx6RZIVignfVzMXDDplCOK0o
         LhZGtuS5j1Wb/kMSA+bJZQHUDqgY/gp38Na8HhaCA560EnuJC2TjLlheRnruOjK7QZw1
         KcUOkD7xr3W01eZtv1G/3r6gknfeWFyaoce5xrY6CKfed//Y7h+a+96cMb1iXUN4Y8rB
         zMEmJmfrY4dtHnPTTkK3+N1SZWb8ov7NKKw3PEbnErAX9+H7j4Ze1YUkpE6VnRmqiGdQ
         l07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007838; x=1790612638;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIxL0kqk4j8Y34L+nTA86vhyKtqo4LqqAJTpMKBQ+Y8=;
        b=W8uVSP9doZxVzARof31zuXj+oRXyeeXIPf3gIdnM60QFRYcFaVEssVYYwl74tZ3krV
         /Gre598AGfJ0MfKVyy1ARc9XxIydR8J/dqkjYuJF6c6HojIeur3Cib4ITv+vPkEHG9H0
         z3w6vTO7SmPEDUFlZJtp0XbQ/f2/9/QbwBTQECt8ncQn7swwOcIHbu/dYAFVBZNTrLLk
         5jkTHiRUp7GdHzy8LLy9iI65a6zXhwoFFUjcVsre3gp19Na1v655eA3tKzVoKiMpi8l+
         8bAxD6QL952OOCLVSsOvOxYB0J1nuM0TSNuHRgA3RW6ijypF9bH0B8vEr5ucmlrrUW0s
         QWGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxh4aAiXyt7uahta72D4je6OOjSZGuNECaxdKv9Q9HvYUUYdyE9dhyjPgcdwP/FsEjFtDgsSiFS8XhRiNMu0yfn@vger.kernel.org
X-Gm-Message-State: AFuF++nUppuTtfL0qzwEouMtRkgq4/G+1GgwASOyiz7EEIZ83W+EjHvX
	7WLSqeTtFYMjWvrvCn1W9ZVb1FIZGcnMbHjcBJUpCdW9jWlw15wvY4JDU5VXEkKgm9Jx1V96m2c
	3oYFArkyZjgA9b3USrmm+TJSdD84ksWyF7gGl7yYw
X-Gm-Gg: AYBFou0E6i3TSQls4NDMRB7WHAnrdSYMZjmfU8elL6z7AJxtJri8SAn6g9rf/eAwU9b
	3b+B1SnP1W0KrxHMu28nfxS/CDBlZuB6H9rPOhgLDRuPhqe8VYXZy1WEBHSPL+YJIO0pY3XjhW2
	pfjpkPjI88ahGWyhBTrMprTg/5Q14PrN8P8yRqHnxMAaMvLUYTrSEhEzjRMTNct9d9HR2MsH/1S
	dA2yzVthV+qo95ArBIfHUMSGK4TJhSagxsUe6JQc1bAxqRxeYL8e4dvpFPJrS87zZ3poaM5kOgG
	ONga27EjegwN4V9im0IwAJ6Pw4ehvhg1I4+wI6nSMg/8yALn6pGF1SVZCUnQIgRRxdsxzZjuFZW
	xH/1ibqrU3scLX+lQxPU=
X-Received: by 2002:a05:622a:1cc5:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-532d8d2fd53mr4769851cf.2.1790007837072; Mon, 21 Sep 2026
 09:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com> <20260915091112.333308-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260915091112.333308-2-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 09:23:45 -0700
X-Gm-Features: AcwNN1WkLBXtXxpdp75rpfIZxFhFJUV8npdtSPEEAM6R2JsKlD9iC8Gb9DOXIjg
Message-ID: <CAP-5=fXQ3dRsg5erJM2YaQ2A1s+YBXSK9vScio__SQWnZyssPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf util: Explicitly include required headers
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:18=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Sashiko complains "the perf tool can be compiled with musl libc, which
> enforces strict POSIX namespace separation and does not implicitly
> include headers. Relying on implicit header inclusion can cause build
> failures under musl."
>
> Include the required headers explicitly to avoid such failures.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/parse-regs-options.c           | 1 +
>  tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
>  tools/perf/util/session.c                      | 5 +++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse=
-regs-options.c
> index 709fcfb077a2..e70393388fae 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -3,6 +3,7 @@
>  #include <stdlib.h>
>  #include <stdint.h>
>  #include <string.h>
> +#include <strings.h>
>  #include <stdio.h>
>  #include "util/debug.h"
>  #include <dwarf-regs.h>
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/=
util/perf-regs-arch/perf_regs_x86.c
> index fb6cf34f42f2..ea1d402b0893 100644
> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> @@ -3,6 +3,8 @@
>  #include <errno.h>
>  #include <string.h>
>  #include <regex.h>
> +#include <unistd.h>
> +#include <stdbool.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a5b596cd14be..04fba6fb02e8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <assert.h>
>  #include <errno.h>
>  #include <signal.h>
>  #include <inttypes.h>
> --
> 2.34.1
>
