Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB8304BDC
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143178; cv=pass; b=B7sXGtUmxb9vEZc/TULYdgrLVya/Qj/gg0U05xvpW24zRVeQ3Pp8mbbkLL+jHfJQtbkKZwaVDaLWfPemWQK+XS2kKx/cccX4niecfAil7D1VFyX2sMhiZGFq5gDpArSi0IiF7In9RX+sABhgUUi8Te05dD+mlBl8wkX+SRLfwTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143178; c=relaxed/simple;
	bh=Mx/nj4wyxgNieeDS/IEHtTU9ztPweGrzK84ZBIWfLRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDUgua9RSRIvXjsScPiC9J2MzG4MVCQrTq/7cifn/Kq2tAxLOEwMmcgeh6/k9E/qPcFoax6LhZuTYabpTgr9Cu2DptzYiDYiCj8BOUxOHpw//8yp86krA14s64JD8e3plxFSbXKclUgjyc76QJzGuEJtPOHcp6h7oDjDCqZvbUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPqKv/Gw; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPqKv/Gw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2591757fbso118825ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 08:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775143177; cv=none;
        d=google.com; s=arc-20240605;
        b=bFY15Nupmy0FEkG0bLSxbSonvLm6mzzmRTfs7iU486iFclOTdrJBexfSe1KwRiVUsp
         /KkOWakJMrTqEL/Ff6lmxIjMDw/NIpP3clIPrfjlRQ/YBYn5p/FsrZkOZd+uIHYW3KBz
         szlxLXKEKSV3bc5gfaaoxux+S3O55ftl3FvsQU7dibbvwanFc5rKA+YeXBnOOIR6MmAI
         V36QI5BCfuTDmtUrXbf40AEfr7zMW5OKVy9xDpa6fYU9m9k/oIZJsCvIjkkzdZme3H7h
         CGYUmXS581pwAl7LAVrz/xxOsL9/UHGuuqOW5vG/PshhlIt5LYGDmV/MtKuBy+Zm+/vz
         o43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiA4VgMCKEfnVUzt0zOdGuj6P0b4ifOmnLxf+zflvRc=;
        fh=MD27MP4cr4+OKr1XhjUfxj2XYKnmvxY8BoBRk0RSSOo=;
        b=Z3al8wO0aytWgN7UpYaMlTscW8lJUZOErTPsDHedN3OVGFun0hXzZ8JfgAh6+AtquU
         pWf74wUMRVhgClpsaIKgk+iHVqhg4/yK2Ctg5GhvbBCV2Uzcf4Oj5DDh0rPrrIbMZq1f
         TaWPMNChW+Rn1B0K3ROg43HWxR7l0rOCMNKruog67B+Y4qDKg4cyUs9cTxNnvm8GMnRf
         VUCfKUePqUFx2y24HC3vl0jXZZ9vkcUjFAeNZaLD0uYm6iBDCW/ZUAYrMzi3Pb/d2hkr
         Dy7mIqiocH95RTqkQfyBakZ239i7EdT8Cn6BniAjRzDF4SJ5FA7oJ5qisK9rTMkFdxRX
         xGXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775143177; x=1775747977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiA4VgMCKEfnVUzt0zOdGuj6P0b4ifOmnLxf+zflvRc=;
        b=lPqKv/GwcpJIab9a65fhjWqY0NgoTFhsKJR7pcQVkN+/bfaJiDWjmAUIfzrD99sVXc
         p4l+SIfJF/2eih3Js63VOmvM8UC5yHagDxQgwIzLKNF0WmirBU8yZLnhX0qSHjgXt3nn
         +t4KA+tN4C0HmP/oausL4zH1qntjT5R0LdowaJ6stuzkSX8QHOZ9ujiVUNtDX+tV6LZv
         TKgXI57qFObi4aE+Z7ZCzTp1l9OWigPYusSngRNkQll7sOqcdP5JP8lzPgu7sg9r62Tw
         GtT6wdoUpgmDnNM4k0oLh7P165LbMavGpzmTbQYW9AnA2sfIBHXmLWKZNpg2tlYdKB+L
         7dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143177; x=1775747977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiA4VgMCKEfnVUzt0zOdGuj6P0b4ifOmnLxf+zflvRc=;
        b=J4/bifEo5p8BrSC1lqZKgqe9q9nTRhpON/dRVZ04zpl07KJHY9G8X4zIDMXZvDtETd
         PWlirZdhduJiJdCrl0QfG35EyYxtaNFa90+GS/xL4owtcKNm7crhCoapflD22RxcU9X3
         P53eHpoLae/aCTfXypha1r+UmLZKZkyE3F/9pj/4swKJKowMdb8qBUZw175ZRLgiE6te
         8KT0JbK8OXbqKeu0kAl50XzR+onWOLiNIy1N1XLkPlB7Xu8QCt+AD511a0MIEVYE5HPl
         kBZ3drGp2SxKV9WlIlNSZulAy6QGDcEtGUrVHyxQNKIOPoOXS6Vsb0KTZSHS+3R1j5qs
         giLw==
