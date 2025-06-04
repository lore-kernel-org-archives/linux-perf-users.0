Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CF1537A7
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052871; cv=none; b=l9T/6as1A/JExwL+Q9eC6XwsSTMFcEVP+k+w8yQNHDlnCpCRpPdWkpSb9I/UVXhUQlYt4yrTRtmYLHIH65Dqs+SyEW+il1KXZWYTGzo1dUA9geVmvxLTQlU1mihvKAkcl2c0PjC/5P6t+1slacIc8CVZrJb+pC274ZqQ/VUcU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052871; c=relaxed/simple;
	bh=ZNaiqJz3y1AytvrDmYno/j8yL7gmDpOSKywYWodv1CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7cTymLJ/HUJanFF+lCaOJn0AJ02cbstpOI1TDdCX8Jfw814/IJ/8KC0pprgbas10/iQZtiuu76JJJoYv0OhV8ZAgBfivYakxXMNGrUt9iToM2zcz8LdzlJ582h4Z5p2Ra9jVObQGitPteWVEB7sGMaz4vMOAVxMDtUtmXiIov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxXIqpF/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxXIqpF/"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so169435ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749052868; x=1749657668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY3VE9czFQShKHXxZIP9vZtbMEDzffpXg7Q/CD6REI8=;
        b=cxXIqpF/ZDCtiHFTvEgqfM8TFUn9gF/6P1FlR9g2/VNLPqxOB5oTuiU91X8z+uifqG
         wLDlLWqzoNqyB9lR/2ArCHziTusiSYv6yAksJJ101Ih9EW3VjjRU3osrDbgYoybQ/NrQ
         4d0CWmVlY/q5lfC71AkfzetQ1M7a1401QAy4cuz9Kgf5JxSAS6YJ/d5O30NfIUj59K8b
         H829CR2B4E2Tx6IPJgI3+m5K+bHmWCc7iSoOvLfjAQiXBm3PJ/oN+NPfZ+H1knL9cEnU
         XLltSE8YUUNDZ0b2fVXgsjIG69bNfSWIO8jMSnrw/exgmZdunfwOARTjsAlC6ra8Oc0D
         Dlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749052868; x=1749657668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY3VE9czFQShKHXxZIP9vZtbMEDzffpXg7Q/CD6REI8=;
        b=gQwmbr9FB1dAGg9BKrocIGJUyim58cQ6J+ktewTkhhXzVPtvvuXK24mb2PoIJyhJ2G
         LlzcIbNDRkUtoiK2fqyckwDMtNHxPyXwXnWPlPOsUyotHJoajP0bAsjY5PBS5MDbHjFh
         Xrh4Ed1tL0uko5OeNkhGxUX+XVLcnA9SbaqW5CV+7MOr7h3VHp80riCG9E4KLyKZe11J
         ZoJWYt4UmkA928ykhUZRz1Gvr5/vyQgvp0Oh1Qyd5B7XhIxOn18INYMoSkppQ27S8ADE
         dk9vyx5qbGfTj9WMVSouvDdx/kDUPSNoXHl54d5hAm9oFh44DSdUaxksN5uwSERp9vj4
         shkw==
X-Forwarded-Encrypted: i=1; AJvYcCVyYfcD7OpVKIOd7iT3q1Hakzzq1yt/ocAZJD497YDFrZNxlzZZuTEzRqCqBI1KHAhXXE/Q0zAO7wNAQGwMK3Q3@vger.kernel.org
X-Gm-Message-State: AOJu0YzA69QZxp4/RRz9ZwmJ8mckQffM6hh0uL5ungX1DIf/z66/4wu2
	Knh0rUeEtM59AmZEpZoOtuaxElNO/jKujXZ8nVgFxtUiKJ23HiNlh1ZlloCfjMUHVnVsRelhc/E
	kPjXNaoVz6NYujF4Aglup9MCepK3muRjzz9AuKTKN
X-Gm-Gg: ASbGncuBAdzM6ZjKBBdQkwc96GhNw/4stc4yL22qrUs4jZlLnEF0DK/V8nPnwFpFuzu
	pgvtpHEDtyzl+T8CaUB1sJpei3PjP+dAvgbQ/Jj4Z+twdByJ/kHyCeLiy9EsHekSihkTNAg2Lty
	L03OW4Az9UuLsYeSSfcIGhNDSgPK+7v9LswVD01Fg6k/9iZjQw9YONx7afK7onQZNBEdPsJt7gk
	M3kB4rEwA==
X-Google-Smtp-Source: AGHT+IG58E6QDHHMSgG62IIRKhYq/xB75dJaFUT7r81uMOGD1R9JRmeQRMlDFC4MLC5KlZ6EIiSSMdQcueXWylyXmEw=
X-Received: by 2002:a05:6e02:3712:b0:3dc:7e01:6f6a with SMTP id
 e9e14a558f8ab-3ddbe7f1920mr4326265ab.26.1749052868151; Wed, 04 Jun 2025
 09:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604054234.23608-1-namhyung@kernel.org>
