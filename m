Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457730B514
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198000; cv=pass; b=mEC30OspZpR49idKka2apoTowvWxYjfdHBEHKBzvc9yYp8O4fgwg8jqI4Hzpqpvs1O1cQU6PAU607eYA6i4xSCxd+Tz3w9TI+EwSO9pJ8cRNg0bPx+eqlah2VsfgL2pUD0FQZsiyads1c0R95XMgMD7uAcx3y0mvsJn1/XVCww4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198000; c=relaxed/simple;
	bh=7XyVqM3OP7aVREUb8TMPamvd/LiQ3M0zu1HVrbJEqGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMI6E5oK1Q0fzF4JifXAJ3hZMLzKNzk3SYqPUT3kSyWmx6Erwi1gFLoqjzaMkSBrupawSdwMACwTwyBfZJduiFnD4SLXdDaxuwDdd1u9RXsbjKgq3mKE/ZNshHilzhTaVhd0Bm3PYBHvHe04iVjORx9r8Z0auQMYxe3gdstTk5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn9y4v5+; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn9y4v5+"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7a2b6adbfa6so17425307b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 23:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775197997; cv=none;
        d=google.com; s=arc-20240605;
        b=d4xh11m0ql+xnpe6UzVMsOat0FIItfCMrvwpAtJfDmcOyThnJl2/bXEs/WbtxB5od2
         7hTZWWyt6GozsZKVf2fWVl5ImMDXrS+TNsk+3bxy4fo9Jw+2DpUe3FgTMCAdz7UOEfV5
         4OK3aye1GWIeQcEnEkqzm48YRjkWuMiZqBsd1Po/ecY4oYjJg46K9yJrB+lh3i48wbML
         Ec/VDRhAwZMpLikjah9y+vTLP2CKBAQN2KvumYHuR/JJZuc24CltyQ2ndsAP9A1alQka
         0326cWKCvX43ECdySR6PRo6Ep+M7jhLMW86yi0deV/NAfWhUhJGqYY9DRVss2Zqek+Y5
         y87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikObTRDzmQCnpPn0SnC4F9o5QbKBAZOyRVtKSVzT42M=;
        fh=m90DUnAchG7xe9gvh8zdUJxUDFNsO5t3vRjbiTbjKio=;
        b=hrtlMPTybVz/3nQOX+kwKVxCwKtIR/MRCY6+BMcajwq3FuYprP2kWlhmsMufnVeR9f
         wMrVnK1gilaDcqEGPWUHaectab/RAfhmue6iZwqVu2fFjFQO5R0UComEO6P69RIN+ZJk
         Hw5sYbPBuTRr7WI/Y8eXrsR3NliYcMQhTxmdVmJpZsTJDuC6I/iUvkefB6gxVE/gkTI1
         a1Q3K9qOPkhf3MbhA1K0hgUKBjKtKFhHn4ZCll/KjytH041hW/nbHBh4UzbebDnisRKN
         qUYf6YD0nORS0o78FLS07w7CNKH8rNLO1cspW68aq5TcCwcCv2vGom95xbG5MkKaBfUJ
         71Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775197997; x=1775802797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikObTRDzmQCnpPn0SnC4F9o5QbKBAZOyRVtKSVzT42M=;
        b=Sn9y4v5+i7lVZFVkMeqXkS6rSc7GQrnTwamqLDMAajKBbu/lk6aB729YNE9sZcUTwR
         Gkx1/rJuOf68CArGOk+BZ4rN1fpBOkRQENhmEUc8y60JKXu0RCCpL5jGK3DxqjPuKe5P
         BPR+toRQtMJafmW45sOgE2i6djTx3ptL7XL+vjlWLu/tcd2B8M4vEmZu64p6hKz96nha
         MU3f6YA1ozpUuwXKpS38jhiaoHnFV71g/Ks0VkcXtVmH6lLIDocvROMDLJ+wtfOMM5/Q
         gHC3+uvoWnL2eZyy/Zy0vwtrPuTrneC1cxiNC2BlRmxXgiWZ44vkjj+l16+bhknl6WNk
         oM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775197997; x=1775802797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikObTRDzmQCnpPn0SnC4F9o5QbKBAZOyRVtKSVzT42M=;
        b=Oaq+q8sxVZQsFvky8OicOhm9aklRyouQt7Uda+0rQwGM9ksvQj+O4W8e4UV/qpw8JN
         sJ7tHnlxX7v68bD7Fto3ZMyEkL7KZ1VsgUfL/UD8elsH6dAkUDz858nIkBClNFDqlBK7
         ajyaSi1YZAYC7T71LIWgcBT5SuKe5OG5rAkSSE4p70U/ZrNjWcZpLtW4AHIm5D1Ys9na
         PTu2lL9vJ2yj8jsdYMWpMMHQ8FrfxcgQDAg//ncVLYdhsGWn7QlSpqrSGNBEtoE/oEHL
         fHTBZI36G3DJ4yk89PwHDpHIo9gZpCFnHLbGpD1XnpUsO7n7uqsv8ms5zEHUb/Gzg3Xt
         TzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX70H8DZsJDAXWY++KNSioSbiYe6b7H8lu9GQUeS3NO0eocvSEwHOC0G9koIk1KA6oCuew1oHEOLmfR+dEafyG5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2gKkairAIR2/qoWYrDDUM8f47Q1Yw+qe+MAcZ0+Ql6ALFQbQ
	grL6NxaH08XMihKCk0U3GcGNAuCkgCRIsVepoZgn0EgfXwKouGUvqVHtgnT2w8FkJ1/xg5tJU7d
	xhGdcw90PimLALX70UW3IIQhSoErJdqw=
