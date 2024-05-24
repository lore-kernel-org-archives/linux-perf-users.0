Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04F2CA5;
	Fri, 24 May 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591736; cv=none; b=lX0jnSe5LtVsq+cxQl50XRQ/bPGGyOnuJeL42lS+HFp0eoTtPgywJrRs5n4rAA8/ASqwwDu8n6Sr0Ez1WsiQSTgVwH2T1pmFyhO0hNnuEpZoQLKTFgOVuT6Qr5xiRl86FBp1E9jFQhZk3tEY0wJRRMU1zRcAw9/uXGoXSjCwWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591736; c=relaxed/simple;
	bh=Gnn5Xv9Qcs364ddbudnym2g5GORqRyPIb/5Ysixtoto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAXk2JOwh79/T5WLcyyjIAHUtYL+4N+xmMw9xYOwxCKTAZYLoTN7J9mpQlKJ6A/fNROThcak6ixyj0QvsRwymZWvSZ+rlF8CcB5Cy/epdgO3pbnqZUp6H+7DnSkA7c1kTgsF/eDqnD+9350i5QgVosRJvPasU+pXUNIuDomJKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bf5bbab573so1177366a91.3;
        Fri, 24 May 2024 16:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716591734; x=1717196534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7+ndk9pXytc1tQUM2OxGsjKo2Ys8ENhjStBvUT/bH8=;
        b=QTjyUPVaWC9bqzLXZSEwvC3wWo0kaKeFo/N14+s8W4/b0v0uDkWhcre8rRbb0WJt//
         Iosrwc+49R+0xXYOwjQYYh+7zk2jIrlb5D+zpachtSErILO7NRWES3XHgjygtnOcSVPt
         v/oEDIXqsEMZcM9tAky3MtFRs+AO6T/QwJyiUR0NnQ9yXRNNuVp/mEOUaGOGbE39qwCQ
         yE4/+T3U740O+vG/TimIQSMhcJgmjvkRLhPFWKi5WES6aqbK91lbnhIVYKZCmxhnY8Ux
         Nkt3gA8jtwTzG9xjfLWtxjmPPVoWRB80ygziq8srdxApYpi7p0jOIthlb6J+kIqj4KZK
         e9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKC5PPbuD0c4rwEcyZX/CRPkaIh9Wt8SqVTcN5OkhzUudg8F1QihlI6MNqgVp1E3mPKynV/l5zhKg96Im0pN45CqJm3OQ0LLMppQHklOseURBvzSFtEE8CMDfpRClK9pHPBO1DcTPNMadlnNN2vw==
X-Gm-Message-State: AOJu0YykF/UWoU2e3jnWdA1LUcucATDYyNx8QYncRWgnwL6xXigkpkOy
	rBCbAYwrtzAjEUcnTJyKQpiNDOIwKmnXrvE5Dz365iTgEiqfMyp3wVxy1sjuwt/hpM9H32J958M
	22UthFiJvTA6eXoXK15z70XF17BI=
X-Google-Smtp-Source: AGHT+IH1Bd/WYYqteAimX60wPBuIN/yU1a8Qo+VDyx23mZ4FWyQqqtwduoHNDhy0EFS/I/ZdOa9IYFd27Ekbniw4mV4=
X-Received: by 2002:a17:90a:d485:b0:2bd:7e38:798e with SMTP id
 98e67ed59e1d1-2bf5ee1ed82mr3221858a91.28.1716591733759; Fri, 24 May 2024
 16:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com> <20240521173952.3397644-4-weilin.wang@intel.com>
