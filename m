Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6971A2C07
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882835; cv=none; b=k43Zr/8OKvcijnlZ9OhxOc7BQPRGN53ECUt6+snqY8Tow3ubXgBSaTYD3ikuj7KPYW9A5naCP2Ocvx8c0m+xv5PWLfVuktgJBhU9P/wNg/q0J7RSKbWFaPpbeKeBGXh3/SwjCXmnX80LuV0PM5LBHMCEbykbrV9PGtCuhLLr160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882835; c=relaxed/simple;
	bh=p3btCliuGbFoPyn4MlwMtBuYC9eMpo29z3epODjNimA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojlpLFOLwI+wt3VLOoxElvZJFwZ0v0A+RqO4fSaAY1JORwqUxhid77ApBN+JOCSspIZMkvdrXiR2OE8F8O116eY+62MlFlfwvnpY0gGWteJG7+T0v8SUvFCjqsHkN4qWVIkAXzKQXoteko5XdvjaPjSQz+CyeaHwNBwyxi8KbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwyW9AWo; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwyW9AWo"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36db330403fso16125ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715882833; x=1716487633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAGK7yA54g8ipBy9BdHl6jJNUHHA/ZpQTM1QlwyODEo=;
        b=bwyW9AWoFo+wXPV+YCYXmVDyqwddWaP2V054cUz7uEKicoHIABb/D4t8bpT5A1x+f1
         UDTLT5gKxdBg6Y6M6EIcOyYqs5gq0FzKZAI9AaStD/VEslzqF5P3F241e8E2gDrz9P5f
         bnA/Jms0WDxxWAwSTaTwOrUFJSnR9vmTVkMNgg6J15PzMNGp3PRGzz6UMOLciR+VESdY
         X37DxGw/pRGNwBaXYXNlaS50UKrcyeXAJVCWDh29zktZgqh8RZ9/VDRbCpdAJEvmC3qi
         EjfhF3HZYBuJfeHRMBSIXrhDvBQKdDhThXc1gmkljShVq/tH6BLkpC8Uk+SnLO4LfCCO
         U0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715882833; x=1716487633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAGK7yA54g8ipBy9BdHl6jJNUHHA/ZpQTM1QlwyODEo=;
        b=mEP5+RjzusJ+vv3Uwznqymw6S+W7CBie7PJnYQ2K1IplfhWw5bAh+ySu5aum5WKvRm
         IoTdtfMm8pa1F/4usBrx8ETScEHnBFvJqlky8/8FkmnMhw8NpAx2w0S1R815vQP45idC
         spm7Uymf7tfMy27aiFPzcK5pXlk9f8cQOHSw+Q6ar6XICRddvnnEp+SFUG17blz2U2Da
         NNDMpxQIuc4WtcwmBPjIbwUJo3J3FD1DyWYFcLxB7m+/HSAcMTtBIIcnJMwtOSclVWbL
         NUxatH+tpXuunKUI58ZelXXMFCWpH6CiODeYVphEpyhl+OOJc4NlZWoqsf7DbQ02ypAJ
         NlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhM+V8Kq4iSvfzgJrryBfJS1xNkA8+JAHYs/o3UIWTBmamwPROW6Amt3XTuHIsUQcZ1qgYwh6A60oxee624/09NuoUks8uIp5OMrYCEsFmHA==
X-Gm-Message-State: AOJu0YxLizoImakLKbRaCUscF65wT8pLDaKU8DMAjZ8/z28hRv20DzNN
	C1KCd509d2KIQ6GhhFQavnA/f7gtM/km8NMYtiTTxB6J9FJHfw7ebNpHCW3V49KHaBou1nggR4A
	XIxldpJ2AhIu2eSChlw2/z1+8f15F0ojw8m0i
X-Google-Smtp-Source: AGHT+IF2QdOTXuArxkNauWXw2qXICMs8nNtm0GI8CrCri/ISJDmGiemocfBxu0Syxg89dbBnvk28ieJYhNMpQc3/pPw=
X-Received: by 2002:a92:c6d2:0:b0:36c:c9b7:9189 with SMTP id
 e9e14a558f8ab-36dc6c375e3mr147045ab.24.1715882832781; Thu, 16 May 2024
 11:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-4-weilin.wang@intel.com> <CAP-5=fWB+rSTaXfTkB9BkWYOt-m2UHcocj6Hkz5B-P0C0WEL2w@mail.gmail.com>
 <CO6PR11MB563581A21BACF954B1BF69E3EEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563581A21BACF954B1BF69E3EEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 11:07:01 -0700