X-Gm-Gg: AeBDieu4FdR7mK+ok/qKdxzp3uvI8t6MMqw9JstygHZG211mIPmzxAwP4x+OEYo2F1P
	SixS4mhOno0H47ykRBsShENILEJSOeoudLyHMzxn43XYoQDQplHCvk3MkxjYH4DumMI65X1q4B0
	8tGaHamN6nkI2J3MTbEgakMVd4rYO1hVP+BrCnixzbJqN1H6ymLRA3uW/bWkBWHoVT8GI/2bpNc
	6VuEX8tnbBw1riFTVTvBVp1/TXa8PV6GV2rlhluYzH2eqCjWnpPU0VbOhhz+c4ulJ7VvrkLxrFs
	+irqh3HNNqVjIwHGxKTpYd3I4wISt3NKsdG8aD27qMnygB/TAgS/h4rS8MG1tHVP4hKsqQ==
X-Received: by 2002:a05:690c:e654:b0:79f:7972:f88c with SMTP id
 00721157ae682-7a4d64480eemr13226287b3.11.1775197997378; Thu, 02 Apr 2026
 23:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402215727.980993-1-irogers@google.com>
In-Reply-To: <20260402215727.980993-1-irogers@google.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 3 Apr 2026 14:33:03 +0800
X-Gm-Features: AQROBzDHLi377LEU70OoLL7LQcZ2-j_I8HrwDSkBlgiNIkIIP9iu5gBB5h_oE8k
Message-ID: <CABFUUZHVg6XQeVBrv8R22M-LNoJUoNEQQ3K_wA-TpTKT-Mr4Hw@mail.gmail.com>
Subject: Re: [PATCH v1] perf cgroup: Update metric leader in evlist__expand_cgroup
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:58=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> When the evlist is expanded the metric leader wasn't being updated. As
> the original evsel is deleted this creates a use-after-free in
> stat-shadow's prepare_metric. This was detected running the "perf stat
> --bpf-counters --for-each-cgroup test" with sanitizers.
>
> The change itself puts the copied evsel into the priv field (known
> unused because of evsel__clone use) and then in a second pass over the
> list updates the copied values using the priv pointer.
>
> Fixes: d1c5a0e86a4e ("perf stat: Add --for-each-cgroup option")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/cgroup.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index 040eb75f0804..1e0fef283826 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -417,7 +417,6 @@ static bool has_pattern_string(const char *str)
>  int evlist__expand_cgroup(struct evlist *evlist, const char *str, bool o=
pen_cgroup)
>  {
>         struct evlist *orig_list, *tmp_list;
> -       struct evsel *pos, *evsel, *leader;
>         struct rblist orig_metric_events;
>         struct cgroup *cgrp =3D NULL;
>         struct cgroup_name *cn;
> @@ -452,6 +451,7 @@ int evlist__expand_cgroup(struct evlist *evlist, cons=
t char *str, bool open_cgro
>                 goto out_err;
>
>         list_for_each_entry(cn, &cgroup_list, list) {
> +               struct evsel *pos;
>                 char *name;
>
>                 if (!cn->used)
> @@ -467,21 +467,41 @@ int evlist__expand_cgroup(struct evlist *evlist, co=
nst char *str, bool open_cgro
>                 if (cgrp =3D=3D NULL)
>                         continue;
>
> -               leader =3D NULL;
> +               /* copy the list and set to the new cgroup. */
>                 evlist__for_each_entry(orig_list, pos) {
> -                       evsel =3D evsel__clone(/*dest=3D*/NULL, pos);
> +                       struct evsel *evsel =3D evsel__clone(/*dest=3D*/N=
ULL, pos);
> +
>                         if (evsel =3D=3D NULL)
>                                 goto out_err;
>
> +                       /* stash the copy during the copying. */
> +                       pos->priv =3D &evsel->core;
>                         cgroup__put(evsel->cgrp);
>                         evsel->cgrp =3D cgroup__get(cgrp);
>
> -                       if (evsel__is_group_leader(pos))
> -                               leader =3D evsel;
> -                       evsel__set_leader(evsel, leader);
> -
>                         evlist__add(tmp_list, evsel);
>                 }
> +               /* update leader information using stashed pointer to cop=
y. */
> +               evlist__for_each_entry(orig_list, pos) {
> +                       struct evsel *evsel =3D pos->priv;
nit: since pos->priv stores &evsel->core above, could we use container_of()=
 here
as well? Or just stash evsel directly into priv?
> +
> +                       if (evsel__leader(pos))
> +                               evsel->core.leader =3D evsel__leader(pos)=
->priv;
> +
> +                       if (pos->metric_leader) {
> +                               evsel->metric_leader =3D
> +                                       container_of(pos->metric_leader->=
priv, struct evsel, core);
> +                       }
> +                       if (pos->first_wildcard_match) {
> +                               evsel->first_wildcard_match =3D
> +                                       container_of(pos->first_wildcard_=
match->priv,
> +                                                    struct evsel, core);
> +                       }
> +               }
> +               /* the stashed copy is no longer used. */
> +               evlist__for_each_entry(orig_list, pos)
> +                       pos->priv =3D NULL;
> +
>                 /* cgroup__new() has a refcount, release it here */
>                 cgroup__put(cgrp);
>                 nr_cgroups++;
> --
> 2.53.0.1213.gd9a14994de-goog
>
>
This patch makes sense to me, apart from the nit above.

Acked-by: Sun Jian <sun.jian.kdev@gmail.com>
