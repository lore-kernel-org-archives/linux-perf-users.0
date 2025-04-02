Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475F23814A;
	Wed,  2 Apr 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604549; cv=none; b=jQnsfKKPzPjW73lKrgW22o1K2bKI2L3FDE66CI5VI+nOqMMXz/Dx25ISj1uEbc2prGY3aCDSqXQcYCff37rgyc8fKCc+a6Dod4uxiAaMSP+DdR3wTwyJMSaB8mMtHIuC+6/P5CEg+jdgVlunfW2+lJTJo22jVJKgk+9HSzqJsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604549; c=relaxed/simple;
	bh=ICFQu9uatwHq5mRLnVZDPfIvCDIZp3w6Sx8ogDkBt3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ1FX1ivRle/3GI8lSpFQbvjKi0edinTzrOEowJsLKPLZ0QjhHHJ+kfWs8UmFRRYo+6IHDPN08jA6Bo5itmqz5sIwblRMwP9JojUvIzE/1iG1UI6x/KquX7qZGBxHSxFTLp0S54W+2TrTK/vyf+jSklHTlTGHUKsW40LWXBFalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDCA31F91;
	Wed,  2 Apr 2025 07:35:48 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99FAA3F63F;
	Wed,  2 Apr 2025 07:35:45 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:35:41 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jann Horn <jannh@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Casey Chen <cachen@purestorage.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andrew Kreimer <algonell@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 09/48] perf tests: Silence -Wshorten-64-to-32 warnings
Message-ID: <20250402143541.GM115840@e132581.arm.com>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401182347.3422199-10-irogers@google.com>

On Tue, Apr 01, 2025 at 11:23:07AM -0700, Ian Rogers wrote:

[...]

> @@ -478,13 +478,14 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
>  	int err = 0;
>  
>  	for (struct test_suite **t = suites; *t; t++) {
> -		int i, len = strlen(test_description(*t, -1));
> +		int i;
> +		int len = (int)strlen(test_description(*t, -1));

Thanks for huge polish.

Just a concern from me.  Throughout this patch, the methodology is not
consistent.  Some changes update variable types which is fine for me.

But the case above it simply cast size_t to int.  Should we update the
variable type as 'size_t' at here?

>  		if (width < len)
>  			width = len;
>  
>  		test_suite__for_each_test_case(*t, i) {
> -			len = strlen(test_description(*t, i));
> +			len = (int)strlen(test_description(*t, i));
>  			if (width < len)
>  				width = len;
>  			num_tests += runs_per_test;
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index cf6edbe697b2..0c31d5ff77e2 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -188,7 +188,7 @@ static int objdump_version(void)
>  	char *line = NULL;
>  	const char *fmt;
>  	FILE *f;
> -	int ret;
> +	ssize_t ret;
>  
>  	int version_tmp, version_num = 0;
>  	char *version = 0, *token;
> @@ -295,7 +295,7 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
>  	if (len) {
>  		pr_debug("objdump read too few bytes: %zd\n", len);
>  		if (!ret)
> -			ret = len;
> +			ret = (int)len;

A proper change is to update the function type to:

  size_t read_via_objdump(...)

[...]

> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index db004d26fcb0..2762794827ce 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -609,7 +609,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>  	pmu_add_sys_aliases(pmu);
>  
>  	/* Count how many aliases we generated */
> -	alias_count = perf_pmu__num_events(pmu);
> +	alias_count = (int)perf_pmu__num_events(pmu);

Could we change the variable 'alias_count' to size_t type?

Or in another way, we need to update perf_pmu__num_events() with
returning int type.

My understanding is rather than using cast, we should polish code for
using consistent type for both variables and return values.

>  	/* Count how many aliases we expect from the known table */
>  	for (table = &test_pmu->aliases[0]; *table; table++)
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index a67c756f90b8..b7d7735f8a72 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -154,13 +154,13 @@ sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __may
>  {
>  	if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
>  		ctx.first_siginfo = *info;
> -	__atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
> +	__atomic_fetch_sub(&ctx.tids_want_signal, (pid_t)syscall(SYS_gettid), __ATOMIC_RELAXED);
>  }
>  
>  static void *test_thread(void *arg)
>  {
>  	pthread_barrier_t *barrier = (pthread_barrier_t *)arg;
> -	pid_t tid = syscall(SYS_gettid);
> +	pid_t tid = (pid_t)syscall(SYS_gettid);
>  	int i;
>  
>  	pthread_barrier_wait(barrier);
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 8df3f9d9ffd2..1f0f8321ae40 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -140,8 +140,8 @@ static int process_sample_event(struct evlist *evlist,
>  
>  	evsel = evlist__id2evsel(evlist, sample.id);
>  	if (evsel == switch_tracking->switch_evsel) {
> -		next_tid = evsel__intval(evsel, &sample, "next_pid");
> -		prev_tid = evsel__intval(evsel, &sample, "prev_pid");
> +		next_tid = (int)evsel__intval(evsel, &sample, "next_pid");
> +		prev_tid = (int)evsel__intval(evsel, &sample, "prev_pid");

Change 'prev_tid' and 'next_tid' to pid_t type?

Thanks,
Leo

>  		cpu = sample.cpu;
>  		pr_debug3("sched_switch: cpu: %d prev_tid %d next_tid %d\n",
>  			  cpu, prev_tid, next_tid);
> @@ -262,9 +262,10 @@ static int compar(const void *a, const void *b)
>  {
>  	const struct event_node *nodea = a;
>  	const struct event_node *nodeb = b;
> -	s64 cmp = nodea->event_time - nodeb->event_time;
>  
> -	return cmp;
> +	if (nodea->event_time == nodeb->event_time)
> +		return 0;
> +	return nodea->event_time < nodeb->event_time ? -1 : 1;
>  }
>  
>  static int process_events(struct evlist *evlist,
> @@ -398,7 +399,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
>  
>  	switch_evsel = evlist__add_sched_switch(evlist, true);
>  	if (IS_ERR(switch_evsel)) {
> -		err = PTR_ERR(switch_evsel);
> +		err = (int)PTR_ERR(switch_evsel);
>  		pr_debug("Failed to create event %s\n", sched_switch);
>  		goto out_err;
>  	}
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> index 74cdbd2ce9d0..fbdb463e965d 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -82,7 +82,7 @@ static bool is_ignored_symbol(const char *name, char type)
>  			return true;
>  
>  	for (p = ignored_suffixes; *p; p++) {
> -		int l = strlen(name) - strlen(*p);
> +		ssize_t l = strlen(name) - strlen(*p);
>  
>  		if (l >= 0 && !strcmp(name + l, *p))
>  			return true;
> @@ -313,7 +313,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  				 * _really_ have a problem.
>  				 */
>  				s64 skew = mem_end - UM(pair->end);
> -				if (llabs(skew) >= page_size)
> +				if (llabs(skew) >= (s64)page_size)
>  					pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
>  						 mem_start, sym->name, mem_end,
>  						 UM(pair->end));
> diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> index 6c178985e37f..d5dd17eb5c05 100644
> --- a/tools/perf/tests/wp.c
> +++ b/tools/perf/tests/wp.c
> @@ -31,10 +31,10 @@ volatile u8 data2[3];
>  #ifndef __s390x__
>  static int wp_read(int fd, long long *count, int size)
>  {
> -	int ret = read(fd, count, size);
> +	ssize_t ret = read(fd, count, size);
>  
>  	if (ret != size) {
> -		pr_debug("failed to read: %d\n", ret);
> +		pr_debug("failed to read: %zd\n", ret);
>  		return -1;
>  	}
>  	return 0;
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 
> 
