Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BA9449;
	Sun, 26 May 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716746513; cv=none; b=VajcjtFKtWamjqQ9seXbeXGe2R6MWELhqjCqvi/q3nzTOQzlsm1lfzyTM29+gZH4XAEMFSvwwBrFlbHKf9Sgm4Gk1IbJXfILr+EZSP8gKNCFPROHnXpMZSCi2n2Nj5yJHzMFfaR7qutITnsqWQ2wpAdavBF3mV71GcRjQNfqDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716746513; c=relaxed/simple;
	bh=GeM7l3n9b7yfTNpVAlxn4n6ZhpD0CYVFaOUjUxaGrJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2xXnH1JrTVqg1z+jPexQdHexWO8T3FeDydC+EZROr6fapAmHiKOg0I40spq34tsQH7wqkoSj31qmQ0VnUJ28dZ3xW0yujpjLtXrcIZTS4jX3ikYzqpV/BOWkTQQdXWfMubjiQmVn7Bk+w6VgjeVS1gyyN1RGEORHrSW3/0JH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so3419360a12.0;
        Sun, 26 May 2024 11:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716746511; x=1717351311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXPh7TFYjYz1hkCYmis26EZXSF/Y7T5SQc05dmlFt2E=;
        b=bvLe2lFZX9zKBWPh3ULirdsPQKbkVpoaz959JEm/AH+GGlE5qfrG7jLNQ6aROh3VM1
         xExQfn29N71KQN3MioGGnbWCkG5o8mCGUu/6JWXZ/tpHXMq/HDlAYU5qU7h9+Yy2iYNb
         xzrqQrWLVYmoLGUEsWxgVAxhVC708zkUt7WvWKd8VtHh5oP7ItMOzDTi2k4KYV2FvOGm
         uNRKnbA/qN9hixnWk9xzlvrOKilMIB/Te+Sswsorg/DzUou/pDO6hijVMDYZuStBNsU4
         eqPzE/ie5txeeqbq3EuHewJnM86VhI7v0xZhE7Nn7i83X2IBt1lKF4BEz2btTm/gUy3K
         dMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCZfilaFBcOXWAZXvZUaFfjP/xoxNycRhmuH9vRGU04s5XOq6WGj/FOYFwjneRTSsD57cCTPAnIAL4UE5nBKQLPwl9CKSyvppILGJiwj9SKeCJlF5HBz/jT+BJC9kOtDUhJmmapoDh2Ns/wSAj5Q==
X-Gm-Message-State: AOJu0YxSYZLoWsKSVxQKiAbkAdbKWO5i/+S/EuWn20R2SwBYuKG1OiJ7
	Ig3EPpac62AsCeTMzvkuxmmTfq+VM1YFRZQz2HK44B7R/40PkCjyNYbdpbjfWuz//3cIGig+dMm
	3hmTcNr4hLDsm7vVRfOpW2b9JOMY8Tw==
X-Google-Smtp-Source: AGHT+IEj2oZe5cMbp27MPB0KaRgspifEGudks6L1xi03Ab2aItxW/y/uLIU7z4xfCkyp6uL/PF34xSBXGXiy+UIDaeI=
X-Received: by 2002:a17:90b:fd3:b0:2b5:4ee8:e5e8 with SMTP id
 98e67ed59e1d1-2bf5e189092mr6262469a91.16.1716746510638; Sun, 26 May 2024
 11:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <20240521173952.3397644-5-weilin.wang@intel.com> <CAM9d7cjob_tfgN+rMRrh=0SV56+z32CmP34BRY1eoFv48RVocg@mail.gmail.com>
 <CO6PR11MB563589ED3FC7126A6B27EB22EEF52@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563589ED3FC7126A6B27EB22EEF52@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 26 May 2024 11:01:39 -0700
Message-ID: <CAM9d7cjz0P=vrSr8yU=xMYhQ5XFT9A+K-WG9E+LyNzYWC-JhwA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 4:52=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Friday, May 24, 2024 4:17 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from=
 sampled
> > data to evsel
> >
> > On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > In current :R parsing implementation, the parser would recognize even=
ts
> > with
> > > retire_latency modifier and insert them into the evlist like a normal=
 event.
> > > Ideally, we need to avoid counting these events.
> > >
> > > In this commit, at the time when a retire_latency evsel is read, set =
the retire
> > > latency value processed from the sampled data to count value. This sa=
mpled
> > > retire latency value will be used for metric calculation and final ev=
ent count
> > > print out.
> >
> > I'm confused.  Do you mean you don't count the event with 'R' modifier
> > (w/ perf stat) and just print the (average) retire latency (from perf r=
ecord)?
>
> In metric formulas, event without 'R' modifier is included as a normal ev=
ent already.
> So we don't need to count the event that with 'R' modifier. They only nee=
d to be
> sampled.

Oh, you have the event in the metric expression twice.  I thought of one.
Then IIUC the metric looks something like this.

  myevent1 + (myevent2 * myevent1:R)

I think you'll have 2 myevent1 in perf stat and 1 in perf record, right?
But the second one in perf stat is never used and the value is updated
from perf record.

Then we can simply remove the event from the evlist (or replace it with
a dummy) to reduce the overheads (of open and read).

