Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22537EFF8
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787007250; cv=pass; b=eYDkWaf/WxS1e8e2xmioHMhCLhip7ekd2CEA5XALG8+Q0rAKVTGd9NlRATz9GBvRi3g4icWVy67lqDKuo2p1ajyeJWyEcsFXXKjVHTUjHyKsR06dbyL/r4pATVKyZWNDWaP/Xpr4Pgk0M2Z1hkKHqhajajbSEglwAJzfua0GQS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787007250; c=relaxed/simple;
	bh=f7SVEOs0gGdPgecK6vMLY1BMDwewsovDEnEdtygwKQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lex6mKZ0v/vol1dMOoPmaJRi14YojzYHtVLM1bLhmh3+5u8ds/8x1lSbm9l6qY/gbRzVIHnMtM231KcUGn/Ri19q7f+RJk4XWI2spz+ltt2xEw9SPIT5wDNTByUtLt47s8VE2gtP/k+wLlpuGp6HFTZz+LgemMQb6MLNiiQWaOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHsV9oBb; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHsV9oBb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c15a5b265so105991cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 15:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787007246; cv=none;
        d=google.com; s=arc-20260327;
        b=sHyYvbspEbTFWAAz0sp3YmJctD8lWk69SraXidyuweQWjToLdZ9Nn+2sNHzmAy6yP/
         8kdp4v3jjT7N4vPJnj/+2wAItM5aQnDE4cfQ1zaZbKJHZcNY0bGnjftl6VGBSMmZwa1E
         n4RRScDoiDzMJZNXHB98rDFkN28dF7HhKzIPxntET+PNVI/hgryBN6vb7aY+JbYYFULh
         51mgqudH+n5uuapbiN4Jc5UHxW6gm2SZgfA/OLt6/Vi7TXJN0IlG+52cNBLsEk0F39J9
         fZ2JpcuSNydkPIZvJdkS3tdTWDFakFle8Rlnwgnx6s0QFeq9/mQwlNPCuXZhmNr2ktMQ
         f6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEoMVJPdwdIY5j8kd7fUPnK5EFHnTbHkeT8x/n0Iq8Q=;
        fh=aYnjpEuKvMfWNaFGKq9C0mIvTgNcZcNh4dkdaII5WT8=;
        b=dniQhpIOBNfqIMX4KM9V7iKP/QoIlpKKmXOgBS1NpUj6LVtwjDcm70LDyOKKjtU6Qv
         qiW0AxvQX3p6InUZTn0S30xaJ1OeJueHfVmX6JQzKG2BaNIHKL9R2kl4CFuDHPTxERpL
         dIZ/JU0TTvdoKFF+cHdvOGDxIaupWSg+fUzdWTX7aEzs0AIIhioYTT1a/kzLf0mw+RGE
         3bWPkk9dfwxcwVxY62GeUTWSqDjW/gRAOLikhv+kvTpJH+/B4udw8rKAnqOwoWHQHbPO
         jQGKiMhV83dJ/zZZfNLzjILMWN/iryONe4SOYUn02xVC1tN68Au2ouDMyJuXh0zILXBf
         rsuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787007246; x=1787612046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEoMVJPdwdIY5j8kd7fUPnK5EFHnTbHkeT8x/n0Iq8Q=;
        b=nHsV9oBbxF/PKU6+P1IelbPZEh50/6f76mB4rm0E/zdZmgits+sK2j0eVPGcDTWL/S
         BwS6uGIjpXxxSpa15zGeaQCAGcNd+oN07SI0dh2iZDYny6CjuTF7AQ5xl43AvPAuFbZF
         bEaoKGqYjVSP89F79gUoyNCfFRm9ZmqNTl+WnO8SMdemym3qz/vgQBzWWsqM4GNLmwnh
         hAMn0AMLWw8OkYnKKntvCCeOr77JlX8gFEh+y9WtpjJuBqtbVKXT7pDhwK5+ztMzEXpN
         EjKUarwVQQNuI2lQj/SEagYv9OZaolWdqi357FiUomjDU0geh08h3Hh2+QE9Xq1CO+n5
         s5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787007246; x=1787612046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEoMVJPdwdIY5j8kd7fUPnK5EFHnTbHkeT8x/n0Iq8Q=;
        b=rF7ctVDeSBlLRFOchus57r6jm2M0PcC43evftFkAxSs7QhodqFgeQNdACJEwBO6cuV
         T/wBerVZJUgXtQbicXKSLSwO8Y+xn+qWnl3KyYJUWdI2vXWZZZtLbGLFiB8/MYA1fUN7
         BW3JjgSsGX7D+31cY8oKDofDJilYGihpgGTxDdJ4/++iIy29/D1VY1cxRZm9VaFytAKV
         bjCf0lMhbs5wqSQaK4SJwnoCE5BlT8t6qNZtkVcB04+9uKpEa7mHsRDHkYVCeQ7XWxD5
         l9S/AgqWzxG+dw/X09JAD+GM0a9fd2sfjvptvcvgpCV6WV4QAAYpun9L7DTX4OJEqd6t
         /ZgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZzVCeLnXDYdspxKoONBDSelOFiozuz4OektCXksR7kk5TDAK7HxWIhRzUxDETrcJE1enoEaHwQy4b2SHMIPA/@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6oKdn6VgcFASk9vO6hM3gVhrWktjGkqNAWbwWDz2WQ28/p0y
	R+snbe+RhsXWhDrEIni6ES2oL1HhPESdabjIE7oUafE1xKZJAlCaB7/9M63qx/RxZKO42O/RCxJ
	lfInrkOhz3hzhx/vguID7USNR6zsKikzBct2wfxj/
