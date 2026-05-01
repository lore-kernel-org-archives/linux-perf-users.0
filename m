Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3534A77D
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671723; cv=pass; b=eiFyajnAzHnzOrGT7HWhYx2UjUpl2SnweaQh0AWzpZPpOiphZogLA7SXidXxyeg3Cb3TPCnWvFJkXmn4oTkY4DIOmCAVBiYROrt4BkQGmttOoUji1fwFyeDQHsHYAEMTcVZQfYQrMjN3j5WFMIB/o+L3XcERldo6lzC1d5GXAKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671723; c=relaxed/simple;
	bh=1qAG/nk6deHwofvFFjxfcESFD4G+gTvnv5hI9A0s9Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naoEYuvVw/+Nx9ffEkpwhOtY2o/FHb28iisvNPNx/4pQ9nI4snR/8+UUD6TRphZTLjnDsqf41ZTAUaAGC9WMQOms9QA+BFtBgqm0doVYEshiqIn7Xgjva7hBfuv7ELgABtR0GoYb8LPWMdmX8A9mqPIzUY9K/UIbwIRBHqSujxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koctjjke; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koctjjke"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12ddbe104ccso2449843c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 14:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777671721; cv=none;
        d=google.com; s=arc-20240605;
        b=EUANIXGMKMW6KajOieK8m/eVBaUB7SuqCP8teaXiUVxvz872EaFI+dIB8KTK49F8SA
         Nxrso2qIcFuZDwQEpfU+khQSu8iK7kLib9MpBNeF4vLfzR/yCTXuxYXVHXTpQNgVJ3yy
         qo3c7sKnrb2JO7Ljkb0J/VX39g80tcWL0AbwfZdWpZuc+2ScfWEH6fZRCCJ9fSs75zV7
         Up9LeF2SH80xAv5c/Q95j9G1+zjNorcHbalukac5Qn5RrBcW/n4SxqjU5NVuPKu/cEik
         J5WKtYT5yCOykLBErbVBHkYJbo0/LQYsv1b0frh73CNA4haUjdbI4l2A14CP9DJhQmLY
         pixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gW3JTZ5EZ29Pr8GxkYxhgn3JQ6pGNT2MYeBfA13uCww=;
        fh=HlIomrtvFJFx21dmJB1xxIToUkQgGEf3iLtEvIRJ81o=;
        b=NvTeM8/pKrD6B1KBmG3vrOZYsVjOd5CuvH9QS+39/Jib62UtBr0J1cfSbXxkct19Zv
         tOQXEuehM8D9ac3XUWQM25OsJfC74LhlPxKN7i13cDMVYh8ZRY/Ezk4g0HdZ+BIutY0u
         j0s6eiGz2xrFDXoK3cPJ5LriqZ5EJGKGl9sH7wvEh6H9W9Ww6QbYj7f21w+ISSlLZWR0
         FpWGhMZpLPLnzL1cIYPklGDNGG4lz3JanB0wIlLYqG5kC18C41AAR7jaQfawBMNC57eS
         r96f7GBJyjkO4NA5b6eTFv00AUulha14VEIVU3Cih8F2i2VYoCgFR01I2TqGkF/YNCV/
         /Bng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777671721; x=1778276521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW3JTZ5EZ29Pr8GxkYxhgn3JQ6pGNT2MYeBfA13uCww=;
        b=koctjjkerNABzWdjEav0p0AgVxRu93N5pjexbgcrR//g5kUjgE5A+uZINCUV2xVMuA
         F+kAYtxsvN1BRTnF9T2kVhecd9GRn5mNnZfztjnCllsja0JZRniqS3kwmE2tYQBgviHp
         serqmgyvgTiAIfbiX/KedEnMDRIR3v6qq+wbcXVejG+Rw8wso20OBZFwRJgGazJydmKE
         HiHtrBd/akDig71mn4dXEYmyMcc1anGPUsyqxT+7cQPLVbqwLlOtKHbHyf8ODyJTpAzp
         qlO5JsgTj0Tqpllg5g6dbe+DhJa64a8HfisbOqBSm+O+NO47tADoMHm9+CNFKyzlwrAO
         GMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671721; x=1778276521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gW3JTZ5EZ29Pr8GxkYxhgn3JQ6pGNT2MYeBfA13uCww=;
        b=MNTisi+WHA6v4EkxUIFtWKIRekjgtcwiQV8jnDAE1ENtJUPSz0o4JCsg7E8UifiQCZ
         0Ra1WNLdgfLsxDOqGl7ZnCJLYTMNnKVgfCej6msRA+8axRQJ77sUOXZUGCCPlwTva+I+
         MVyEYVxD1R1tH26RjO8fC9W+Pty4JreEW8NG5VVJGW1xjcBHNejMrKcBoTykAX/STYqD
         lVuoekU6/KNNj3PQNjCW4DquXBiGgKstLl9V1YoA04dfPs3mr0lWOES0kb5skvaiqob4
         tb/RLmy15mURuSZaLPfuWnUKOVHIQTP1Cuw2innQEvE9Qj9J8USgzLCxw1qpeFhZdyQL
         N1Ig==