Message-ID: <CAP-5=fUNqiVH1kqAx2e7pbCRQauMZWbPi0jLBtg8sGMGt4KFhA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
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

On Thu, May 16, 2024 at 10:38=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Thursday, May 16, 2024 9:43 AM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>; Arnaldo Carvalho de Melo
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
> > Subject: Re: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record =
when
> > perf stat needs to get retire latency value for a metric.
> >
> > On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > When retire_latency value is used in a metric formula, perf stat woul=
d fork a
> > > perf record process with "-e" and "-W" options. Perf record will coll=
ect
> > > required retire_latency values in parallel while perf stat is collect=
ing
> > > counting values.
> > >
> > > At the point of time that perf stat stops counting, it would send sig=
term
> > signal
> > > to perf record process and receiving sampling data back from perf rec=
ord
> > from a
> > > pipe. Perf stat will then process the received data to get retire lat=
ency data
> > > and calculate metric result.
> > >
> > > Another thread is required to synchronize between perf stat and perf =
record
> > > when we pass data through pipe.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > So I don't think this is the correct way to add this. My reviewed-by
> > was based on the fact that I was going to refactor this after landing.
> > It didn't land and I already sent out:
> > "Retirement latency perf stat support"
> > https://lore.kernel.org/lkml/20240428053616.1125891-1-
> > irogers@google.com/
> > v3 to just land the tool portion:
> > https://lore.kernel.org/lkml/20240503232849.17752-1-
> > irogers@google.com/
> > So my reviewed-by no longer stands. The changes I've sent out haven't
> > been reviewed. Given you're trying to land this, can we work on
> > reviewing those changes? The v3 was specifically done just so that we
> > can have the cleaner basis for adding tpebs to the evsel.
> >
>
> Sorry about carrying the reviewed-by in wrong places. I will remove them.
>
> > Let me point to specific issues below:
> >
> > > ---
> > >  tools/perf/builtin-stat.c     |  19 +++
> > >  tools/perf/util/Build         |   1 +
> > >  tools/perf/util/intel-tpebs.c | 285
> > ++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/intel-tpebs.h |  29 ++++
> > >  tools/perf/util/stat.h        |   3 +
> > >  5 files changed, 337 insertions(+)
> > >  create mode 100644 tools/perf/util/intel-tpebs.c
> > >  create mode 100644 tools/perf/util/intel-tpebs.h
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 428e9721b908..85927cf45adb 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -70,6 +70,7 @@
> > >  #include "util/bpf_counter.h"
> > >  #include "util/iostat.h"
> > >  #include "util/util.h"
> > > +#include "util/intel-tpebs.h"
> > >  #include "asm/bug.h"
> > >
> > >  #include <linux/time64.h>
> > > @@ -94,6 +95,7 @@
> > >  #include <perf/evlist.h>
> > >  #include <internal/threadmap.h>
> > >
> > > +
> > >  #define DEFAULT_SEPARATOR      " "
> > >  #define FREEZE_ON_SMI_PATH     "devices/cpu/freeze_on_smi"
> > >
> > > @@ -162,6 +164,8 @@ static struct perf_stat_config stat_config =3D {
> > >         .ctl_fd                 =3D -1,
> > >         .ctl_fd_ack             =3D -1,
> > >         .iostat_run             =3D false,
> > > +       .tpebs_results          =3D LIST_HEAD_INIT(stat_config.tpebs_=
results),
> > > +       .tpebs_pid              =3D -1,
> >
> > Here we're adding state to the stat_config for the sake of tpebs
> > events. Were the state in the evsel, as in my changes, we'd not need
> > to carry new global state for tpebs.
>
> Yes, I should remove the .tpebs_results out. How about .tpebs_pid?
> It is used in builtin-stat later.
>
> >
> > >  };
> > >
> > >  static void evlist__check_cpu_maps(struct evlist *evlist)
> > > @@ -653,6 +657,8 @@ static enum counter_recovery
> > stat_handle_error(struct evsel *counter)
> > >
> > >         if (child_pid !=3D -1)
> > >                 kill(child_pid, SIGTERM);
> > > +       if (stat_config.tpebs_pid !=3D -1)
> > > +               stop_tpebs();
> >
> > This logic is builtin-stat but what about other commands that could be
> > using TPEBS for counters?
>
> Could you please let me know the commands that could use it?
> I was thinking we could do this logic in evsel once the per core per even=
t fork
> get updated. I think that would work for all the commands.

