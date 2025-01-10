Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4F18C03A
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544852; cv=none; b=L3flxLbVqKYco0FuYPFWif8ZBE9EXQm3xCpga3I+xkoXNhuqNO5TyZRtskddQgcxq2sTdNWNP7qZZnmrkZo3Ir4eUiECxzTgQR13UvAVuGKX2sWbAfdLCddh23ZhBJ/Ocgzw7oIu7VojJ104r/FondVVbnDv9e9NFUONtf5t8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544852; c=relaxed/simple;
	bh=kC4gyxH+ZXbhvEedwkM8kXKfQzZrluE1oflnj21g2b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhYGLhd4aBnjfOm+eBH8ShDaXjT8Pb6OzIgC5J3C8mGXS2TDqRBgN/oKzOItQmtHv9Rhi3gfehOSUDb/pwSUyDGiTUERfaNj4x7CkF2RR6QlzjuYNN2FYykWqRk59nVTFHP/qm8k4Zylc/aq5OBLfJalT3kT8tS7R8c0Kp0WVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dd2PSHKn; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dd2PSHKn"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso27665ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736544850; x=1737149650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+v8LB3q0TBinGdL8dPxVNIRGzIG3TlXZoCpIPgbLUI=;
        b=dd2PSHKnRQ4OT3RTsBUQeYXAQvST91eGc7DGidHjtQxDBSttz/V4+u3fRi7anN2quu
         d59SRjy/LUXFPlPEJKpFN1fT2YJch4l53OHAxUDcwK6Vg6F7bKrfONGeStHnn63Ri8dB
         hp73kQJyVoSQthaRrmVezLdyg7P4E7Fc0QdltZeTcg+7CFXbgsok0NfbxwXABDAbc7kJ
         qx4hVwYUrijdbOV60PXCGGMy2BsK73Go+/6fGpx+cbmLfKVvsbUxPVdpZUnnU3pO0E2U
         YWflYQQiB1+saiBkM4IdZHOXyEdKI79RH94O6qPhKp/jpHCnC0nmZfhFWbfY+RnFXFWB
         EDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736544850; x=1737149650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+v8LB3q0TBinGdL8dPxVNIRGzIG3TlXZoCpIPgbLUI=;
        b=dQJliKkA4VnMPen/NWeuEVU1kCBiEpc54YAhff37JMdxmLIsWq3W11ORJTzn+tkSv2
         apXEPdYLvG7ESRJU9ae+ZVlBIz1TbKtDSq0fSSjRsotT6+xcPaQ+RuEBPR2eG99Ss4XL
         NrRmDmULazYEnYdzwmPwqoEIf2ZSj8BPx3B1oRSnOyoKZffHp2GZVtxYrbapUJY0gJrp
         N9Xbnzkkazrm/vjX7JWa0LOt3yIedfRsKfm4L+x3vwMHAnsiLq6FqL02CGT5vh0WqrM3
         G1Z8QcAZoYatti8sBu+tF8LLjw3pM/FeI9UY5P2FbKPKUbSZFEQoQQSY4zCZrJEBOwAY
         Dlbw==
X-Forwarded-Encrypted: i=1; AJvYcCXATXhrdmlASPvz6ZxvltfRagP+VMfciUOioZRmaMVHUobZiBucYYvmG71Z/9EgohRpntQnBbOZN65e3kHk+tse@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxrKE6uFAPrg5m0NTpe5IBgStZOW8/Wm+LIHTjPgZS+dgKdzA
	tpU9LUOXuocOne/bFeQTDum1Adrc0U86jsTh1FyIB08ZBnD5aY+kxbyz8KUR0W1uHTsJys9PG1Q
	KyXw5nnYfwfQ4i/TRGSOJEFpFdkGzpbVMqKcm
X-Gm-Gg: ASbGncuvJDTG9MneyQsH1lYF3iAJWenF2UDg0s6G4yv3iSIWEo9HM5LDr6ZV9eTXOcu
	RUgtwP7riIO0rvr1HCccIgn0o7A0FoT4KPgIK33857UKFY2PSiqLtIDBdticm3pT0t5uC4A==
