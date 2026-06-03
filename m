Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADA3AD511
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499712; cv=pass; b=U5k+auVoxr2568pg8BJQK4Q5Bh7s7L8v1XxJZIdcbl9zeUUR2kLmmXj0PvBxNp3xPAbmyzDvf6wo9M+bT5lL5uZlbZxjvI6Wueb4CMQlyalr/h29ymd6IeOZ0BJ+EE7YFDOlp/+S4+PrA4PL+UtJikcT8+UawTFaJqGU6tNOBM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499712; c=relaxed/simple;
	bh=mMCgskGYG/dl8P3hjOmcIu+xGserJlQ3jY4yovmQYOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttyCGoJd8HjXStZlwgQElM555IePQOhlDhINS9nwyUjgQRGohAD0ni10s3lWWpoonuCAZV3h4vGnTcT7e1DFy7/ovQh99CPurQJHeIBVonuUQCD1htR1NDEYn4H1iogivpvMv/fwiL/1KxUL8EpZha4dKYFlR24qEfgATvouHhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXwV0R0H; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXwV0R0H"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2d865383so79205ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499709; cv=none;
        d=google.com; s=arc-20240605;
        b=aUzVkWibVM1QmVqO0jxfflMMCD0XVua63ca84QYofuWqx2EHCQw9uYzUFkoX2TCvSy
         f7oOqCqJScCDT3v3I6/OhS+UJyoYc15SidH5HVbzdqBf4+/QOqJpUtir9QKxwy3JVPk/
         DqLrhwcxlBDNP8hnNwkNerwtsru3sC+2r5wYfAKK7S5/tGWHakCmMqGe8VJR73A7zkMw
         ssmwEeZMYb+k4kB1h+/U6tZAPlcF4PDmWK7AU/SZxDlPm0lO6nhIuVgQoYM6Kh/Y9tuC
         I5q4ADBOuRqBNBSGJnd+mE8UuIBEzDCWzg8yJj7FyRgnL15iprQdky5QOXMd5MrHkD95
         /ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ym6tQRNPKFTLb+pXIWlwZB9USX6GeKEFLSERypAIDpE=;
        fh=PPbSbqLSk/5r8Dol2BSsU+W97PPSwrkLdtoBqG6sucg=;
        b=gs3l5XZA7c6+MSGzf7g0RsW4DlFkJ9sBHv35fNx7a79ybabgfYd3EBkFZCDsbZ4HXa
         2o3kQK6vKGN6wJuspEqqDLODKTystkaNxoOZuWbuhIVhrFXGLbXLtM2R/dJVw57n4g6E
         e2j8nbphbBbV37qo7EnevcsA7sI0ON6Ai9/m7mv74QgBR2bVa9uTOM9MxpA7ya7HDsg1
         ON/t3SuRSsCGxer9k4AzwHZCdZjzzcXARcpt7Ez4iBA12A2KNieFDayy+NyunGfc/Tz3
         /NpkfGCBTnFEN83rFMDTNZJXAMAkAhRi9d6FV7U+lBawQH/zVDui6u2xI8zz3jKeBXo2
         0RRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499709; x=1781104509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym6tQRNPKFTLb+pXIWlwZB9USX6GeKEFLSERypAIDpE=;
        b=wXwV0R0HzC0h1Wb65BQ/7GUx/Is+BQ8RKI38HaTfrIbaAslIHy0cGSkzH+KiFtCjMJ
         ca1NWPGxk8Y4tfMzB9rR7zARYDOYn6M8N+k7d5dRJGO7c5HRAiVQOS3MBtl1DhuFNRsZ
         LIiFxTmeXueF6YckUC97WMyySed48JdVKOmBhtwGWwFINGWb/2H784B09iWc0hWB3nnm
         vHRpJ8LeuE/BZV42WX6DRBSWvYIqocVcD9RAmQVO4hS79KnVzuqLoztDbv2Bb3rZFjwj
         myBbyFteaHElRKfPas73eftmDzr01WCoVLKda4OCmigFdtA6S2+uRBWfhYPlfwqjgg4A
         2kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499709; x=1781104509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ym6tQRNPKFTLb+pXIWlwZB9USX6GeKEFLSERypAIDpE=;
        b=HnZWE7PYO/iSaR99gYaRTVTVj9MJSOni/tZix8IXCTZh9325Znvyu2EHvy81TyKOoT
         rvzuQS1MP7kwsn6CtUTYCK4hA/FlT1Wrh9brOWAHQuu3JQ9v+/MS1/T/utVZc+jUbe5N
         sqQNZA323rE608Lp8Jh7a462CO/BKuJf8kwWSfL7j/XPQtyuq49mVSWm2qdNsxc3dEc8
         Tikkyunno/LgwZmJNnnGu5q4A+R8FGC0eiciGlJB797xvN7IojETjRqJEVeKNXVcy1kO
         G1OoXFtU4XMHvAm5mQeCfBTimNZ+g1OlwI0GGr0vizYcEXLjLTAZRGXGve0IrCcLnCRH
         REJA==
