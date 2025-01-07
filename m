Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3031F2397
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282080; cv=none; b=nUSpg9C+26deY99EdHfcs8Rnrc+mW01JxTnTtj2cHcFJtUt8Igb73/KsXCF4VEpzmlQxmcuM3TFVqI6x9HINWX5IcEJzuEvKkdbbsnPgoE2NLFVa5cPeWuyli87xhF1i6X8H2K32y0gtpnwHh8GPAbMJbdkYWMzNZ5Mx5I5F7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282080; c=relaxed/simple;
	bh=v5KXoKCmLEgPWVhNDsmKrtd0mjwAQ31Xs85i3Yi0Jl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuxlP4EYz4sLvUHlhIZkN1/lmtomNeZY96+T1v7Z8fADK8grDqshHOMYjEkwqkoNdXHXLVTbS9x8CUT/W7oeFhy9jFiSJEcpfSslvntGHm0ROm0018aY7av+zvWlHSqiyCv3sRjbk8U0W9C1qM9raPEYU3il7+M+zIXYuZjVKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NL2wjuQp; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NL2wjuQp"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a814c54742so1465ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 12:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736282077; x=1736886877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or/GXsQduu+lAaQOs5ovRUaCLa/4KcRd7UcUDDXCPzM=;
        b=NL2wjuQpb/ia5JnpVhvGeYD1OTjRXP+zFRX1AgDbJafaGHPEGayu199KVt0aVZAlDM
         R3Wo4TeREN34eFrmX+D192d/Mr2v7JB/AzBH8JLNtchDwpw8f+ewwyjUo5Yjv7YrJOjN
         d0OGOkC/b0UWRuzzhgZyNhnoGKyQqKcDOfXOM/bWBsyRJ3ix5gZWTsL049kLyJuYOxCj
         4Y6VHRNq2LRFMJBqiLW3FdINYDIoLzU6gJdYOkxdkwBfri1nbRZurYf3Y1T2u8xXBDvD
         9XywYyXwTYUO96Sv77OOqG7ZLIi7B4Akdcy0OOVFE3GXHMf+ReD/aEwt3vS+I3qCahUm
         YYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282077; x=1736886877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or/GXsQduu+lAaQOs5ovRUaCLa/4KcRd7UcUDDXCPzM=;
        b=YKoyJ2ubfuio0/9H9OGqNLGWqfcgkpXvDlhuw9ND4sNXj1abcEn8v77M+92uUu2Pio
         dgKDfj3J0Yh4uPhIXkjeDrmhlyas2USTHmsTiy8UgETHJNgmnAzTF8rbff8NajAST3tn
         GC5n8pH4IbPliDBAHIuQThuKzrNUn1OySAfOUeOycHg5YkFtL/VYSZe+GqCh1ySMm7Ap
         YgDVHHR5hxBRzP+2ZQLodGBWYykkQy2RXxN3FtN5d6ua20tqjQGrmqb8it6k8btdwZ7b
         25nlaXCrMYOGTriUOYeUU1d/ZofoIeFt4Z21NBsP+EmW8KQKnzHppUXuJbJuR8CL4yFV
         3+gg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ceIqont8LMH3BSK230FAkQFPjwQ091DY33EHlT9m25jc5oIvcSRszcQn/xi1yO3Da4zEZpGfk6n3ck4zdsPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVm1qJncBvrDov6c/HrNGRh1404usYoXDlLJo9StggPIqu1R3
	+oAj0vWgvK2VYodUEgVEJLiWSfzRRMzgu1+fT0LnbKAKZNhwmbkSGA4FpZwR1/plkQEAC7aDiEz
	uaheZeN6hMwLjSb4myhu4pNeY/dhaGMdaCBa7
X-Gm-Gg: ASbGnctXKnJTzMNdrYfcBGqauBbcTZgFlQLOno6S+KQEManwy/lCLsU9xcr7FpP6/7q
	LYY62yU1CtYbv8aVwtK8fLWLRTIMC3fkR9AmNyeXX8SpKkA3xv0994t/XGq/WIIss99wjYg==
X-Google-Smtp-Source: AGHT+IFZ0iVTbuLT+g2M8APtutEjx4UdEShOMQdSvIjbhz89iPJ8F8kqniFTntZE1Hw2GgMAXhau7KKgJSw03wxcUkY=
X-Received: by 2002:a92:d450:0:b0:3a7:c997:f66b with SMTP id
 e9e14a558f8ab-3ce3b202844mr489185ab.19.1736282076588; Tue, 07 Jan 2025
 12:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107180854.770470-1-irogers@google.com> <20250107180854.770470-4-irogers@google.com>
 <Z32CeUuxt4ASJeRe@google.com>
