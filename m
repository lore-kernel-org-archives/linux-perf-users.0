Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95A204010
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428730; cv=none; b=I4mA09uAeAALC9lDT/a7+ALalJJJf7igRUuU0qLVxUJ6zKE7LhniYq6W6C0iEiZdzA9w7nOn5z5MIv1XM/MvIgQiVTr1Do732emQSrSE80FScKY73QBiA/O6JxlFPhqzdZMSYQ6iLOyeBbYPTESE8831oSnFW00IaPwwDOTQdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428730; c=relaxed/simple;
	bh=Lj1dVaKfn6KZuwukxE9bf+f2fDaYl29WXxrlgmaLzAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u57VSGzt9Npvqvm8cdv/gPeC77cJxwc9bQLllPHvJi30+4tU6khLhdJ4MGCZfpCW/MeMcK77S2SRIpSHJ9XQjyOmS+vEo4mJJ0YjmBfrQdMMGkAOGjLOE9WarC57g12h31bLHLJSpCzZQsLFWgy8V6Uzm30bne5/uheeQ7X+Kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwKpaH8h; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwKpaH8h"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso161725ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731428725; x=1732033525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mID2YwIdPOcSk2daOdRZYR567nuf/vDV1Q8uNLvDSaA=;
        b=qwKpaH8hFrFHVTow2+6mvs3SsklgH7oW0xsIPukiRC8plk5ScJEXHXdfKkZJwbt4fW
         XNc+VYc5ahRI2pl95Xhn1v9YG8Q9XvSrgk5WMjBBry99DvUk6ExnbOAt+amjJGLPiWIZ
         xX/VRkELRyd2yQ0xIWnQH0UPTTPGV4BV4NJfjdWcb5qe1gKltz/84dqGHnXcM0yQ8FR5
         yOh3gD8j7cEMcFZPRUTTBDxlDw+wJZSXgZdtMFjM1DBkHBZsQd1Tk58zmgRw1ZKQlPLJ
         eynL7l6KQSKs1odU6V9TWY6jHGNJUm6hkvnmQB/n92hi4EMZCKs+rb5acX/CraKJtT+C
         UsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428725; x=1732033525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mID2YwIdPOcSk2daOdRZYR567nuf/vDV1Q8uNLvDSaA=;
        b=mOOzV53N9z3HJPkP2kf5JbxloA+IbeujFYma71OFNarpA9PTtuYR9jf+mTdwrdeY/O
         yw/2QCuU+GOkCq2f/qP0pTPwouFvCHmg8r4jxBsc9JByKnY1BFBtwS6SNq+4oxkFFiUA
         CDaYYFfg6T+u9iCaMHjXP2YFLbMeGyZx/K+EoaihWtgtSeg3Exg6hAfNvahVJiXHVnmO
         zEKHVgmxwtuV/s62tXKiyzeK7gZVYazjcC7mEbVzwYEx5lkEp7umRrxIG2XctoRx90sy
         AxCEmgazj5llK1NP0GO2fYzigln+3o/8rwsua6L0jMBfz0tWr2n87RW272ZQc1OgWwwK
         I0IA==
X-Forwarded-Encrypted: i=1; AJvYcCXcgo3OHoeMoIBnHDbpWkA4i7f/3Twi4+7aAp/llH4n4PClkud4JElcL2sJiR0sVaifDtaGdkU5cxParePJ85MP@vger.kernel.org
X-Gm-Message-State: AOJu0YzogH1NxUhVdE6JfGfeFWqhZWN4iaKN3Epvi/QjsNOmwZLam+Te
	lBiWyYznEPZcKpYMDZJLVUMYWuV4kXbTXjmTzjIn+o5UIuoNkckqBQXk6Vdiv1rfSuoMg27MqH5
	Q9RFWuN6rdIbCoMlB9LG9/HEPB/jmLt3+ZE16
X-Gm-Gg: ASbGncu9NgoDk+dgbSOy6ih8ACf4bn2cUSFgUyVMgqrRpa3ERcyaKo0y4BPHJUbFEYA
	MH+Vzs6HeIOFYU1nEyncBbz6TstEiWgBgCubQn74QDZ8n5ZQdPFqhc/K/MpnROb8=
