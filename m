Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061050A63
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934633; cv=none; b=mm7ZXsm04y4Li3j0SDQ5gaWIGVs71+ff4+4BrZskFCLuIMXJPoy1UFrDmL9Vof1M30V1+EpE8jrCZcfu/puzw77V0fBkjbFLb/1LbN5XBPZnWmMWX0HaZiNbJVWEujzqvdMPC5bzO8kMo4rc1rIzZaZf2OuPf9sympyoKTU4Pfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934633; c=relaxed/simple;
	bh=KgxKy3B9/bvHCk1XIcrOxAdTViZHUFvaiD1OLQpr4sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vD4dMs1W9wY4X45RuJBbGuxY565f5AWpytRUnbfqilNyApIT2Dydt6ZKWp2itNf/GyFIDQz3Pdx56LJZaDkbnhYt2yVhjo76R1MDuLauRclfY6HVgZvz386B5q3w/4f/cN3elYekMpK9BCkOdCl1+npuwvPCVn7z+OZcP92rEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhrsXZxN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhrsXZxN"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfe020675so193651cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716934630; x=1717539430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKsx1Wjb37gHKeRHMU40MydeR/ELp98IEnmlde48+So=;
        b=uhrsXZxNa3RFXafIfe+U2Ltq6bS7DneRc5jPRc37O1O6XONs2lgWFsmXVbBVcs7nBY
         6KHhcxVxXuy3I/1T3dyC/xBPnI/HO0m/4/a8/D6hTRsIScprEPKYxeAqqMzgPm6B1Xge
         jMak/ihiTv0r1wooaj8+tY4XaVUG2umuTGuVtPXDVqBAn4J8g9gGz9AYRNXGzDMTjIqV
         XX+T0kJ0euoLcy+n5GuOPYrw4UM263StVinX0ot4LwxcDK6Ji6fw6UCf7NTh0Lm8/25S
         Uh2wYXocCrXpSFT5PoEtTb2K0BBr+EOfPKFU37wgUdjhUt2TeWf3eajjqB4xGz1Gcqdq
         oGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716934630; x=1717539430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKsx1Wjb37gHKeRHMU40MydeR/ELp98IEnmlde48+So=;
        b=M2b7bRjhLRwixyKB4yrBo1cVmQGJlDtHB4C+ojFBgBcOfen5fmEEVYg8fN15ezAuCW
         Ax0FATl3fFWSEo47eiwhUEyyoGPrRE1ZLfsc/0JGHEN/UhpVpT3nL0v9uz4Mj0qtQT4U
         HOvPE9HimVmD00mxpCfq1+Pk9pn5aP/m/Ee25+jKqPiZBuzks4vXrMzZSbyFWfYRoQYJ
         VwG8MRfdK1ogLQphb3II4O/vw4kQNEVweawcZQVrXljFacAN9FahfThafBiHIrn42scP
         CJJvLc2CicaYKwD1B2h4SvVkKUk1271MDsckj8kQcLKE9mDVgPiCbOzn8UbJCj7FeWOt
         Vbeg==
X-Forwarded-Encrypted: i=1; AJvYcCWe9rVw8GDdKf6Gcs0CaDVOFSQpChLAhTxZ/2Fr3OQVJon1pEsugNM2JvdDCgdibwMYtSlmHR+oCL1j+VGL3AeSimcKPq2WzUM3oQHiqVBfiA==
X-Gm-Message-State: AOJu0YwoTsPk06uMdUR73RRJddd1RKz6UNqREYl9wDFKqRNAjMoAkJxv
	eQZ4e3P5VQnAEZZpxT5rAsStnns+QYP5TROmGN2rwsaAwqCmDeGL9h55EhQcjjU97akeBDJnmKd
	RUDFCnCqyigx1OnL5jhVNe++3r3cNQUK3K1k/
X-Google-Smtp-Source: AGHT+IETo0a4r5DWLWDwEytiMN9zQ17SSn1T3aVosvBNctOg0AmLMUGYAh9Ft4CGHNsTPvElc6EcRlu9Gn2L3/Z3Xr8=
X-Received: by 2002:a05:622a:4819:b0:43f:bb44:bbb7 with SMTP id
 d75a77b69052e-43fe0f4cefamr851191cf.8.1716934630467; Tue, 28 May 2024
 15:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <20240521173952.3397644-5-weilin.wang@intel.com> <CAM9d7cjob_tfgN+rMRrh=0SV56+z32CmP34BRY1eoFv48RVocg@mail.gmail.com>
 <CO6PR11MB563589ED3FC7126A6B27EB22EEF52@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjz0P=vrSr8yU=xMYhQ5XFT9A+K-WG9E+LyNzYWC-JhwA@mail.gmail.com>
