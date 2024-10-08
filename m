Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCC13959D
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364418; cv=none; b=lmpU9RuFlK89hqDuVDyFpciPDNSW8mSw/2Vil05opb71Iyay61r4QQqbYWowCBcuVjzKhYViF7i4v8Aau49kNv78z8i6MPeIJrK9dLbKVulI+B2ZhNfXRp7Ov7mdwWMOp6DBi+SgPesXb9yDY7VFV7BnpryQgR4caZgRhar1g+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364418; c=relaxed/simple;
	bh=1EjQ0KXwv7lZn6c10spm9WfH7PgaqXsei0Ivoqk2W6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOwsF5x9R0/0GrELTj/OH7ZKzQUU1Gtd398+4BMMgD5IKDkFTI38rg/phPa5pHQ07qv3mM4z+YAhZmX5lsGJjYrq4mvVnfSwacNaTkWJEZtrGkF1QQdoNArgu7GqVOs859vaC1deh56Fv+655NWCFInJazzyrFgBxPXcjidjFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQ1Kr3uI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQ1Kr3uI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c593d6a95so40475ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Oct 2024 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728364416; x=1728969216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmPqsIyIYSer8+7FQ/b/QDr6vcp9lff6dK1sfuzXgSo=;
        b=xQ1Kr3uI4uVCEip/Jr+uZFlgkGQ2AoqotFCf1PHg178pFBV4NNsPFTQ5ksgRszS67Y
         p/OLk/J2UTxlqRdBuKA5zcTicUqhNOnow6Ges+giTA1M5LJtH+sTSYa9SoZcoIGDpyx2
         gAJwppYeYUnxIU0QHQ3LSWCDSye1OGPVUoyaBSjYXmsbmxHukZaknqOFg5NHNC9K40bv
         KqDcKUDlYgN/V4hcOZxQytzEy2FoiTWKClNeP6LLKrnG1WjKWUJWAt6eC3An0rhGbeuo
         tT2PWVOHyIB1vFB7uQuPt5K7OU/Uqpc0qhlysiX4OYoePbAIKLdRVjXlf9vZmnpScbvG
         oOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364416; x=1728969216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmPqsIyIYSer8+7FQ/b/QDr6vcp9lff6dK1sfuzXgSo=;
        b=B/cNumPT2XlidLX2Z0CzTyPCX+fwsgcDUw5inl/HVBMsTmMjkztxkOaIK/xcjBp2Tj
         VjO2cp7J+2lL78YIfYoTzrLxiNy5Ri9AwOpuNjwAJjvLkYdjSzryi4maGRRS+YqzZixP
         tr1JJDLBrilck+dASxWBOk3cS+nyWbgCwwBsnZyDrz7bwz4wU7Ebgb/PGTxeKlFfmISl
         bvEHCEW9BjAk9AfAnoigX9Qj/KP8kC445FoOUy05ib6c3mcOXPYYveOGxBNRHOmAWbRQ
         dKAXQ2HxgpfayllU1htdVmsBWLpfbQIbzy/56Js6Gyq0FhAEqqyr52SkNcs30YncUmCx
         HE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXIATZeXCrk7l0aLcNmrhBXY56rCO4+X8zFkbOqqRxixbh86Ood009pzk4KtQ7rIhiCsB21l5InbMy59Nzl6h84@vger.kernel.org
X-Gm-Message-State: AOJu0YznWC93LvEEiD8FAFW/tZ233W5hJY441Bt00Xqv12wczGml+BS7
	7ETfc3g5Wc1r47WpVI817MPxlgApbgT+DoTW9hRJUf6/9zjj9bPkC6LdZ06bBvk4iQTpCLHdwlr
	Cwlvzx5gA8ugjs3+JewG5plMIAO9D7tjqb35/0AVnS3ra9jZ0hVHyU2g=
X-Google-Smtp-Source: AGHT+IF4N8E/GBZW0DRZvjWNzwGfc67oFXTVypzovKmUSl92DUAT4ClpcGM9lERdV+laYRFTLC0plaxBk5XxKavvmp4=
X-Received: by 2002:a17:903:2303:b0:205:753e:b49d with SMTP id
 d9443c01a7336-20c4fea8644mr1988455ad.0.1728364415747; Mon, 07 Oct 2024
 22:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com> <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com> <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com> <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
 <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
 <Zv8XIZAwfoTtzOl4@google.com> <8df24fe8-4d90-4105-acf0-e4f2667c42c9@linux.intel.com>
 <CAP-5=fUVNa_JKz7WweWsQjobhFCoknbPuPGzPGFGcaDJ8wxLQw@mail.gmail.com> <PH0PR11MB482486871B66FC139C399C8DCD7E2@PH0PR11MB4824.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB482486871B66FC139C399C8DCD7E2@PH0PR11MB4824.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Oct 2024 22:13:22 -0700
