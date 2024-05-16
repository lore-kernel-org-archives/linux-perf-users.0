Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653863BF
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877810; cv=none; b=S+MhM7BpKYw6vKHq/Xb2ruSUX34+/xO1/EpCuxTDMvUbe5NtLXVPAZFZ6TujQj3c/NWic02gn1d/Lh264nND0Ph8rUdL2/2zzhUVv7L6gMoH/q4pUXF//mXHJjepnOMJXc+Q667bV4C9CPwHbBq3SOxkIT7loXDTt6/ntGXi7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877810; c=relaxed/simple;
	bh=v2p6heHYfEkFaIblU2RAzPLaaKr5FYKpPHkxDcnnCHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odSOLV3Est/wsK0WNft0ZvyIx1fwBtHfTtyrn7U+j5MJRHWP6FjLuZ0kCqwnQtgqtAyiPIs3q0Rimax6tOd8F7Mz3lFd8lSAlgTMpwJE83s8acvs7jgOg+GSD1wfVh96DqvUKc2wqlN3OBtro6CcWPJUaC24Bhay4FaIMHVOMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quHfxCQ7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quHfxCQ7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee5f3123d8so1245ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715877808; x=1716482608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRZXHT5zv4OLD8sClnj1MyaIu2OkR4Vag3zoxjx9vrk=;
        b=quHfxCQ7U/6YgkacTgBlX/hyO1ov/Dw33WaTm8v081yHXMKbX0XjXhfFObyFmHaA8V
         t+Tvnitq3NFs/k5xrrozwYTjM+YWAkHXf6lpHbAotnn2sKa1BVJaTlXKDoaPhcZuONUe
         4qpIvSKCTUTR2jYqba+HUj4q+7Ck9UV4cMBp90ddrfQS7gQJBBGl0xICAASeSvD4RSrh
         L5lKGh94+U1PVV2qeVqVLqrauPE3NOyrJWyBTkccjI2mKlW4eS6l7XlE/zr6WoKY/P04
         wFUY7I263W/cT+iL6C4T3ZUt/hCJcEGB0r4FcEw4ZnRAAbxKf8QBVXRZtv3ZQd7RyWpp
         E1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715877808; x=1716482608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRZXHT5zv4OLD8sClnj1MyaIu2OkR4Vag3zoxjx9vrk=;
        b=CdGv7iXdUZS4FroooOLYi0RgWWEESISmK77YOHaNaYk66PyMFA36m2GgLWyVGVffst
         XvHSDrfeaDPN/iY4QFm7w18HpUkvSWirr6x4+nIVIEajNDJ4va7lYOnndWhi95OVVJqd
         myEFhUU/nVRz+Lo/5hgCCNYmD+gIKpLNXT8W5os5wa4vs/ZfjJzB8zfs9cIX0/AHJl9V
         YhyC1bFajfyhc7cPH0pikTDA5k+su00xioeeyfHiqUP6ysCMjHplRA8ej1E33v4TaumJ
         0fM5jGN6pFHmFSVpZNk6Vi3y98TaAbH+vmeC0pnBJoFKquwpzTKWrrU1EpFy2kk4SQYn
         lvoA==
X-Forwarded-Encrypted: i=1; AJvYcCUnGYqCFCsmJkHdbBh5CucudJHALLPXBY3ktXFK9N00P7mqEh7QAW/Y5ieKTU4pqhWQgd1iIW97ulbEiKYgFhFxQAn3B1ThJ6HobPVVhrUNsg==
X-Gm-Message-State: AOJu0YwYsXNOarnC4OEp9fjpUHpQd7wCJzrXPAvoM5b0Ut/XEQ1T2t3r
	VV34QpOSWVa4yOF3zU5p18iOk2ZWUtWft9K2/HIo57/hnsrrKBadji4L22FxBQKhg6XlI4Fk7X2
	Vnvf6ur2dBjYFD3CxxidoBDnP4Smajn5wuahv
X-Google-Smtp-Source: AGHT+IHYVd0OFe7jbnEFMHJ3QzsmHY59lb5sCE2OxbM0AvTFwCiZVXBVLT3r9YdEUzOhpatqvTXxBz4UTGUz3pFzcz8=
X-Received: by 2002:a17:902:bb0f:b0:1ea:2b8:2761 with SMTP id
 d9443c01a7336-1f05f77e58amr12299965ad.20.1715877807540; Thu, 16 May 2024
 09:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-4-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-4-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:43:16 -0700
