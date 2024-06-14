Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AB262BE;
	Fri, 14 Jun 2024 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336606; cv=none; b=YvT5Cw1so0r+zD4j10WH2d3oOh14uxzINp1lylJlMJAIl5D+Hy1BNziSdOpRA49f4km7ftlyMHFY75YR8zmRI1TpeYzp+NM0yHkrX9fShO0L41YVL163XqRsIW5CYnUvCvQkPU1Tpux38muRNguxhYte9ULpujVNUr/SCASDixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336606; c=relaxed/simple;
	bh=OtbOM3hKhInP17oGSpKGJOOCrYBnUHT76/Gk6UTiJyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEI9mBEL34+EYh+8AJx8FONGn6a2FQNCmfFgzXbTCFZ7/AopOD1xwkDCd4xxfW1enbrSAWJ177LfcZTC+ZCZpoIEn/FZWFOEE//y+8nGZvFw6HoW2vKJEWnfnw2X93Kn/+bMmL/m+BL34lu7O4Gkt52wlvJW4Kytu05EXgZAbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70599522368so1353365b3a.2;
        Thu, 13 Jun 2024 20:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718336604; x=1718941404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEns122DF4ORxOv+hY+sFqPCmpA0T4JQRa3ZlqqBaYE=;
        b=dd0N792sQlCHO0z+0QluSqzU0HyCtEXPVo4/PaNTtDvMouOueSrg6A32VeO9uXEpdB
         VE8d8hiDTRPNq2OIWXF8AIRnsZW+W+CJdZ10wv6GQw1WhLyVhDZpYOCvjgv5lUsEtur4
         9C8tDGmG6mAYnPXnIuQvBkprwbC+Hegl4c3HcN1zwl6pTZWrhc78a265MJYY3+TQV2eu
         j0VfZ0zYl7BqXbxpoSTlDVRH9ggN6YG/CI5EmNjzjU24JSEAogda/nI6V/vvx4r4t3gR
         Dz7ub/jBSBaUktaWgm0IQ/4MLtwo1wApLsSh82/gikRWVwk5CcK9ADvSJbhyl8Y5IYuT
         6nRA==
X-Forwarded-Encrypted: i=1; AJvYcCWD4sA8qZkim3mO9gpJR93afaYSAwhiWJpmzcRPtl5o+ejnbVxDqKYAZ41Uu+D7ORwAxxiBMvrPOxm8nwqzA3yCWLCJDanTRjepLjC2GEI8XYDNnFrJUbMDT87nTgFybKRKkI0rOVjxnVi0c1azvw==
X-Gm-Message-State: AOJu0YypjuXmY1gMRReDvcr7zcybpgBGnN5WAl2HWG1ZLW4+L4yEKTqs
	oI3dtJfVV92kKVsjUOGbma/FWdhlMeFV+0XdoVKdP8eXl7dmuaeyLO1Xoh2w+5/PNWE4ndyZkTj
	4yt8gIc+w/rDFQt8LToPmttIywPU=
X-Google-Smtp-Source: AGHT+IEqujDuJP84z+C0ud5LNON7yidV0VbedNy9wLz4UAkiU5nT0YiO/NqEOhlv30RmBy6lHTMt3ClAYiAnTL57vu8=
X-Received: by 2002:a05:6a20:430d:b0:1b4:c4c8:bcb7 with SMTP id
 adf61e73a8af0-1bae7e2271amr2367076637.1.1718336603971; Thu, 13 Jun 2024
 20:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608124915.33860-1-vineethr@linux.ibm.com>
 <ZmeET1yhxU1-D7hy@google.com> <dd2d1e43-8928-4205-9fdb-88208f18c495@linux.ibm.com>
