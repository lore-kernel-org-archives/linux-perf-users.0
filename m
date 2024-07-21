Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413DF1E4BE
	for <linux-perf-users@vger.kernel.org>; Sun, 21 Jul 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721576714; cv=none; b=aVqvr4FoCvgTcCMpLlhUgixIWN5Mnv6pUrwUSPqOY2yiQuh0es6OlCiuPgpS7BcsrZOmtVQtXcvvKh045Q36j5m0geaYRf6VP7PUarhIZwtFQdSVABHI71hJh3Y6bgotcPbd6F5rhIBPfDAEOl1yH43PlUFnRvqF07y88rTVQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721576714; c=relaxed/simple;
	bh=D3p2QaYgcA3SxkvFQ0hiQVrQarKn3r3ZEkug9rLRc9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XahXeM3rPN2nbCnyCNIPp4VkR12Vh4pImXi1kl/SLQUiMPWYC9qo8mOnjz0hseJtNg//kjaXs+Ycs4LhcGQDP4Ogj4neM37hmsLkzPxZFzHuJzcv5w/o3Ys2qt9+adSG8EU+yNE1/N/0pqI6q711PJMdxibJQsCbLP2f1o6E1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=APxJwNFb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="APxJwNFb"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso31772501fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 Jul 2024 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721576710; x=1722181510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V+rPPxTJkY1lpgNajZBDBI+gSNOjf1tlrmrZu0K21g=;
        b=APxJwNFb9jOYIW79zxF1+gJrNV2B2GlHFkvUyfSa8WzfiGsG7dsw/BDxW1sLPDTvi4
         A4hWOv2lBhtCBYxC7dJL8KFx6dKJiGQda6WTvVOl5N4YDxhuSzywpS1GNKfQnAY/sj3t
         noQjZtqkF/I6O9t3n68yepObtiopdQFtD4oQpURlRtMvP1ZPnQ8sMYwSXoplD3fSK2Pw
         d20sCTpeRAtRWnKiuUncJ6vbU/0UZzTtfukNPOhRtb0h/VUa3KOqhgj8Ccv/N4Wmtv54
         eZnl7eExSvHsRIu8pqKB0P/w2HBpNoa3HwOFJiIcED1Ed5a5X4qYXo1WNjs++K0DubCA
         scmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721576710; x=1722181510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V+rPPxTJkY1lpgNajZBDBI+gSNOjf1tlrmrZu0K21g=;
        b=tMl6P2PnOiGq8zkaLsbyYVo0wJkDQS8NGozjzlTQPgJlPyo2W1l07IkPCeQY9o+BNg
         YTiem5IiSqwtPyBfJnbGrKAmNXNRlQcEZSsX8V6Qw/wRe9XdTjey4sBOktNlYKUr9pLt
         3j+jteaYAA27xPknK4Cy02wUHk543iN5Ht630C5anlNnEdRKWOBp3JkJC8Ah/Ki1iSMk
         VNm6f5nsy1fe+UD66RAZ2+NSqXRVCTaqxgegXFYWIpkHz3S+5enYXqCZDXDkIEM/Qv2y
         JOijonBUQ+1E+3x/iMcMcTotItMw7ruRYkACYvp0RHX9SBjXX+HZLDoUax4UQSZfNk5L
         viIg==
X-Forwarded-Encrypted: i=1; AJvYcCWz+SZDnpcdy8y7HK6OOK4oYPcrqmsp2POMxPivSOVYGeg08OwxVmPDz5a1+T8C63SJQCxOQyiOgArdoU0Z3cYxaVKvWoVYdq9A0gAo2CX2DQ==
X-Gm-Message-State: AOJu0YxF5vNvkNXERdC8MESEI06sLLgcjvK8cwcX50L9msGkkJoNRXqY
	UAfTV2a0MdqycWZqUKQAYKWTSe7YMlNdEzmj2XHEQqNgFIjclsawQkoX6/ZJV6YZoIu5xruU8f5
	He2sGuVyknidyAWgxnmvNyPdlJhP36G+EQqj/DQ==
