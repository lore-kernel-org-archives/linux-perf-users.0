Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512F1E871;
	Fri, 14 Mar 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985295; cv=none; b=Jj8PQSdNQhPf1k2WjyZd7WTClR6DVbagUV4dKq+WsLag5PN479/b5TZ7HZd3LrQ3hJ7g5tSnhFPbpBL9glqTqaAZvmEYQ5ukls1r7JKnxKOBNx5kgFloA1kznn2UD9te1Mzc6gdvKlkZu6eW2D9As/wkEVWOt4AHt1PhkmRH0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985295; c=relaxed/simple;
	bh=QZITLRQh5Pilrk+i/O0RCZEME5s/otaVmwmlBiRuMuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnLn0QdN+7AG9UXtmCJh2lgjbWrTCW4tGRSoTavL5ufJAF9XCg09TOnxwTRfO8cuXiIXyv5QjoSyPiMTl/9to/Cz5mNhgsv6xMHi+Q+w03MiSK3JBSWVjlDLvHMqGK+qBfp5VHpvnB8o0/jRD/KbK/YTdLlDrDGTSMSt7CV/G/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3Ixpg0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3Ixpg0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6662EC4CEE3;
	Fri, 14 Mar 2025 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741985294;
	bh=QZITLRQh5Pilrk+i/O0RCZEME5s/otaVmwmlBiRuMuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3Ixpg0HJRCUFTfxE27Wt1rf8UBwz/oBrqEwQ9TeF9/iO30PlBJ8WNVSSD5qv5EqV
	 0QZowG9NQuNgXghNkjEX/Tx//JTcWhTB+KMh7ybKLX5Td2nN+NXi3lYZEhzxwVPsXr
	 CBZvSaTK2r4/M/SSF53bjnEDUhx9cygiadLNhksopMJag21XS1RvvDrHOOiyQvC4q3
	 KzpDNpGOq86V8Bs8t/v0iom/0v/rp39B2r7cXw8M5qtlRboDqOAiyuruu8z1dCjK62
	 g33yb3zw2Yj9QIlS8v0fOot5OPXhLXXBjoIA7/RltVeW6qxvels5qW8AGtYIxV/Lww
	 tropxqqdJRitQ==
Date: Fri, 14 Mar 2025 17:48:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
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
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in
 the build
Message-ID: <Z9SWDGsdgagMr8PV@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
 <Z9M9-YhDJg3NgiUy@x1>
 <Z9NEX3j_1RUvaFI0@x1>
 <Z9PCjQ8PhOadVGQ8@google.com>
 <Z9RjHpEJGWtj8PAM@x1>
 <Z9Rm0W6YLpxKIcI1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9Rm0W6YLpxKIcI1@x1>

On Fri, Mar 14, 2025 at 02:26:41PM -0300, Arnaldo Carvalho de Melo wrote:
> it finds the pair, but then its sc->args has a bogus pointer... I'll see
> where this isn't being initialized...

Breakpoint 4, trace__find_usable_bpf_prog_entry (trace=0x7fffffffa510, sc=0x1046f10) at builtin-trace.c:3874
3874			bool is_candidate = false;
(gdb) n
3876			if (pair == NULL || pair == sc ||
(gdb) p pair
$7 = (struct syscall *) 0x1083c50
(gdb) p pair->name
$8 = 0x81478e "accept4"
(gdb) n
3877			    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
(gdb) p i
$9 = 1
(gdb) n
3876			if (pair == NULL || pair == sc ||
(gdb) n
3880			printf("sc=%p\n", sc); fflush(stdout);
(gdb) n
sc=0x1046f10
3881			printf("sc->name=%p\n", sc->name); fflush(stdout);
(gdb) n
sc->name=0x6c66202c786c3830
3882			printf("sc->nr_args=%d, sc->args=%p\n", sc->nr_args, sc->args); fflush(stdout);
(gdb) p sc->nr_args
$10 = 1935635045
(gdb) p sc->args
$11 = (struct tep_format_field *) 0x257830203a6e656c
(gdb) p *sc
$12 = {e_machine = 540697702, id = 807761968, tp_format = 0x657075202c786c38, nr_args = 1935635045, args_size = 1634427759, bpf_prog = {sys_enter = 0x257830203a726464, 
    sys_exit = 0x7075202c786c3830}, is_exit = 101, is_open = 101, nonexistent = 114, use_btf = 95, args = 0x257830203a6e656c, 
  name = 0x6c66202c786c3830 <error: Cannot access memory at address 0x6c66202c786c3830>, fmt = 0x257830203a736761, arg_fmt = 0x786c3830}
(gdb) 

Ok, ran out of time, but if I simple avoid the second loop in:

static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_machine)


I.e. the one that starts with:

        /*
         * Now lets do a second pass looking for enabled syscalls without
         * an augmenter that have a signature that is a superset of another
         * syscall with an augmenter so that we can auto-reuse it.

This:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e0434f7dc67cb988..3664bb512c70cabf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3989,6 +3989,8 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
                        goto out;
        }
 
+       return 0;
+
        /*
         * Now lets do a second pass looking for enabled syscalls without
         * an augmenter that have a signature that is a superset of another
⬢ [acme@toolbox perf-tools-next]$ 


Then all works, we don't reuse any BPF program, but then that is an
heuristic anyway, that is tried becuase landlock_add_rule has a pointer
argument:

root@number:~# perf trace -e landlock_add_rule perf test -w landlock
     0.000 ( 0.003 ms): perf/71034 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7fff6f2bb550, flags: 45) = -1 EINVAL (Invalid argument)
     0.004 ( 0.001 ms): perf/71034 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7fff6f2bb540, flags: 45) = -1 EINVAL (Invalid argument)
root@number:~# perf test enum
105: perf trace enum augmentation tests                              : Ok
root@number:~#

So its some sort of syncronization on the various new tables, sorted by
name, etc that then when iterating over the syscalls ends up using a sc
that is not initialized.

- Arnaldo
