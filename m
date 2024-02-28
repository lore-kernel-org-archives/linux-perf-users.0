Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76E1AAC9
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083210; cv=none; b=s6bKkuNJoyQXiL4MBzCcdIf74gwmgCUdWA8QT1fLC1yBer2EVgqhSDcS+ie3qH3P+tIrANNz25MDtvF/foeyyj+lbvYtpocp71NpOmZjB2i/bpxV5n8WEQcyuqdio7VL60GvPwiRFiu2KY8m4cHmxtP//dKukMbQCeFQzRFU0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083210; c=relaxed/simple;
	bh=9qll4EAZp7xZbfC2l/E18PzekDZKS5gdLme9hxcfwr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWoGQ3aeTzh6+AsI25ZMXu8A8yYilgA/f4SMC+LmQziRsGvpWw8xH5REdyjKl+ai5J6/m3zalVTlIOJAF0ZDrPVBADyPEsyzzP5tGba3wGqNvJHKrfsSMNj/jyjpPeMPOBbijbqf+ucccYAa1Fm5jY8xnJ/IHWXWeuoRcfGMudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCXbGul3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCXbGul3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc929e5d99so50805ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 17:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709083208; x=1709688008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTmmVU2YsnEQHc0ghGArOeYhLtN51cwHy7vJLHmcGh8=;
        b=BCXbGul35GPXd6tDmWUySMcr/ACg6BSiijByq/45suXVbckDhVNotvpMvHQKzMMITC
         fHfVdPNfVcculS0O9RWF3fLmwf2tTUpNx8ML8QeW/euhp2eACbWa93UYbYv697DTpuXK
         0NR3TUMFuNoRGG4yZmFxwRc1Ndva7i2zdnTsB1LnKwQUhQm8ZyOaZi2bdQrck4wPOW3r
         mz9C961MFQQ1BJMSxZugldsGyEEWFhQmW0RX01R9xr8FFEypLHgkmF08aFxHFT1CCIBX
         84J2osNoCXjCOe02VRjyU0jR0xrct8Z0EeTokm85mdGZIPcXhsxhAw9kVtpSTLSSThv7
         /VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083208; x=1709688008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTmmVU2YsnEQHc0ghGArOeYhLtN51cwHy7vJLHmcGh8=;
        b=VMMIYjzWLEpdxEXtm97PbadAzw/Tv2fCye0dCO/YLC0G6gDZKoCZx5MngABG1AOh9v
         QG/l0w11272an290h0dR+8rGHiNgngjE40zRZA3kFb5UOPldugL2lve4BQJ04bVBim/a
         AOzLwHkYaEwrQ2oOAPUvvir7cAs76mT+jqoUyPrYSTurBb3dOeftzd+VgLIQG5YOwV5d
         eMfHu5ZLzOGkw8n/HM/qKVARGdfSxjZXug/r7iBRvKmn2IVrKgKd7oN/qfzhtu6LXQDA
         OEnaZGQqPOBxF5gZWjdGFvSQ4x/fNqM7WEdkq56TMXoXTQoSRRUdifo3cUzBEwDiEfQO
         HoGg==
X-Forwarded-Encrypted: i=1; AJvYcCUQSMDJDOq0QFs4b1Fth2MlxGd7FYR5vFzuvN2UfRwymz1OkntDodRLdFMVJbhG6p3/HiASywaT6V8/9NLun+USgpNiYI6tQTt4hUtew9Rz9w==
X-Gm-Message-State: AOJu0Yx8TuRj9eSqO7t997TEf/sz4r5nThKG5GvwsZ0lgPCs193j/hIO
	Gqd8lkRnUVlVoAjqUXMnhhyc8F87fUr2D/yzXQzRflToJwLen1W1V0lsLjl/CwNzBGY/CYKVvc2
	Wpb4i73OW6K4WZG4HejIYVBl6qgRp0uwOv/GR
X-Google-Smtp-Source: AGHT+IF59eNnnySegsKhfnfzXYM07i5Fgsx6xFLHCRkXQs7BnMoj+MUqztMGZD2zxbeHPnGH23UuKKSLPu/28cL7+B0=
X-Received: by 2002:a17:902:fa0f:b0:1dc:8841:43f2 with SMTP id
 la15-20020a170902fa0f00b001dc884143f2mr48794plb.26.1709083207590; Tue, 27 Feb
 2024 17:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org> <20240228005230.287113-2-namhyung@kernel.org>