Using this code refactored into evsels is what I'd like to see, so I
think we're agreed. I'm not thinking of a main command reading
counters. The evlist and evsel are exposed through python so
potentially any script could use the values, which is why it'd be best
to abstract them behind an evsel.

> >
> > >         return COUNTER_FATAL;
> > >  }
> > >
> > > @@ -673,6 +679,10 @@ static int __run_perf_stat(int argc, const char
> > **argv, int run_idx)
> > >         int err;
> > >         bool second_pass =3D false;
> > >
> > > +       err =3D start_tpebs(&stat_config, evsel_list);
> > > +       if (err < 0)
> > > +               return err;
> > > +
> > >         if (forks) {
> > >                 if (evlist__prepare_workload(evsel_list, &target, arg=
v, is_pipe,
> > workload_exec_failed_signal) < 0) {
> > >                         perror("failed to prepare workload");
> > > @@ -878,6 +888,10 @@ static int __run_perf_stat(int argc, const char
> > **argv, int run_idx)
> > >
> > >         t1 =3D rdclock();
> > >
> > > +       err =3D stop_tpebs();
> > > +       if (err < 0)
> > > +               return err;
> > > +
> > >         if (stat_config.walltime_run_table)
> > >                 stat_config.walltime_run[run_idx] =3D t1 - t0;
> > >
> > > @@ -985,6 +999,9 @@ static void sig_atexit(void)
> > >         if (child_pid !=3D -1)
> > >                 kill(child_pid, SIGTERM);
> > >
> > > +       if (stat_config.tpebs_pid !=3D -1)
> > > +               kill(stat_config.tpebs_pid, SIGTERM);
> > > +
> > >         sigprocmask(SIG_SETMASK, &oset, NULL);
> > >
> > >         if (signr =3D=3D -1)
> > > @@ -2918,5 +2935,7 @@ int cmd_stat(int argc, const char **argv)
> > >         metricgroup__rblist_exit(&stat_config.metric_events);
> > >         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_=
ack,
> > &stat_config.ctl_fd_close);
> > >
> > > +       tpebs_data__delete();
> > > +
> > >         return status;
> > >  }
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 292170a99ab6..c9f1d0bb6bf8 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -153,6 +153,7 @@ perf-y +=3D clockid.o
> > >  perf-y +=3D list_sort.o
> > >  perf-y +=3D mutex.o
> > >  perf-y +=3D sharded_mutex.o
> > > +perf-y +=3D intel-tpebs.o
> > >
> > >  perf-$(CONFIG_LIBBPF) +=3D bpf_map.o
> > >  perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
> > > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tp=
ebs.c
> > > new file mode 100644
> > > index 000000000000..4b7a98794fae
> > > --- /dev/null
> > > +++ b/tools/perf/util/intel-tpebs.c
> > > @@ -0,0 +1,285 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * intel_pt.c: Intel Processor Trace support
> > > + * Copyright (c) 2013-2015, Intel Corporation.
> > > + */
> > > +
> > > +
> > > +#include <sys/param.h>
> > > +#include <subcmd/run-command.h>
> > > +#include <thread.h>
> > > +#include "intel-tpebs.h"
> > > +#include <linux/list.h>
> > > +#include <linux/zalloc.h>
> > > +#include <linux/err.h>
> > > +#include "sample.h"
> > > +#include "debug.h"
> > > +#include "evlist.h"
> > > +#include "evsel.h"
> > > +#include "session.h"
> > > +#include "tool.h"
> > > +#include "metricgroup.h"
> > > +#include <sys/stat.h>
> > > +#include <sys/file.h>
> > > +
> > > +
> > > +
> > > +#define PERF_DATA              "-"
> > > +#define CONTROL                        "/tmp/control"
> > > +#define ACK                    "/tmp/ack"
> > > +pthread_t reader_thread;
> > > +struct child_process *cmd;
> > > +struct perf_stat_config *stat_config;
> > > +
> > > +static int get_perf_record_args(const char **record_argv)
> > > +{
> > > +       int i =3D 0;
> > > +       struct tpebs_retire_lat *e;
> > > +
> > > +       pr_debug("Prepare perf record for retire_latency\n");
> > > +
> > > +       record_argv[i++] =3D "perf";
> > > +       record_argv[i++] =3D "record";
> > > +       record_argv[i++] =3D "-W";
> > > +       record_argv[i++] =3D "--synth=3Dno";
> >
> > There should be more things to disable, like BPF events, we don't need
> > the dummy, etc.
>
> Ok, I will add that.

Well this is my comment that we shouldn't be beefing up "perf record"
for retirement latencies, it'd be better to avoid the fork altogether.
Adding "--no-bpf-event" is simple.

> >
> > > +       record_argv[i++] =3D "--control=3Dfifo:/tmp/control,/tmp/ack"=
;
> > > +
> > > +       if (stat_config->user_requested_cpu_list) {
> > > +               record_argv[i++] =3D "-C";
> > > +               record_argv[i++] =3D stat_config->user_requested_cpu_=
list;
> > > +       }
> > > +
> > > +       if (stat_config->system_wide)
> > > +               record_argv[i++] =3D "-a";
> > > +
> > > +       if (!stat_config->system_wide && !stat_config-
> > >user_requested_cpu_list) {
> > > +               pr_err("Require -a or -C option to run sampling.\n");
> > > +               return -ECANCELED;
> > > +       }
> > > +
> > > +       list_for_each_entry(e, &stat_config->tpebs_results, nd) {
> > > +               record_argv[i++] =3D "-e";
> > > +               record_argv[i++] =3D e->name;
> > > +       }
> > > +
> > > +       record_argv[i++] =3D "-o";
> > > +       record_argv[i++] =3D PERF_DATA;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int prepare_run_command(const char **argv)
> > > +{
> > > +       cmd =3D zalloc(sizeof(struct child_process));
> > > +       if (!cmd)
> > > +               return -ENOMEM;
> > > +       cmd->argv =3D argv;
> > > +       cmd->out =3D -1;
> > > +       return 0;
> > > +}
> > > +
> > > +static int prepare_perf_record(int tpebs_event_size)
> > > +{
> > > +       const char **record_argv;
> > > +       int ret;
> > > +
> > > +       /*Create control and ack fd for --control*/
> > > +       if (mkfifo(CONTROL, 0600)) {
> > > +               pr_err("Failed to create control fifo");
> > > +               return -1;
> > > +       }
> > > +       if (mkfifo(ACK, 0600)) {
> > > +               pr_err("Failed to create control fifo");
> > > +               return -1;
> > > +       }
> > > +
> > > +       record_argv =3D calloc(10 + 2 * tpebs_event_size, sizeof(char=
 *));
> > > +       if (!record_argv)
> > > +               return -ENOMEM;
> > > +
> > > +
> > > +       ret =3D get_perf_record_args(record_argv);
> > > +       if (ret)
> > > +               goto out;
> > > +
> > > +       ret =3D prepare_run_command(record_argv);
> > > +       if (ret)
> > > +               goto out;
> > > +       ret =3D start_command(cmd);
> > > +out:
> > > +       free(record_argv);
> > > +       return ret;
> > > +}
> > > +struct sample_data_reader {
> > > +       struct perf_tool        tool;
> > > +       struct perf_session     *session;
> > > +};
> > > +
> > > +static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> > > +{
> > > +       zfree(&r->name);
> > > +       zfree(&r->tpebs_name);
> > > +       free(r);
> > > +}
> > > +
> > > +void tpebs_data__delete(void)
> > > +{
> > > +       struct tpebs_retire_lat *r, *rtmp;
> > > +
> > > +       list_for_each_entry_safe(r, rtmp, &stat_config->tpebs_results=
, nd) {
> > > +               list_del_init(&r->nd);
> > > +               tpebs_retire_lat__delete(r);
> > > +       }
> > > +       free(cmd);
> > > +}
> > > +
> > > +static int process_sample_event(struct perf_tool *tool __maybe_unuse=
d,
> > > +                               union perf_event *event __maybe_unuse=
d,
> > > +                               struct perf_sample *sample,
> > > +                               struct evsel *evsel,
> > > +                               struct machine *machine __maybe_unuse=
d)
> > > +{
> > > +       int ret =3D 0;
> > > +       const char *evname;
> > > +       struct tpebs_retire_lat *t;
> > > +
> > > +       evname =3D evsel__name(evsel);
> > > +
> > > +       /*
> > > +        * Need to handle per core results? We are assuming average r=
etire
> > > +        * latency value will be used. Save the number of samples and=
 the sum
> > of
> > > +        * retire latency value for each event.
> > > +        */
> > > +       list_for_each_entry(t, &stat_config->tpebs_results, nd) {
> > > +               if (!strcmp(evname, t->name)) {
> > > +                       t->count +=3D 1;
> > > +                       t->sum +=3D sample->retire_lat;
> > > +                       t->val =3D (double) t->sum / t->count;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int process_feature_event(struct perf_session *session,
> > > +                                union perf_event *event)
> > > +{
> > > +       if (event->feat.feat_id < HEADER_LAST_FEATURE)
> > > +               return perf_event__process_feature(session, event);
> > > +       return 0;
> > > +}
> > > +
> > > +static void *__sample_reader(void *arg)
> > > +{
> > > +       struct child_process *child =3D arg;
> > > +       struct perf_session *session;
> > > +       struct perf_data data =3D {
> > > +               .mode =3D PERF_DATA_MODE_READ,
> > > +               .path =3D PERF_DATA,
> > > +               .file.fd =3D child->out,
> > > +       };
> > > +       struct sample_data_reader reader =3D {
> > > +               .tool =3D {
> > > +               .sample          =3D process_sample_event,
> > > +               .feature         =3D process_feature_event,
> > > +               .attr            =3D perf_event__process_attr,
> > > +               },
> > > +       };
> >
> > I prefer the reading approach here over what I did here:
> > https://lore.kernel.org/lkml/CAM9d7cgzTsfk3C+dTN80f5FhB1rmfturjuUUwv
> > STeUvny5eWKw@mail.gmail.com/
> > I'd done that as Namhyung had commented on using perf report:
> > https://lore.kernel.org/lkml/CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69
> > +rD06RAnu9-EQ@mail.gmail.com/
> > It was also less work. I don't see why we can't move the reading logic
> > into a function like evsel__read_retire_latency that's in my change. I
> > also think that in the first instance all reading logic should be
> > implemented to return 0 and we only do the forking, etc. when a
> > command line flag is passed.
>
> Yes, a command line flag to turn it on is a good idea. Andi also suggeste=
d this.
> I want to add this option in next version.
>
> I tried to refactor the code so that you could easily reuse it later. You=
 could either
> put this code directly into evsel__read_retire_latency or call this funct=
ion,
> whichever way you feel better.

Could you add that into the series rather than leaving it as work for me?

> >
> > > +
> > > +       session =3D perf_session__new(&data, &reader.tool);
> > > +       if (IS_ERR(session))
> > > +               return NULL;
> > > +       reader.session =3D session;
> > > +       perf_session__process_events(session);
> > > +       perf_session__delete(session);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +
> > > +int start_tpebs(struct perf_stat_config *perf_stat_config, struct ev=
list
> > *evsel_list)
> > > +{
> > > +       int ret =3D 0;
> > > +       struct evsel *evsel;
> > > +       int control =3D -1, ack =3D -1;
> > > +
> > > +       stat_config =3D perf_stat_config;
> > > +       /*
> > > +        * Prepare perf record for sampling event retire_latency befo=
re fork and
> > > +        * prepare workload
> > > +        */
> > > +       evlist__for_each_entry(evsel_list, evsel) {
> > > +               if (evsel->retire_lat) {
> > > +                       struct tpebs_retire_lat *new =3D malloc(sizeo=
f(struct
> > tpebs_retire_lat));
> > > +                       int i;
> > > +                       char *name;
> > > +
> > > +                       pr_debug("perf stat retire latency %s require=
d\n", evsel-
> > >name);
> > > +                       if (!new)
> > > +                               return -1;
> > > +                       for (i =3D strlen(evsel->name) - 1; i > 0; i-=
-) {
> > > +                               if (evsel->name[i] =3D=3D 'R')
> > > +                                       break;
> > > +                       }
> > > +                       if (i <=3D 0 || evsel->name[i] !=3D 'R')
> > > +                               return -1;
> > > +
> > > +                       name =3D strdup(evsel->name);
> > > +                       if (!name)
> > > +                               return -ENOMEM;
> > > +                       name[i] =3D 'p';
> > > +                       new->name =3D strdup(name);
> > > +                       free(name);
> > > +                       new->tpebs_name =3D strdup(evsel->name);
> > > +                       if (!new->tpebs_name)
> > > +                               return -ENOMEM;
> > > +                       new->count =3D 0;
> > > +                       new->sum =3D 0;
> > > +                       list_add_tail(&new->nd, &stat_config->tpebs_r=
esults);
> > > +                       stat_config->tpebs_event_size +=3D 1;
> > > +               }
> > > +       }
> > > +
> > > +       if (stat_config->tpebs_event_size > 0) {
> > > +               ret =3D prepare_perf_record(stat_config->tpebs_event_=
size);
> > > +               if (ret)
> > > +                       return ret;
> > > +               if (pthread_create(&reader_thread, NULL, __sample_rea=
der, cmd)) {
> > > +                       kill(cmd->pid, SIGTERM);
> > > +                       close(cmd->out);
> > > +                       pr_err("Could not create thread to process sa=
mple data.\n");
> > > +                       return -1;
> > > +               }
> > > +               /* Wait for perf record initialization a little bit.*=
/
> > > +               control =3D open(CONTROL, O_RDONLY, O_NONBLOCK);
> > > +               if (!control)
> > > +                       return -1;
> > > +               close(control);
> > > +               ack =3D open(ACK, O_RDONLY, O_NONBLOCK);
> > > +               if (!ack)
> > > +                       return -1;
> > > +               close(ack);
> > > +               pr_debug("Received ack from perf record\n");
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +
> > > +int stop_tpebs(void)
> > > +{
> > > +       int ret =3D 0;
> > > +
> > > +       if (stat_config->tpebs_event_size > 0) {
> > > +               kill(cmd->pid, SIGTERM);
> > > +               pthread_join(reader_thread, NULL);
> > > +               close(cmd->out);
> > > +               ret =3D finish_command(cmd);
> > > +               if (ret =3D=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> > > +                       ret =3D 0;
> > > +               remove(CONTROL);
> > > +               remove(ACK);
> > > +       }
> > > +       return ret;
> > > +}
> > > diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tp=
ebs.h
> > > new file mode 100644
> > > index 000000000000..e8e2bb2f479b
> > > --- /dev/null
> > > +++ b/tools/perf/util/intel-tpebs.h
> > > @@ -0,0 +1,29 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * intel_pt.h: Intel Processor Trace support
> > > + * Copyright (c) 2013-2015, Intel Corporation.
> > > + */
> > > +#include "stat.h"
> > > +
> > > +#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
> > > +#define INCLUDE__PERF_INTEL_TPEBS_H__
> > > +
> > > +struct tpebs_retire_lat {
> > > +       struct list_head nd;
> > > +       /* Event name */
> > > +       const char *name;
> > > +       /* Event name with the TPEBS modifier R */
> > > +       const char *tpebs_name;
> > > +       /* Count of retire_latency values found in sample data */
> > > +       size_t count;
> > > +       /* Sum of all the retire_latency values in sample data */
> > > +       int sum;
> > > +       /* Average of retire_latency, val =3D sum / count */
> > > +       double val;
> > > +};
> >
> > An evsel has a pretty much all of this and so we're duplicating in
> > particular the counting logic which then needs later work to integrate
> > and is why I'd prefer we went the evsel route.
>
> I wanted to reuse evsel as much as I could. But as you know, I had some i=
ssue
> to use it and had to remove the code. I'm going to explore more and see i=
f I could
> get it work with evsel better.

Ok, it was never clear to me what the issue was.

> Comparing with last version, do you think this change is toward the direc=
t that you
> Want? I believe we could get this code to use evsel more.

I think with the evsels and the record/reading logic here things will
be in a good place.  There will be more work to do to have the
retirement latency respect options like the cgroups, perhaps the BPF
filters are an option there.
https://lore.kernel.org/lkml/20240516041948.3546553-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> Weilin
>
> >
> > Thanks,
> > Ian
> >
> > > +
> > > +int start_tpebs(struct perf_stat_config *perf_stat_config, struct ev=
list
> > *evsel_list);
> > > +int stop_tpebs(void);
> > > +void tpebs_data__delete(void);
> > > +
> > > +#endif
> > > diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> > > index fd7a187551bd..c6c2aa43030f 100644
> > > --- a/tools/perf/util/stat.h
> > > +++ b/tools/perf/util/stat.h
> > > @@ -110,6 +110,9 @@ struct perf_stat_config {
> > >         struct cpu_aggr_map     *cpus_aggr_map;
> > >         u64                     *walltime_run;
> > >         struct rblist            metric_events;
> > > +       size_t                   tpebs_event_size;
> > > +       struct list_head         tpebs_results;
> > > +       pid_t                    tpebs_pid;
> > >         int                      ctl_fd;
> > >         int                      ctl_fd_ack;
> > >         bool                     ctl_fd_close;
> > > --
> > > 2.43.0
> > >
