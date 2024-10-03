Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410F1C245F;
	Thu,  3 Oct 2024 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993072; cv=none; b=ZOnzq2Yk3ja6SxaZ7DIMuxj4Q3RJLZKOyKu6Vr7/oE5KkMFC7qwNSUiVNi3gYjtQpUAjDMRtTp9ya2ipcCUpBZbXxxDbva2SYq9Yglul7G+PTJL7iMgjhn9yEHcFibqm/L8igYcv1uFhMrKA6uNo7by2PQHwAx4lLJHYscddGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993072; c=relaxed/simple;
	bh=N8c5/VzxfTBa6nYUmDXyq1k10B+fARsQ9Wxk5Pvk7bU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VE7NQs6qgnQvjEeUG5yE4ZlEEHVVdq0dEaTkLg9H5qUea8oL3UDqx5h/rt+wPqAt5nZdWaD76Fx+Wl4L3UnRz7Gd8yOy4ory3rNBDNWGFENqb9opaGVFseRvLGtx68rgspZG1wvBrVPqFZcpQnLsz5VFb4nZ2nApK4fyhiMP33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtzRHy5Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtzRHy5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727993070; x=1759529070;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=N8c5/VzxfTBa6nYUmDXyq1k10B+fARsQ9Wxk5Pvk7bU=;
  b=VtzRHy5Y99tR2To4gzmEklokkOM+smz2dZpsySBPVABtseS2ak9P9cH3
   wjzefbFssqdeS3zQ5MxvaQJTADNFKqxeAfpmZke5xotseSGrQCQITfPSM
   GhuxIb4oQEGu0BVM8ZmtdltnnYOJA03SfaJEJdWdWICXhITdlWjQF4q1d
   ow7qeIA4T0JFYz+b8DyDVyF4jBfK8J6WaaJNm9pj1g7GJJbuN+5wLY8nR
   0V71YSGe14OgTARGUGTF7BbLh0Fqd8I3x24/FgFv9s67FKA3aWZ41VdLs
   vWZ4eEjEwKO85Su4mmNbKy1VyargDtjx8ogkLgX9bMt9zuCPvrfPE9hrv
   A==;
X-CSE-ConnectionGUID: wLAK/K9rQ8mBmtG9Uxp32A==
X-CSE-MsgGUID: CljyZOw9QL2F0CWMO8q04Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26678231"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="26678231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 15:04:29 -0700
X-CSE-ConnectionGUID: 1VUJZIYURAqTabsfvSHL2w==
X-CSE-MsgGUID: qO1n9ziCSsyIOZorFhQQ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="78912786"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.109.154]) ([10.125.109.154])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 15:04:29 -0700
Message-ID: <05c572743f8cefd0da65a56d9b110697eba5529e.camel@linux.intel.com>
Subject: Re: [PATCH v3] perf sched timehist: Add pre-migration wait time
 option
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark
 Rutland <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
 acme@redhat.com, linux-perf-users <linux-perf-users@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Thu, 03 Oct 2024 15:04:28 -0700
In-Reply-To: <20241002163917.33781-1-vineethr@linux.ibm.com>
References: <20241002163917.33781-1-vineethr@linux.ibm.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-02 at 22:09 +0530, Madadi Vineeth Reddy wrote:
> pre-migration wait time is the time that a task unnecessarily spends
> on the runqueue of a CPU but doesn't get switched-in there. In terms
> of tracepoints, it is the time between sched:sched_wakeup and
> sched:sched_migrate_task.
>=20
> Let's say a task woke up on CPU2, then it got migrated to CPU4 and
> then it's switched-in to CPU4. So, here pre-migration wait time is
> time that it was waiting on runqueue of CPU2 after it is woken up.
>=20
> The general pattern for pre-migration to occur is:
> sched:sched_wakeup
> sched:sched_migrate_task
> sched:sched_switch

If a task migrate from CPU A to CPU B, but is unlucky that
someone took CPU B and it has to wait. Then it is yet again migrated to CPU=
 C.
Do you only compute pre-mig time as=C2=A0
t_sched_migrate_task_CPU_A - t_sched_migrate_task_CPU_A?