In-Reply-To: <20240228005230.287113-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 17:19:56 -0800
Message-ID: <CAP-5=fVUqFbvYp_g5PL9e4on=5gF1YE42-w-XMTrFxOZJ+JrXw@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf annotate: Add a hashmap for symbol histogram
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Now symbol histogram uses an array to save per-offset sample counts.
> But it wastes a lot of memory if the symbol has a few samples only.
> Add a hashmap to save values only for actual samples.
>
> For now, it has duplicate histogram (one in the existing array and
> another in the new hash map).  Once it can convert to use the hash
> in all places, we can get rid of the array later.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 40 +++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/annotate.h |  2 ++
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 107b264fa41e..7a70e4d35c9b 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -38,6 +38,7 @@
>  #include "arch/common.h"
>  #include "namespaces.h"
>  #include "thread.h"
> +#include "hashmap.h"
>  #include <regex.h>
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
> @@ -863,6 +864,17 @@ bool arch__is(struct arch *arch, const char *name)
>         return !strcmp(arch->name, name);
>  }
>
> +/* symbol histogram: key =3D offset << 16 | evsel->core.idx */
> +static size_t sym_hist_hash(long key, void *ctx __maybe_unused)
> +{
> +       return (key >> 16) + (key & 0xffff);
> +}
> +
> +static bool sym_hist_equal(long key1, long key2, void *ctx __maybe_unuse=
d)
> +{
> +       return key1 =3D=3D key2;
> +}
> +
>  static struct annotated_source *annotated_source__new(void)
>  {
>         struct annotated_source *src =3D zalloc(sizeof(*src));
> @@ -877,6 +889,8 @@ static __maybe_unused void annotated_source__delete(s=
truct annotated_source *src
>  {
>         if (src =3D=3D NULL)
>                 return;
> +
> +       hashmap__free(src->samples);
>         zfree(&src->histograms);
>         free(src);
>  }
> @@ -909,6 +923,14 @@ static int annotated_source__alloc_histograms(struct=
 annotated_source *src,
>         src->sizeof_sym_hist =3D sizeof_sym_hist;
>         src->nr_histograms   =3D nr_hists;
>         src->histograms      =3D calloc(nr_hists, sizeof_sym_hist) ;
> +
> +       if (src->histograms =3D=3D NULL)
> +               return -1;
> +
> +       src->samples =3D hashmap__new(sym_hist_hash, sym_hist_equal, NULL=
);
> +       if (src->samples =3D=3D NULL)
> +               zfree(&src->histograms);
> +
>         return src->histograms ? 0 : -1;
>  }
>
> @@ -920,6 +942,7 @@ void symbol__annotate_zero_histograms(struct symbol *=
sym)
>         if (notes->src !=3D NULL) {
>                 memset(notes->src->histograms, 0,
>                        notes->src->nr_histograms * notes->src->sizeof_sym=
_hist);
> +               hashmap__clear(notes->src->samples);
>         }
>         if (notes->branch && notes->branch->cycles_hist) {
>                 memset(notes->branch->cycles_hist, 0,
> @@ -983,8 +1006,10 @@ static int __symbol__inc_addr_samples(struct map_sy=
mbol *ms,
>                                       struct perf_sample *sample)
>  {
>         struct symbol *sym =3D ms->sym;
> +       long hash_key;
>         unsigned offset;
>         struct sym_hist *h;
> +       struct sym_hist_entry *entry;
>
>         pr_debug3("%s: addr=3D%#" PRIx64 "\n", __func__, map__unmap_ip(ms=
->map, addr));
>
> @@ -1002,15 +1027,28 @@ static int __symbol__inc_addr_samples(struct map_=
symbol *ms,
>                          __func__, __LINE__, sym->name, sym->start, addr,=
 sym->end, sym->type =3D=3D STT_FUNC);
>                 return -ENOMEM;
>         }
> +
> +       hash_key =3D offset << 16 | evidx;
> +       if (!hashmap__find(src->samples, hash_key, &entry)) {
> +               entry =3D zalloc(sizeof(*entry));
> +               if (entry =3D=3D NULL)
> +                       return -ENOMEM;
> +
> +               if (hashmap__add(src->samples, hash_key, entry) < 0)
> +                       return -ENOMEM;
> +       }
> +
>         h->nr_samples++;
>         h->addr[offset].nr_samples++;
>         h->period +=3D sample->period;
>         h->addr[offset].period +=3D sample->period;
> +       entry->nr_samples++;
> +       entry->period +=3D sample->period;
>
>         pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRI=
x64
>                   ", evidx=3D%d] =3D> nr_samples: %" PRIu64 ", period: %"=
 PRIu64 "\n",
>                   sym->start, sym->name, addr, addr - sym->start, evidx,
> -                 h->addr[offset].nr_samples, h->addr[offset].period);
> +                 entry->nr_samples, entry->period);
>         return 0;
>  }
>
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 94435607c958..a2b0c8210740 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -12,6 +12,7 @@
>  #include "symbol_conf.h"
>  #include "mutex.h"
>  #include "spark.h"
> +#include "hashmap.h"

nit: This could just be a forward reference to keep the number of
header files down.

Thanks,
Ian

>
>  struct hist_browser_timer;
>  struct hist_entry;
> @@ -280,6 +281,7 @@ struct annotated_source {
>         size_t                  sizeof_sym_hist;
>         struct sym_hist         *histograms;
>         struct annotation_line  **offsets;
> +       struct hashmap          *samples;
>         int                     nr_histograms;
>         int                     nr_entries;
>         int                     nr_asm_entries;
> --
> 2.44.0.rc1.240.g4c46232300-goog
>