Message-ID: <CAP-5=fV1wvWqQs3oEojdv4YDB-CFOFSotJoLAZdn_m1+AxRZQw@mail.gmail.com>
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: "Mi, Dapeng1" <dapeng1.mi@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yongwei Ma <yongwei.ma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:52=E2=80=AFPM Mi, Dapeng1 <dapeng1.mi@intel.com> w=
rote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Friday, October 4, 2024 7:36 AM
> > To: Liang, Kan <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>; Peter Zijlstra
> > <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Arnaldo Carvalh=
o
> > de Melo <acme@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>;
> > Alexander Shishkin <alexander.shishkin@linux.intel.com>; Dapeng Mi
> > <dapeng1.mi@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Yongwei Ma <yongwei.ma@intel.com>; Mi, Dapeng1
> > <dapeng1.mi@intel.com>
> > Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
> >
> > On Thu, Oct 3, 2024 at 4:29=E2=80=AFPM Liang, Kan <kan.liang@linux.inte=
l.com> wrote:
> > >
> > >
> > >
> > > On 2024-10-03 6:13 p.m., Namhyung Kim wrote:
> > > >> Dapeng's comment should cover replace the comment /* Followed by
> > > >> topdown events. */ but there are other things amiss. I'm thinking
> > > >> of something like: "slots,cycles,{instructions,topdown-be-bound}"
> > > >> the topdown-be-bound should get sorted and grouped with slots, but
> > > >> cycles and instructions have no reason to be reordered, so do we
> > > >> end up with slots, instructions and topdown-be-bound being grouped
> > > >> with cycles sitting ungrouped in the middle of the evlist? I
> > > >> believe there are assumptions that grouped evsels are adjacent in
> > > >> the evlist, not least
> > > >> in:
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-ne=
x
> > > >> t.git/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n210=
6
> > > >> Does cycles instructions end up being broken out of a group in thi=
s
> > > >> case? Which feels like the case the code was trying to avoid.
> > > > I got this:
> > > >
> > > >   $ sudo ./perf record -a -e "slots,cycles,{instructions,topdown-be=
-bound}"
> > true
> > > >   Error:
> > > >   The sys_perf_event_open() syscall returned with 22 (Invalid argum=
ent) for
> > event (topdown-be-bound).
> > > >   "dmesg | grep -i perf" may provide additional information.
> > >
> > > To be honest, I think the "slots,cycles,{instructions,topdown-be-boun=
d}"
> > > is a meaningless case. Why a user wants to group instructions and
> > > topdown events, but leave the slots out of the group?
> > > There could be hundreds of different combinations caused by the perf
> > > metrics mess. I don't think the re-ordering code should/can fix all o=
f them.
> >
> > I'm happy with better code and things don't need to be perfect. Can we =
fix the
> > comments though? It'd be nice to also include that some things are goin=
g to be
> > broken. I can imagine groups with topdown events but without slots, for=
 example
> > we group events in metrics and in tma_retiring we add "0 *
> > tma_info_thread_slots" to the metric so that we get a slots event. If t=
he multiply
> > were optimized away as redundant then we'd have a topdown group without
> > slots, we could pick up slots and other events from other metrics.
>
> I don't think this patch would break any current regroup case. It just bl=
ocks to move topdown metrics event if they are already in same group with s=
lot events. We can see same error for this event combination "slots,cycles,=
{instructions,topdown-be-bound}" in the original code.
>
> As Kan said, there could be hundreds of topdown metrics combinations, it'=
s unrealistic to cover all these combinations just using sorting, and even =
it can be done, the comparator would become much complicated and hard to ma=
intain.
>
> I think we'd better just maintain several commonly used regroup cases, it=
 would be fine to raise an error for these unsupported combinations as long=
 as error message is clear enough.
>
> Ian, I don't fully understand your words, could you please give an exampl=
e? Thanks.

So in the comparator I think most people won't understand the list of
cases that are supported and those that are not supported:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/evlist.c?h=3Dperf-tools-next#n35
The groups usually come from metrics and to work around issues there
are constraints on those that may or may not group events. This could
yield situations that don't work given the cases you list, but I don't
think current metrics will violate this. We do test metrics
individually but not together as part of perf test.

Thanks,
Ian

> >
> > > For the case which the re-ordering cannot cover (like above), an erro=
r
> > > out is acceptable. So the end user can update their command to a more
> > > meaningful format, either {slots,cycles,instructions,topdown-be-bound=
}
> > > or {slots,topdown-be-bound},cycles,instructions still works.
> >
> > Perhaps we can add an arch error path that could help more for topdown =
events
> > given they are a particular pain to open.
> >
> > > I think what the patch set really fixed is the failure of sample read
> > > with perf metrics. Without the patch set, it never works no matter ho=
w
> > > you change the order of the events.
> > > A better ordering is just a nice to have feature. If perf cannot
> > > provides a perfect re-ordering, I think an error out is also OK.
> >
> > Agreed, we don't need to fix everything and focussing on the common use=
 cases
> > makes sense.
> >
> > Thanks,
> > Ian
