Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D817552
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Aug 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215655; cv=none; b=Zf5Ql3kIar8ptE0zuIc86+6TbvPw8r3WCJQVZYGa/q0HAPbMA+iKH+ZtlxE3QlegOipKl6fXQdW0v9i+fPZBfaOXSESPXeXkM8xVIM/r7Eskvlw9yGpqPZY9UVK8+gbQsoZcroKR481YqkJ0MW3EE4GfOEg3QQMViAmQKoHmjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215655; c=relaxed/simple;
	bh=2/VoztJBuXDprKNoI0vzxSIB06IEaQPTPLnouZqaoEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7f8B5ctUXABm6D91v6xzQNhSqnedit7GJEk9oaSUW+qhtFoPvn+u+RFNvrJXaSmChEv5FXAHJlWlTIzRRCtIhXwiZNhPgL3DRWa8uEvn3GZImVtnlNpG+ptIiIftzK6+3ExLS4aaNUNvPKkO/A3fZZSKG1gO5Wq1bLZ7RMKTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzZlKBB7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzZlKBB7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd657c9199so120575ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Aug 2024 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723215653; x=1723820453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHRyJ+nR6PS8lEPUMrhPMIf0CdwrJbRWFLUbhbjnnGE=;
        b=fzZlKBB7dDzpzHfDRepjLSE4M02iggRf6yxjTcjPzKC2qXjD84CdWeKUrCgZpB/lR2
         6RDLzmgJxWJc/j+JQfU6uGC6Jtle/lWYMgNrzKoCoUiaVc9sZkSi3IT4NU9N/tOmYnAb
         QixJL9eB8G2G7vyw5YRUrz8Y6lLPnJV3AySpaJqpanHjl5TmKAiNGV/wLMQmUHUvisX6
         BGFS4srV3sjDMzjYaugKRV/QNnFZExfvf64DQSV5IoRtSEYkrdjSDRTt9PrZz8SN2YtZ
         K1Mahh/bSok5A7C1BOi8CDM/RflDwUHZQH84LLUW6slCXQ1hfKygjRxg1hUOk+Z0eA2m
         zr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723215653; x=1723820453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHRyJ+nR6PS8lEPUMrhPMIf0CdwrJbRWFLUbhbjnnGE=;
        b=ohDfOuG7kD0QPmqVefUer3+K7ceAHhYXKS4BFMi6+9vXtrMnsA5J/gHdl7dtauBSnB
         xRMd+QEXGipm8rAO5Y884wPOFEoew3z016wFEF1zjjscf8aa11uy/Qg6LzOtj3vIWMZ7
         ZlEW+SJSwzthC6Yp3b56Ey8ckJnXGemKFBq9k/FDBPCyFaD+GmWxokOQ5nZoWF08Lzt9
         SlTS3VBQ7zkSxLonioDG6u6bgcruPPiQgsVJhlrV7p50pdqE0objlpZul7NnJNxg7hGJ
         03zDEqZPmv0vpNpWMLDtbTWiSR4X3W2aP2F8XghcfwMgqYF/8Ey9shAd3is+hOnzTBOS
         Lqig==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZbC2fZY48TZFU6fcTh3fk3Xqp+pThCMTGMWjE9OfOyCuEIXmRDhEVVI8B56xRTHy4pxySFX5ZDheCN6j1EcanYb80fKM/iLHnJNjpL48+g==
X-Gm-Message-State: AOJu0YzAFTYpUVYiNFHEWRDAcG5ecbUvnBdnSjDLXgiHQxh3NtSCKzaY
	QHOJPQgcGAlGPoYi/Qymudsm3OoGcTwXT5ie3zNR8OghswhHXxo0N4iqj3xDeNsRckVpQNJKpyp
	eJfSGG6o1ml4O8AfFOJQGVn5MUZeSxNmLflKs/pYCSrPFMbvzyMkY4Xs=
X-Google-Smtp-Source: AGHT+IEjqtGNJN8nTjVWi7BZ18r7XFGwoTMObY+KUXZFvZ6Qt8VWZ/Smx/vdOpP/kQLadpZhqYMs0fsGzKguzZ+ijG8=
X-Received: by 2002:a17:903:22c1:b0:1fd:d0c0:1a69 with SMTP id
 d9443c01a7336-200aa49d2fcmr2492125ad.9.1723215652358; Fri, 09 Aug 2024
 08:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807231823.898979-1-ak@linux.intel.com> <20240807231823.898979-3-ak@linux.intel.com>
 <CAM9d7ci40WcV=EtsNuNXkRAWc3XHDKzb9OACNUhD5WaqTu5vxg@mail.gmail.com>
 <CAP-5=fVZ0_orgpLcG492WtjW05QWu2Mbnuv=_NKweouVXq2icA@mail.gmail.com> <ZrUoCRu4HGoROUs2@tassilo>
In-Reply-To: <ZrUoCRu4HGoROUs2@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Aug 2024 08:00:40 -0700
Message-ID: <CAP-5=fXraYBGd2UPB-VmSn92ug-o+33NHJpx3rf+9v+xYncE4Q@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] perf script: Fix perf script -F +metric
To: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:18=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> >
> > Fwiw, not acked-by me. Repeating my comments below:
>
> Let me just point out that you broke it in the first place.
>
> A little more enthusiasm in handling regressions would be appreciated.