X-Forwarded-Encrypted: i=1; AFNElJ9qcafVbZvn4cPeBbMT+Em2IW8GSRuyeoSLaUipgeSVNP9070h80fKVfTX/NmJhdG+329O4VjUQhaY6Q5htf6/f@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIeMg4iNRs9cvoAcs8lagBIBcASh9CabCgeBlZTLsMEt54Vo6
	XkXizvxPMrvsbJC6UYDKvNOwgIZxaWnwRSp7p2iRtOvWrsnJ18lpR+9mNqRXYGE7C+omGZEFpTz
	lPZI/+/caHMGJbvhVaXvwfHFl5etz90zGJqw4g8Et
X-Gm-Gg: Acq92OEoaQSUIXKbATh4osW5JiEvYvRwT+AXHRGTTO9wJ6BZa1rgktGVeGZac13O+cr
	Ob2/utFJz/redgXWFkFe/3WrmWi3LWZj0TAjwSAEtSbeuMsbPfy8D/nKSlj0OIjPfR20WONTW58
	C06vteObvemLRh42FvVJEPCToH7jduASpL6JC/r7DLQPOOU7KAy+0h2WTKzGfRjV//iDhmqTji0
	5yr9s8jZaW+wR51CnmAsS95kg4G1PIWJgPYfpzttpdlMHRDcXparxsgYIoD1uRaDhW6JBND+1Hs
	qir1uCYQ15mX77RXTp9MIyrsO+1JzQqihtJoxLhrwJRZ59Ks
X-Received: by 2002:a17:902:d591:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2c16fb11c51mr1756555ad.11.1780499707915; Wed, 03 Jun 2026
 08:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-6-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:14:56 -0700
