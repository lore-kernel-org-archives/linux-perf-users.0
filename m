Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419545;
	b=yiIG11QJUUddfqVzpEI3R6dVNnH6xSrwF3G7kjmDEXkcqFRT8QmRl+Mbu8FitM52WR+s
	 pHlOsPfJkTpwODC1qWE0QhFze4fsNdvNFQ1aVNAgbTo2SPGjmT2RQVOpcqFVKAWL93a/U
	 IJoslWc0DgtjZz+dAu63V0JCv3R/A9vJj4eQMDi6ayFxga9UmNN4ZGEUY2pEvROinsva4
	 YbWHhwDEsPvbbgWRNrKw/O6+jIPlYnmAL1UHVTMmWYjR+J6GnBYaM9drEmkmS41jPyqlS
	 XKXMmu7iUJT1g3HYWbTLTAKOwFVM32eNqWbzp/AbLxmUC1ywXhgaKgN97dEXaZZ/GWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P5+w84baakYMlxmurzGdxKb0ESJofLuo3Amc1fBjJPk=;
	b=N+Ik8mraB5dWVTX6Q8siDgvA4BQNutmqdb1z3Wx/FAZE3EG8jlKZuh4otl1Xw5VdGsGU
	 qh+dVh3bFTtDHyhFl85voaW8L7Y6BQpTjg5WS2pOjLxc/XweH+F08J6PSmWnoP/W+ElkS
	 mgmV25vcsG6JOaPo1fQf1B0z0BWuYkGc00ecvdkAwVeqhEpfbQOeH1zTZaVncLiypPagv
	 kbEQFi1Q1LwUlz24ErNvR2Nhhm2PfYRygTSZXuLrrhdZ5VeuaW4YAs+4kgmh2bpkJNU7R
	 onYyN5/cOrxQ0EdMdqG9xw3BI9zjcpVDQZp4rvka4FQ6/L4fEJ0E/33Nm6c2YilP87g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OZKaU+ZN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB40606A894
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB40606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OZKaU+ZN
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so286171cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794419544; cv=none;
        d=google.com; s=arc-20260327;
        b=V5+3CEGMvXIcKvpkfpIMUr8tYy3wjHTB8+V8RwVz+eeCS9wzVFJgxq4oyxHqI+DFfl
         sTsOeJ9HuECejB1e2HgiMUQ2nx+b5UjmAI8ZblIHNJY9Pis9NBj+r2A7UVATG4V9Gf8U
         RuaoQP2Dn39aXLZMzui+TmkyXnZHpb0LwrpRbf/1ikZH+NHNkjhUSnDEG3AYn/aBPwGC
         BPlH2DDfB2pDVlWd18x2EFdqB8HQPdARt4NccCewvztYtkeQu629Vx+iK6pOowNEfIY2
         F9maIhXSKDsojyuHcFkC1r1KPTOoqj0V2NrfMMjnHeT7RkuVUYqaeUWqrFymjOkNuZiU
         nM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P5+w84baakYMlxmurzGdxKb0ESJofLuo3Amc1fBjJPk=;
        fh=JgECY+u06RBYeF5C9/UFvMuJtlTqiDABoBI9g9+eiB0=;
        b=God20zR5Q9oyQI34M+kDRusH4ic/6EcvXS8YlrNxTDe/lFWk5uFYfCKAQ869+kP8b8
         Jam77s1XdYlbAE59Abs9Jaq+PDa0HT2op0VGKyo/FkpBDn+wLGy+lBgOIqOvNIAgEnYa
         P39ldJgePJOQldLjYpztrr5T9zZOhd0s1duofGYP6iZumgNpbGEgow3Ob6IzLcfI1EqH
         9BQ5xjkDUyGuMy7g3xbzKK2Fg3PCwOWZYF8NvmW9Baskel49tTUwtXfn7SZTM6T/JAMj
         aj391DDSkfrs+n/vJRMFVruFfHn8i2+qhuNrgJIGUzP1vAb42BtOw1NU6pDoC4anPX4W
         /rRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794419543; x=1795024343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P5+w84baakYMlxmurzGdxKb0ESJofLuo3Amc1fBjJPk=;
        b=OZKaU+ZNKD8V/hiFDze4d82Yb/tq8yusA2sng4iE/OEcMDG88cAM6ZG79g42Kl98EG
         EomAVYCWz3HUXAUZHOB6UrRv43iNMAbSykZQcArGfvtUSHCzHwCfbPAdrgJqVH6Odj7A
         0WiOguGfMzAoBfyFT5wC9aGs1pFG70+VN6+Uxr8mGuKDjUr5nq+CHPZN+5YF9KGCTBRL
         TT4N9OCbfGRhyS9Pb/UTow5JMmBFK+Mt+SHk4Gcn3MlzY9hIyWoSsuK7VIZBnkk+r2eW
         3By4oqSQzebEVVhCsT5k5PKIZFcZdgb9ldehvDIOcZHMLZpLzs6H2nunow2cXB46oSg2
         k0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419544; x=1795024344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5+w84baakYMlxmurzGdxKb0ESJofLuo3Amc1fBjJPk=;
        b=GiIFuNVprxqOI9PtVWc+oLfYJaIUryR56CfYelWcIQZdbXMbD8W01ctkkD2C16Dvc2
         NiUfPXKdsPXoW89g/ZQH+CQf08vXseEaAH0tdg37ZdR6nYaW5l5sdE9F3So61dCKz4zI
         HmBY+6kLFKqDnZOQFfiQJIst3Ddqoo5Z4DMlWSZUwzLSQhHP23cke7MCc08Aob1GYT9C
         Csfb7AAfhxA1P813xFnhWtSlzPlATb2v9iLVLD34XFemd50GnXyUVxW5sxBZeQOmURPH
         ldWbhhMrwVOiQoj1RNmXLix6eEsI4i1c+XhIsyMvq2GfShG7QPL8igMIyqtas0SJc656
         bg3g==
