Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4E38B7C4
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Apr 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499964; cv=pass; b=NwBXGhhiU+uf+V88tQdMR8Ua5vW5Sz2Uet5gkzg1j6/XiDuYhk4lzgR6bK7xfweEyQzrW/82yW18WkMNKNAgXDDrTWz2fsZZnGEXbP/NuvMQar9rTbg5rD2Y4w6EAXxjFhIbx0B7gtplaugeLJvo0fOVn0YrjZI3BdJgGYr3V80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499964; c=relaxed/simple;
	bh=sDwwW/XR/fLXih2BB7NvupvDp02VA/ay4gqNs52wGgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3BW6N3QwyyFWSa5ZeI0DCiSqJ+DQt2rEvr1VY0vHCvf+5TFsU2HJ8uC1w73tKdkDOGC1iLh1FCs4CTUjwfAN1QF5CTOI2kCILEYNdDX6buKPe344hYRffP47X8/4zcIJBueU97q37T5sRnz+bf1hJNMeASiYoBmqpu/HppsUpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eguCRdB4; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eguCRdB4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b243198058so231035ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Apr 2026 11:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775499963; cv=none;
        d=google.com; s=arc-20240605;
        b=VIqw79Hcfh2CymLh8MlAnihnJlEbTYaMtpqB1k23QYgJfPBfCN+iZtTqw9qIvXkIKk
         aywdeRUGbSdy8GqkqnZEVr84Zw/4ys3RnnBq77ZsonF93he7O1jtDwBWA1LEK1go+EEY
         HKO/h1oHKw1nX8GoLf/3l2QA7T25Sa0sZ2vIBwG9Wr2UtD+vjnNL3cNxx8odTo+l6eXI
         xLcG2nn8aICRzqpTjMURAAB3HcIlE0vLw7Ie+BZH5DZA7iEPDg/Zn9vsBLzK94HwhL2Z
         vDqQkGZcZfWkUQSbBX67OtNNreR/sf6dZYo6I7BwINIdJ4Tbg6sWslvUq3HXNqTDC9Ll
         SDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40oDQG1IezhwwHv9hu+uoOm5eDPV0K8qWLxWBOSegmo=;
        fh=AFUz7waUlXxHAw6ghSRqGO9flsGsbhK4mmeuYKSKeIg=;
        b=PDTnKCAdMNxTlTUjbrRXTuvGXlgaYQPJ/7dtXrJ9vy/0vETjYhMuzfGgq76fNf24oK
         ZVBRLOLT08iL1NNfmIZEMUe2UHFR9BBgrDpkzOwzA8hkOTSTWc+/0vC+i00BJPkKSFc8
         Un3R5f3OccWU8KG+Sa/bT1CUhvUJkGLF4a0PrYMiUidmnsXex9oI48Twmozp6DyjElg1
         QDYBxssBA9KQqYFyB86tzoVL04sIxXtax/eRKTBjrdVYGG9C7OxzKP+SsQr20r7tbP6p
         /2mnCQy7wPKaJxN7P2FeHKVLEdvEe5L6k4OIH+cN1ceDOhZ4vdZBGmc8OsQpLIIBwywG
         0mbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775499963; x=1776104763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40oDQG1IezhwwHv9hu+uoOm5eDPV0K8qWLxWBOSegmo=;
        b=eguCRdB4pF5W4r5gC6AflVkn+S2PaGs3RBg7Nu7a4gjNGw1B5fxS0pqVfCjEwywT4F
         yBuXpDsRuqUi79vDOA7W+NRfe33hodnj3JC43CjxQOA+o/nb/ZeKJgljjrpKOZtbG124
         bCdcINSBLt1xCiq2EGWfpFqikycHd6Klh+EAkGGq+oUbbTrcOLR3CpUnB+DIMk9B8D3D
         BJ2StV0OWAG2DoxUgC35vNyq6h36jL1VdhVgkfBJsJNfkCEjjoRMVFVFHhle/20UMX62
         sSMLnbx0q8fZ6o/+cF/O9XHxwVRdzBV+5YXXJM+vDtj7CD2S/CB0wTxPIx5pHYvYlQGR
         aWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499963; x=1776104763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40oDQG1IezhwwHv9hu+uoOm5eDPV0K8qWLxWBOSegmo=;
        b=TiYKIQFso95ENKAPZx9S8qYbCD9V1JYTYhZSJBezGqYdYLny3kP76Yfar7l3sXLbym
         imVg1TkS5vmuWu+Atga4OmHzMsSf5Cy5JEnEFiHt1vtUOM4Q4K4E9UuJgTTYI/9De3Tj
         WYID15owTZv6J3sGMAq3hSNCbZ7N3R7ZKtRbxjBWUw7eifZ6wIU05pKjgXXDBjzwIv8M
         Z11IVXAMS4DQZFxQitttcg1J5u6bu3EMJGg/peB4Aqv0sHL4IM98/dWj0QefaKXe7d5f
         XpVtyub4Jv5E+tTNzs3W9VkIc8uaWXsIZrvo7YZxgXYZjKAcju3qGt3Z4AIHvZyKfEn/
         fHyw==