In-Reply-To: <20250604054234.23608-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Jun 2025 09:00:56 -0700
X-Gm-Features: AX0GCFsPBzBYxeEG_xn9wHFKD76SA0WA2zT1oLAKGF42jZeceXnvQLoTylM5ZMY
Message-ID: <CAP-5=fUwjAwyhKc=RGfKnZoPz9iKiVyKfBOYxm7EuP2QRsnhgw@mail.gmail.com>
Subject: Re: [PATCH] perf bpf-filter: Improve error messages
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BPF filter needs libbpf/BPF-skeleton support and root privilege.
> Add error messages to help users understand the problem easily.
>
> When it's not build with BPF support (make BUILD_BPF_SKEL=3D0).
>
>   $ sudo perf record -e cycles --filter "pid !=3D 0" true
>   Error: BPF filter is requested but perf is not built with BPF.
>         Please make sure to build with libbpf and BPF skeleton.
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>           --filter <filter>
>                             event filter
>
> When it supports BPF but runs without root or CAP_BPF.  Note that it
> also checks pinned BPF filters.
>
>   $ perf record -e cycles --filter "pid !=3D 0" -o /dev/null true
>   Error: BPF filter only works for users with the CAP_BPF capability!
>         Please run 'perf record --setup-filter pin' as root first.
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>           --filter <filter>
>                             event filter
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf-filter.c | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/bpf-filter.h |  3 +++
>  tools/perf/util/cap.c        |  1 -
>  tools/perf/util/cap.h        |  5 +++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index a4fdf6911ec1c32e..92e2f054b45e91dd 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -52,6 +52,7 @@
>  #include <internal/xyarray.h>
>  #include <perf/threadmap.h>
>
> +#include "util/cap.h"
>  #include "util/debug.h"
>  #include "util/evsel.h"
>  #include "util/target.h"
> @@ -618,11 +619,38 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__=
new(enum perf_bpf_filter_term
>         return expr;
>  }
>
> +static bool check_bpf_filter_capable(void)
> +{
> +       bool used_root;
> +
> +       if (perf_cap__capable(CAP_BPF, &used_root))
> +               return true;
> +
> +       if (!used_root) {
> +               /* Check if root already pinned the filter programs and m=
aps */
> +               int fd =3D get_pinned_fd("filters");
> +
> +               if (fd >=3D 0) {
> +                       close(fd);
> +                       return true;
> +               }
> +       }
> +
> +       pr_err("Error: BPF filter only works for %s!\n"
> +              "\tPlease run 'perf record --setup-filter pin' as root fir=
st.\n",
> +              used_root ? "root" : "users with the CAP_BPF capability");
> +
> +       return false;
> +}
> +
>  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
>  {
>         YY_BUFFER_STATE buffer;
>         int ret;
>
> +       if (!check_bpf_filter_capable())
> +               return -EPERM;
> +
>         buffer =3D perf_bpf_filter__scan_string(str);
>
>         ret =3D perf_bpf_filter_parse(expr_head);
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> index 916ed7770b734f15..187e5bbcc5910d78 100644
> --- a/tools/perf/util/bpf-filter.h
> +++ b/tools/perf/util/bpf-filter.h
> @@ -2,6 +2,7 @@
>  #ifndef PERF_UTIL_BPF_FILTER_H
>  #define PERF_UTIL_BPF_FILTER_H
>
> +#include <stdio.h>
>  #include <linux/list.h>
>
>  #include "bpf_skel/sample-filter.h"
> @@ -38,6 +39,8 @@ int perf_bpf_filter__unpin(void);
>  static inline int perf_bpf_filter__parse(struct list_head *expr_head __m=
aybe_unused,
>                                          const char *str __maybe_unused)
>  {
> +       fprintf(stderr, "Error: BPF filter is requested but perf is not b=
uilt with BPF.\n"
> +               "\tPlease make sure to build with libbpf and BPF skeleton=
.\n");

Generally LGTM. This needs to be a pr_err otherwise nothing will be
displayed with TUI.

Thanks,
Ian

>         return -EOPNOTSUPP;
>  }
>  static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_u=
nused,
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index 69d9a2bcd40bfdd1..24a0ea7e6d97749b 100644
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c
> @@ -7,7 +7,6 @@
>  #include "debug.h"
>  #include <errno.h>
>  #include <string.h>
> -#include <linux/capability.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
>
> diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
> index 0c6a1ff55f07340a..c1b8ac033ccc5826 100644
> --- a/tools/perf/util/cap.h
> +++ b/tools/perf/util/cap.h
> @@ -3,6 +3,7 @@
>  #define __PERF_CAP_H
>
>  #include <stdbool.h>
> +#include <linux/capability.h>
>
>  /* For older systems */
>  #ifndef CAP_SYSLOG
> @@ -13,6 +14,10 @@
>  #define CAP_PERFMON    38
>  #endif
>
> +#ifndef CAP_BPF
> +#define CAP_BPF                39
> +#endif
> +
>  /* Query if a capability is supported, used_root is set if the fallback =
root check was used. */
>  bool perf_cap__capable(int cap, bool *used_root);
>
> --
> 2.49.0
>