X-Forwarded-Encrypted: i=1; AJvYcCVqxEWhmP955xf6DdY4TOJluC1kWsP5qsAQnQsv+ox3ks37LFDa3jejY1FUca5cN1Qng/yayfgWF6HIJ1LaZ9fF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9gn8TpGf/F5jZfz5s95nHAYC5ARjpTc7OIIYu6ML0WU+TnBm
	/ssjUC6SPJU2qUVnSUjj0s/JKEfdGb2OkcmbKYseJtnYS9wr8a2G6Wv49YlUy7pHFSuMG5trN/4
	qtsJBJ6fio3wFwLH2P3bmLmV2E/dQzoJ0CjEQmGF0
X-Gm-Gg: AeBDieuoNiB5rYG21uFF7Dy2lhBlcpcXNxlSuvbcHC1t85fDUAbimckb+pu5Q52rqj2
	dwNY9hi49MtJku7Mj3eAbcAsbMo8KXKPKDm1TTKGuyTI85s2MpBxn5BGE1yt9Z/kadJe15lETJZ
	US2TKoA6YWkW0B82oWgtPRuZNkQhJKcS8okjj/a4IvPZ4o84J3fZfZhmTzCjGW07aIiq8CPJzsn
	hy1yY1/9FdT7m7yEISdMmxzXkTIigRPnM3acWXHttNJbYuCOJv72PlJnfdZgxh54N126flD7/jL
	r2RRYhdqiQwP9KUUqWje30YFtdmMIJrm394a
X-Received: by 2002:a17:903:18a:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2b278447deamr2342505ad.5.1775143176170; Thu, 02 Apr 2026
 08:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402001740.2220481-1-acme@kernel.org> <20260402001740.2220481-5-acme@kernel.org>
In-Reply-To: <20260402001740.2220481-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Apr 2026 08:19:24 -0700
X-Gm-Features: AQROBzCbwwwgLterahwkSawXu7sj_cbyzwEVnlqo1HxKsQ-aQ9LGGkmr99_ddR8
Message-ID: <CAP-5=fVv=5H-6DOaAr4BSDE=pKrxWDa9oduYbVTozYc-ZeeuRg@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf symbol: Add missing libgen.h include to get
 basename() prototype
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:20=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> This works in some places because there are tricks to prefer a GNU
> version instead of the XPG version, but started breaking in some musl
> libc systems due to some unrelated change that made libgen.h stop being
> included by chance.
>
> Since symbol.h is using basename(), make it include libgen.h.

Huh, this is being flagged by Sashiko:
"""
Could this include cause segmentation faults by exposing the POSIX version
of basename() to the rest of the tools?

According to the POSIX specification, if the input is an empty string
or slashes, basename() can return a pointer to a statically allocated,
read-only string literal (such as "." or "/").

In tools/perf/util/probe-event.c:convert_exec_to_group(), the code takes
the return value of basename() and modifies it in-place:
    ptr =3D basename(exec);
    ...
    for (ptr2 =3D ptr; *ptr2 !=3D '\0'; ptr2++) {
            if (!isalnum(*ptr2) && *ptr2 !=3D '_')
                    *ptr2 =3D '_';
    }
If a user provides an empty target or "/", the POSIX basename() would
return a read-only string. When the loop attempts to write a null or
underscore into it, wouldn't it trigger an immediate segmentation fault?

Is there a way we can safely duplicate the returned string before modifying=
 it,
or ensure the inputs never resolve to these static strings?
"""

The story of the two basename versions and the issues appears in the
man pages. The whole thing makes me think we should avoid basename :-)

Thanks,
Ian

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/symbol.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index c67814d6d6d6f64a..b37ecc2e90f77efe 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -10,6 +10,7 @@
>  #include <linux/rbtree.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <libgen.h>
>  #include "addr_location.h"
>  #include "path.h"
>  #include "symbol_conf.h"
> --
> 2.53.0
>
