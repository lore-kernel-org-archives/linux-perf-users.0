Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7419ABC4
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344419; cv=none; b=g4is584XFSRlStEj6CUvQcxGSfHHso2ofIgDOrocBAfJqGZu1rm+Vv9VulllBoJI/0bnlBfmUqlXYSUbXSV0+vwCAY10ToywQmsYa5g3B3fsQFZ3VRgD/FCi8u9wGNybpuKQn+vgl8pRYZSGc31+T26dhW2TyHxXXZ6UrEEPu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344419; c=relaxed/simple;
	bh=bZcUsHX/XX/Y9UgZZpuD7GCkcs/O5U0Dwbsl8aOhuE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDLGnKhkvosBsbOhe2KsZOMWiZxwbKRJj6lcEOpFtauYfMr9aDj5Iub7y+QmHk2Bc6ULYHDy32XNLN3s3jIYe2sprra2Yn/JKLoGnRPzjrdEzSUwsO66cP5HleMomr7IkgILjdW0QNdhlA5o2oSgnz8uTxmD88LHHoTFhGoKKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdB1KZqD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdB1KZqD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8ac50b79so293695ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731344416; x=1731949216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHH2LHa3vPHSGvaLtOvoUyE3JuhsGkvRwuZLTaOZxw0=;
        b=cdB1KZqDSYwGbgvITWVXu19Ok2e2md7xkgUJz1VlSshm07xD56h6PwwJQAEHAFh1z0
         r2geBiQY+nS13hxgqI7oOExA07x7ZNi2M2V8VhjFAdjiqxNvQyg3BaQ8qM909BWfqt62
         R6GjYl0U5OBTdwsifvOC5RUn2meaqXyFxAAAzMONp9QDg+UZeJO3co/JjmSpGs4j0+mq
         QC01A1VUbP2CojwZBNqEHxJeI9PVNMK9g2VMe8Bt9h6NxfgD68UcYpQjCpsTkhdsvBVq
         mCv3lx9qR6JMRDtfQI6CTq3DKDvF14IAWlWyKhr2YsoU0/b4kKR3LlzEB9F8xHp7P/Rm
         ouDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731344416; x=1731949216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHH2LHa3vPHSGvaLtOvoUyE3JuhsGkvRwuZLTaOZxw0=;
        b=Dy4Kx+YfczI5Bi2b/vdJr/dppF2J1jCItjb2HdGilQFD95JyL2tgiVpsdZ89VtvmKR
         ocMXLVFclQ6CozYgfOQ+yYzBZy8zshu6fxIhW9CVzaMx6Nv0nw+Fwp2SHhVeXCjJbUvi
         zfw98iscRLreuN7QXKradtxAr7evdQvPL1NbKydD9woB/KWXmfKwHMOVI+p20isP/ai/
         1Bg2hbAzxBqhuElSrKf3Td4gYSAIEDAOQgmgsOEcoRNYmQU8BVUIWfy0X35fBcP+9NSl
         Gl/2o4Hj+wSY2e9Dq+s68yzykMZIMbcFon7WFd4wsLuWVCBLFuO6lMbP5yjU+VK/5RmY
         Zqtg==
X-Forwarded-Encrypted: i=1; AJvYcCXZr7lpHJz9mR257A5jZIygUZ9d1OY53eWekplfRsNAbV3AUY1YA5aOGvUmW+PYvez/3OyjCBVba/kFKInEybQF@vger.kernel.org
X-Gm-Message-State: AOJu0YxtraAvL8CgTVXa9f+aGDuJ5runRKNFduQ+SNT8A5sKcTDEzKmg
	Waa781UcrNCa1eU4amB1G1ZnwHBoy1B6DEE3guFP4HntA8ti0Q9yJDGeTNJVlg0ph+4PawqTZtb
	Fw8GxQfBaLgXgJOUWbpdShJ4GyC01CQU9Xth4
X-Gm-Gg: ASbGnctganIsF/xrsQNyTeTfB36REwb0HW2kJW1+ql3dC1BS5T96guIgQcTMGjfXSWz
	p1BpiPUwpIF0xuES8+58zwrkcKy7xOWSqFOGNs+i/d5mC2M4uWyuAL3rikvionuY=
X-Google-Smtp-Source: AGHT+IEgdO4RDbRkIKjrQdG/JhToxdKmloY06eIr8CvJ09W1TALe6pY/R3RBCiwi2J0ANnu652M9+mQ8+Xchzjj7fEQ=
X-Received: by 2002:a17:903:2446:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-211901961a0mr3353115ad.15.1731344416139; Mon, 11 Nov 2024
 09:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <20241026121758.143259-4-irogers@google.com>
 <7c1a0bbf-12fd-46ef-9db2-183dfa70a334@linaro.org>