X-Forwarded-Encrypted: i=1; AL+hErFURGC3dEFYsS/ohsP/969q3aEe8f1kE+hd1ft1RvClI381Mosjn6uFZzmRDTqJwjvC7ow+hvzbxOGijRSnLVUu@vger.kernel.org
X-Gm-Message-State: APuU4Z8D4DtIJdb/MA79tpjk1XJY+A2UPCX4xYU+fM3SY0xVWOrdBk1g
	2IS7NnePtWmssv7rWBnelpnHGEtdsW1LxdwfonNNCbtcRk9qZGN9ase386qR6D8qH6E7ldfHXwS
	gwEvNzaSPQfxhBFN+qNxfLvVT+cYUlNXjyYq5Yvri
X-Gm-Gg: AYBFou2aOML5XsdxZm9geswTvwzHOFNA7ID54eZuFkFKJ04JXhLxavMuA9hzvVdacQ8
	XXkHk7Ec1ODo6hvnlLw1+AqjGgNmB9izcFbQu+xvX60gqHhlhHH93NDbA0R6NFf0SmMgJbZYI9I
	J3MFH4ZGiMwFHXxbBVzUDPL20KOOpjW8JRmopaLcknpNf7zfztii1DzSY0Wkmq06D+GdGqJhmDR
	cOsZl4K7F8sk7PQyPi3do1YL6AXaAALG/g1PGHwCqebxa/AMq/29YO8LE8ORoX22+9nbVlbUwr9
	Q1B5uO5wohFOwK6DzTVMXDRGLb/HkWd+cPLD4uAIKFaGfFC6U80pj4tHjIlCwlmxfGnqC0+MtUV
	1GyLZqUKXag6gPDoqQeyFkaK5QF2pVuvJe2B7qJuqKdQ1AGVhZFkZdDjpNg==
X-Received: by 2002:a05:622a:4d91:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-5569e71ab9dmr25300801cf.2.1794419542771; Wed, 11 Nov 2026
 09:52:22 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022210753.1851597-1-irogers@google.com> <20261022222245.2064964-1-irogers@google.com>