In-Reply-To: <dd2d1e43-8928-4205-9fdb-88208f18c495@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 13 Jun 2024 20:43:10 -0700
Message-ID: <CAM9d7cjRJUfSPOAdVgcB=UHShPCxY8d3ryEZjzqdiuGhOKd4Lg@mail.gmail.com>
Subject: Re: [PATCH v2] perf sched map: Add command-name, fuzzy-name options
 to filter the output map
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Chen Yu <yu.c.chen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 11, 2024 at 1:47=E2=80=AFAM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Namhyung,
>
> On 11/06/24 04:25, Namhyung Kim wrote:
> > Hello,
> >
> > On Sat, Jun 08, 2024 at 06:18:29PM +0530, Madadi Vineeth Reddy wrote:
> >> By default, perf sched map prints sched-in events for all the tasks
> >> which may not be required all the time as it prints lot of symbols
> >> and rows to the terminal.
> >>
> >> With --command-name option, one could specify the specific command(s)
> >> for which the map has to be shown. This would help in analyzing the
> >> CPU usage patterns easier for that specific command(s). Since multiple
> >> PID's might have the same command name, using command-name filter
> >> would be more useful for debugging.
> >>
> >> Multiple command names can be given with a comma separator without
> >> whitespace.
> >>
> >> The --fuzzy-name option can be used if fuzzy name matching is required=
.
> >> For example, "taskname" can be matched to any string that contains
> >> "taskname" as its substring.
> >>
> >> For other tasks, instead of printing the symbol, ** is printed and
> >> the same . is used to represent idle. ** is used instead of symbol
> >> for other tasks because it helps in clear visualization of command(s)
> >> of interest and secondly the symbol itself doesn't mean anything
> >> because the sched-in of that symbol will not be printed(first sched-in
> >> contains pid and the corresponding symbol).
> >>
> >> 6.10.0-rc1
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>   *A0                   213864.670142 secs A0 =3D> migration/0:18
> >>   *.                    213864.670148 secs .  =3D> swapper:0
> >>    .  *B0               213864.670217 secs B0 =3D> migration/1:21
> >>    .  *.                213864.670223 secs
> >>    .   .  *C0           213864.670247 secs C0 =3D> migration/2:26
> >>    .   .  *.            213864.670252 secs
> >>
> >> 6.10.0-rc1 + patch (--command-name =3D schbench)
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>    **  .   ** *A0       213864.671055 secs A0 =3D> schbench:104834
> >>   *B0  .   .   A0       213864.671156 secs B0 =3D> schbench:104835
> >>   *C0  .   .   A0       213864.671187 secs C0 =3D> schbench:104836
> >
> > I still think some people are interested in sched-out time.  For
> > example, we don't know when B0 was scheduled out in the above.  There
> > could be other tasks between B0 and C0 on the CPU 0.
>
> Yes, you are right. When using the --command-name filter, there can be
> other tasks in between. This won't be a problem without the --command-nam=
e
> filtering, as no task will be missed, and we can be sure that the C0 sche=
d-in
> time is the B0 sched-out time.
>
> I will add the sched-out time when using the --command-name option in v3.
>
> >
> >
> >>   *D0  .   .   A0       213864.671219 secs D0 =3D> schbench:104837
> >>   *E0  .   .   A0       213864.671250 secs E0 =3D> schbench:104838
> >>    E0  .  *D0  A0
> >>
> >> This helps in visualizing how a benchmark like schbench is spread over
> >> the available cpus while also knowing which cpus are idle(.) and which
> >> are not(**). This will be more useful as number of CPUs increase.
> >>
> >> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> >> Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <ma=
ilto:atrajeev@linux.vnet.ibm.com>>
> >>
> >> ---
[SNIP]
> >> @@ -1605,7 +1625,8 @@ static int map_switch_event(struct perf_sched *s=
ched, struct evsel *evsel,
> >>                       */
> >>                      tr->shortname[0] =3D '.';
> >>                      tr->shortname[1] =3D ' ';
> >> -            } else {
> >> +            } else if (!sched->map.command || command_matches(thread_=
_comm_str(sched_in),
> >> +                                                    sched->map.comman=
d, sched->map.fuzzy)) {
> >
> > We usually align the indentation using the open parenthesis.
> > Maybe you can rename the function and pass the sched pointer directly
> > to reduce the argument.
>
> Sure, got it.
>
> >
> >   bool sched_match_task(struct perf_sched *sched, const char *comm_str)
> >   {
> >       ...
> >   }
> >
> > Or you could pass thread instead of comm_str and possibly support
> > matching with TID too.
>
> Do you want me to add another command line option to support matching
> with TID?

Maybe later.. if somebody wants. :)

Thanks,
Namhyung

>
> Thanks for all the suggestions. Will implement them and send v3.
>
> Thanks and Regards
> Madadi Vineeth Reddy
>
> >
> > Thanks,
> > Namhyung
> >
> >
> >>                      tr->shortname[0] =3D sched->next_shortname1;
> >>                      tr->shortname[1] =3D sched->next_shortname2;
> >>
> >> @@ -1618,10 +1639,19 @@ static int map_switch_event(struct perf_sched =
*sched, struct evsel *evsel,
> >>                              else
> >>                                      sched->next_shortname2 =3D '0';
> >>                      }
> >> +            } else {
> >> +                    tr->shortname[0] =3D '*';
> >> +                    tr->shortname[1] =3D '*';
> >>              }
> >>              new_shortname =3D 1;
> >>      }
> >>
> >> +    if (sched->map.command && !command_matches(thread__comm_str(sched=
_in), sched->map.command,
> >> +                                                                     =
       sched->map.fuzzy))
> >> +            goto skip;
> >> +
> >> +    printf("  ");
> >> +
> >>      for (i =3D 0; i < cpus_nr; i++) {
> >>              struct perf_cpu cpu =3D {
> >>                      .cpu =3D sched->map.comp ? sched->map.comp_cpus[i=
].cpu : i,
> >> @@ -1678,6 +1708,7 @@ static int map_switch_event(struct perf_sched *s=
ched, struct evsel *evsel,
> >>  out:
> >>      color_fprintf(stdout, color, "\n");
> >>
> >> +skip:
> >>      thread__put(sched_in);
> >>
> >>      return 0;
> >> @@ -3560,6 +3591,10 @@ int cmd_sched(int argc, const char **argv)
> >>                      "highlight given CPUs in map"),
> >>      OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
> >>                      "display given CPUs in map"),
> >> +    OPT_STRING(0, "command-name", &sched.map.command, "command",
> >> +            "map output only for the given command name(s)"),
> >> +    OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
> >> +            "given command name can be partially matched (fuzzy match=
ing)"),
> >>      OPT_PARENT(sched_options)
> >>      };
> >>      const struct option timehist_options[] =3D {
> >> --
> >> 2.31.1
> >>
>