Message-ID: <CAP-5=fWB+rSTaXfTkB9BkWYOt-m2UHcocj6Hkz5B-P0C0WEL2w@mail.gmail.com>
Subject: Re: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When retire_latency value is used in a metric formula, perf stat would fo=
rk a
> perf record process with "-e" and "-W" options. Perf record will collect
> required retire_latency values in parallel while perf stat is collecting
> counting values.
>
> At the point of time that perf stat stops counting, it would send sigterm=
 signal
> to perf record process and receiving sampling data back from perf record =
from a
> pipe. Perf stat will then process the received data to get retire latency=
 data
> and calculate metric result.
>
> Another thread is required to synchronize between perf stat and perf reco=
rd
> when we pass data through pipe.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

So I don't think this is the correct way to add this. My reviewed-by
was based on the fact that I was going to refactor this after landing.
It didn't land and I already sent out:
"Retirement latency perf stat support"
https://lore.kernel.org/lkml/20240428053616.1125891-1-irogers@google.com/
v3 to just land the tool portion:
https://lore.kernel.org/lkml/20240503232849.17752-1-irogers@google.com/
So my reviewed-by no longer stands. The changes I've sent out haven't
been reviewed. Given you're trying to land this, can we work on
reviewing those changes? The v3 was specifically done just so that we
can have the cleaner basis for adding tpebs to the evsel.

Let me point to specific issues below:

> ---
>  tools/perf/builtin-stat.c     |  19 +++
>  tools/perf/util/Build         |   1 +
>  tools/perf/util/intel-tpebs.c | 285 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/intel-tpebs.h |  29 ++++
>  tools/perf/util/stat.h        |   3 +
>  5 files changed, 337 insertions(+)
>  create mode 100644 tools/perf/util/intel-tpebs.c
>  create mode 100644 tools/perf/util/intel-tpebs.h
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 428e9721b908..85927cf45adb 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -70,6 +70,7 @@
>  #include "util/bpf_counter.h"
>  #include "util/iostat.h"
>  #include "util/util.h"
> +#include "util/intel-tpebs.h"
>  #include "asm/bug.h"
>
>  #include <linux/time64.h>
> @@ -94,6 +95,7 @@
>  #include <perf/evlist.h>
>  #include <internal/threadmap.h>
>
> +
>  #define DEFAULT_SEPARATOR      " "
>  #define FREEZE_ON_SMI_PATH     "devices/cpu/freeze_on_smi"
>
> @@ -162,6 +164,8 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd                 =3D -1,
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
> +       .tpebs_results          =3D LIST_HEAD_INIT(stat_config.tpebs_resu=
lts),
> +       .tpebs_pid              =3D -1,

Here we're adding state to the stat_config for the sake of tpebs
events. Were the state in the evsel, as in my changes, we'd not need
to carry new global state for tpebs.

>  };
>
>  static void evlist__check_cpu_maps(struct evlist *evlist)
> @@ -653,6 +657,8 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
> +       if (stat_config.tpebs_pid !=3D -1)
> +               stop_tpebs();

This logic is builtin-stat but what about other commands that could be
using TPEBS for counters?