In-Reply-To: <CAM9d7cjz0P=vrSr8yU=xMYhQ5XFT9A+K-WG9E+LyNzYWC-JhwA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 May 2024 15:16:58 -0700
Message-ID: <CAP-5=fV0Xoe9HAcpvSFBF=vGhTaHAJdDCPEmwZSRk3VXL9S+1A@mail.gmail.com>
Subject: Re: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Wang, Weilin" <weilin.wang@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 11:01=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, May 24, 2024 at 4:52=E2=80=AFPM Wang, Weilin <weilin.wang@intel.c=
om> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Namhyung Kim <namhyung@kernel.org>
> > > Sent: Friday, May 24, 2024 4:17 PM
> > > To: Wang, Weilin <weilin.wang@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > <mingo@redhat.com>; Alexander Shishkin
> > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; H=
unter,
> > > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.co=
m>;
> > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylo=
r, Perry
> > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Big=
gers,
> > > Caleb <caleb.biggers@intel.com>
> > > Subject: Re: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value fr=
om sampled
> > > data to evsel
> > >
> > > On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrot=
e:
> > > >
> > > > From: Weilin Wang <weilin.wang@intel.com>
> > > >
> > > > In current :R parsing implementation, the parser would recognize ev=
ents
> > > with
> > > > retire_latency modifier and insert them into the evlist like a norm=
al event.
> > > > Ideally, we need to avoid counting these events.
> > > >
> > > > In this commit, at the time when a retire_latency evsel is read, se=
t the retire
> > > > latency value processed from the sampled data to count value. This =
sampled
> > > > retire latency value will be used for metric calculation and final =
event count
> > > > print out.
> > >
> > > I'm confused.  Do you mean you don't count the event with 'R' modifie=
r
> > > (w/ perf stat) and just print the (average) retire latency (from perf=
 record)?