In-Reply-To: <20240521173952.3397644-4-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 24 May 2024 16:02:02 -0700
Message-ID: <CAM9d7cg5j486Bpanqdu9KeZ4oNt091q4bd7E7zWs27ncTCLrvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrote:
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
> ---
>  tools/perf/builtin-stat.c     |  17 ++
>  tools/perf/util/Build         |   1 +
>  tools/perf/util/intel-tpebs.c | 301 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/intel-tpebs.h |  30 ++++
>  tools/perf/util/stat.h        |   1 +
>  5 files changed, 350 insertions(+)
>  create mode 100644 tools/perf/util/intel-tpebs.c
>  create mode 100644 tools/perf/util/intel-tpebs.h
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 428e9721b908..c0e9dfa3b3c2 100644
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
> @@ -162,6 +163,7 @@ static struct perf_stat_config stat_config =3D {
>         .ctl_fd                 =3D -1,
>         .ctl_fd_ack             =3D -1,
>         .iostat_run             =3D false,
> +       .tpebs_pid              =3D -1,

Where is this set?

>  };
>
>  static void evlist__check_cpu_maps(struct evlist *evlist)
> @@ -653,6 +655,8 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
> +       if (stat_config.tpebs_pid !=3D -1)
> +               stop_tpebs();
>         return COUNTER_FATAL;
>  }
>
> @@ -673,6 +677,10 @@ static int __run_perf_stat(int argc, const char **ar=
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
> @@ -878,6 +886,10 @@ static int __run_perf_stat(int argc, const char **ar=
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
> @@ -985,6 +997,9 @@ static void sig_atexit(void)
>         if (child_pid !=3D -1)
>                 kill(child_pid, SIGTERM);
>
> +       if (stat_config.tpebs_pid !=3D -1)
> +               kill(stat_config.tpebs_pid, SIGTERM);
> +
>         sigprocmask(SIG_SETMASK, &oset, NULL);
>
>         if (signr =3D=3D -1)
> @@ -2918,5 +2933,7 @@ int cmd_stat(int argc, const char **argv)
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

Can we make this Intel (or x86) only?

>
>  perf-$(CONFIG_LIBBPF) +=3D bpf_map.o
>  perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.=
c
> new file mode 100644
> index 000000000000..13f65e39a845
> --- /dev/null
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * intel_tpebs.c: Intel TPEBS support
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
> +#include <poll.h>
> +
> +#define PERF_DATA              "-"
> +
> +struct list_head tpebs_results =3D LIST_HEAD_INIT(tpebs_results);

static LIST_HEAD(tpebs_results);


> +static pthread_t reader_thread;
> +static struct child_process *cmd;

Maybe better to have the 'tpebs_' prefix.


> +static struct perf_stat_config *stat_config;

Is this really needed? ...


> +static size_t tpebs_event_size;
> +
> +static int get_perf_record_args(const char **record_argv, char buf[])

... I think you can just pass the stat_config argument
from start_tpebs().

> +{
> +       struct tpebs_retire_lat *e;
> +       int i =3D 0;
> +
> +       pr_debug("Prepare perf record for retire_latency\n");
> +
> +       record_argv[i++] =3D "perf";
> +       record_argv[i++] =3D "record";
> +       record_argv[i++] =3D "-W";
> +       record_argv[i++] =3D "--synth=3Dno";
> +       record_argv[i++] =3D buf;
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
> +       list_for_each_entry(e, &tpebs_results, nd) {
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
> +static int prepare_perf_record(int control_fd[], int ack_fd[])
> +{
> +       const char **record_argv;
> +       int ret;
> +       char buf[32];
> +
> +       scnprintf(buf, sizeof(buf), "--control=3Dfd:%d,%d", control_fd[0]=
, ack_fd[1]);
> +
> +       record_argv =3D calloc(12 + 2 * tpebs_event_size, sizeof(char *))=
;
> +       if (!record_argv)
> +               return -ENOMEM;
> +
> +       ret =3D get_perf_record_args(record_argv, buf);
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

Please add a blank line.


> +struct sample_data_reader {
> +       struct perf_tool        tool;
> +       struct perf_session     *session;

You don't need this, right?  Why not pass the 'tool' directly?

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
> +       list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
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

I don't know.  It depends on the use case where you want
different per-core retire-latency for the (per-core) metric.


> +        * latency value will be used. Save the number of samples and the=
 sum of
> +        * retire latency value for each event.
> +        */
> +       list_for_each_entry(t, &tpebs_results, nd) {
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

Strange indentations.


> +               },
> +       };
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
> +
> +       stat_config =3D perf_stat_config;
> +       /*
> +        * Prepare perf record for sampling event retire_latency before f=
ork and
> +        * prepare workload
> +        */
> +       evlist__for_each_entry(evsel_list, evsel) {
> +               if (evsel->retire_lat) {

To reduce the indentation, consider early continue like

    if (!evsel->retire_lat)
        continue;


> +                       struct tpebs_retire_lat *new =3D malloc(sizeof(st=
ruct tpebs_retire_lat));

I prefer sizeof(*new) instead but it doesn't matter.  But you might use
zalloc() and forget about the 0 initialization later.

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

I remember Ian checked '/' and ':' too.  Otherwise it can detect
R in the event name and treat it as a modifier.

> +                       }
> +                       if (i <=3D 0 || evsel->name[i] !=3D 'R')
> +                               return -1;

You need to free the memory here and other places.

> +
> +                       name =3D strdup(evsel->name);
> +                       if (!name)
> +                               return -ENOMEM;
> +                       name[i] =3D 'p';
> +                       new->name =3D strdup(name);
> +                       free(name);

Seems like an unnecessary allocation.  Why not use 'name'
directly?

> +                       new->tpebs_name =3D strdup(evsel->name);
> +                       if (!new->tpebs_name)
> +                               return -ENOMEM;

Maybe orig_name?  But I'm not sure if it's really needed..
Can we just teach perf record to understand 'R' and to act
like 'p'?


> +                       new->count =3D 0;
> +                       new->sum =3D 0;
> +                       list_add_tail(&new->nd, &tpebs_results);
> +                       tpebs_event_size +=3D 1;
> +               }
> +       }
> +
> +       if (tpebs_event_size > 0) {
> +               struct pollfd pollfd =3D { .events =3D POLLIN, };
> +               int control_fd[2], ack_fd[2], len;
> +               char ack_buf[8];
> +
> +               /*Create control and ack fd for --control*/
> +               if (pipe(control_fd) < 0) {
> +                       pr_err("Failed to create control fifo");
> +                       return -1;
> +               }
> +               if (pipe(ack_fd) < 0) {
> +                       pr_err("Failed to create control fifo");
> +                       return -1;

Need to close the pipes here and other places.

> +               }
> +
> +               ret =3D prepare_perf_record(control_fd, ack_fd);
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
> +               /* Wait for perf record initialization.*/
> +               len =3D strlen("enable");
> +               ret =3D write(control_fd[1], "enable", len);
> +               if (ret !=3D len) {
> +                       pr_err("perf record control write control message=
 failed\n");
> +                       goto out;
> +               }
> +
> +               pollfd.fd =3D ack_fd[0];
> +               if (!poll(&pollfd, 1, 2000))
> +                       goto out;

Do we need this?  Why not just read?

> +
> +               ret =3D read(ack_fd[0], ack_buf, sizeof(ack_buf));
> +               if (ret > 0)
> +                       ret =3D strcmp(ack_buf, "ack\n");
> +               else {
> +                       pr_err("perf record control ack failed\n");
> +                       goto out;
> +               }
> +               pr_debug("Received ack from perf record\n");
> +out:
> +               close(control_fd[0]);
> +               close(control_fd[1]);
> +               close(ack_fd[0]);
> +               close(ack_fd[1]);
> +       }
> +       return ret;
> +}
> +
> +
> +int stop_tpebs(void)
> +{
> +       int ret =3D 0;
> +
> +       if (tpebs_event_size > 0) {
> +               kill(cmd->pid, SIGTERM);
> +               pthread_join(reader_thread, NULL);
> +               close(cmd->out);
> +               ret =3D finish_command(cmd);
> +               if (ret =3D=3D -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> +                       ret =3D 0;
> +       }
> +       return ret;
> +}
> diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.=
h
> new file mode 100644
> index 000000000000..25e3e6729146
> --- /dev/null
> +++ b/tools/perf/util/intel-tpebs.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * intel_tpebs.h: Intel TEPBS support
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
> +
> +extern struct list_head tpebs_results;
> +
> +int start_tpebs(struct perf_stat_config *perf_stat_config, struct evlist=
 *evsel_list);
> +int stop_tpebs(void);
> +void tpebs_data__delete(void);

I think it's better to have the same prefix.

tpebs_start()
tpebs_stop()
tpebs_delete()

Thanks,
Namhyung

> +
> +#endif
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index fd7a187551bd..6e86311bc75e 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -110,6 +110,7 @@ struct perf_stat_config {
>         struct cpu_aggr_map     *cpus_aggr_map;
>         u64                     *walltime_run;
>         struct rblist            metric_events;
> +       pid_t                    tpebs_pid;
>         int                      ctl_fd;
>         int                      ctl_fd_ack;
>         bool                     ctl_fd_close;
> --
> 2.43.0
>