You want more than a patch series that reimplements things correctly?
https://lore.kernel.org/lkml/20240720074552.1915993-1-irogers@google.com/
You have not listened to feedback from the earlier patch series you
sent and keep sending something that I have explained I disagree with.

> > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-scrip=
t.c
> > > > index c16224b1fef3..cb63507af839 100644
> > > > --- a/tools/perf/builtin-script.c
> > > > +++ b/tools/perf/builtin-script.c
> > > > @@ -335,7 +335,6 @@ struct evsel_script {
> > > >         FILE *fp;
> > > >         u64  samples;
> > > >         /* For metric output */
> > > > -       u64  val;
> > > >         int  gnum;
> >
> > We're globally assuming properties of events assuming leader sampling.
> > gnum shouldn't exist. The assumptions will be invalid when leader
> > sampling isn't enabled.
>
> This is checked for now, see the earlier discussion.

So you can then remove the gnum as the samples are all in the event.

> > > > +       if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP) ||
> > > > +           !(leader->core.attr.sample_type & PERF_SAMPLE_READ)) {
> > > > +               if (!printed)
> > > > +                       fprintf(stderr, "perf script: -F metric req=
uires {}:S for groups leader sampling\n");
> > > > +               printed =3D 1;
> > > > +               return;
> > > > +       }
> > > > +       /*
> > > > +        * Always use the first entry as storage because the leader=
 sampling
> > > > +        * groups are contiguous and there's no need to handle mult=
iple indexes
> > > > +        * for anything.
> > > > +        */
> > > > +       evsel->stats->aggr[0].counts.val =3D val;
> >
> > Updating counts needs perf_stat_process_counter to update the
> > aggregation. How does sample->cpu given below relate to aggr[0] here?
> > This and the comment above are a hack liable to break in anything but
> > straightforward circumstances. See:
> > https://lore.kernel.org/lkml/20240720074552.1915993-2-irogers@google.co=
m/
> > on how to handle this.
>
> Your patch is based on a fundamental misunderstanding on the perf script
> metrics use model, see below.

Great, that's explained like where?

> >
> > > >         if (evsel_script(leader)->gnum =3D=3D leader->core.nr_membe=
rs) {
> > > >                 for_each_group_member (ev2, leader) {
> > > >                         perf_stat__print_shadow_stats(&stat_config,=
 ev2,
> > > > -                                                     evsel_script(=
ev2)->val,
> > > > -                                                     sample->cpu,
> > > > +                                                     evsel->stats-=
>aggr[0].counts.val,
> > > > +                                                     0,
> >
> > Similarly this hard coded and unexplained constant.
>
> There's a comment just on top of it explaining it:

No, I mean if you are going to use 0 as your special index do something lik=
e:

const int andis_special_aggr_index =3D 0;

then pass that around rather than 0 otherwise people have to figure
out the numbers are connected. At least in the case of arbitrary
constants you can name them like:

/*aggr_idx=3D*/0,

/*

>         /*
>          * Always use the first entry as storage because the leader sampl=
ing
>          * groups are contiguous and there's no need to handle multiple i=
ndexes
>          * for anything.
>          */
>
>
> >
> > > >                                                       &ctx,
> > > >                                                       NULL);
> > > >                 }
> > > > @@ -2325,6 +2337,20 @@ static void process_event(struct perf_script=
 *script,
> > > >                 fflush(fp);
> > > >  }
> > > >
> > > > +static void check_metric_conflict(void)
> > > > +{
> > > > +       int i;
> > > > +       /*
> > > > +        * Avoid conflict with the aggregation mode used for the me=
tric printing.
> > > > +        */
> >
> > Why is it a conflict, why not support aggregation modes?
>
> I thought I had explained that before.
>
> perf script has two touch point with perf stat output code: one is this o=
ne
> (for metrics on sampling group) and the other is for perf stat record / s=
cript
>
> None of them actually support aggregation because perf script as a
> general rule doesn't aggregate, it only handles single events.

evsels have counts, counts are per thread, per cpu, etc. we get >1
event and so we have aggregation. You can put counts into aggregation
and then clear the aggregation immediately afterward. Metrics are
determined from aggregated counts as that's the most generic way of
doing things.

> But the later one forces AGGR_NONE which doesn't work with the mode the g=
roup
> output uses.
>
> This feature is only to report the metric state for a single sampling per=
iod
> and group as explained in the original commit [1]
>
> If you want to aggregate multiple sample periods you need a lot the
> machinery from perf report, which doesn't make sense to duplicate
> in perf script.
>
> [1] https://www.uwsg.indiana.edu/hypermail/linux/kernel/1712.0/04705.html
>
> -Andi

You are arguing you are special and don't need to use aggregation
machinery then calling APIs that use the aggregation machinery - as
the person maintaining the other end I'm asking to not do that.
Randomly combining samples with gnum and claiming their periods are
related is just weird, and also fundamentally broken for perf inject:
https://lore.kernel.org/lkml/20240729220620.2957754-1-irogers@google.com/
Making assumptions about aggregation indices is brittle, and prone to
break on the other end.

Tbh, nobody noticed in years that there was a segv here. The hard
coded metrics have been disappearing and should disappear even more
so. I don't consider it bad that this is broken, we can then just
delete it knowing nobody has cared about it in years.

Thanks,
Ian