>
> >
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  tools/perf/arch/x86/util/evlist.c |  6 +++++
> > >  tools/perf/util/evsel.c           | 44 +++++++++++++++++++++++++++++=
++
> > >  tools/perf/util/evsel.h           |  5 ++++
> > >  3 files changed, 55 insertions(+)
> > >
> > > diff --git a/tools/perf/arch/x86/util/evlist.c
> > b/tools/perf/arch/x86/util/evlist.c
> > > index b1ce0c52d88d..cebdd483149e 100644
> > > --- a/tools/perf/arch/x86/util/evlist.c
> > > +++ b/tools/perf/arch/x86/util/evlist.c
> > > @@ -89,6 +89,12 @@ int arch_evlist__cmp(const struct evsel *lhs, cons=
t
> > struct evsel *rhs)
> > >                         return 1;
> > >         }
> > >
> > > +       /* Retire latency event should not be group leader*/
> >
> > Hmm.. why?
> Because we don't want to count them. Make them the group leader would not=
 work.

I don't understand.  You'll read the event regardless of being a
leader or not.

>
> >
> > > +       if (lhs->retire_lat && !rhs->retire_lat)
> > > +               return 1;
> > > +       if (!lhs->retire_lat && rhs->retire_lat)
> > > +               return -1;
> > > +
> > >         /* Default ordering by insertion index. */
> > >         return lhs->core.idx - rhs->core.idx;
> > >  }
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index a0a8aee7d6b9..4d700338fc99 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -58,6 +58,7 @@
> > >  #include <internal/xyarray.h>
> > >  #include <internal/lib.h>
> > >  #include <internal/threadmap.h>
> > > +#include "util/intel-tpebs.h"
> > >
> > >  #include <linux/ctype.h>
> > >
> > > @@ -1523,6 +1524,40 @@ static int evsel__read_one(struct evsel *evsel=
,
> > int cpu_map_idx, int thread)
> > >         return perf_evsel__read(&evsel->core, cpu_map_idx, thread, co=
unt);
> > >  }
> > >
> > > +static int evsel__set_retire_lat(struct evsel *evsel, int cpu_map_id=
x, int
> > thread)
> > > +{
> > > +       struct perf_counts_values *count;
> > > +       struct tpebs_retire_lat *t;
> > > +       bool found =3D false;
> > > +       __u64 val;
> > > +
> > > +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > > +
> > > +       list_for_each_entry(t, &tpebs_results, nd) {
> > > +               if (!strcmp(t->tpebs_name, evsel->name)) {
> > > +                       found =3D true;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (!found)
> > > +               return -1;
> > > +
> > > +       /*
> > > +        * Only set retire_latency value to the first CPU and thread.
> > > +        */
> > > +       if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> > > +               val =3D t->val;
> > > +       else
> > > +               val =3D 0;
> > > +
> > > +       count->val =3D val;
> > > +       /* Set ena and run to non-zero */
> > > +       count->ena =3D count->run =3D 1;
> > > +       count->lost =3D 0;
> >
> > So here it seems you discard the actual count of the events
> > and replace it with the retire latency.  That means you don't
> > need to open the event in perf stat, and probably just have a
> > placeholder, right?
> >
> > Btw, I think it's better to move this logic to intel-tpebs.c file and
> > rename to tpebs_set_retire_lat().
>
> Ian wants this to be here and also suggested me to rename this function t=
o
> evsel__read_retire_lat(). I'm ok with either way.

I think it's better to have the tpebs logic together.

Thanks,
Namhyung

>
> >
> >
> > > +       return 0;
> > > +}
> > > +
> > >  static void evsel__set_count(struct evsel *counter, int cpu_map_idx,=
 int
> > thread,
> > >                              u64 val, u64 ena, u64 run, u64 lost)
> > >  {
> > > @@ -1530,6 +1565,12 @@ static void evsel__set_count(struct evsel
> > *counter, int cpu_map_idx, int thread,
> > >
> > >         count =3D perf_counts(counter->counts, cpu_map_idx, thread);
> > >
> > > +       if (counter->retire_lat) {
> >
> > if (evsel__is_retire_lat(counter)) ?
> >
> >
> > > +               evsel__set_retire_lat(counter, cpu_map_idx, thread);
> > > +               perf_counts__set_loaded(counter->counts, cpu_map_idx,=
 thread,
> > true);
> > > +               return;
> > > +       }
> > > +
> > >         count->val    =3D val;
> > >         count->ena    =3D ena;
> > >         count->run    =3D run;
> > > @@ -1778,6 +1819,9 @@ int evsel__read_counter(struct evsel *evsel, in=
t
> > cpu_map_idx, int thread)
> > >         if (evsel__is_tool(evsel))
> > >                 return evsel__read_tool(evsel, cpu_map_idx, thread);
> > >
> > > +       if (evsel__is_retire_lat(evsel))
> > > +               return evsel__set_retire_lat(evsel, cpu_map_idx, thre=
ad);
> > > +
> >
> > I'm not sure if it works well with group event.  Probably that's
> > why you wanted to prevent group leaders.  But I guess you
> > can just check this after the PERF_FORMAT_GROUP, no?
> >
> > Thanks,
> > Namhyung
> >
> >
> > >         if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
> > >                 return evsel__read_group(evsel, cpu_map_idx, thread);
> > >
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index bd8e84954e34..aaf572317e92 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -303,6 +303,11 @@ static inline bool evsel__is_tool(const struct e=
vsel
> > *evsel)
> > >         return evsel->tool_event !=3D PERF_TOOL_NONE;
> > >  }
> > >
> > > +static inline bool evsel__is_retire_lat(const struct evsel *evsel)
> > > +{
> > > +       return evsel->retire_lat;
> > > +}
> > > +
> > >  const char *evsel__group_name(struct evsel *evsel);
> > >  int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
> > >
> > > --
> > > 2.43.0
> > >
