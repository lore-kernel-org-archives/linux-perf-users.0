Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51519D09C;
	Sat, 15 Mar 2025 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742079758; cv=none; b=okE0UkAUN9KKqVfhCpgNJUZ/Qt7jQLsjyytPKkKRyBLiqghxTD6I+rH3Ftfi6C8DG66uqXlhpEF7vQ8HjONaR7uUaiWmH5+JVHHSNVAbThMHKNDzQt4qfQd4x+GboozsOvwPXgseZ578GSSAUfgs0PvgJKzgOwQHNKWSMBVDeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742079758; c=relaxed/simple;
	bh=8XxuyM3rSXd31IYIv534Hq8h4Bllxjj9SAfhpY0z5zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxeCcjTygWp5jfjFccOW/thCaNa0pv5nz70G+i2bdQo8+soyHwO4zRZxRPJEeyOFoWa3VR0TE4rGQ7Y5UnIKkcEolqlK/D1xLRKvAAXtDN0+e5BlP+wjB7bktMxcQr72RCx+zAWFadJAMHT5aQNcqeMflVY0E2hFFOeIBzmir6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj7Di1nj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj7Di1nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B62C4CEE5;
	Sat, 15 Mar 2025 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742079758;
	bh=8XxuyM3rSXd31IYIv534Hq8h4Bllxjj9SAfhpY0z5zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj7Di1njZVjpy/0Z52Tb50Gk3d6lh4HTnDSUTCsGBYIs1wS6mKBiWq96kFuJUFw0p
	 yGblIEs1YuxFZkW0isR0z6Lgu4m0+XyYM639dyGvwzvVXGz80ny3yPAARlcpESzzen
	 P+RKfVlW2Qn/filHuFtMeg/2MjgfFso2dpnrf+gjwVij0yrwBlHbvVsIpW1ISpdA/j
	 iUfazW87RiSB3UEpLWUqTesR2F7UlQGQwbYbs8pxQB65L5ofbeukzbnVOY9ni7PARm
	 ZgQ0SHiOT1cLht/iB3jbrcQJNWvo46UoNo/uoUHeiJBkDYeda+WoxQFqjy2GIdE8Iq
	 GGQjIIks1wvEA==
Date: Sat, 15 Mar 2025 16:02:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in
 the build
Message-ID: <Z9YHCzINiu4uBQ8B@google.com>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
 <Z9M9-YhDJg3NgiUy@x1>
 <Z9NEX3j_1RUvaFI0@x1>
 <Z9PCjQ8PhOadVGQ8@google.com>
 <Z9RjHpEJGWtj8PAM@x1>
 <Z9Rm0W6YLpxKIcI1@x1>
 <Z9SWDGsdgagMr8PV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9SWDGsdgagMr8PV@x1>