X-Gm-Features: AVHnY4Kh4x8K8trjtJRY8oG_OWf3my0UfPoqS1xWViQ9x4Ig4IQSfoFGf4aS5Bw
Message-ID: <CAP-5=fWhv3z04MkKPL6fHgmpoPCOgk321c=+HUOfvTXaqzevHw@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf tools: Include file offset and event type name
 in skip messages
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add the perf.data file offset and use perf_event__name() instead of raw
> event type integers in the 'problem processing event, skipping it'
> messages emitted by process_sample_event() callbacks across annotate,
> c2c, diff, kmem, kvm, kwork, lock, report, script, and build-id.
>
> This lets users cross-reference skipped events with 'perf report -D'
> output.  Also add explicit #include "util/event.h" and <inttypes.h>
> where needed to avoid depending on transitive includes.
>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-annotate.c |  5 +++--
>  tools/perf/builtin-c2c.c      |  5 +++--
>  tools/perf/builtin-diff.c     |  8 +++++---
>  tools/perf/builtin-kmem.c     |  6 ++++--
>  tools/perf/builtin-kvm.c      |  9 ++++++---
>  tools/perf/builtin-kwork.c    |  4 +++-
>  tools/perf/builtin-lock.c     |  6 ++++--
>  tools/perf/builtin-report.c   |  9 ++++++---
>  tools/perf/builtin-script.c   | 10 ++++++----
>  tools/perf/util/build-id.c    |  5 +++--
>  10 files changed, 43 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 5f450c8093c09210..b918f9eed5fd2441 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -288,8 +288,9 @@ static int process_sample_event(const struct perf_too=
l *tool,
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_warning("problem processing %d event, skipping it.\n",
> -                          event->header.type);
> +               pr_warning("problem processing %s (%u) event at offset %#=
" PRIx64 ", skipping it.\n",
> +                          perf_event__name(event->header.type), event->h=
eader.type,
> +                          sample->file_offset);
>                 ret =3D -1;
>                 goto out_put;
>         }
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 36f38694992386ad..d3503be9350c03bb 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -328,8 +328,9 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_debug("problem processing %d event, skipping it.\n",
> -                        event->header.type);
> +               pr_debug("problem processing %s (%u) event at offset %#" =
PRIx64 ", skipping it.\n",
> +                        perf_event__name(event->header.type), event->hea=
der.type,
> +                        sample->file_offset);
>                 ret =3D -1;
>                 goto out;
>         }
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index b4ff863b304ca046..9592f44b6545bab6 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -409,8 +409,9 @@ static int diff__process_sample_event(const struct pe=
rf_tool *tool,
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_warning("problem processing %d event, skipping it.\n",
> -                          event->header.type);
> +               pr_warning("problem processing %s (%u) event at offset %#=
" PRIx64 ", skipping it.\n",
> +                          perf_event__name(event->header.type), event->h=
eader.type,
> +                          sample->file_offset);
>                 ret =3D -1;
>                 goto out;
>         }
> @@ -436,7 +437,8 @@ static int diff__process_sample_event(const struct pe=
rf_tool *tool,
>         case COMPUTE_STREAM:
>                 if (hist_entry_iter__add(&iter, &al, PERF_MAX_STACK_DEPTH=
,
>                                          NULL)) {
> -                       pr_debug("problem adding hist entry, skipping eve=
nt\n");
> +                       pr_debug("problem adding hist entry at offset %#"=
 PRIx64 ", skipping event\n",
> +                                sample->file_offset);
>                         goto out;
>                 }
>                 break;
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 33585e353efe56cc..e1b2f5bc1ba8d887 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -22,6 +22,7 @@
>  #include "util/cpumap.h"
>
>  #include "util/debug.h"
> +#include "util/event.h"
>  #include "util/string2.h"
>  #include "util/util.h"
>
> @@ -987,8 +988,9 @@ static int process_sample_event(const struct perf_too=
l *tool __maybe_unused,
>                                                         sample->tid);
>
>         if (thread =3D=3D NULL) {
> -               pr_debug("problem processing %d event, skipping it.\n",
> -                        event->header.type);
> +               pr_debug("problem processing %s (%u) event at offset %#" =
PRIx64 ", skipping it.\n",
> +                        perf_event__name(event->header.type), event->hea=
der.type,
> +                        sample->file_offset);
>                 return -1;
>         }
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index dd2ed21596aa59f9..394302ebdb161077 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -22,6 +22,7 @@
>  #include "util/synthetic-events.h"
>  #include "util/top.h"
>  #include "util/data.h"
> +#include "util/event.h"
>  #include "util/ordered-events.h"
>  #include "util/kvm-stat.h"
>  #include "util/util.h"
> @@ -1141,14 +1142,16 @@ static int process_sample_event(const struct perf=
_tool *tool,
>                 return 0;
>
>         if (machine__resolve(machine, &kvm->al, sample) < 0) {
> -               pr_warning("Fail to resolve address location, skip sample=
.\n");
> +               pr_warning("WARNING: at offset %#" PRIx64 ": fail to reso=
lve address location, skipping sample\n",
> +                          sample->file_offset);
>                 return 0;
>         }
>
>         thread =3D machine__findnew_thread(machine, sample->pid, sample->=
tid);
>         if (thread =3D=3D NULL) {
> -               pr_debug("problem processing %d event, skipping it.\n",
> -                       event->header.type);
> +               pr_debug("problem processing %s (%u) event at offset %#" =
PRIx64 ", skipping it.\n",
> +                        perf_event__name(event->header.type), event->hea=
der.type,
> +                        sample->file_offset);
>                 return -1;
>         }
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 99dc293a0744726e..110de3507d48160c 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -9,6 +9,7 @@
>  #include "perf.h"
>
>  #include "util/data.h"
> +#include "util/event.h"
>  #include "util/evlist.h"
>  #include "util/evsel.h"
>  #include "util/header.h"
> @@ -897,7 +898,8 @@ static int timehist_exit_event(struct perf_kwork *kwo=
rk,
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_debug("Problem processing event, skipping it\n");
> +               pr_debug("problem processing event at offset %#" PRIx64 "=
, skipping it\n",
> +                        sample->file_offset);
>                 ret =3D -1;
>                 goto out;
>         }
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 94a8c35abb0bc991..5841d43be9718414 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -21,6 +21,7 @@
>  #include "util/tracepoint.h"
>
>  #include "util/debug.h"
> +#include "util/event.h"
>  #include "util/session.h"
>  #include "util/tool.h"
>  #include "util/data.h"
> @@ -1433,8 +1434,9 @@ static int process_sample_event(const struct perf_t=
ool *tool __maybe_unused,
>                                                         sample->tid);
>
>         if (thread =3D=3D NULL) {
> -               pr_debug("problem processing %d event, skipping it.\n",
> -                       event->header.type);
> +               pr_debug("problem processing %s (%u) event at offset %#" =
PRIx64 ", skipping it.\n",
> +                        perf_event__name(event->header.type), event->hea=
der.type,
> +                        sample->file_offset);
>                 return -1;
>         }
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 973d97af85019e6e..cd052aa78132b65f 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -27,6 +27,7 @@
>
>  #include "perf.h"
>  #include "util/debug.h"
> +#include "util/event.h"
>  #include "util/evlist.h"
>  #include "util/evsel.h"
>  #include "util/evswitch.h"
> @@ -284,8 +285,9 @@ static int process_sample_event(const struct perf_too=
l *tool,
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_debug("problem processing %d event, skipping it.\n",
> -                        event->header.type);
> +               pr_debug("problem processing %s (%u) event at offset %#" =
PRIx64 ", skipping it.\n",
> +                        perf_event__name(event->header.type), event->hea=
der.type,
> +                        sample->file_offset);
>                 ret =3D -1;
>                 goto out_put;
>         }
> @@ -332,7 +334,8 @@ static int process_sample_event(const struct perf_too=
l *tool,
>
>         ret =3D hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
>         if (ret < 0)
> -               pr_debug("problem adding hist entry, skipping event\n");
> +               pr_debug("problem adding hist entry at offset %#" PRIx64 =
", skipping event\n",
> +                        sample->file_offset);
>  out_put:
>         addr_location__exit(&al);
>         return ret;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 5124edf2b7a692b2..f4aa255fc3297f90 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2693,8 +2693,9 @@ static int process_sample_event(const struct perf_t=
ool *tool,
>                 goto out_put;
>
>         if (!al.thread && machine__resolve(machine, &al, sample) < 0) {
> -               pr_err("problem processing %d event, skipping it.\n",
> -                      event->header.type);
> +               pr_err("problem processing %s (%u) event at offset %#" PR=
Ix64 ", skipping it.\n",
> +                      perf_event__name(event->header.type), event->heade=
r.type,
> +                      sample->file_offset);
>                 ret =3D -1;
>                 goto out_put;
>         }
> @@ -2775,8 +2776,9 @@ static int process_deferred_sample_event(const stru=
ct perf_tool *tool,
>                 goto out_put;
>
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_err("problem processing %d event, skipping it.\n",
> -                      event->header.type);
> +               pr_err("problem processing %s (%u) event at offset %#" PR=
Ix64 ", skipping it.\n",
> +                      perf_event__name(event->header.type), event->heade=
r.type,
> +                      sample->file_offset);
>                 ret =3D -1;
>                 goto out_put;
>         }
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index af4d874f13810ffe..8c0a9ae932aa5798 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -10,6 +10,7 @@
>  #include "util.h" // lsdir(), mkdir_p(), rm_rf()
>  #include <dirent.h>
>  #include <errno.h>
> +#include <inttypes.h>
>  #include <stdio.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> @@ -62,8 +63,8 @@ int build_id__mark_dso_hit(const struct perf_tool *tool=
 __maybe_unused,
>                                                         sample->tid);
>
>         if (thread =3D=3D NULL) {
> -               pr_err("problem processing %d event, skipping it.\n",
> -                       event->header.type);
> +               pr_err("problem processing %s event at offset %#" PRIx64 =
", skipping it.\n",
> +                      perf_event__name(event->header.type), sample->file=
_offset);
>                 return -1;
>         }
>
> --
> 2.54.0
>
