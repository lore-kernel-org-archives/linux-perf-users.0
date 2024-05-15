Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEF3B1AC
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753221; cv=none; b=sjYyZsAi0JeR05CpKwdMGm+S4BqlFQ+QrGosy9os72JIZem/n+xx6y4aM5GfkGGCxfgKhJc9Gp/tpH3TO0uYnSenl4GJGq0WLY7dv7NMi0rgsJ1JgnWF6gCgu9lvLGRJF0mIV6CAVF9fUqxPo1f2684aBHh8SZgNeqPo5z6hohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753221; c=relaxed/simple;
	bh=kUL4zZYBA6Zz37ENPOn7eSbSBL2HQB6Dt7zdYhhamFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtQ1IksZjV6rErwZ4myy3DR1wMuZYcNG/HNljd8HMMoA5t56BcwEDdeSjiznS8Lc9+4Pc92IK//lm0uMjdpkQBmsORTgqWG+rqyXEr/BQBq+D/u+Ofiju0yd8AYQkQkJQSj6H77ENmHdo9t5gW1WBnsfJ0ko6TpncUyL2UBnYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5Q9dPtn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5Q9dPtn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43dfe020675so1814721cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715753219; x=1716358019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw46tNmLyy6/gqhuKbv79aER+4CQjoFXDtqPExJDGXQ=;
        b=Z5Q9dPtniOh6Uq2JbA8QW55FIASwF+jIR6xza9a23e1XGBGV3P9UFx9aSlt0m9S8A2
         0ib7VJwtu3pSsbvrnACx3crX3xF4hSS1NeodyFvdoQmmekZKWv8qU2KRJKaCBG3VMd1S
         lBvWAqkIOddBcbrqNFpMsvVOBjv+Uyv+PA0LpIQ1f5yMQAQltuuN8uwIh479NOU0tUm/
         3UgcT/LldOatiHXqz+90t0BqEdheiqQ5t2Nm976BY2IyrWdJONA1uY7HKUqSYdKbq3TY
         oaSBfZ1l/imeXLctcVY3prPO25Fwwj8xXTaHbhnmxLG3rbEDTwFvV2dPBfXnyZAr7bJo
         P+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715753219; x=1716358019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw46tNmLyy6/gqhuKbv79aER+4CQjoFXDtqPExJDGXQ=;
        b=R4OrZ2tFwoSt6pQi0o9zusStSKAMnIng9jUpRBmIqd2TvV10n2dcnF3TDUQgGwdVlv
         q2D44X+NE3BhkqSUfGcdwiCBPtVLiWlI0jdD7rnhel+XdybCv2f3EQoZdqwbcqfNcBQf
         r9AzHHGpW81X3fhg4vrDjTcMfiRiJCNzWH3wm/uAVBCBalrTCmuL622zppDKGv0c1f24
         GBURNe5GoRf5GgYSLxb74B7lseDoZFK0OLWLs28GfWDiKo7IKBDcvmXDotfoPKgMW7Bg
         fmKCET8hJ9A+zffLjKV23+WMr1VOMR32CTtjCANmO0cv5Uns8kcNfKWsh187WBst9Fjc
         W+WA==
X-Forwarded-Encrypted: i=1; AJvYcCWPWKCnz+EZmFJwbrUjxkCEVdf4nLYNa4htOQqfTzUSZbF6Pk2zGZG6MtYGpIClXs4zDxnMg4GpRmmTuz1VinDI4bOuwKzqutIojKoPsfixqA==
X-Gm-Message-State: AOJu0YwWR/MPPf5CPZ/E/eA3dO6ZtXJX6F5kYOWu6mf/6tloTi7lQ+GM
	E2GFUo1WsQHI2BLkcDCTOwCLNm5CPDU9eZDxOVNeNBOKh8SznzHB7SRJXXt5qXnapJRjeCa7n5m
	gu+V2QnviYoepEC6BouVIKd6+8N8lMPFY6/y1
X-Google-Smtp-Source: AGHT+IGMu7jEqAfsDU1Uer1R6+MjwPSUeYmT6edhDvNSUzQjbN/bHVLcoORZTgm810sR6j/aC2DogtZJd7HemIH0eYk=
X-Received: by 2002:a05:622a:2291:b0:437:986d:86f4 with SMTP id
 d75a77b69052e-43e09555a24mr8295751cf.22.1715753218537; Tue, 14 May 2024
 23:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com> <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
 <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
 <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com> <CO6PR11MB5635CC88D0855FA485C383A9EEEC2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635CC88D0855FA485C383A9EEEC2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 May 2024 23:06:47 -0700
Message-ID: <CAP-5=fV_mco8cf4yf0VUTGnpNUmQx-VA0S8TpbekAa83c3u5WQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:57=E2=80=AFPM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Wednesday, April 24, 2024 11:50 AM
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
> > Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record =
when
> > perf stat needs to get retire latency value for a metric.
> >
> > On Wed, Apr 24, 2024 at 10:08=E2=80=AFAM Wang, Weilin <weilin.wang@inte=
l.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Namhyung Kim <namhyung@kernel.org>
> > > > Sent: Tuesday, April 23, 2024 4:06 PM
> > > > To: Wang, Weilin <weilin.wang@intel.com>
> > > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Moln=
ar
> > > > <mingo@redhat.com>; Alexander Shishkin
> > > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>;=
 Hunter,
> > > > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.=
com>;
> > > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Tay=
lor,
> > Perry
> > > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
> > Biggers,
> > > > Caleb <caleb.biggers@intel.com>
> > > > Subject: Re: [RFC PATCH v6 2/5] perf stat: Fork and launch perf rec=
ord
> > when
> > > > perf stat needs to get retire latency value for a metric.
> > > >
> > > > On Tue, Apr 23, 2024 at 3:16=E2=80=AFPM Wang, Weilin <weilin.wang@i=
ntel.com>
> > > > wrote:
> > > > > > > > > -static int __run_perf_record(void)
> > > > > > > > > +static int __run_perf_record(const char **record_argv)
> > > > > > > > >  {
> > > > > > > > > +       int i =3D 0;
> > > > > > > > > +       struct tpebs_event *e;
> > > > > > > > > +
> > > > > > > > >         pr_debug("Prepare perf record for retire_latency\=
n");
> > > > > > > > > +
> > > > > > > > > +       record_argv[i++] =3D "perf";
> > > > > > > > > +       record_argv[i++] =3D "record";
> > > > > > > > > +       record_argv[i++] =3D "-W";
> > > > > > > > > +       record_argv[i++] =3D "--synth=3Dno";
> > > > > > > > > +
> > > > > > > > > +       if (stat_config.user_requested_cpu_list) {
> > > > > > > > > +               record_argv[i++] =3D "-C";
> > > > > > > > > +               record_argv[i++] =3D stat_config.user_req=
uested_cpu_list;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       if (stat_config.system_wide)
> > > > > > > > > +               record_argv[i++] =3D "-a";
> > > > > > > > > +
> > > > > > > > > +       if (!stat_config.system_wide
> > > > > > && !stat_config.user_requested_cpu_list)
> > > > > > > > {
> > > > > > > > > +               pr_err("Require -a or -C option to run sa=
mpling.\n");
> > > > > > > > > +               return -ECANCELED;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       list_for_each_entry(e, &stat_config.tpebs_events,=
 nd) {
> > > > > > > > > +               record_argv[i++] =3D "-e";
> > > > > > > > > +               record_argv[i++] =3D e->name;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       record_argv[i++] =3D "-o";
> > > > > > > > > +       record_argv[i++] =3D PERF_DATA;
> > > > > > > > > +
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > >
> > > > > > > > Still I think it's weird it has 'perf record' in perf stat =
(despite the
> > > > > > > > 'perf stat record').  If it's only Intel thing and we don't=
 have a plan
> > > > > > > > to do the same on other arches, we can move it to the arch
> > > > > > > > directory and keep the perf stat code simple.
> > > > > > >
> > > > > > > I'm not sure what is the proper way to solve this. And Ian me=
ntioned
> > > > > > > that put code in arch directory could potentially cause other=
 bugs.
> > > > > > > So I'm wondering if we could keep this code here for now. I c=
ould
> > work
> > > > > > > on it later if we found it's better to be in arch directory.
> > > > > >
> > > > > > Maybe somewhere in the util/ and keep the main code minimal.
> > > > > > IIUC it's only for very recent (or upcoming?) Intel CPUs and we
> > > > > > don't have tests (hopefully can run on other arch/CPUs).
> > > > > >
> > > > > > So I don't think having it here would help fixing potential bug=
s.
> > > > >
> > > > > Do you mean by creating a new file in util/ to hold this code?
> > > >
> > > > Yeah, maybe util/intel-tpebs.c (if it's better than arch/x86/...) ?
> > > >
> > > > >
> > > > > Yes, this feature is for very recent Intel CPUs. It should only b=
e triggered if
> > > > > a metric uses event(s) that has the R modifier in the formula.
> > > >
> > > > Can we have a test with a fake metric so that we can test
> > > > the code on non-(or old-)Intel machines?
> > >
> > > All the existing metrics in non-(or old-)Intel CPUs should work as us=
ual. So I
> > think
> > > existing metric tests should work for it.
> > >
> > > If we want to add a fake metric uses the :R modifier for those platfo=
rms, the
> > metric
> > > should either fail (if the fake metric uses an event not exist on the=
 test
> > platform) or
> > > return all 0 retire latency data.
> > >
> > > So, I'm not quite sure what we want the fake metric to test for. Mayb=
e we
> > could
> > > continue using existing metric tests to ensure all the defined metric=
s work
> > correctly
> > > in each machine under test?
> >
> > I think it's ok to return all 0 retire latency for fake tPEBS metrics.
> > It's just to verify the background record + report logic works ok.
>
> Hi Namhyung,
>
> After think more about how TPEBS and metrics work, I feel should discuss =
more
> about defining a fake TPEBS metric in unsupported platforms.
> If we'd like a add fake metrics, where should we define and store these m=
etrics?
> Should we add this type of metrics for every platform? All the official m=
etrics
> we publish are defined by architect and stored in JSON files under separa=
te
> directories for each platform. I think it is not a good idea to place fak=
e metrics
> together with real metrics. Could you please let me know if there is any =
other
> method to define fake metrics for testing?

We do put fake events/metrics in the "test" arch:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json

It is something of a pain bringing things here over to the
NO_JEVENTS=3D1 (ie no python) empty-pmu-events.c file. I agree on not
wanting to pollute real metrics with test metrics, we currently just
use the test metrics to fake up some expression parsing tests:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu-events.c#n811

Thanks,
Ian

> Thanks,
> Weilin
>
> >
> > Thanks,
> > Namhyung