On Fri, Mar 14, 2025 at 05:48:12PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 14, 2025 at 02:26:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > it finds the pair, but then its sc->args has a bogus pointer... I'll see
> > where this isn't being initialized...
> 
> Breakpoint 4, trace__find_usable_bpf_prog_entry (trace=0x7fffffffa510, sc=0x1046f10) at builtin-trace.c:3874
> 3874			bool is_candidate = false;
> (gdb) n
> 3876			if (pair == NULL || pair == sc ||
> (gdb) p pair
> $7 = (struct syscall *) 0x1083c50
> (gdb) p pair->name
> $8 = 0x81478e "accept4"
> (gdb) n
> 3877			    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
> (gdb) p i
> $9 = 1
> (gdb) n
> 3876			if (pair == NULL || pair == sc ||
> (gdb) n
> 3880			printf("sc=%p\n", sc); fflush(stdout);
> (gdb) n
> sc=0x1046f10
> 3881			printf("sc->name=%p\n", sc->name); fflush(stdout);
> (gdb) n
> sc->name=0x6c66202c786c3830
> 3882			printf("sc->nr_args=%d, sc->args=%p\n", sc->nr_args, sc->args); fflush(stdout);
> (gdb) p sc->nr_args
> $10 = 1935635045
> (gdb) p sc->args
> $11 = (struct tep_format_field *) 0x257830203a6e656c
> (gdb) p *sc
> $12 = {e_machine = 540697702, id = 807761968, tp_format = 0x657075202c786c38, nr_args = 1935635045, args_size = 1634427759, bpf_prog = {sys_enter = 0x257830203a726464, 
>     sys_exit = 0x7075202c786c3830}, is_exit = 101, is_open = 101, nonexistent = 114, use_btf = 95, args = 0x257830203a6e656c, 
>   name = 0x6c66202c786c3830 <error: Cannot access memory at address 0x6c66202c786c3830>, fmt = 0x257830203a736761, arg_fmt = 0x786c3830}
> (gdb) 
> 
> Ok, ran out of time, but if I simple avoid the second loop in:
> 
> static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_machine)
> 
> 
> I.e. the one that starts with:
> 
>         /*
>          * Now lets do a second pass looking for enabled syscalls without
>          * an augmenter that have a signature that is a superset of another
>          * syscall with an augmenter so that we can auto-reuse it.
> 
> This:
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e0434f7dc67cb988..3664bb512c70cabf 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3989,6 +3989,8 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
>                         goto out;
>         }
>  
> +       return 0;
> +
>         /*
>          * Now lets do a second pass looking for enabled syscalls without
>          * an augmenter that have a signature that is a superset of another
> ⬢ [acme@toolbox perf-tools-next]$ 
> 
> 
> Then all works, we don't reuse any BPF program, but then that is an
> heuristic anyway, that is tried becuase landlock_add_rule has a pointer
> argument:
> 
> root@number:~# perf trace -e landlock_add_rule perf test -w landlock
>      0.000 ( 0.003 ms): perf/71034 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7fff6f2bb550, flags: 45) = -1 EINVAL (Invalid argument)
>      0.004 ( 0.001 ms): perf/71034 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7fff6f2bb540, flags: 45) = -1 EINVAL (Invalid argument)
> root@number:~# perf test enum
> 105: perf trace enum augmentation tests                              : Ok
> root@number:~#
> 
> So its some sort of syncronization on the various new tables, sorted by
> name, etc that then when iterating over the syscalls ends up using a sc
> that is not initialized.

Right, I've realized that calling trace__syscall_info() can invalidate
the existing sc since it calls trace__find_syscall() which reallocates
and resorts the syscall table.  That's why it was ok when no filter was
used since it'd allocate the whole table in the first pass.  Otherwise
it looks for a pair syscall while holding the original sc but calling
the function would invalidate the sc.

What about this (on top of my earlier fix)?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 49199d753b7cafbf..da0ddc713e6b35da 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2506,10 +2506,12 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	};
 	struct syscall *sc, *tmp;
 
-	sc = bsearch(&key, trace->syscalls.table, trace->syscalls.table_size,
-		     sizeof(struct syscall), syscall__cmp);
-	if (sc)
-		return sc;
+	if (trace->syscalls.table) {
+		sc = bsearch(&key, trace->syscalls.table, trace->syscalls.table_size,
+			     sizeof(struct syscall), syscall__cmp);
+		if (sc)
+			return sc;
+	}
 
 	tmp = reallocarray(trace->syscalls.table, trace->syscalls.table_size + 1,
 			   sizeof(struct syscall));
@@ -3855,6 +3857,10 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
+	int orig_id = sc->id;
+	const char *orig_name = sc->name;
+	int e_machine = sc->e_machine;
+	struct tep_format_field *args = sc->args;
 	struct tep_format_field *field, *candidate_field;
 	/*
 	 * We're only interested in syscalls that have a pointer:
@@ -3866,18 +3872,19 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 
 	return NULL;
 
+	/* calling trace__syscall_info() may invalidate 'sc' */
 try_to_find_pair:
-	for (int i = 0, num_idx = syscalltbl__num_idx(sc->e_machine); i < num_idx; ++i) {
-		int id = syscalltbl__id_at_idx(sc->e_machine, i);
-		struct syscall *pair = trace__syscall_info(trace, NULL, sc->e_machine, id);
+	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
+		int id = syscalltbl__id_at_idx(e_machine, i);
+		struct syscall *pair = trace__syscall_info(trace, NULL, e_machine, id);
 		struct bpf_program *pair_prog;
 		bool is_candidate = false;
 
-		if (pair == NULL || pair == sc ||
+		if (pair == NULL || pair->id == orig_id ||
 		    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
 			continue;
 
-		for (field = sc->args, candidate_field = pair->args;
+		for (field = args, candidate_field = pair->args;
 		     field && candidate_field; field = field->next, candidate_field = candidate_field->next) {
 			bool is_pointer = field->flags & TEP_FIELD_IS_POINTER,
 			     candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
@@ -3944,7 +3951,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 				goto next_candidate;
 		}
 
-		pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s\"\n", pair->name, sc->name);
+		pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s\"\n", pair->name, orig_name);
 		return pair_prog;
 	next_candidate:
 		continue;
@@ -4041,6 +4048,11 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
 		if (pair_prog == NULL)
 			continue;
 
+		/*
+		 * Get syscall info again as find usable entry above might
+		 * modify the syscall table and shuffle it.
+		 */
+		sc = trace__syscall_info(trace, NULL, e_machine, key);
 		sc->bpf_prog.sys_enter = pair_prog;
 
 		/*