X-Google-Smtp-Source: AGHT+IHMpjvOztjJUP2l+AlVCb7Kck2R81RLm/U+9sk1WbODBAVa+E9VpMnbTO65o9P1PoDSOKaRh4amWsgWjLBp8ww=
X-Received: by 2002:a05:6e02:1ca9:b0:3a6:f1e9:46c6 with SMTP id
 e9e14a558f8ab-3a70de18957mr2524775ab.27.1731428724875; Tue, 12 Nov 2024
 08:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com> <20241026121758.143259-4-irogers@google.com>
 <7c1a0bbf-12fd-46ef-9db2-183dfa70a334@linaro.org> <CAP-5=fVODgnWgfCpA7x3B8JFQhkt_unUeTjhWWdSDpKECdTSYg@mail.gmail.com>
 <9bfdc5a0-ed1d-40f6-8a72-6129e1587ca7@linaro.org>
In-Reply-To: <9bfdc5a0-ed1d-40f6-8a72-6129e1587ca7@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Nov 2024 08:25:13 -0800
Message-ID: <CAP-5=fXB_GHd8x-c8Q4Y+5=G=YJJBJ+Q7hT6_rGFEzmi7q8nsA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf record: Skip don't fail for events that don't open
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:12=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 11/11/2024 5:00 pm, Ian Rogers wrote:
> > On Mon, Nov 11, 2024 at 7:49=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >>
> >>
> >> On 26/10/2024 1:17 pm, Ian Rogers wrote:
> >>> Whilst for many tools it is an expected behavior that failure to open
> >>> a perf event is a failure, ARM decided to name PMU events the same as
> >>> legacy events and then failed to rename such events on a server uncor=
e
> >>> SLC PMU. As perf's default behavior when no PMU is specified is to
> >>> open the event on all PMUs that advertise/"have" the event, this
> >>> yielded failures when trying to make the priority of legacy and
> >>> sysfs/json events uniform - something requested by RISC-V and ARM. A
> >>> legacy event user on ARM hardware may find their event opened on an
> >>> uncore PMU which for perf record will fail. Arnaldo suggested skippin=
g
> >>> such events which this patch implements. Rather than have the skippin=
g
> >>> conditional on running on ARM, the skipping is done on all
> >>> architectures as such a fundamental behavioral difference could lead
> >>> to problems with tools built/depending on perf.
> >>>
> >>> An example of perf record failing to open events on x86 is:
> >>> ```
> >>> $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> >>> Error:
> >>> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' =
which will be removed.
> >>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)=
 for event (data_read).
> >>> "dmesg | grep -i perf" may provide additional information.
> >>>
> >>> Error:
> >>> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' =
which will be removed.
> >>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)=
 for event (data_read).
> >>> "dmesg | grep -i perf" may provide additional information.
> >>>
> >>
> >> This makes me wonder if this message was overly wordy to begin with.
> >> This line is fine:
> >>
> >>    Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0=
'
> >>    which will be removed.
> >>
> >> The next bit about the syscall just repeats. The exit code could be
> >> included on the previous line. And the dmesg bit is general advice tha=
t
> >> could possibly be printed once at the end.
> >
> > Thanks for the time spent investigating this!
> >
> > I agree on this. I wonder if we should have short and long messages,
> > or message+help like we do for parse events. One patch series like
> > this is improving EBUSY:
> > https://lore.kernel.org/lkml/20241106003007.2112584-1-ctshao@google.com=
/
> > The issue with printing at the end is knowing where/when the end is.
> > Printing once is easy enough.
> >
> >>> Error:
> >>> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be =
removed.
> >>> The LLC-prefetch-read event is not supported.
> >>> [ perf record: Woken up 1 times to write data ]
> >>> [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> >>>
> >>> $ perf report --stats
> >>> Aggregated stats:
> >>>                  TOTAL events:      17255
> >>>                   MMAP events:        284  ( 1.6%)
> >>>                   COMM events:       1961  (11.4%)
> >>>                   EXIT events:          1  ( 0.0%)
> >>>                   FORK events:       1960  (11.4%)
> >>>                 SAMPLE events:         87  ( 0.5%)
> >>>                  MMAP2 events:      12836  (74.4%)
> >>>                KSYMBOL events:         83  ( 0.5%)
> >>>              BPF_EVENT events:         36  ( 0.2%)
> >>>         FINISHED_ROUND events:          2  ( 0.0%)
> >>>               ID_INDEX events:          1  ( 0.0%)
> >>>             THREAD_MAP events:          1  ( 0.0%)
> >>>                CPU_MAP events:          1  ( 0.0%)
> >>>              TIME_CONV events:          1  ( 0.0%)
> >>>          FINISHED_INIT events:          1  ( 0.0%)
> >>> cycles stats:
> >>>                 SAMPLE events:         87
> >>> ```
> >>>
> >>> Note, if all events fail to open then the data file will contain no
> >>> samples. This is deliberate as at the point the events are opened
> >>> there are other events, such as the dummy event for sideband data, an=
d
> >>> these events will succeed in opening even if the user specified ones
> >>
> >> Is a file with only sideband events useful? Is it possible to fail the
> >> record command if the event doesn't open anywhere?
> >>
> >> I noticed this leads to some different behavior and a libperf warning
> >> when you have paranoid=3D3:
> >>
> >>     $ perf record -e cycles -C 0 -- true
> >>
> >>     Error:
> >>     Failure to open event 'cpu_atom/cycles/u' on PMU 'cpu_atom' which =
will
> >>     be removed.
> >>     ...
> >>     Consider adjusting /proc/sys/kernel/perf_event_paranoid setting
> >>     ...
> >>     libperf: Miscounted nr_mmaps 0 vs 28
> >>     WARNING: No sample_id_all support, falling back to unordered
> >>     processing
> >>     [ perf record: Woken up 1 times to write data ]
> >>     [ perf record: Captured and wrote 0.021 MB perf.data ]
> >
> > So paranoid=3D3 is a Debian extension that Peter Z doesn't agree with
> > and so isn't enabled in regular kernels. So we're dealing with cycles,
> > which we'd expect to open or fall-back to a software event like
> > task-clock. It feels like things could happen better here but that's
> > not necessarily the fault of this patch.
> >
>
> paranoid=3D3 is a bit of a red-herring. I actually meant any paranoid
> value other than -1. The important part is "-C 0" because only root is
> allowed to open on a CPU. Or "-a" also causes the issue.
>
> Previously you got the command failure and the hint about the paranoid
> value, but now you get the libperf error too and it still makes the file.
>
> I still don't think a file with only sideband events is useful, I don't
> think there's even a commandline that you can run currently that results
> in that? You always need at least one event to open for it to succeed
> and I'm thinking we could keep that.