In-Reply-To: <Z32CeUuxt4ASJeRe@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 12:34:25 -0800
X-Gm-Features: AbW1kvYmdbSV5W97iq4NxNedkJc9wcxsUlg4eY-hL40jdkGgiAQI2eyO1BY-ivk
Message-ID: <CAP-5=fUqbPX4RLSLzw1UJ9NycOh8r5o4TxLfu2RRxooPG0gUtA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:37=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Jan 07, 2025 at 10:08:53AM -0800, Ian Rogers wrote:
> > Whilst for many tools it is an expected behavior that failure to open
> > a perf event is a failure, ARM decided to name PMU events the same as
> > legacy events and then failed to rename such events on a server uncore
> > SLC PMU. As perf's default behavior when no PMU is specified is to
> > open the event on all PMUs that advertise/"have" the event, this
> > yielded failures when trying to make the priority of legacy and
> > sysfs/json events uniform - something requested by RISC-V and ARM. A
> > legacy event user on ARM hardware may find their event opened on an
> > uncore PMU which for perf record will fail. Arnaldo suggested skipping
> > such events which this patch implements. Rather than have the skipping
> > conditional on running on ARM, the skipping is done on all
> > architectures as such a fundamental behavioral difference could lead
> > to problems with tools built/depending on perf.
> >
> > An example of perf record failing to open events on x86 is:
> > ```
> > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' wh=
ich will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' wh=
ich will be removed.
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (data_read).
> > "dmesg | grep -i perf" may provide additional information.
> >
> > Error:
> > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be re=
moved.
> > The LLC-prefetch-read event is not supported.
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> >
> > $ perf report --stats
> > Aggregated stats:
> >                TOTAL events:      17255
> >                 MMAP events:        284  ( 1.6%)
> >                 COMM events:       1961  (11.4%)
> >                 EXIT events:          1  ( 0.0%)
> >                 FORK events:       1960  (11.4%)
> >               SAMPLE events:         87  ( 0.5%)
> >                MMAP2 events:      12836  (74.4%)
> >              KSYMBOL events:         83  ( 0.5%)
> >            BPF_EVENT events:         36  ( 0.2%)
> >       FINISHED_ROUND events:          2  ( 0.0%)
> >             ID_INDEX events:          1  ( 0.0%)
> >           THREAD_MAP events:          1  ( 0.0%)
> >              CPU_MAP events:          1  ( 0.0%)
> >            TIME_CONV events:          1  ( 0.0%)
> >        FINISHED_INIT events:          1  ( 0.0%)
> > cycles stats:
> >               SAMPLE events:         87
> > ```
> >
> > If all events fail to open then the perf record will fail:
> > ```
> > $ perf record -e LLC-prefetch-read true
> > Error:
> > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be re=
moved.
> > The LLC-prefetch-read event is not supported.
> > Error:
> > Failure to open any events for recording
> > ```
> >
> > This is done by detecting if dummy events were implicitly added by
> > perf and seeing if the evlist is empty without them. This allows the
> > dummy event still to be recorded:
> > ```
> > $ perf record -e dummy true
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > ```
> > but fail when inserted:
> > ```
> > $ perf record -e LLC-prefetch-read -a true
> > Error:
> > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be re=
moved.
> > The LLC-prefetch-read event is not supported.
> > Error:
> > Failure to open any events for recording
> > ```
> >
> > The issue with legacy events is that on RISC-V they want the driver to
> > not have mappings from legacy to non-legacy config encodings for each
> > vendor/model due to size, complexity and difficulty to update. It was
> > reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> > was broken and the sysfs/json events should always take precedent,
> > however, it isn't clear this is still the case. It is the case that
> > without working around this issue a legacy event like cycles without a
> > PMU can encode differently than when specified with a PMU - the
> > non-PMU version favoring legacy encodings, the PMU one avoiding legacy
> > encodings.
> >
> > The patch removes events and then adjusts the idx value for each
> > evsel. This is done so that the dense xyarrays used for file
> > descriptors, etc. don't contain broken entries. As event opening
> > happens relatively late in the record process, use of the idx value
> > before the open will have become corrupted, so it is expected there
> > are latent bugs hidden behind this change - the change is best
> > effort. As the only vendor that has broken event names is ARM, this
> > will principally effect ARM users. They will also experience warning
> > messages like those above because of the uncore PMU advertising legacy
> > event names.
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: James Clark <james.clark@linaro.org>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > Tested-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  tools/perf/builtin-record.c | 54 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 48 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 5db1aedf48df..b3f06638f3c6 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -161,6 +161,7 @@ struct record {
> >       struct evlist           *sb_evlist;
> >       pthread_t               thread_id;
> >       int                     realtime_prio;
> > +     int                     num_parsed_dummy_events;
> >       bool                    switch_output_event_set;
> >       bool                    no_buildid;
> >       bool                    no_buildid_set;
> > @@ -961,7 +962,6 @@ static int record__config_tracking_events(struct re=
cord *rec)
> >        */
> >       if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
> >           perf_pmus__num_core_pmus() > 1) {
> > -
> >               /*
> >                * User space tasks can migrate between CPUs, so when tra=
cing
> >                * selected CPUs, sideband for all CPUs is still needed.
> > @@ -1366,6 +1366,7 @@ static int record__open(struct record *rec)
> >       struct perf_session *session =3D rec->session;
> >       struct record_opts *opts =3D &rec->opts;
> >       int rc =3D 0;
> > +     bool skipped =3D false;
> >
> >       evlist__for_each_entry(evlist, pos) {
> >  try_again:
> > @@ -1381,15 +1382,50 @@ static int record__open(struct record *rec)
> >                               pos =3D evlist__reset_weak_group(evlist, =
pos, true);
> >                               goto try_again;
> >                       }
> > -                     rc =3D -errno;
> >                       evsel__open_strerror(pos, &opts->target, errno, m=
sg, sizeof(msg));
> > -                     ui__error("%s\n", msg);
> > -                     goto out;
> > +                     ui__error("Failure to open event '%s' on PMU '%s'=
 which will be removed.\n%s\n",
> > +                               evsel__name(pos), evsel__pmu_name(pos),=
 msg);
> > +                     pos->skippable =3D true;
> > +                     skipped =3D true;
> > +             } else {
> > +                     pos->supported =3D true;
> >               }
> > -
> > -             pos->supported =3D true;
> >       }
> >
> > +     if (skipped) {
> > +             struct evsel *tmp;
> > +             int idx =3D 0, num_dummy =3D 0, num_non_dummy =3D 0,
> > +                 removed_dummy =3D 0, removed_non_dummy =3D 0;
> > +
> > +             /* Remove evsels that failed to open and update indices. =
*/
> > +             evlist__for_each_entry_safe(evlist, tmp, pos) {
> > +                     if (evsel__is_dummy_event(pos))
> > +                             num_dummy++;
> > +                     else
> > +                             num_non_dummy++;
> > +
> > +                     if (!pos->skippable)
> > +                             continue;
> > +
> > +                     if (evsel__is_dummy_event(pos))
> > +                             removed_dummy++;
> > +                     else
> > +                             removed_non_dummy++;
> > +
> > +                     evlist__remove(evlist, pos);
> > +             }
> > +             evlist__for_each_entry(evlist, pos) {
> > +                     pos->core.idx =3D idx++;
> > +             }
> > +             /* If list is empty except implicitly added dummy events =
then fail. */
> > +             if ((num_non_dummy =3D=3D removed_non_dummy) &&
> > +                 ((rec->num_parsed_dummy_events =3D=3D 0) ||
> > +                  (removed_dummy >=3D (num_dummy - rec->num_parsed_dum=
my_events)))) {
> > +                     ui__error("Failure to open any events for recordi=
ng.\n");
> > +                     rc =3D -1;
> > +                     goto out;
> > +             }
> > +     }
>
> Instead of couting dummy events, I wonder if it could check any
> supported non-dummy events in the evlist.
>
>         if (skipped) {
>                 bool found =3D false;
>
>                 evlist__for_each_entry_safe(evlist, tmp, pos) {
>                         if (pos->skippable) {
>                                 evlist__remove(evlist, pos);
>                                 continue;
>                         }
>                         if (evsel__is_dummy_event(pos))
>                                 continue;
>                         found =3D true;
>                 }
>                 if (!found) {
>                         ui__error("...");
>                         rc =3D -1;
>                         goto out;
>                 }
>                 /* recalculate the index */
>         }
>
> Then it should do the same, no?  The corner case would be when users
> specify dummy events in the command line (maybe to check permissions
> by the exit code).
>
>   $ perf record -a -e dummy true
>
> If it fails to open, then 'skipped' set and 'found' not set so the
> command will fail.  It it succeeds, then it doesn't set 'skipped'
> and the command will exit with 0.
>
> Do I miss something?

Yep, but it depends on what we want the behavior to be. Consider an
event that doesn't support record and the dummy event which for the
sake of argument will open here:

$ perf record -a -e LLC-prefetch-read,dummy true

In this case initially found is false, we then process
LLC-prefetch-read which didn't open and remove it from the evlist.
Next we process the dummy event that did open but because it was a
dummy event found won't be set to true. The code will then proceed to
fail (found =3D=3D false) even though the dummy event did open. Were this
cycles and not dummy:

$ perf record -a -e LLC-prefetch-read,cycles true

Then the expectation would be for this to proceed with a warning on
LLC-prefetch-read and to record cycles. With your code dummy will
behave differently to cycles as it will terminate perf record early.
Does this matter? I'm not sure, but I was trying to make the events
(dummy vs non-dummy) consistent.

Thanks,
Ian