In-Reply-To: <20261022222245.2064964-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Nov 2026 09:52:11 -0800
X-Gm-Features: AclHuK9DRkfOycmjU6BBrM6wRCKLw_GMvonjO2tOpkb71cEcT3xPaK4tPgJs_wM
Message-ID: <CAP-5=fVgSpx5nS5mXthvyAkjHVJSGGVxr6W0NRB2+ekOUHjx7A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] perf test: Per-test timeouts and JUnit XML schema compliance
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:22=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> This series adds per-test timeout support to 'perf test', improves JUnit
> XML output to validate against strict JUnit schemas, and ensures time
> spent waiting for the shared mlock budget does not count towards a
> test's timeout or reported duration:
>
> 1. Add a per-test timeout (default 120s, configurable via '-t'/'--timeout=
',
>    0 to disable, disabled with '-F'/'--dont-fork'). Forked tests run in
>    their own process groups and the existing polling loops in
>    finish_test() and finish_tests_parallel() check elapsed runtimes,
>    sending SIGTERM on timeout and escalating to SIGKILL after 1 second.
>    Timed out tests are reported as 'TIMEOUT!', listed in the summary,
>    and recorded as '<error message=3D"TIMEOUT" type=3D"timeout">' in JUni=
t
>    XML output.
>
> 2. Update 'perf test -j' output to validate cleanly against both the
>    Apache Ant/Windy Road JUnit schema (JUnit.xsd) and the Jenkins
>    xUnit/Maven Surefire schema (junit-10.xsd), including required
>    '<testsuite>' attributes, '<properties>' from uname, '<system-out/>'
>    and '<system-err/>', self-closing tags, apostrophe escaping, and
>    UTF-8/XML 1.0 codepoint validation.
>
> 3. Record each mlock-serialized test's start time in the shared
>    mlock_budget mapping when it acquires mlock_budget->lock in
>    run_test_case_mlocked(), so tests waiting for the mlock budget do not
>    time out while waiting in line and their reported elapsed time
>    reflects actual execution time.
>
> v6:
>  - Reap finished child tests (invoking kill_timed_out_group()) before
>    draining process.err in finish_test() and finish_tests_parallel(),
>    and skip draining in handle_child_pipe_activity() once a timed out
>    test has finished, so a noisy surviving subprocess cannot block the
>    pipe drain loop before the process group is killed.
>
> v5:
>  - Rebase onto tmp.perf-tools-next (patch 3 of v4 was applied upstream)
>    and add Namhyung's Acked-by to patches 1 and 2.
>  - Add patch 3 so tests waiting on mlock_budget->lock don't time out
>    while waiting.
>  - Increase the default per-test timeout from 60s to 120s. When running
>    the full suite as root (where CAP_IPC_LOCK lifts the mlock limit and
>    mlock_budget is unused), all ~180 non-exclusive tests start
>    simultaneously at t=3D0 and contend heavily on CPUs, /proc scanning,
>    and vmlinux/DWARF symbol resolution. On a 28-CPU hybrid machine, a
>    60s timeout resulted in 33 timeouts across the parallel burst and
>    large sequential suites; increasing the default to 120s allowed
>    longer tests ('kernel lock contention analysis test' at 115.3s,
>    'task-analyzer python test' at 94.7s, 'perf data type profiling
>    tests' at 92.6s, 'perf metrics value validation' at 91.2s, 'perf
>    record tests' at 79.0s, and 'python profiling with jitdump' at 62.7s)
>    to complete, reducing timeouts from 33 to 2 ('perf record LBR tests'
>    and 'perftool-testsuite_report') and overall suite wall-clock time
>    from 503.5s to 363.9s.
>
> v4:
>  - Drop the ITIMER_REAL timer and SIGALRM handler in patch 1, relying on
>    the existing 10ms/100ms polling loops in finish_test() and
>    finish_tests_parallel() to detect timeouts.
>  - Only fall back to kill(pid, sig) when kill(-pid, sig) fails, and
>    ignore SIGTERM/SIGINT while waiting for subprocesses in
>    run_test_child().
>  - Add patch 3 to avoid stack trace noise in verbose=3D1 failure snippets=
.
>
> v3:
>  - Block SIGINT/SIGTERM while a test process may be reaped and until its
>    pid is cleared, and skip already reaped tests in the signal path.
>
> v2:
>  - Reset SIGALRM to SIG_DFL in the forked test child.
>  - Replace the blocking waitpid(-1) loop with a bounded, non-blocking
>    wait that only runs when interrupted by SIGTERM/SIGINT.
>  - Ensure the SIGKILL escalation reaches the whole process group before
>    the zombie is reaped.
>  - Factor out timespec_diff_secs() and TEST_KILL_GRACE_SECS.
>
> Assisted-by: Antigravity:gemini-3.1-pro
>
> Ian Rogers (3):
>   perf test: Add per-test timeout support
>   perf test: Improve JUnit XML schema compliance and completeness
>   perf test: Don't count mlock budget wait time towards test timeout

Ping.

The sashiko reviews are clean:
https://sashiko.dev/#/patchset/20261022222245.2064964-1-irogers@google.com

There's an additional patch for making the mlock waiting time not
count as timeout time:
https://lore.kernel.org/linux-perf-users/20261022222245.2064964-4-irogers@g=
oogle.com/
that is missing any tags.

Thanks,
Ian

>  tools/perf/Documentation/perf-test.txt |  12 +-
>  tools/perf/tests/builtin-test.c        | 662 +++++++++++++++++++------
>  tools/perf/tests/tests.h               |   7 +-
>  3 files changed, 535 insertions(+), 146 deletions(-)
>
> --
> 2.56.0.307.g5fe7bd680c-goog
>