You can currently do `perf record -e dummy ...` for example in this
ARM SPE test (I see similar in offcpu, attr test, intel_pt, switch
tracking):
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/test_arm_spe.sh?h=3Dperf-tools-next#n94
If we add a condition that an evlist with only sideband events is
erroneous, and fail perf record, then I think that will break these
expectations. Any change like that would at least need to fix up the
tests, but the tests could be a good indicator that users are also
doing things like this and that may lead to complaints.

> It would be nice to fix the libperf warning too because it's warning
> about something that was already warned about.

Do you have something in mind to clean up the warning? Perhaps you can
send it as a patch.

> >>> don't. Having a mix of open and broken events leads to a problem of
> >>> identifying different sources of events.
> >>   >
> >>
> >> In my basic test I saw that the opened event was identified correctly =
in
> >> perf report, unless you have an example that you encountered that we
> >> should fix?
> >
> > I didn't find any but we also don't tend to test failing to open
> > events. I could imagine things failing in `perf test` on neoverse
> > testing given the l3 advertising the cycles event.
> >
> >> One place I saw an issue was with auxtrace events. If there's an event
> >> name clash then you're likely to not be able to open the file afterwar=
ds
> >> because the auxtrace code can't handle an event that didn't open. But =
I
> >> don't know of any name clashes there (I just faked one for testing), a=
nd
> >> maybe that could be fixed up later in the auxtrace code if there is ev=
er
> >> a real one.
> >>
> >> Other than the above it does seem to work ok.
> >
> > Cool, can this be taken as a Tested-by?
> >
>
> Yep, although with a caveat that I faked the second cycles PMU that
> wouldn't open, but I don't think that should make a difference:
>
> Tested-by: James Clark <james.clark@linaro.org>