In-Reply-To: <7c1a0bbf-12fd-46ef-9db2-183dfa70a334@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:00:04 -0800
Message-ID: <CAP-5=fVODgnWgfCpA7x3B8JFQhkt_unUeTjhWWdSDpKECdTSYg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf record: Skip don't fail for events that don't open
To: James Clark <james.clark@linaro.org>
Cc: Atish Patra <atishp@rivosinc.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:49=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 26/10/2024 1:17 pm, Ian Rogers wrote:
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
>
> This makes me wonder if this message was overly wordy to begin with.
> This line is fine:
>
>   Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
>   which will be removed.
>
> The next bit about the syscall just repeats. The exit code could be
> included on the previous line. And the dmesg bit is general advice that
> could possibly be printed once at the end.

Thanks for the time spent investigating this!

I agree on this. I wonder if we should have short and long messages,
or message+help like we do for parse events. One patch series like
this is improving EBUSY:
https://lore.kernel.org/lkml/20241106003007.2112584-1-ctshao@google.com/
The issue with printing at the end is knowing where/when the end is.
Printing once is easy enough.

> > Error:
> > Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be re=
moved.
> > The LLC-prefetch-read event is not supported.
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> >
> > $ perf report --stats
> > Aggregated stats:
> >                 TOTAL events:      17255
> >                  MMAP events:        284  ( 1.6%)
> >                  COMM events:       1961  (11.4%)
> >                  EXIT events:          1  ( 0.0%)
> >                  FORK events:       1960  (11.4%)
> >                SAMPLE events:         87  ( 0.5%)
> >                 MMAP2 events:      12836  (74.4%)
> >               KSYMBOL events:         83  ( 0.5%)
> >             BPF_EVENT events:         36  ( 0.2%)
> >        FINISHED_ROUND events:          2  ( 0.0%)
> >              ID_INDEX events:          1  ( 0.0%)
> >            THREAD_MAP events:          1  ( 0.0%)
> >               CPU_MAP events:          1  ( 0.0%)
> >             TIME_CONV events:          1  ( 0.0%)
> >         FINISHED_INIT events:          1  ( 0.0%)
> > cycles stats:
> >                SAMPLE events:         87
> > ```
> >
> > Note, if all events fail to open then the data file will contain no
> > samples. This is deliberate as at the point the events are opened
> > there are other events, such as the dummy event for sideband data, and
> > these events will succeed in opening even if the user specified ones
>
> Is a file with only sideband events useful? Is it possible to fail the
> record command if the event doesn't open anywhere?
>
> I noticed this leads to some different behavior and a libperf warning
> when you have paranoid=3D3:
>
>    $ perf record -e cycles -C 0 -- true
>
>    Error:
>    Failure to open event 'cpu_atom/cycles/u' on PMU 'cpu_atom' which will
>    be removed.
>    ...
>    Consider adjusting /proc/sys/kernel/perf_event_paranoid setting
>    ...
>    libperf: Miscounted nr_mmaps 0 vs 28
>    WARNING: No sample_id_all support, falling back to unordered
>    processing
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.021 MB perf.data ]

So paranoid=3D3 is a Debian extension that Peter Z doesn't agree with
and so isn't enabled in regular kernels. So we're dealing with cycles,
which we'd expect to open or fall-back to a software event like
task-clock. It feels like things could happen better here but that's
not necessarily the fault of this patch.

> > don't. Having a mix of open and broken events leads to a problem of
> > identifying different sources of events.
>  >
>
> In my basic test I saw that the opened event was identified correctly in
> perf report, unless you have an example that you encountered that we
> should fix?

I didn't find any but we also don't tend to test failing to open
events. I could imagine things failing in `perf test` on neoverse
testing given the l3 advertising the cycles event.

> One place I saw an issue was with auxtrace events. If there's an event
> name clash then you're likely to not be able to open the file afterwards
> because the auxtrace code can't handle an event that didn't open. But I
> don't know of any name clashes there (I just faked one for testing), and
> maybe that could be fixed up later in the auxtrace code if there is ever
> a real one.
>
> Other than the above it does seem to work ok.

Cool, can this be taken as a Tested-by?

Thanks,
Ian

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
>
>
>
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/builtin-record.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index f83252472921..7e99743f7e42 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1364,6 +1364,7 @@ static int record__open(struct record *rec)
> >       struct perf_session *session =3D rec->session;
> >       struct record_opts *opts =3D &rec->opts;
> >       int rc =3D 0;
> > +     bool skipped =3D false;
> >
> >       evlist__for_each_entry(evlist, pos) {
> >   try_again:
> > @@ -1379,15 +1380,26 @@ static int record__open(struct record *rec)
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
> > +             int idx =3D 0;
> > +
> > +             evlist__for_each_entry_safe(evlist, tmp, pos) {
> > +                     if (pos->skippable)
> > +                             evlist__remove(evlist, pos);
> > +                     pos->core.idx =3D idx++;
> > +             }
> > +     }
> >       if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist))=
 {
> >               pr_warning(
> >   "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restrict=
ed,\n"
>