> >
> > In metric formulas, event without 'R' modifier is included as a normal =
event already.
> > So we don't need to count the event that with 'R' modifier. They only n=
eed to be
> > sampled.
>
> Oh, you have the event in the metric expression twice.  I thought of one.
> Then IIUC the metric looks something like this.
>
>   myevent1 + (myevent2 * myevent1:R)
>
> I think you'll have 2 myevent1 in perf stat and 1 in perf record, right?
> But the second one in perf stat is never used and the value is updated
> from perf record.
>
> Then we can simply remove the event from the evlist (or replace it with
> a dummy) to reduce the overheads (of open and read).
>
> >
> > >
> > > >
> > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > > ---
> > > >  tools/perf/arch/x86/util/evlist.c |  6 +++++
> > > >  tools/perf/util/evsel.c           | 44 +++++++++++++++++++++++++++=
++++
> > > >  tools/perf/util/evsel.h           |  5 ++++
> > > >  3 files changed, 55 insertions(+)
> > > >
> > > > diff --git a/tools/perf/arch/x86/util/evlist.c
> > > b/tools/perf/arch/x86/util/evlist.c
> > > > index b1ce0c52d88d..cebdd483149e 100644
> > > > --- a/tools/perf/arch/x86/util/evlist.c
> > > > +++ b/tools/perf/arch/x86/util/evlist.c
> > > > @@ -89,6 +89,12 @@ int arch_evlist__cmp(const struct evsel *lhs, co=
nst
> > > struct evsel *rhs)
> > > >                         return 1;
> > > >         }
> > > >
> > > > +       /* Retire latency event should not be group leader*/
> > >
> > > Hmm.. why?
> > Because we don't want to count them. Make them the group leader would n=
ot work.
>
> I don't understand.  You'll read the event regardless of being a
> leader or not.
>
> >
> > >
> > > > +       if (lhs->retire_lat && !rhs->retire_lat)
> > > > +               return 1;
> > > > +       if (!lhs->retire_lat && rhs->retire_lat)
> > > > +               return -1;
> > > > +
> > > >         /* Default ordering by insertion index. */
> > > >         return lhs->core.idx - rhs->core.idx;
> > > >  }
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index a0a8aee7d6b9..4d700338fc99 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -58,6 +58,7 @@
> > > >  #include <internal/xyarray.h>
> > > >  #include <internal/lib.h>
> > > >  #include <internal/threadmap.h>
> > > > +#include "util/intel-tpebs.h"
> > > >
> > > >  #include <linux/ctype.h>
> > > >
> > > > @@ -1523,6 +1524,40 @@ static int evsel__read_one(struct evsel *evs=
el,
> > > int cpu_map_idx, int thread)
> > > >         return perf_evsel__read(&evsel->core, cpu_map_idx, thread, =
count);
> > > >  }
> > > >
> > > > +static int evsel__set_retire_lat(struct evsel *evsel, int cpu_map_=
idx, int
> > > thread)
> > > > +{
> > > > +       struct perf_counts_values *count;
> > > > +       struct tpebs_retire_lat *t;
> > > > +       bool found =3D false;
> > > > +       __u64 val;
> > > > +
> > > > +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > > > +
> > > > +       list_for_each_entry(t, &tpebs_results, nd) {
> > > > +               if (!strcmp(t->tpebs_name, evsel->name)) {
> > > > +                       found =3D true;
> > > > +                       break;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (!found)
> > > > +               return -1;
> > > > +
> > > > +       /*
> > > > +        * Only set retire_latency value to the first CPU and threa=
d.
> > > > +        */
> > > > +       if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> > > > +               val =3D t->val;
> > > > +       else
> > > > +               val =3D 0;
> > > > +
> > > > +       count->val =3D val;
> > > > +       /* Set ena and run to non-zero */
> > > > +       count->ena =3D count->run =3D 1;
> > > > +       count->lost =3D 0;
> > >
> > > So here it seems you discard the actual count of the events
> > > and replace it with the retire latency.  That means you don't
> > > need to open the event in perf stat, and probably just have a
> > > placeholder, right?
> > >
> > > Btw, I think it's better to move this logic to intel-tpebs.c file and
> > > rename to tpebs_set_retire_lat().
> >
> > Ian wants this to be here and also suggested me to rename this function=
 to
> > evsel__read_retire_lat(). I'm ok with either way.
>
> I think it's better to have the tpebs logic together.

I think the tpebs functions can be in a tpebs file. I'd rather have
the retirement latency events (from the metric) be evsels for a few
reasons:

1) I'd rather everything in a metric be evsels, so things like
"num_cpus_online" should really be a tool event rather than a special
literal kind of thing. I'd like to reduce special cases over time, in
part as it should help with portability. For example, if only Intel
x86 can parse :R then someone trying to parse an Intel x86 metric on
ARM may get parser errors.

2) When we change from forking perf record to directly opening a
sampling ring buffer then it makes sense that we use/update the
evsel/evlist logic.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > >
> > >
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static void evsel__set_count(struct evsel *counter, int cpu_map_id=
x, int
> > > thread,
> > > >                              u64 val, u64 ena, u64 run, u64 lost)
> > > >  {
> > > > @@ -1530,6 +1565,12 @@ static void evsel__set_count(struct evsel
> > > *counter, int cpu_map_idx, int thread,
> > > >
> > > >         count =3D perf_counts(counter->counts, cpu_map_idx, thread)=
;
> > > >
> > > > +       if (counter->retire_lat) {
> > >
> > > if (evsel__is_retire_lat(counter)) ?
> > >
> > >
> > > > +               evsel__set_retire_lat(counter, cpu_map_idx, thread)=
;
> > > > +               perf_counts__set_loaded(counter->counts, cpu_map_id=
x, thread,
> > > true);
> > > > +               return;
> > > > +       }
> > > > +
> > > >         count->val    =3D val;
> > > >         count->ena    =3D ena;
> > > >         count->run    =3D run;
> > > > @@ -1778,6 +1819,9 @@ int evsel__read_counter(struct evsel *evsel, =
int
> > > cpu_map_idx, int thread)
> > > >         if (evsel__is_tool(evsel))
> > > >                 return evsel__read_tool(evsel, cpu_map_idx, thread)=
;
> > > >
> > > > +       if (evsel__is_retire_lat(evsel))
> > > > +               return evsel__set_retire_lat(evsel, cpu_map_idx, th=
read);
> > > > +
> > >
> > > I'm not sure if it works well with group event.  Probably that's
> > > why you wanted to prevent group leaders.  But I guess you
> > > can just check this after the PERF_FORMAT_GROUP, no?
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > >         if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
> > > >                 return evsel__read_group(evsel, cpu_map_idx, thread=
);
> > > >
> > > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > > index bd8e84954e34..aaf572317e92 100644
> > > > --- a/tools/perf/util/evsel.h
> > > > +++ b/tools/perf/util/evsel.h
> > > > @@ -303,6 +303,11 @@ static inline bool evsel__is_tool(const struct=
 evsel
> > > *evsel)
> > > >         return evsel->tool_event !=3D PERF_TOOL_NONE;
> > > >  }
> > > >
> > > > +static inline bool evsel__is_retire_lat(const struct evsel *evsel)
> > > > +{
> > > > +       return evsel->retire_lat;
> > > > +}
> > > > +
> > > >  const char *evsel__group_name(struct evsel *evsel);
> > > >  int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)=
;
> > > >
> > > > --
> > > > 2.43.0
> > > >