X-Google-Smtp-Source: AGHT+IG//DUq5s+gUf2ep4pqOLIEXo2WXdn8W+8+ptXPQM/Iu5GMK+WM7ZBtmeCmxWTTg37xlIpFrWaNhWcmcQU2dwU=
X-Received: by 2002:a05:6e02:138b:b0:3ce:35c8:bdf3 with SMTP id
 e9e14a558f8ab-3ce56c223ebmr4098925ab.2.1736544849780; Fri, 10 Jan 2025
 13:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-4-irogers@google.com>
 <Z4B279zu_8Kz5N6u@google.com> <Z4EsUAtOKZUzcw2S@x1> <CAP-5=fV2cYjxf6jvYcKkd=2wcQrbR=58qafiSJ-qzE17EmWqGQ@mail.gmail.com>
 <Z4F0bKnCHCaqdvFw@google.com>
In-Reply-To: <Z4F0bKnCHCaqdvFw@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 Jan 2025 13:33:57 -0800
X-Gm-Features: AbW1kvbJI16RBvNLBcmGgkSr1EcdbYaHPdAP3ROXzM9WfcKZzSN34U8MXifgt5c
Message-ID: <CAP-5=fVn=0n=gN6ngMmBTry3A+US3z=bX5SzVP6Zs0J0t2HLuA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf record: Skip don't fail for events that don't open
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

On Fri, Jan 10, 2025 at 11:26=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Jan 10, 2025 at 08:42:02AM -0800, Ian Rogers wrote:
> > On Fri, Jan 10, 2025 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Adding Linus to the CC list as he participated in this discussion in =
the
> > > past, so a heads up about changes in this area that are being further
> > > discussed.
> >
> > Linus blocks my email so I'm not sure of the point.
>
> That's unfortunate, but he should be able to see others' reply.
>
> >
> > > On Thu, Jan 09, 2025 at 05:25:03PM -0800, Namhyung Kim wrote:
> > > > On Thu, Jan 09, 2025 at 02:21:08PM -0800, Ian Rogers wrote:
> > > > > Whilst for many tools it is an expected behavior that failure to =
open
> > > > > a perf event is a failure, ARM decided to name PMU events the sam=
e as
> > > > > legacy events and then failed to rename such events on a server u=
ncore
> > > > > SLC PMU. As perf's default behavior when no PMU is specified is t=
o
> > > > > open the event on all PMUs that advertise/"have" the event, this
> > > > > yielded failures when trying to make the priority of legacy and
> > > > > sysfs/json events uniform - something requested by RISC-V and ARM=
. A
> > > > > legacy event user on ARM hardware may find their event opened on =
an
> > > > > uncore PMU which for perf record will fail. Arnaldo suggested ski=
pping
> > > > > such events which this patch implements. Rather than have the ski=
pping
> > > > > conditional on running on ARM, the skipping is done on all
> > > > > architectures as such a fundamental behavioral difference could l=
ead
> > > > > to problems with tools built/depending on perf.
> > > > >
> > > > > An example of perf record failing to open events on x86 is:
> > > > > ```
> > > > > $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> > > > > Error:
> > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running=
_0' which will be removed.
> > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argum=
ent) for event (data_read).
> > > > > "dmesg | grep -i perf" may provide additional information.
> > > > >
> > > > > Error:
> > > > > Failure to open event 'data_read' on PMU 'uncore_imc_free_running=
_1' which will be removed.
> > > > > The sys_perf_event_open() syscall returned with 22 (Invalid argum=
ent) for event (data_read).
> > > > > "dmesg | grep -i perf" may provide additional information.
> > > > >
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will=
 be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples)=
 ]
> > > >
> > > > I'm afraid this can be too noisy.
> > >
> > > Agreed.
> > >
> > > > > $ perf report --stats
> > > > > Aggregated stats:
> > > > >                TOTAL events:      17255
> > > > >                 MMAP events:        284  ( 1.6%)
> > > > >                 COMM events:       1961  (11.4%)
> > > > >                 EXIT events:          1  ( 0.0%)
> > > > >                 FORK events:       1960  (11.4%)
> > > > >               SAMPLE events:         87  ( 0.5%)
> > > > >                MMAP2 events:      12836  (74.4%)
> > > > >              KSYMBOL events:         83  ( 0.5%)
> > > > >            BPF_EVENT events:         36  ( 0.2%)
> > > > >       FINISHED_ROUND events:          2  ( 0.0%)
> > > > >             ID_INDEX events:          1  ( 0.0%)
> > > > >           THREAD_MAP events:          1  ( 0.0%)
> > > > >              CPU_MAP events:          1  ( 0.0%)
> > > > >            TIME_CONV events:          1  ( 0.0%)
> > > > >        FINISHED_INIT events:          1  ( 0.0%)
> > > > > cycles stats:
> > > > >               SAMPLE events:         87
> > > > > ```
> > > > >
> > > > > If all events fail to open then the perf record will fail:
> > > > > ```
> > > > > $ perf record -e LLC-prefetch-read true
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will=
 be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > Error:
> > > > > Failure to open any events for recording
> > > > > ```
> > > > >
> > > > > As an evlist may have dummy events that open when all command lin=
e
> > > > > events fail we ignore dummy events when detecting if at least som=
e
> > > > > events open. This still permits the dummy event on its own to be =
used
> > > > > as a permission check:
> > > > > ```
> > > > > $ perf record -e dummy true
> > > > > [ perf record: Woken up 1 times to write data ]
> > > > > [ perf record: Captured and wrote 0.046 MB perf.data ]
> > > > > ```
> > > > > but allows failure when a dummy event is implicilty inserted or w=
hen
> > > > > there are insufficient permissions to open it:
> > > > > ```
> > > > > $ perf record -e LLC-prefetch-read -a true
> > > > > Error:
> > > > > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will=
 be removed.
> > > > > The LLC-prefetch-read event is not supported.
> > > > > Error:
> > > > > Failure to open any events for recording
> > > > > ```
> > > > >
> > > > > The issue with legacy events is that on RISC-V they want the driv=
er to
> > > > > not have mappings from legacy to non-legacy config encodings for =
each
> > > > > vendor/model due to size, complexity and difficulty to update. It=
 was