X-Forwarded-Encrypted: i=1; AJvYcCUo2hObKX122sI7nCYWu4cFqXrwpw65AbMOL2UVqcW3d+hqMdjTgQhDvk0O3UXXCibCMbS7KA/h+yQ4n+OEZLVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxub61NHeKYQLNUp2fS8CfPqEaoc04Msf19pzmbSyQX9/Zl+JR0
	jpCgKcrDmiKlSqip7dkUIYkpkfSIzN8f3Rr4BxKGanuBFisG3UEpbIfxk53/kvue659Eeogl38r
	4iucqrh6cVC2YZ4FnXOXIQpG7i+42ajxE5OTflPNe
X-Gm-Gg: AeBDieusf/5JyL5Ot2JQL4BxOrmQ7v124MtIY3Yhctez1BYNmJGzFo2+SBANiRH2TkH
	ZwWIHP1vdbyfqaQLLXIuhxRCOOMp2FdJSrgqmBgmCnvdvgINnou6vC10u5z7qduU1jYU80qG9oa
	bQ8ODFn/3lz/g1Bh0ufHxOG2QPebRyBIqtTw7xDf0sPECvcK50tS6Ruubeci4W/2Aks2+WKBNnx
	FMyRimHhcT4sOe7tvv6O4kREXwiSEfmNCDlwGKgqBdk33Y0ZH2zZV7PRtBHiuwQNvxzFYKFXRkR
	q459MABE9qaxUmuXsW89LDuKqHjGOhfLSkWBxg==
X-Received: by 2002:a17:903:3c47:b0:2b2:5931:5950 with SMTP id
 d9443c01a7336-2b282f63e10mr8012315ad.16.1775499962025; Mon, 06 Apr 2026
 11:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402220406.983248-1-irogers@google.com> <adP4dyKNTz3LjFmt@google.com>
In-Reply-To: <adP4dyKNTz3LjFmt@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Apr 2026 11:25:49 -0700
X-Gm-Features: AQROBzBo6Kuisd07YzgNdfp7txzKFkc5qztirS1p_q6mhBkCTFrsCVJjxkik8aA
Message-ID: <CAP-5=fU50qG6BB+eG=EkE55Hn+rFPBPeHe9P=0hYdACQ=yviUg@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Stat std output match 2 metrics for stalled-cycles-backend
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 11:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Apr 02, 2026 at 03:04:06PM -0700, Ian Rogers wrote:
> > Seen on ARM, the stalled-cycles-backend event can be given as the
> > event for both backend_cycles_idle and stalled_cycles_per_instruction
> > metrics. Make the metric match sufficiently generic to allow this.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat+std_output.sh | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tes=
ts/shell/stat+std_output.sh
> > index 9c4b92ecf448..5a6bda436dd4 100755
> > --- a/tools/perf/tests/shell/stat+std_output.sh
> > +++ b/tools/perf/tests/shell/stat+std_output.sh
> > @@ -11,9 +11,12 @@ set -e
> >
> >  stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
> >
> > +# For event_name[i] expect to see event_metric[i]. 'stalled-cycles-bac=
kend' may
> > +# match both 'backend_cycles_idle' and 'stalled_cycles_per_instruction=
', hence
> > +# matching "_cycles_".
> >  event_name=3D(cpu-clock task-clock context-switches cpu-migrations pag=
e-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions=
 branches branch-misses)
> > -event_metric=3D("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/s=
ec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_p=
er_cycle" "/sec" "branch_miss_rate")
> > -skip_metric=3D("tma_" "TopdownL1")
> > +event_metric=3D("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/s=
ec" "faults/sec" "frontend_cycles_idle" "_cycles_" "GHz" "insn_per_cycle" "=
/sec" "branch_miss_rate")
>
> Is this used for partial string match?
>
> Then I guess "frontend_cycles_idle" can be covered by "_cycles_" too?
> Also as we have "/sec", can "cs/sec" and "migrations/sec" be removed?

When we see the event at index 'i' in the event_name array, we check
the corresponding metric at index 'i' in the event_metric array. So
"cs/sec" matches the event "context-switches" while "/sec" matches
"branches". We could weaken the "context-switches" event to match just
"/sec" as a metric, but it seems better to leave it as "cs/sec".

> > +skip_metric=3D("tma_" "TopdownL1" "percent of slots")
>
> Why is "percent of slots" added as well?

Seen on ARM, the metric names lack an easily catchable prefix like
tma_. Its part of the fixing this test for ARM, but could be called
out more in the commit message.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >  cleanup() {
> >    rm -f "${stat_output}"
> > --
> > 2.53.0.1213.gd9a14994de-goog
> >
