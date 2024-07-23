Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D1156C7B
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746664; cv=none; b=gEYDoiwB/5lunQlWRtsB9KeyyfgDiffTovldcCNdtQASd7LufWNjwFE8JS+wfTjI8euVDqG/73UKAxQaRZes5tVAnK9s6MPjALNePmKL4zC97SA2YZalvzbgeqrTN8fhRiyZKzaL/WCL1uevzbQHOdYDR6fjfoJmq06uFD+Mrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746664; c=relaxed/simple;
	bh=iEhm9/9xLKg6GaZQCc+MM9yVFxWsVzlmo5ZoEYVZUmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODluGRw6LGJxFC85KjJlIDznT9ZNdONucpTm8D29l3iBpzsySRYHtXgNbEouCmPGQC8T+rv+z99TN0GIYqY8qW4CPjmLM2yRM2anM0K54soOCDrclZwdKPFok8O2CC5mB+pKdwQAMAgYCxB7HwoHXezOAPJ6SqVsCETXlCRFOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVp7hrQo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVp7hrQo"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-38b3543541dso168095ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721746661; x=1722351461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOO8rTGxuXP8p8sxBPSAP2u2AgeXwG2nl1LkN5RKC9U=;
        b=fVp7hrQopELTQq/PY7dFe8u9HUQj4CqV8O9ASJG4vWq6yIE7sa15CFXFw16L7gOVLz
         p8189J+0h9iOEO0ePIQ/OSXV2b0a/bPe96SOxNn8oec7190t3unfmmwH3/Kl6GjdjBxM
         sLePT8Dqgu1B2GlMuDlahnuUWcBCOZsdhm9OkYt50lvmPn7RYdVEeIZ+ILArYH3xWmWH
         bxMgzjmJw2G2yQDiJ4x4cMSOEcfA4tUNwYjuF7IxnRnjsPLjyWLyHa72mlqJvsCpdfKv
         /KlnrpRxdrlkt2C1YzbsKVzO8u1CCZ0bEz2ug5y5rQQvvVN4k9KDCKlGCH96reoPfKNm
         bB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746661; x=1722351461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOO8rTGxuXP8p8sxBPSAP2u2AgeXwG2nl1LkN5RKC9U=;
        b=VntcGL/4fg41JoI/f/KTLJoVbmZag7ezNxrgfyKj6NcOujUGVUIYoCeZcvQi9oEDAR
         Wxhl4f2rnpJEm63s9v2ahDk/TaVKdRi2FmQUCNN0dFFXaMfsLsBJfyAcex+zxO7Sn1aW
         ru2f7KgoKWfU3qVj2o8kVF89rUxrAT2rPrn4gxsN2tp60sNNGVoCyRG9hlBYWCNFJKpW
         1SLUq8PNxxGahWQkko/66Jal9BoUQ9K6tGswe+5lD0kIL8RqZgjflaiKJI3enQbq1g/8
         3pPb/q9hxCE0FAvA8SUSybsM3jeV0CqCDJsSDWUN7FyU5h6x12gRbcVIgPB2t638/kda
         eJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVSWE2QejsRi/ahvZizDVP8tKPQhcb293P+LaoI9Ae3QxtjgwRxFMLicJX93KVd3ylKPDX+iukEtyH08PPRo08+Q/VvgRoEeXKezKt9DCPwg==
X-Gm-Message-State: AOJu0YzIGHjtIxuEb4tTc0BQ6e3/MDIxWbMc1oujAHrIpck4dSDp8UnV
	7GnSEZ/ksfQdYm6TgoL9mCTDPRBo37Q6Dd2HCSYvp/mAE7RrBdFuLcszjM06z1d/tMw4gMIwWFr
	UDyMcANZn5zhR7r5P85uUikqHKvRU6lC9dzF/
X-Google-Smtp-Source: AGHT+IH/RpMY9dkipDwHt7eC8aSysGJbBXGF2Ss3iyuxo9ET10fPeoN4bU+sC777ajTWlkewT5mGlhe9GeTDLraUxjs=
X-Received: by 2002:a05:6e02:388f:b0:375:d7d7:bfc with SMTP id
 e9e14a558f8ab-39942180057mr7732145ab.27.1721746661348; Tue, 23 Jul 2024
 07:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720074552.1915993-1-irogers@google.com> <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
In-Reply-To: <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 07:57:29 -0700
Message-ID: <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: James Clark <james.clark@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:41=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 20/07/2024 8:45 am, Ian Rogers wrote:
> > Andi Kleen reported a regression where `perf script +F metric` would
> > crash. With this change the output is:
> >
> > ```
> > $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
> >
> >        21.229620 GB/sec
> >
> >        15.751008 GB/sec
> >
> >        16.009221 GB/sec
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
> > $ perf --no-pager script -F +metric
> >              perf 1912464 [000] 814503.473101:       6325       cycles:=
  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
> >              perf 1912464 [000] 814503.473101:   metric:    0.06  insn =
per cycle
> >              perf 1912464 [000] 814503.473101:        351 instructions:=
  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
> >              perf 1912464 [000] 814503.473101:   metric:    0.03  insn =
per cycle
> > ...
> > ```
>
> For some reason I only get the metric: lines when I record with -a. I
> noticed this because Andi's test doesn't use -a so it fails.
>
> I'm not sure if that's expected or it's related to your disclaimer below?

It is. When you don't do -a the cpu map just contains -1 and for some
reason it is busted. The whole indirections to arrays of arrays,
counts, stats, aggregations, with indices into various other arrays
and a lack of helpers. The code works for perf stat, but there is a
lot of complexity that I don't fully grok in that. Here I've tried to
kind of break down what the code is trying to do in the comments, but
the old code never did sample_read_group__for_each so was is broken
with leader sampling? Is the leader sampling pretending the read
counts are periods and calling process sample multiple times. Andi
likely knows this code better than me so I was hoping he could fix it
up. We may want to take the patches anyway in order to not have a
segv.

Thanks,
Ian

> >
> > The change fixes perf script to update counts and thereby aggregate
> > values which then get consumed by unchanged metric logic in the shadow
> > stat output. Note, it would be preferential to switch to json metrics.
> >
> > Reported-by: Andi Kleen <ak@linux.intel.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378=
-1-ak@linux.intel.com/
> > Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than save=
d_value")'
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > The code isn't well tested nor does it support non-leader sampling
> > reading of counts based on periods that seemed to present in the
> > previous code. Sending out for the sake of discussion. Andi's changes
> > added a test and that should certainly be added.
> > ---
> >   tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++------=
-
> >   1 file changed, 93 insertions(+), 21 deletions(-)
> >