Thanks James, as this patch is before reapplying the "Prefer
sysfs/JSON hardware events over legacy" patch, can I take it that the
tag is for the whole series?

> I can also test with the real thing if you like but would take a bit
> longer as I have to borrow it off Leo.

More testing is always good.

Thanks,
Ian

> > Thanks,
> > Ian
> >
> >>> The issue with legacy events is that on RISC-V they want the driver t=
o
> >>> not have mappings from legacy to non-legacy config encodings for each
> >>> vendor/model due to size, complexity and difficulty to update. It was
> >>> reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> >>> was broken and the sysfs/json events should always take precedent,
> >>> however, it isn't clear this is still the case. It is the case that
> >>> without working around this issue a legacy event like cycles without =
a
> >>> PMU can encode differently than when specified with a PMU - the
> >>> non-PMU version favoring legacy encodings, the PMU one avoiding legac=
y
> >>> encodings.
> >>>
> >>> The patch removes events and then adjusts the idx value for each
> >>> evsel. This is done so that the dense xyarrays used for file
> >>> descriptors, etc. don't contain broken entries. As event opening
> >>> happens relatively late in the record process, use of the idx value
> >>> before the open will have become corrupted, so it is expected there
> >>> are latent bugs hidden behind this change - the change is best
> >>> effort. As the only vendor that has broken event names is ARM, this
> >>> will principally effect ARM users. They will also experience warning
> >>> messages like those above because of the uncore PMU advertising legac=
y
> >>> event names.
> >>
> >>
> >>
> >>>
> >>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>    tools/perf/builtin-record.c | 22 +++++++++++++++++-----
> >>>    1 file changed, 17 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
> >>> index f83252472921..7e99743f7e42 100644
> >>> --- a/tools/perf/builtin-record.c
> >>> +++ b/tools/perf/builtin-record.c
> >>> @@ -1364,6 +1364,7 @@ static int record__open(struct record *rec)
> >>>        struct perf_session *session =3D rec->session;
> >>>        struct record_opts *opts =3D &rec->opts;
> >>>        int rc =3D 0;
> >>> +     bool skipped =3D false;
> >>>
> >>>        evlist__for_each_entry(evlist, pos) {
> >>>    try_again:
> >>> @@ -1379,15 +1380,26 @@ static int record__open(struct record *rec)
> >>>                                pos =3D evlist__reset_weak_group(evlis=
t, pos, true);
> >>>                                goto try_again;
> >>>                        }
> >>> -                     rc =3D -errno;
> >>>                        evsel__open_strerror(pos, &opts->target, errno=
, msg, sizeof(msg));
> >>> -                     ui__error("%s\n", msg);
> >>> -                     goto out;
> >>> +                     ui__error("Failure to open event '%s' on PMU '%=
s' which will be removed.\n%s\n",
> >>> +                               evsel__name(pos), evsel__pmu_name(pos=
), msg);
> >>> +                     pos->skippable =3D true;
> >>> +                     skipped =3D true;
> >>> +             } else {
> >>> +                     pos->supported =3D true;
> >>>                }
> >>> -
> >>> -             pos->supported =3D true;
> >>>        }
> >>>
> >>> +     if (skipped) {
> >>> +             struct evsel *tmp;
> >>> +             int idx =3D 0;
> >>> +
> >>> +             evlist__for_each_entry_safe(evlist, tmp, pos) {
> >>> +                     if (pos->skippable)
> >>> +                             evlist__remove(evlist, pos);
> >>> +                     pos->core.idx =3D idx++;
> >>> +             }
> >>> +     }
> >>>        if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlis=
t)) {
> >>>                pr_warning(
> >>>    "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restr=
icted,\n"
> >>
>
