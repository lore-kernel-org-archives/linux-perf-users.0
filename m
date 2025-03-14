Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E63BBE5;
	Fri, 14 Mar 2025 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931152; cv=none; b=Rlo0JVpe22H93V6pzue26Hj83uqNE9mqWM7PJvkPeDUVT16p9BRh5GIeErYC/xI/lQj7UOK1pQ1Cw7tcA+kSelLxLeryxoHu5ip6fVT7bmfXXLnXmGbw0Y5dRznzuB/BNcVkOsjE2AQu+VN2i25bTpgZBNBgGMWQmeGJ0S+QhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931152; c=relaxed/simple;
	bh=UIHoxzhPf3e+N6sft1joYHuPe2ZldXQM7xaEMHF8UQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsR8uvDzKbH/wMp0Y8yng2CE5ypPoHEl89mlkBhCb4MR0ULu2xj6Z8yEllph2bPSBzkuiY2/qNmJg/69EXzQIP1X9XGiT6hU7F5dYYzSACYq8VpyXmxppeAloNTPOs3QMP51bPpXAi8iPYyQhPVPp1Q+6uEsdwvSmSwfERslhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9V5wLKv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9V5wLKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40296C4CEE3;
	Fri, 14 Mar 2025 05:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741931152;
	bh=UIHoxzhPf3e+N6sft1joYHuPe2ZldXQM7xaEMHF8UQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9V5wLKvvzdYnmDpHxzPOfq0AxNt5QiDf5RPSpD1Z9RQFIFrZI9gA6Ga/OC4vbrhF
	 zyDAK/ALK3zLwiZA6+/Q21+00Jl+xwDMvnbK9EKGk9+vsSta0y8nKGItKJlqK8TFK8
	 Zmt6h+ElRvf3Xdm+rk+dFeLAJn4QCe7tdd5Bcs7zqnaInu6fdUEwMmqvuSl7jzpzlk
	 y0LjtBD7LCjdJeUA0wCptEUIDygjsTNjui4I1ClM50r1tz72lQWQx5jEp6mYfhYszs
	 K0h3QOuxoRTchgjOR1QZXwOpfJDwG7nh3cJRlxEKdJeH0c8hGd77+eWDt9B5y6qNkZ
	 XKaU59OZuTVUg==
Date: Thu, 13 Mar 2025 22:45:49 -0700
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
Message-ID: <Z9PCjQ8PhOadVGQ8@google.com>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
 <Z9M24AJzui9lFbGo@x1>
 <Z9M9-YhDJg3NgiUy@x1>
 <Z9NEX3j_1RUvaFI0@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9NEX3j_1RUvaFI0@x1>

On Thu, Mar 13, 2025 at 05:47:27PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Mar 13, 2025 at 05:20:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > Still building, but noticed this on x86_64:
> > 
> > 105: perf trace enum augmentation tests                              : FAILED!
> > 106: perf trace BTF general tests                                    : FAILED!
> > 107: perf trace exit race                                            : Ok
> > 108: perf trace record and replay                                    : FAILED!
> > 
> > 
> > The first doesn´t help that much with verbose mode, haven't checked if
> > before this series it was failing :-\
> > 
> > root@x1:~# perf test -vvv 105
> > 105: perf trace enum augmentation tests:
> > --- start ---
> > test child forked, pid 19411
> > Checking if vmlinux exists
> > Tracing syscall landlock_add_rule
> > ---- end(-1) ----
> > 105: perf trace enum augmentation tests                              : FAILED!
> > root@x1:~#
> 
> So:
> 
> root@x1:~# perf trace -e landlock_add_rule perf test -w landlock
> root@x1:~# 
> 
> But:
> 
> root@x1:~# perf trace perf test -w landlock |& grep landlock_add_rule
>     26.120 ( 0.002 ms): perf/19791 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffde75e2680, flags: 45) = -1 EINVAL (Invalid argument)
>     26.124 ( 0.001 ms): perf/19791 landlock_add_rule(ruleset_fd: 11, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffde75e2690, flags: 45) = -1 EINVAL (Invalid argument)
> root@x1:~# 
> 
> -e is having some trouble, when no event is specified, then it works.
> 
> Something in the changes made to:
> 
> static int trace__parse_events_option(const struct option *opt, const char *str,
>                                       int unset __maybe_unused)

Thanks for the test, I think this should fix it:

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index ace66e69c1bcde1e..67a8ec10e9e4bc8d 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -76,7 +76,7 @@ int syscalltbl__id(int e_machine, const char *name)
 {
        const struct syscalltbl *table = find_table(e_machine);
        struct syscall_cmp_key key;
-       const int *id;
+       const uint16_t *id;
 
        if (!table)
                return -1;