X-Gm-Gg: AR+sD11uzaqdig95eb+TqKF7x0DW48bKxuKe4+kO/tMaZiuUEXkRP122EBNRo8gN/bH
	G83EucNqzldWUO1ZYlJuhAZ/nc1ZP4gWdukwrT5enszXqefwbI3dG91+IEy5OGS7dsGaqnexKUQ
	S3UPAGP7c5cGfGco6z5a7c/m5tAxvRaYZeucqpIJugfSFnJHdlt56PeXHBenwSOHfrof1QK1WVA
	te0TUlQDCL5Bj7jWYzWYSy0AcBf7Na/gWEqHb/TMZ75tnhpomTaZx2SiD00DO4zcUFPx/AsR4RL
	PwlVYDzOyGdQbUE9GH8NV8NeIdmVOPSZxbK0G6jOivxUfuQPEC+PAPUevRCfQvhK3q4tAH/D3mk
	=
X-Received: by 2002:a05:622a:2610:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52dc470e82cmr1598801cf.1.1787007245994; Mon, 17 Aug 2026
 15:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-3-jiebin.sun@intel.com> <CAP-5=fXbrgF1+bhYLxvr+JPQhs_9YrMkSjOx6QrncPj0CKABXA@mail.gmail.com>
 <aoOP2P8EWYPzLy1V@google.com>
In-Reply-To: <aoOP2P8EWYPzLy1V@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 15:53:54 -0700
X-Gm-Features: AcwNN1WQuU2Cduj6bnMlRCmNR5uowkJv0IXiMd8UKn8ShBsaWv416zv4I4ZpxiY
Message-ID: <CAP-5=fUbShKSuco7GUFuqMWiAt+z--+BNBuec-toHV8ZMULh6g@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] perf c2c: add function view model skeleton
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiebin Sun <jiebin.sun@intel.com>, acme@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, wangyang.guo@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Aug 17, 2026 at 01:53:46PM -0700, Ian Rogers wrote:
> > On Mon, Aug 17, 2026 at 2:40=E2=80=AFAM Jiebin Sun <jiebin.sun@intel.co=
m> wrote:
> > >
> > > Add the initial common model for the c2c function view: model state a=
nd
> > > small helpers shared by the hierarchy construction and formatting add=
ed
> > > in later patches.
> > >
> > > Build the model from util/ so it remains independent of the TUI and
> > > command-private symbols.
> > >
> > > Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Falcon <thomas.falcon@intel.com>
> > > Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> > > Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> > > ---
> > >  tools/perf/util/Build          |  1 +
> > >  tools/perf/util/c2c-function.c | 66 ++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 67 insertions(+)
> > >  create mode 100644 tools/perf/util/c2c-function.c
> > >
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 1dfd92cbe3b7..b26a0b1ddfa3 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -12,6 +12,7 @@ perf-util-y +=3D block-info.o
> > >  perf-util-y +=3D block-range.o
> > >  perf-util-y +=3D build-id.o
> > >  perf-util-y +=3D c2c.o
> > > +perf-util-y +=3D c2c-function.o
> > >  perf-util-y +=3D cacheline.o
> > >  perf-util-$(CONFIG_LIBCAPSTONE) +=3D capstone.o
> > >  perf-util-y +=3D config.o
> > > diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-fun=
ction.c
> > > new file mode 100644
> > > index 000000000000..ca82425a28dc
> > > --- /dev/null
> > > +++ b/tools/perf/util/c2c-function.c
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * C2C function model - function-level cacheline sharing analysis
> > > + *
> > > + * Displays a 3-level hierarchy showing which functions share cachel=
ines:
> > > + *   Level 1: Read-side functions sorted by Cycles % (estimated load=
 cycles)
