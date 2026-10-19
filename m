Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F040D578;
	Mon, 19 Oct 2026 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388204; cv=none; b=qFoCczLgbpBxyeyTW7kwVb9sR4DSYGpx4Nci/jQ1rPpI3SV82aXO3gH8Jr7Uzmvo6q6tV0qypqneYkgypC1ZcDxR3l7PsORS3VKmUi2gHj21PGw0r2uZTRymBnQEvWiDRClHycXqYmSnunzkLDRnI/f6o0oarbb8sMDf5IXXsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388204; c=relaxed/simple;
	bh=7cTAtqR/fNjb5a7HOA/yH47DzrXspOLlHAN5OgayPDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc2bLBRkAAdS/mKjIEWlwH8KnZTMHbfLQWTSNy9HPRzPqK/kX6oq+BRYluJsQr6797qpA71q31UPbusP2Q5Q/2GXuZfQe6aJJiFdETzuHbEmJ2nC2+KYQkxeGVlE3TMvKqd16ku9RQREPVrD75w511fH04/q6mgBa7bCzDzUQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY4+gcd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY4+gcd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7284E1F000C4;
	Mon, 19 Oct 2026 05:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792388197;
	bh=hGkFIVQy1NIS6CA2l0xjL8lS1QnEtcgLT+LqKtKlp38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UY4+gcd+9ufRnaDrH/2WTrXwgteWq7OuceePVc2yALfejEOo8bbxJ0tcr16L2Ij5m
	 spBz2D4+mg4xgtrsSuH5N7K6F1fWjUGTXZw4Y030MGUH0o+ewR80OPYcgqyD38QZL9
	 PTtMOczXexTbn7pqnnf3OafGVya6ee4TFfzpRF/ZvY9bz2fzcfyi9WIzeR1SFvcEdO
	 6AnQIrbIXak3UWNsDwTXaVokGGQi9xwVO12W3MDysDU/iNlyYWcbwCwRK4yfjynn6g
	 rMGmYV2V6lbLTbwu61tJOVH14C19Zff0aTxK/SVCTcESGxRnvifqXveCvIqgInAkgw
	 uRCu0qmieGJHA==
Date: Sun, 18 Oct 2026 22:36:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/5] perf test: Make sure maps to have a machine
Message-ID: <atWsYwyWGxPc9VcR@z2>
References: <20261018163741.850434-1-namhyung@kernel.org>
 <20261018163741.850434-2-namhyung@kernel.org>
 <CAP-5=fWt5r++c1=BnM+459WsiZiwvihGpcjZ+j5_6Kr4P7sDUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWt5r++c1=BnM+459WsiZiwvihGpcjZ+j5_6Kr4P7sDUw@mail.gmail.com>

On Sun, Oct 18, 2026 at 01:33:45PM -0700, Ian Rogers wrote:
> On Sun, Oct 18, 2026 at 9:37 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It's be easier if we could guarantee that maps always have a machine.
> > IIUC this is true for all real use cases, but only the test code has
> > an exception.  Let's get rid of it and make sure they have machines.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/maps.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> > index 2c05d62f40dcdf72..f40b68f5fa5fe2c1 100644
> > --- a/tools/perf/tests/maps.c
> > +++ b/tools/perf/tests/maps.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <inttypes.h>
> > +#include <unistd.h>
> >  #include <linux/compiler.h>
> >  #include <linux/kernel.h>
> >  #include "tests.h"
> > @@ -100,8 +101,12 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
> >         };
> >         struct map *map_kcore1, *map_kcore2, *map_kcore3;
> >         int ret;
> > -       struct maps *maps = maps__new(NULL);
> > +       struct machine *machine = machine__new_live(/*host_env=*/NULL,
> > +                                                   /*kernel_maps=*/false,
> > +                                                   getpid());
> > +       struct maps *maps = maps__new(machine);
> >
> > +       TEST_ASSERT_VAL("failed to create machine", machine);
> >         TEST_ASSERT_VAL("failed to create maps", maps);
> >
> >         for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
> > @@ -159,6 +164,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
> >         map__zput(map_kcore1);
> >         map__zput(map_kcore2);
> >         map__zput(map_kcore3);
> > +       machine__delete(machine);
> >         return TEST_OK;
> >  }
> >
> > @@ -189,8 +195,12 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
> >         struct map *map_split, *map_eclipse;
> >         int ret;
> >         unsigned int i;
> > -       struct maps *maps = maps__new(NULL);
> > +       struct machine *machine = machine__new_live(/*host_env=*/NULL,
> > +                                                   /*kernel_maps=*/false,
> > +                                                   getpid());
> 
> For completeness should we pass in a host_env like in builtin-top.c?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-top.c?h=perf-tools-next#n1661

Sure, will add in v2.

Thanks,
Namhyung

