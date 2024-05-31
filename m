Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123A33CA;
	Fri, 31 May 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191015; cv=none; b=rYsjfwMwb41FixTcinJ3WYXhoNSHJEJhhIQKHvuhlVdFrYqd/hVetTo3cDXs89OGn/v9kcVWyvCBWj5pfZkTg/Am9pwDoDmRntiJHhFyLObSshUG7SDNyGdE4M5jXrHNmrzvraPPF8mwsZd8kP9q3qKDDI/tBhwaoNmSCfQb89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191015; c=relaxed/simple;
	bh=r0gbpWvNbzGCrMhYFi0EbECyBtITGpmDI6DFAmxmtLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQc1WF6P6D8p44ONXwWKAjTZLc/6X789V4jT4TEW22n396VQYhSLYCLsKBVROYTJHch18FY4LdHxxDaSF4Veo/dvTwNH+j7Ky0kkvyWSH+YksWMdJsm04y1JN6sOa0dyxOhD4vfevVITZcTtj58WqtoXReO6CW0zmjD8HWWstBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bdd8968dabso1112736a91.3;
        Fri, 31 May 2024 14:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191013; x=1717795813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf5goCeDE6/jONyA1+NLXMd0UgptexLjaZQOdCXS4dQ=;
        b=KkyrqLnXKv1/AbVgo/CDBWvUx4r1PGjNPqKx0bCezRT1jpcmQphpCtoxdDSx5ZKbZs
         drzzYQQ1DJXVVNWtGhSsFiQD2s5f/2+JIykkhvykqtZSvlTwp0pPV1x3/0HnoMu8TUG2
         BSvtVzW+neBGIb07HXTzGXjvdHp1mdMq0CucV/vRYiBT/r5K+iybR+YDEE67sCuZUKn6
         IorXeim6+l15O2jVLHVN8cJPhs/ZbxtI+PHZT0OSmIpK7N/b8uo38HI/dZ2mZ7AyAEHF
         +obtXgd3/6S9qqq644dHjdsVQYi3kKMuUtzK2pp2FUSr1V9hDdUjt9f+vUQDuzuJDfhN
         JAyA==
X-Forwarded-Encrypted: i=1; AJvYcCX4qCCCYasONJ5dYXMiBBFbAxBCNNzJD+jMIUhZVzjz3vs3tOCG3EJssvsRG24q60AGeTu671FJrat020BLaJS13+hawosxw+eGtu2g+TEa7ouVMEfczE6fs6HQJFiSMe+9A0bQ82Nybq61EmesZQ==
X-Gm-Message-State: AOJu0YzOrWLecw+BeqYm+O0zcnJNRW7JgMy5OsiRozBaH3tFTmizKeM2
	tT3dwzFa8NOipBtA6RAUkZMetBqkZ9PwNicWOUB6upzcC/p3h9xfTq4A9pysMOwVv/dzQJkoIO0
	9HuWJbMgWfmAkZUT+A/ymIPmMoJg=
X-Google-Smtp-Source: AGHT+IHwy0dvwzXh9ZxotJ+7sqGd6Df4qBQTmz9Q0Xs+Mh9KNGYtTRNVs8y7/4W8vAySGuNIdjts7lCgB3KbW+7Ankw=
X-Received: by 2002:a17:90b:440b:b0:2c1:aa8d:25d5 with SMTP id
 98e67ed59e1d1-2c1dc568f40mr2716432a91.8.1717191013289; Fri, 31 May 2024
 14:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <CAM9d7cj676sty01zqJVyk9DVesVYNFgVTZ329X=UP3xgV2aDfA@mail.gmail.com> <CO6PR11MB5635D7581425EF0F089EA781EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5635D7581425EF0F089EA781EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 31 May 2024 14:30:02 -0700
Message-ID: <CAM9d7chSC=n2sCc_nhgwqHYnBhSjMhH1quAY6_JWXNhrk1ri8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v10 0/8] TPEBS counting mode support
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

On Fri, May 31, 2024 at 12:00=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Thursday, May 30, 2024 11:37 PM
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
> > Subject: Re: [RFC PATCH v10 0/8] TPEBS counting mode support
> >
> > Hello,
> >
> > On Tue, May 28, 2024 at 11:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > I have tried not to count retire_latency events but did not succeed.
> > > In particular, I tried the following methods:
> > >  - Convert retire_latency event to dummy event in event parser.
> > >  - Early bail out in evsel__open_cpu() and store_evsel_ids().
> > >
> > > The first method fails and causes non-retire_latency events with the =
same
> > event
> > > name return 0 count.
> > >
> > > The second method fails and causes all the events in the same group
> > returning
> > > "<not counted>" results.
> >
> > Can you please describe where it fails?  Is it failing on other events
> > because the tpebs event is a leader of the group?  I think you wanted
> > to avoid having it in the leader position.  If we can skip any actual
> > operations (open/close/enable/disable/read) for the tpebs events, then
> > it could be fine..
>
> It does not fail with the code in this patch set. But if I make it return=
 directly
> from tpebs_start() in evsel__open_cpu(), it will cause segfault. The segf=
ault is
> caused by store_evsel_id(). I could add another early return from store_e=
vsel_id()
> if the evsel->retire_lat is true.

Yeah, I think event:R should not go to kernel from perf stat and you need t=
o
handle that in the tools.

>
> After this change, it will eventually run and give me <not counted> resul=
ts
> like below:
>
>         <not counted> event1
>         <not counted> event2
>         xx event1:R
>
> In a different case, it may seem to work (xxxxxx stands for some valid va=
lue):
>
>         xxxxxxx event1
>         xxxxxxx event2
>         xxxxxxx event3
>         xx event1:R
>
> In the first case, the event1, event2 and event1:R are scheduled in the s=
ame
> group. On the other hand, in the second case, event1, event2 and event3 a=
re
> in one group, while event1:R is in a different group.

If you don't open event1:R then the kernel only sees event1 and event2.

>
> Based on these two different type of results, I believe the failure happe=
ns in
> the group that include a :R event. I've added the change to arch_evlist__=
cmp()
> so that a :R event would not be a leader of the group.
>
> I think I've made evsel__open_cpu() return before it create fd and make
> store_evsel_id() not to read and store fd. I'm not sure where I'm missing=
. Please
> let me know if you have any suggestions.

As I said, please don't open event1:R (for perf stat) and let tpebs_stop() =
set
the value using the data from perf record in background.

Thanks,
Namhyung