> > > + *   Level 2: Functions sampled writing the shared lines read by lev=
el 1
> > > + *   Level 3: The specific cachelines where the two functions conten=
d
> > > + *
> > > + * Builds the hierarchy from the existing cacheline histograms
> > > + * (c2c_hist_entry->hists), reusing the shared c2c data structures.
> > > + */
> > > +
> > > +#include <errno.h>
> > > +#include <inttypes.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <tools/libc_compat.h> /* reallocarray */
> > > +#include <linux/list.h>
> > > +#include <linux/rbtree.h>
> > > +#include <linux/zalloc.h>
> > > +
> > > +#include "addr_location.h"
> > > +#include "c2c.h"
> > > +#include "cacheline.h"
> > > +#include "hist.h"
> > > +#include "map.h"
> > > +#include "mem-events.h"
> > > +#include "mem-info.h"
> > > +#include "sort.h"
> > > +#include "symbol.h"
> > > +#include "thread.h"
> >
> > nit: the number of #includes is somewhat generous here. I presume
> > later patches will require these includes. To avoid everything
> > depending on everything else it would be nice to use forward
> > declarations when possible. For example, if the only reason for
> > including the header file was to use a struct's name where it is
> > passed as a pointer in a function declaration, ie in header files
> > prefer:
> >
> >   struct map;
> >   int foo(struct map *m);
> >
> > over
> >
> >   #include "map.h"
> >   int foo(struct map *m);
>
> I think they are actually used in the later patches in this series.

Ah. I misread and thought they were being added to the header file. My
mistake and I guess it is okay to add unused header file #includes in
the same way as the patches introduce initially unused functions.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >
> > > +
> > > +struct c2c_function_model {
> > > +       struct c2c_hists        function_hists;
> > > +       /* Total estimated cycles across all level-1 entries. */
> > > +       u64                     total_cycles;
> > > +       /* Source cacheline histograms; not owned here. */
> > > +       struct c2c_hists        *cl_hists;
> > > +       /* --coalesce field list, used to require iaddr. */
> > > +       const char              *cl_sort;
> > > +       /* Do not cap long symbol names. */
> > > +       bool                     symbol_full;
> > > +};
> > > +
> > > +static struct c2c_function_model c2c_ext __maybe_unused;
> > > +
> > > +static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_sta=
ts *stats)
> > > +{
> > > +       return stats->tot_hitm;
> > > +}
> > > +
> > > +static inline __maybe_unused bool symbol_name_equal(struct symbol *a=
, struct symbol *b)
> > > +{
> > > +       /* Two unknown symbols compare equal, matching cmp_null() in =
util/sort.c. */
> > > +       if (!a || !b)
> > > +               return a =3D=3D b;
> > > +       return arch__compare_symbol_names(a->name, b->name) =3D=3D 0;
> >
> > Sashiko rightly flagged this as not being cross-platform compatible,
> > but this is a pre-existing issue that looks relatively easy to clean
> > up but only really impacts PowerPC and so is hard for me to test. I'll
> > try to do it anyway.
>
> Thanks for your review.  Yep, I think it can be handled separately.
>
> Namhyung
>
> >
> > > +}
> > > +
> > > +static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry=
 *he)
> > > +{
> > > +       if (he->mem_info)
> > > +               return mem_info__iaddr(he->mem_info)->addr;
> > > +       return he->ip;
> > > +}
> > > --
> > > 2.52.0
> > >