The task also spend some pre-mig time on CPU_B that probably
should be included. =C2=A0And that time is when it migrates to B
till it is migrated away from B.  Do you take that into
account?

>=20
> The sched:sched_waking event is used to capture the wakeup time,
> as it aligns with the existing code and only introduces a negligible
> time difference.
>=20
> pre-migrations are generally not useful and it increases migrations.

Not sure long pre-migration itself leads to migrations.  But rather migrati=
ons
is a function of the aggressiveness of the idle load balancer.

> This metric would be helpful in testing patches mainly related to wakeup
> and load-balancer code paths=C2=A0
>=20

I think it is most relevant for the idle load balancer code paths, where
newly idle CPU pull task from other CPUs to run.

Are there cases where you have used this metric to tune the scheduler?

Thanks.

Tim=20

> as better wakeup logic would choose an
> optimal CPU where task would be switched-in and thereby reducing pre-
> migrations.
>=20
> The sample output(s) when -P or --pre-migrations is used:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>            time    cpu  task name                       wait time  sch de=
lay   run time  pre-mig time
>                         [tid/pid]                          (msec)     (ms=
ec)     (msec)     (msec)
> --------------- ------  ------------------------------  ---------  ------=
---  ---------  ---------
>    38456.720806 [0001]  schbench[28634/28574]               4.917      4.=
768      1.004      0.000
>    38456.720810 [0001]  rcu_preempt[18]                     3.919      0.=
003      0.004      0.000
>    38456.721800 [0006]  schbench[28779/28574]              23.465     23.=
465      1.999      0.000
>    38456.722800 [0002]  schbench[28773/28574]              60.371     60.=
237      3.955     60.197
>    38456.722806 [0001]  schbench[28634/28574]               0.004      0.=
004      1.996      0.000
>    38456.722811 [0001]  rcu_preempt[18]                     1.996      0.=
005      0.005      0.000
>    38456.723800 [0000]  schbench[28833/28574]               4.000      4.=
000      3.999      0.000
>    38456.723800 [0004]  schbench[28762/28574]              42.951     42.=
839      3.999     39.867
>    38456.723802 [0007]  schbench[28812/28574]              43.947     43.=
817      3.999     40.866
>    38456.723804 [0001]  schbench[28587/28574]               7.935      7.=
822      0.993      0.000
>=20
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>=20
> ---
> Changes in v3:
> - Use the sched:sched_waking event to calculate the wakeup time. (Namhyun=
g Kim)
> - Rebase against perf-tools-next commit 80f192724e31 ("perf tests: Add mo=
re
>   topdown events regroup tests")
>=20
> Changes in v2:
> - Use timehist_sched_wakeup_event() to get the sched_wakeup time. (Namhyu=
ng Kim)
> - Rebase against perf-tools-next commit b38c49d8296b ("perf/test: Speed u=
p test
>   case perf annotate basic tests")
>=20
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  8 +++
>  tools/perf/builtin-sched.c              | 83 ++++++++++++++++---------
>  2 files changed, 60 insertions(+), 31 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documen=
tation/perf-sched.txt
> index 3db64954a267..6dbbddb6464d 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -221,6 +221,14 @@ OPTIONS for 'perf sched timehist'
>  	priorities are specified with -: 120-129. A combination of both can als=
o be
>  	provided: 0,120-129.
> =20
> +-P::
> +--pre-migrations::
> +	Show pre-migration wait time. pre-migration wait time is the time spent
> +	by a task waiting on a runqueue but not getting the chance to run there
> +	and is migrated to a different runqueue where it is finally run. This
> +	time between sched_wakeup and migrate_task is the pre-migration wait
> +	time.
> +
>  OPTIONS for 'perf sched replay'
>  ------------------------------
> =20
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index fdf979aaf275..e6540803ced6 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -225,6 +225,7 @@ struct perf_sched {
>  	bool		show_wakeups;
>  	bool		show_next;
>  	bool		show_migrations;
> +	bool		pre_migrations;
>  	bool		show_state;
>  	bool		show_prio;
>  	u64		skipped_samples;
> @@ -244,7 +245,9 @@ struct thread_runtime {
>  	u64 dt_iowait;      /* time between CPU access by iowait (off cpu) */
>  	u64 dt_preempt;     /* time between CPU access by preempt (off cpu) */
>  	u64 dt_delay;       /* time between wakeup and sched-in */
> +	u64 dt_pre_mig;     /* time between migration and wakeup */
>  	u64 ready_to_run;   /* time of wakeup */
> +	u64 migrated;	    /* time when a thread is migrated */
> =20
>  	struct stats run_stats;
>  	u64 total_run_time;
> @@ -252,6 +255,7 @@ struct thread_runtime {
>  	u64 total_iowait_time;
>  	u64 total_preempt_time;
>  	u64 total_delay_time;
> +	u64 total_pre_mig_time;
> =20
>  	char last_state;
> =20
> @@ -2073,14 +2077,15 @@ static void timehist_header(struct perf_sched *sc=
hed)
>  		printf(" ");
>  	}
> =20
> -	if (sched->show_prio) {
> -		printf(" %-*s  %-*s  %9s  %9s  %9s",
> -		       comm_width, "task name", MAX_PRIO_STR_LEN, "prio",
> -		       "wait time", "sch delay", "run time");
> -	} else {
> -		printf(" %-*s  %9s  %9s  %9s", comm_width,
> -		       "task name", "wait time", "sch delay", "run time");
> -	}
> +	printf(" %-*s", comm_width, "task name");
> +
> +	if (sched->show_prio)
> +		printf("  %-*s", MAX_PRIO_STR_LEN, "prio");
> +
> +	printf("  %9s  %9s  %9s", "wait time", "sch delay", "run time");
> +
> +	if (sched->pre_migrations)
> +		printf("  %9s", "pre-mig time");
> =20
>  	if (sched->show_state)
>  		printf("  %s", "state");
> @@ -2095,17 +2100,15 @@ static void timehist_header(struct perf_sched *sc=
hed)
>  	if (sched->show_cpu_visual)
>  		printf(" %*s ", ncpus, "");
> =20
> -	if (sched->show_prio) {
> -		printf(" %-*s  %-*s  %9s  %9s  %9s",
> -		       comm_width, "[tid/pid]", MAX_PRIO_STR_LEN, "",
> -		       "(msec)", "(msec)", "(msec)");
> -	} else {
> -		printf(" %-*s  %9s  %9s  %9s", comm_width,
> -		       "[tid/pid]", "(msec)", "(msec)", "(msec)");
> -	}
> +	printf(" %-*s", comm_width, "[tid/pid]");
> =20
> -	if (sched->show_state)
> -		printf("  %5s", "");
> +	if (sched->show_prio)
> +		printf("  %-*s", MAX_PRIO_STR_LEN, "");
> +
> +	printf("  %9s  %9s  %9s", "(msec)", "(msec)", "(msec)");
> +
> +	if (sched->pre_migrations)
> +		printf("  %9s", "(msec)");
> =20
>  	printf("\n");
> =20
> @@ -2117,15 +2120,15 @@ static void timehist_header(struct perf_sched *sc=
hed)
>  	if (sched->show_cpu_visual)
>  		printf(" %.*s ", ncpus, graph_dotted_line);
> =20
> -	if (sched->show_prio) {
> -		printf(" %.*s  %.*s  %.9s  %.9s  %.9s",
> -		       comm_width, graph_dotted_line, MAX_PRIO_STR_LEN, graph_dotted_l=
ine,
> -		       graph_dotted_line, graph_dotted_line, graph_dotted_line);
> -	} else {
> -		printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
> -		       graph_dotted_line, graph_dotted_line, graph_dotted_line,
> -		       graph_dotted_line);
> -	}
> +	printf(" %.*s", comm_width, graph_dotted_line);
> +
> +	if (sched->show_prio)
> +		printf("  %.*s", MAX_PRIO_STR_LEN, graph_dotted_line);
> +
> +	printf("  %.9s  %.9s  %.9s", graph_dotted_line, graph_dotted_line, grap=
h_dotted_line);
> +
> +	if (sched->pre_migrations)
> +		printf("  %.9s", graph_dotted_line);
> =20
>  	if (sched->show_state)
>  		printf("  %.5s", graph_dotted_line);
> @@ -2180,6 +2183,8 @@ static void timehist_print_sample(struct perf_sched=
 *sched,
> =20
>  	print_sched_time(tr->dt_delay, 6);
>  	print_sched_time(tr->dt_run, 6);
> +	if (sched->pre_migrations)
> +		print_sched_time(tr->dt_pre_mig, 6);
> =20
>  	if (sched->show_state)
>  		printf(" %5c ", thread__tid(thread) =3D=3D 0 ? 'I' : state);
> @@ -2239,6 +2244,7 @@ static void timehist_update_runtime_stats(struct th=
read_runtime *r,
>  	r->dt_iowait  =3D 0;
>  	r->dt_preempt =3D 0;
>  	r->dt_run     =3D 0;
> +	r->dt_pre_mig =3D 0;
> =20
>  	if (tprev) {
>  		r->dt_run =3D t - tprev;
> @@ -2247,6 +2253,11 @@ static void timehist_update_runtime_stats(struct t=
hread_runtime *r,
>  				pr_debug("time travel: wakeup time for task > previous sched_switch =
event\n");
>  			else
>  				r->dt_delay =3D tprev - r->ready_to_run;
> +
> +			if (r->ready_to_run && r->migrated) {
> +				if ((r->migrated > r->ready_to_run) && (r->migrated < tprev))
> +					r->dt_pre_mig =3D r->migrated - r->ready_to_run;
> +			}
>  		}
> =20
>  		if (r->last_time > tprev)
> @@ -2270,6 +2281,7 @@ static void timehist_update_runtime_stats(struct th=
read_runtime *r,
>  	r->total_sleep_time   +=3D r->dt_sleep;
>  	r->total_iowait_time  +=3D r->dt_iowait;
>  	r->total_preempt_time +=3D r->dt_preempt;
> +	r->total_pre_mig_time +=3D r->dt_pre_mig;
>  }
> =20
>  static bool is_idle_sample(struct perf_sample *sample,
> @@ -2684,8 +2696,14 @@ static int timehist_migrate_task_event(const struc=
t perf_tool *tool,
> =20
>  	tr->migrations++;
> =20
> +	if (tr->migrated =3D=3D 0)
> +		tr->migrated =3D sample->time;
> +
>  	/* show migrations if requested */
> -	timehist_print_migration_event(sched, evsel, sample, machine, thread);
> +	if (sched->show_migrations) {
> +		timehist_print_migration_event(sched, evsel, sample,
> +							machine, thread);
> +	}
> =20
>  	return 0;
>  }
> @@ -2836,11 +2854,13 @@ static int timehist_sched_change_event(const stru=
ct perf_tool *tool,
>  		/* last state is used to determine where to account wait time */
>  		tr->last_state =3D state;
> =20
> -		/* sched out event for task so reset ready to run time */
> +		/* sched out event for task so reset ready to run time and migrated ti=
me */
>  		if (state =3D=3D 'R')
>  			tr->ready_to_run =3D t;
>  		else
>  			tr->ready_to_run =3D 0;
> +
> +		tr->migrated =3D 0;
>  	}
> =20
>  	evsel__save_time(evsel, sample->time, sample->cpu);
> @@ -3280,8 +3300,8 @@ static int perf_sched__timehist(struct perf_sched *=
sched)
>  		goto out;
>  	}
> =20
> -	if (sched->show_migrations &&
> -	    perf_session__set_tracepoints_handlers(session, migrate_handlers))
> +	if ((sched->show_migrations || sched->pre_migrations) &&
> +		perf_session__set_tracepoints_handlers(session, migrate_handlers))
>  		goto out;
> =20
>  	/* pre-allocate struct for per-CPU idle stats */
> @@ -3823,6 +3843,7 @@ int cmd_sched(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
>  	OPT_STRING(0, "prio", &sched.prio_str, "prio",
>  		   "analyze events only for given task priority(ies)"),
> +	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-mig=
ration wait time"),
>  	OPT_PARENT(sched_options)
>  	};
> =20