>         return COUNTER_FATAL;
>  }
>
> @@ -673,6 +679,10 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
>         int err;
>         bool second_pass =3D false;
>
> +       err =3D start_tpebs(&stat_config, evsel_list);
> +       if (err < 0)
> +               return err;
> +
>         if (forks) {
>                 if (evlist__prepare_workload(evsel_list, &target, argv, i=
s_pipe, workload_exec_failed_signal) < 0) {
>                         perror("failed to prepare workload");
> @@ -878,6 +888,10 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
>
>         t1 =3D rdclock();
>
> +       err =3D stop_tpebs();
> +       if (err < 0)
> +               return err;
> +
>         if (stat_config.walltime_run_table)
>                 stat_config.walltime_run[run_idx] =3D t1 - t0;
>
> @@ -985,6 +999,9 @@ static void sig_atexit(void)
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
>
> +       if (stat_config.tpebs_pid !=3D -1)
> +               kill(stat_config.tpebs_pid, SIGTERM);
> +
>         sigprocmask(SIG_SETMASK, &oset, NULL);
>
>         if (signr =3D=3D -1)
> @@ -2918,5 +2935,7 @@ int cmd_stat(int argc, const char **argv)
>         metricgroup__rblist_exit(&stat_config.metric_events);
>         evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack,=
 &stat_config.ctl_fd_close);
>
> +       tpebs_data__delete();
> +
>         return status;
>  }
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 292170a99ab6..c9f1d0bb6bf8 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -153,6 +153,7 @@ perf-y +=3D clockid.o
>  perf-y +=3D list_sort.o
>  perf-y +=3D mutex.o
>  perf-y +=3D sharded_mutex.o
> +perf-y +=3D intel-tpebs.o
>
>  perf-$(CONFIG_LIBBPF) +=3D bpf_map.o
>  perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.=
c
> new file mode 100644
> index 000000000000..4b7a98794fae
> --- /dev/null
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * intel_pt.c: Intel Processor Trace support
> + * Copyright (c) 2013-2015, Intel Corporation.
> + */
> +
> +
> +#include <sys/param.h>
> +#include <subcmd/run-command.h>
> +#include <thread.h>
> +#include "intel-tpebs.h"
> +#include <linux/list.h>
> +#include <linux/zalloc.h>
> +#include <linux/err.h>
> +#include "sample.h"
> +#include "debug.h"
> +#include "evlist.h"
> +#include "evsel.h"
> +#include "session.h"
> +#include "tool.h"
> +#include "metricgroup.h"
> +#include <sys/stat.h>
> +#include <sys/file.h>
> +
> +
> +
> +#define PERF_DATA              "-"
> +#define CONTROL                        "/tmp/control"
> +#define ACK                    "/tmp/ack"
> +pthread_t reader_thread;
> +struct child_process *cmd;
> +struct perf_stat_config *stat_config;
> +
> +static int get_perf_record_args(const char **record_argv)
> +{
> +       int i =3D 0;
> +       struct tpebs_retire_lat *e;
> +
> +       pr_debug("Prepare perf record for retire_latency\n");
> +
> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +       record_argv[i++] =3D "--synth=3Dno";

There should be more things to disable, like BPF events, we don't need
the dummy, etc.

> +       record_argv[i++] =3D "--control=3Dfifo:/tmp/control,/tmp/ack";
> +
> +       if (stat_config->user_requested_cpu_list) {
> +               record_argv[i++] =3D "-C";
> +               record_argv[i++] =3D stat_config->user_requested_cpu_list=
;
> +       }
> +
> +       if (stat_config->system_wide)
> +               record_argv[i++] =3D "-a";
> +
> +       if (!stat_config->system_wide && !stat_config->user_requested_cpu=
_list) {
> +               pr_err("Require -a or -C option to run sampling.\n");
> +               return -ECANCELED;
> +       }
> +
> +       list_for_each_entry(e, &stat_config->tpebs_results, nd) {
> +               record_argv[i++] =3D "-e";
> +               record_argv[i++] =3D e->name;
> +       }
> +
> +       record_argv[i++] =3D "-o";
> +       record_argv[i++] =3D PERF_DATA;
> +
> +       return 0;
> +}
> +
> +static int prepare_run_command(const char **argv)
> +{
> +       cmd =3D zalloc(sizeof(struct child_process));
> +       if (!cmd)
> +               return -ENOMEM;
> +       cmd->argv =3D argv;
> +       cmd->out =3D -1;
> +       return 0;
> +}
> +
> +static int prepare_perf_record(int tpebs_event_size)
> +{
> +       const char **record_argv;
> +       int ret;
> +
> +       /*Create control and ack fd for --control*/
> +       if (mkfifo(CONTROL, 0600)) {
> +               pr_err("Failed to create control fifo");
> +               return -1;
> +       }
> +       if (mkfifo(ACK, 0600)) {
> +               pr_err("Failed to create control fifo");
> +               return -1;
> +       }
> +
> +       record_argv =3D calloc(10 + 2 * tpebs_event_size, sizeof(char *))=
;
> +       if (!record_argv)
> +               return -ENOMEM;
> +
> +
> +       ret =3D get_perf_record_args(record_argv);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D prepare_run_command(record_argv);
> +       if (ret)
> +               goto out;
> +       ret =3D start_command(cmd);
> +out:
> +       free(record_argv);
> +       return ret;
> +}
> +struct sample_data_reader {
> +       struct perf_tool        tool;
> +       struct perf_session     *session;
> +};
> +
> +static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> +{
> +       zfree(&r->name);
> +       zfree(&r->tpebs_name);
> +       free(r);
> +}
> +
> +void tpebs_data__delete(void)
> +{
> +       struct tpebs_retire_lat *r, *rtmp;
> +
> +       list_for_each_entry_safe(r, rtmp, &stat_config->tpebs_results, nd=
) {
> +               list_del_init(&r->nd);
> +               tpebs_retire_lat__delete(r);
> +       }
> +       free(cmd);
> +}
> +
> +static int process_sample_event(struct perf_tool *tool __maybe_unused,
> +                               union perf_event *event __maybe_unused,
> +                               struct perf_sample *sample,
> +                               struct evsel *evsel,
> +                               struct machine *machine __maybe_unused)
> +{
> +       int ret =3D 0;
> +       const char *evname;
> +       struct tpebs_retire_lat *t;
> +
> +       evname =3D evsel__name(evsel);
> +
> +       /*
> +        * Need to handle per core results? We are assuming average retir=
e
> +        * latency value will be used. Save the number of samples and the=
 sum of
> +        * retire latency value for each event.
> +        */
> +       list_for_each_entry(t, &stat_config->tpebs_results, nd) {
> +               if (!strcmp(evname, t->name)) {
> +                       t->count +=3D 1;
> +                       t->sum +=3D sample->retire_lat;
> +                       t->val =3D (double) t->sum / t->count;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int process_feature_event(struct perf_session *session,
> +                                union perf_event *event)
> +{
> +       if (event->feat.feat_id < HEADER_LAST_FEATURE)
> +               return perf_event__process_feature(session, event);
> +       return 0;
> +}
> +
> +static void *__sample_reader(void *arg)
> +{
> +       struct child_process *child =3D arg;
> +       struct perf_session *session;
> +       struct perf_data data =3D {
> +               .mode =3D PERF_DATA_MODE_READ,
> +               .path =3D PERF_DATA,
> +               .file.fd =3D child->out,
> +       };
> +       struct sample_data_reader reader =3D {
> +               .tool =3D {
> +               .sample          =3D process_sample_event,
> +               .feature         =3D process_feature_event,
> +               .attr            =3D perf_event__process_attr,
> +               },
> +       };

I prefer the reading approach here over what I did here:
https://lore.kernel.org/lkml/CAM9d7cgzTsfk3C+dTN80f5FhB1rmfturjuUUwvSTeUvny=
5eWKw@mail.gmail.com/
I'd done that as Namhyung had commented on using perf report:
https://lore.kernel.org/lkml/CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69+rD06RAn=
u9-EQ@mail.gmail.com/
It was also less work. I don't see why we can't move the reading logic
into a function like evsel__read_retire_latency that's in my change. I
also think that in the first instance all reading logic should be
implemented to return 0 and we only do the forking, etc. when a
command line flag is passed.

> +
> +       session =3D perf_session__new(&data, &reader.tool);
> +       if (IS_ERR(session))
> +               return NULL;
> +       reader.session =3D session;
> +       perf_session__process_events(session);
> +       perf_session__delete(session);
> +
> +       return NULL;
> +}
> +
> +
> +int start_tpebs(struct perf_stat_config *perf_stat_config, struct evlist=
 *evsel_list)
> +{
> +       int ret =3D 0;
> +       struct evsel *evsel;
> +       int control =3D -1, ack =3D -1;
> +
> +       stat_config =3D perf_stat_config;
> +       /*
> +        * Prepare perf record for sampling event retire_latency before f=
ork and
> +        * prepare workload
> +        */
> +       evlist__for_each_entry(evsel_list, evsel) {
> +               if (evsel->retire_lat) {
> +                       struct tpebs_retire_lat *new =3D malloc(sizeof(st=
ruct tpebs_retire_lat));
> +                       int i;
> +                       char *name;
> +
> +                       pr_debug("perf stat retire latency %s required\n"=
, evsel->name);
> +                       if (!new)
> +                               return -1;
> +                       for (i =3D strlen(evsel->name) - 1; i > 0; i--) {
> +                               if (evsel->name[i] =3D=3D 'R')
> +                                       break;
> +                       }
> +                       if (i <=3D 0 || evsel->name[i] !=3D 'R')
> +                               return -1;
> +
> +                       name =3D strdup(evsel->name);
> +                       if (!name)
> +                               return -ENOMEM;
> +                       name[i] =3D 'p';
> +                       new->name =3D strdup(name);
> +                       free(name);
> +                       new->tpebs_name =3D strdup(evsel->name);
> +                       if (!new->tpebs_name)
> +                               return -ENOMEM;
> +                       new->count =3D 0;
> +                       new->sum =3D 0;
> +                       list_add_tail(&new->nd, &stat_config->tpebs_resul=
ts);
> +                       stat_config->tpebs_event_size +=3D 1;
> +               }
> +       }
> +
> +       if (stat_config->tpebs_event_size > 0) {
> +               ret =3D prepare_perf_record(stat_config->tpebs_event_size=
);
> +               if (ret)
> +                       return ret;
> +               if (pthread_create(&reader_thread, NULL, __sample_reader,=
 cmd)) {
> +                       kill(cmd->pid, SIGTERM);
> +                       close(cmd->out);
> +                       pr_err("Could not create thread to process sample=
 data.\n");
> +                       return -1;
> +               }
> +               /* Wait for perf record initialization a little bit.*/
> +               control =3D open(CONTROL, O_RDONLY, O_NONBLOCK);
> +               if (!control)
> +                       return -1;
> +               close(control);
> +               ack =3D open(ACK, O_RDONLY, O_NONBLOCK);
> +               if (!ack)
> +                       return -1;
> +               close(ack);
> +               pr_debug("Received ack from perf record\n");
> +       }
> +
> +       return ret;
> +}
> +
> +
> +int stop_tpebs(void)
> +{
> +       int ret =3D 0;
> +
> +       if (stat_config->tpebs_event_size > 0) {
> +               kill(cmd->pid, SIGTERM);
> +               pthread_join(reader_thread, NULL);
> +               close(cmd->out);
> +               ret =3D finish_command(cmd);
> +               if (ret =3D=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> +                       ret =3D 0;
> +               remove(CONTROL);
> +               remove(ACK);
> +       }
> +       return ret;
> +}
> diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.=
h
> new file mode 100644
> index 000000000000..e8e2bb2f479b
> --- /dev/null
> +++ b/tools/perf/util/intel-tpebs.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * intel_pt.h: Intel Processor Trace support
> + * Copyright (c) 2013-2015, Intel Corporation.
> + */
> +#include "stat.h"
> +
> +#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
> +#define INCLUDE__PERF_INTEL_TPEBS_H__
> +
> +struct tpebs_retire_lat {
> +       struct list_head nd;
> +       /* Event name */
> +       const char *name;
> +       /* Event name with the TPEBS modifier R */
> +       const char *tpebs_name;
> +       /* Count of retire_latency values found in sample data */
> +       size_t count;
> +       /* Sum of all the retire_latency values in sample data */
> +       int sum;
> +       /* Average of retire_latency, val =3D sum / count */
> +       double val;
> +};

An evsel has a pretty much all of this and so we're duplicating in
particular the counting logic which then needs later work to integrate
and is why I'd prefer we went the evsel route.

Thanks,
Ian

> +
> +int start_tpebs(struct perf_stat_config *perf_stat_config, struct evlist=
 *evsel_list);
> +int stop_tpebs(void);
> +void tpebs_data__delete(void);
> +
> +#endif
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index fd7a187551bd..c6c2aa43030f 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -110,6 +110,9 @@ struct perf_stat_config {
>         struct cpu_aggr_map     *cpus_aggr_map;
>         u64                     *walltime_run;
>         struct rblist            metric_events;
> +       size_t                   tpebs_event_size;
> +       struct list_head         tpebs_results;
> +       pid_t                    tpebs_pid;
>         int                      ctl_fd;
>         int                      ctl_fd_ack;
>         bool                     ctl_fd_close;
> --
> 2.43.0
>