> > > > > reported that on ARM Apple-M? CPUs the legacy mapping in the driv=
er
> > > > > was broken and the sysfs/json events should always take precedent=
,
> > > > > however, it isn't clear this is still the case. It is the case th=
at
> > > > > without working around this issue a legacy event like cycles with=
out a
> > > > > PMU can encode differently than when specified with a PMU - the
> > > > > non-PMU version favoring legacy encodings, the PMU one avoiding l=
egacy
> > > > > encodings.
> > > > >
> > > > > The patch removes events and then adjusts the idx value for each
> > > > > evsel. This is done so that the dense xyarrays used for file
> > > > > descriptors, etc. don't contain broken entries. As event opening
> > > > > happens relatively late in the record process, use of the idx val=
ue
> > > > > before the open will have become corrupted, so it is expected the=
re
> > > > > are latent bugs hidden behind this change - the change is best
> > > > > effort. As the only vendor that has broken event names is ARM, th=
is
> > > > > will principally effect ARM users. They will also experience warn=
ing
> > > > > messages like those above because of the uncore PMU advertising l=
egacy
> > > > > event names.
> > > > >
> > > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > Tested-by: James Clark <james.clark@linaro.org>
> > > > > Tested-by: Leo Yan <leo.yan@arm.com>
> > > > > Tested-by: Atish Patra <atishp@rivosinc.com>
> > > > > ---
> > > > >  tools/perf/builtin-record.c | 47 +++++++++++++++++++++++++++++++=
+-----
> > > > >  1 file changed, 41 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-rec=
ord.c
> > > > > index 5db1aedf48df..c0b8249a3787 100644
> > > > > --- a/tools/perf/builtin-record.c
> > > > > +++ b/tools/perf/builtin-record.c
> > > > > @@ -961,7 +961,6 @@ static int record__config_tracking_events(str=
uct record *rec)
> > > > >      */
> > > > >     if (opts->target.initial_delay || target__has_cpu(&opts->targ=
et) ||
> > > > >         perf_pmus__num_core_pmus() > 1) {
> > > > > -
> > > > >             /*
> > > > >              * User space tasks can migrate between CPUs, so when=
 tracing
> > > > >              * selected CPUs, sideband for all CPUs is still need=
ed.
> > > > > @@ -1366,6 +1365,7 @@ static int record__open(struct record *rec)
> > > > >     struct perf_session *session =3D rec->session;
> > > > >     struct record_opts *opts =3D &rec->opts;
> > > > >     int rc =3D 0;
> > > > > +   bool skipped =3D false;
> > > > >
> > > > >     evlist__for_each_entry(evlist, pos) {
> > > > >  try_again:
> > > > > @@ -1381,15 +1381,50 @@ static int record__open(struct record *re=
c)
> > > > >                             pos =3D evlist__reset_weak_group(evli=
st, pos, true);
> > > > >                             goto try_again;
> > > > >                     }
> > > > > -                   rc =3D -errno;
> > > > >                     evsel__open_strerror(pos, &opts->target, errn=
o, msg, sizeof(msg));
> > > > > -                   ui__error("%s\n", msg);
> > > > > -                   goto out;
> > > > > +                   ui__error("Failure to open event '%s' on PMU =
'%s' which will be removed.\n%s\n",
> > > > > +                             evsel__name(pos), evsel__pmu_name(p=
os), msg);
> > >
> > > > How about changing it to pr_debug() and add below ...
> > >
> > > That sounds better.
> > >
> > > > > +                   pos->skippable =3D true;
> > > > > +                   skipped =3D true;
> > > > > +           } else {
> > > > > +                   pos->supported =3D true;
> > > > >             }
> > > > > -
> > > > > -           pos->supported =3D true;
> > > > >     }
> > > > >
> > > > > +   if (skipped) {
> > > > > +           struct evsel *tmp;
> > > > > +           int idx =3D 0;
> > > > > +           bool evlist_empty =3D true;
> > > > > +
> > > > > +           /* Remove evsels that failed to open and update indic=
es. */
> > > > > +           evlist__for_each_entry_safe(evlist, tmp, pos) {
> > > > > +                   if (pos->skippable) {
> > > > > +                           evlist__remove(evlist, pos);
> > > > > +                           continue;
> > > > > +                   }
> > > > > +
> > > > > +                   /*
> > > > > +                    * Note, dummy events may be command line par=
sed or
> > > > > +                    * added by the tool. We care about supportin=
g `perf
> > > > > +                    * record -e dummy` which may be used as a pe=
rmission
> > > > > +                    * check. Dummy events that are added to the =
command
> > > > > +                    * line and opened along with other events th=
at fail,
> > > > > +                    * will still fail as if the dummy events wer=
e tool
> > > > > +                    * added events for the sake of code simplici=
ty.
> > > > > +                    */
> > > > > +                   if (!evsel__is_dummy_event(pos))
> > > > > +                           evlist_empty =3D false;
> > > > > +           }
> > > > > +           evlist__for_each_entry(evlist, pos) {
> > > > > +                   pos->core.idx =3D idx++;
> > > > > +           }
> > > > > +           /* If list is empty then fail. */
> > > > > +           if (evlist_empty) {
> > > > > +                   ui__error("Failure to open any events for rec=
ording.\n");
> > > > > +                   rc =3D -1;
> > > > > +                   goto out;
> > > > > +           }
> > >
> > > > ... ?
> > >
> > > >               if (!verbose)
> > > >                       ui__warning("Removed some unsupported events,=
 use -v for details.\n");
> > >
> > > And even this one would be best left for cases where we can determine
> > > that its a new situation, i.e. one that should work and not the ones =
we
> > > know that will not work already and thus so far didn't alarm the user
> > > into thinking something is wrong.
> > >
> > > Having the ones we know will fail as pr_debug() seems enough, I'd say=
.
> >
> > This means that:
> > ```
> > $ perf record -e data_read,LLC-prefetch-read -a sleep 0.1
> > ```
> > will fail (as data_read is a memory controller event and the LLC
> > doesn't support sampling) with something like:
> > ```
> > Error:
> > Failure to open any events for recording
> > ```
> > Which feels a bit minimal. As I already mentioned, it is also a
> > behavior change and so has the potential to break scripts dependent on
> > the failure information.
>
> I don't think it's about failure behavior, the concern is the error
> messages.  It can take too much screen space when users give a long list
> of invalid events.  And unfortunately the current error message for
> checking dmesg is not very helpful.

Making the dmesg message more useful is a separate issue. The error
message only happens when things are broken and I think having an
error message is better than none, or somehow having to know to wade
through verbose output. I think this is very clear in:
https://lore.kernel.org/lkml/CAP-5=3DfVr43v8gkqi8SXVaNKnkO+cooQVqx3xUFJ-Btg=
xGHX90g@mail.gmail.com/

> Anyway you can add this line too: "Use -v to see the details."

So silently failing and then expecting users to scrape verbose output
is a fairly significant behavior change for the tool.

> >
> > A patch lowering the priority of error messages should be independent
> > of the 4 changes here. I'd be happy if someone follows this series
> > with a patch doing it.
>
> I think the error behavior is a part of this change.

I disagree with it, so I think you need to address my comments.

Thanks,
Ian