X-Google-Smtp-Source: AGHT+IHJJ78YGiZuqAl+fzdHUOms5HRzmKL23l2X9Zy/P5DZNo7tMea3N8NMNixSrmz96ThXLs/lsMgaRB6wE8WDgMU=
X-Received: by 2002:a2e:95cd:0:b0:2ef:22a1:7d8b with SMTP id
 38308e7fff4ca-2ef22a18602mr9909821fa.4.1721576710231; Sun, 21 Jul 2024
 08:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719081651.24853-1-eric.lin@sifive.com> <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
In-Reply-To: <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
From: Eric Lin <eric.lin@sifive.com>
Date: Sun, 21 Jul 2024 23:44:59 +0800
Message-ID: <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Athira,

On Sat, Jul 20, 2024 at 4:35=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 19 Jul 2024, at 1:46=E2=80=AFPM, Eric Lin <eric.lin@sifive.com> wrot=
e:
> >
> > Currently, if vendor JSON files have two duplicate event names,
> > the "perf list" command will trigger a segfault.
> >
> > In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
> > pmu_events_table__num_events() gets the number of JSON events
> > from table_pmu->num_entries, which includes duplicate events
> > if there are duplicate event names in the JSON files.
>
> Hi Eric,
>
> Let us consider there are duplicate event names in the JSON files, say :
>
> metric.json with: EventName as pmu_cache_miss, EventCode as 0x1
> cache.json with:  EventName as pmu_cache_miss, EventCode as 0x2
>
> If we fix the segfault and proceed, still =E2=80=9Cperf list=E2=80=9D wil=
l list only one entry for pmu_cache_miss with may be 0x1/0x2 as event code =
?
> Can you check the result to confirm what =E2=80=9Cperf list=E2=80=9D will=
 list in this case ? If it=E2=80=99s going to have only one entry in perf l=
ist, does it mean there are two event codes for pmu_cache_miss and it can w=
ork with either of the event code ?
>

Sorry for the late reply.
Yes, I've checked if there are duplicate pmu_cache_miss events in the
JSON files, the perf list will have only one entry in perf list.

> If it happens to be a mistake in json file to have duplicate entry with d=
ifferent event code (ex: with some broken commit), I am thinking if the bet=
ter fix is to keep only the valid entry in json file ?
>

Yes, I agree we should fix the duplicate events in vendor JSON files.

According to this code snippet [1], it seems the perf tool originally
allowed duplicate events to exist and it will skip the duplicate
events not shown on the perf list.
However, after this commit e6ff1eed3584 ("perf pmu: Lazily add JSON
events"),  if there are two duplicate events, it causes a segfault.

Can I ask, do you have any suggestions? Thanks.

[1] https://github.com/torvalds/linux/blob/master/tools/perf/util/pmus.c#L4=
91

Regards,
Eric Lin

> Thanks
> Athira
>
> >
> > perf_pmu__for_each_event() adds JSON events to the pmu->alias
> > list and copies sevent data to the aliases array. However, the
> > pmu->alias list does not contain duplicate events, as
> > perf_pmu__new_alias() checks if the name was already created.
> >
> > When sorting the alias data, if there are two duplicate events,
> > it causes a segfault in cmp_sevent() due to invalid aliases in
> > the aliases array.
> >
> > To avoid such segfault caused by duplicate event names in the
> > JSON files, the len should be updated before sorting the aliases.
> >
> > Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > ---
> > tools/perf/util/pmus.c | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index b9b4c5eb5002..e38c3fd4d1ff 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct print=
_callbacks *print_cb, void *p
> > {
> > struct perf_pmu *pmu;
> > int printed =3D 0;
> > - int len;
> > + size_t len, j;
> > struct sevent *aliases;
> > struct events_callback_state state;
> > bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(print_state)=
;
> > @@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct print=
_callbacks *print_cb, void *p
> > perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
> > perf_pmus__print_pmu_events__callback);
> > }
> > + len =3D state.index;
> > qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> > - for (int j =3D 0; j < len; j++) {
> > + for (j =3D 0; j < len; j++) {
> > /* Skip duplicates */
> > if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> > continue;
> > --
> > 2.43.2
> >
> >
>