X-Forwarded-Encrypted: i=1; AFNElJ9tZwhzk+Pp2dPKYWIffOd1axrM0a0t8b60sR87kUwcgE1gxUJtnboTmyKKgEqxwYm1p5ZhV0OVXrh30eeeQDMo@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLdSo36XB5XnVZecidqwkXjTV+KO0xBUyvX1QAhCfnJkM1E8u
	Of87TzM7nXHC/0O2JPDbwsgXzi2114XJF3Xp1pPqtOw8KTHi71pQH+y9EQmuolou7mFC7s6VbPK
	tjHMRVZEL0BFeVys2SCTr5Scct0ti6xPco7eLY0tY
X-Gm-Gg: AeBDietE+j7h/IRjt/FF/+00aGkEivkyALO6tDn+PzPQU7alj+L9CmhAUYz+spsgS+R
	wDCoqYRrZiRTg15vmJuBYTfFEGSF5BTR7a2v+3gPTYDz+vlvLj0hr9yMtc+3TfQFRq27sqMFZlC
	b3VWFw9TjpPEqlckwY+flgiNc2xT1mLVkpM0SEikv8NIgKohtDTR1NLxKB1kY9fbAyHBoIS/4cz
	2oRmkcglgiAAY0sLbp5WDEwjvwGYzSJofICTfs3MjTmSpGEQuS0rWvfn8pYrVY4H/9HmLf86MB1
	bBEqlyq7RenAyT1aIF+CUKEtgvc=
X-Received: by 2002:a05:7022:41a3:b0:12d:de3f:d850 with SMTP id
 a92af1059eb24-12dfd83bca5mr375870c88.41.1777671720706; Fri, 01 May 2026
 14:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501181129.938256-1-ctshao@google.com> <CAP-5=fXbvOWgwWs_TD4rfWpN70YAuoxfbFUTEwtpEJv6btoXuw@mail.gmail.com>
In-Reply-To: <CAP-5=fXbvOWgwWs_TD4rfWpN70YAuoxfbFUTEwtpEJv6btoXuw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 May 2026 14:41:49 -0700
X-Gm-Features: AVHnY4Io-QnfhcDMKyMJKM6x5HNWJBfB278tRL5aSEk6xwqv2VScaEkn6wzdgYc
Message-ID: <CAJpZYjXXNqeS1WbmjgU+uezxx19gyYEOdVtmiJ26gCS9C1hegg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Check aliases in should_skip_zero_counter
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian, thanks for your review.

On Fri, May 1, 2026 at 12:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, May 1, 2026 at 11:11=E2=80=AFAM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Aggregation IDs (e.g. sockets, caches) with event zero counts are hidde=
n
> > in aggregated modes (like `--per-socket`) because alias merging
> > aggregates counts but not CPU maps. This causes display logic to skip
> > aggregation IDs not present in the leader's map.
> >
> > Instead of mutating CPU maps in `evsel__merge_aggr_counters` (which
> > could have side effects on shared CPU maps), check aliases in
> > `should_skip_zero_counter` to ensure all applicable aggregation IDs are
> > displayed.
> >
> > Before the fix:
> >   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0       12                  0      amd_umc/config=3D0xff/
> >
> >          1.000721604 seconds time elapsed
> >
> > After the fix:
> >   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0       12                  0      amd_umc/config=3D0xff/
> >   S1       12                  0      amd_umc/config=3D0xff/
> >
> >          1.000879376 seconds time elapsed
>
> Does this change the behavior without --per-socket when the uncore
> PMUs have different cpumasks?

Nope, the behavior is unchanged for `-a`, since counts aggregate to
the leader's `aggr[0]` and all CPUs's `aggr_id` is 0 in AGGR_GLOBAL
mode.

>
> > `perf test` looks good too.
> >
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index 993f4c4b8f44..c12a3405118a 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -945,6 +945,27 @@ static bool should_skip_zero_counter(struct perf_s=
tat_config *config,
> >                 if (aggr_cpu_id__equal(id, &own_id))
> >                         return false;
> >         }
> > +
> > +       /*
> > +        * If the counter is a leader in alias merging, check if the ag=
gr id
> > +        * matches any of its aliases.
>
> Could you expand why in this case we want the zero count?

We don't want to hide counts if it is not in leader's cpumask even
though it is 0. It would cause confusion to users/parsers.
In my scenario, I tested an event that was all zeros on S1 and was
hidden by perf. Initially, I thought perf wasn't collecting the event
on S1, then realized collecting was working but hidden.
>
> > +        */
> > +       if (config->aggr_mode !=3D AGGR_NONE && counter->first_wildcard=
_match =3D=3D NULL) {
> > +               struct evsel *alias;
> > +
> > +               evlist__for_each_entry(counter->evlist, alias) {
> > +                       if (alias->first_wildcard_match =3D=3D counter)=
 {
>
> Could this also have a "&& !perf_cpu_map__equal(counter->core.cpu,
> alias->core.cpus)" ? ie if the alias' cpumask matches that of the
> counter, then the loop above covers it. Perhaps the cpumaps of each
> alias could be merged and the test only run if their intersection is
> not empty.

Thanks for the suggestion, I will add it in the next patch.
>
> > +                               perf_cpu_map__for_each_cpu(cpu, idx, al=
ias->core.cpus) {
> > +                                       struct aggr_cpu_id own_id =3D
> > +                                               config->aggr_get_id(con=
fig, cpu);
>
> Could this fit on one line?

Then it will make the line 101 characters long...
>
> Thanks,
> Ian
>
> > +
> > +                                       if (aggr_cpu_id__equal(id, &own=
_id))
> > +                                               return false;
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +
> >         return true;
> >  }
> >
> > --
> > 2.54.0.545.g6539524ca2-goog
> >
