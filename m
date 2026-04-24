Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757832CCB9
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051802; cv=none; b=iszC1F8hukg970JOP19XSGVCakWP3s8YFhWUoRlRQn6kyWCYTmMATmbPCQzaFbGjG0H7qO9YqDkc7iGl/nMi6WK5I/bQp00w16UwXNEyEILsJTK06R4EyJ6JgBca+H5/hDGQHSGAipuPBhuj2NffcWtEBvv4eTI2irz11RfcYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051802; c=relaxed/simple;
	bh=zDHdL19FTbvmz0vIjimIXZVWmdpjFoEnRbvisRLUS7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9Rm/k0vrbdYyfU/C57Vxq2SFXS1O3b/+OnLiMRjiCIdQJKy2sv3S7NsVbnQrZB1kXqV+IffQ3vy8z2yG3ttgtkjVwVS2CsbXpgrC19T0F1pDlsl/G6b3+pOhtnP+ed12HpZ9Cn1/xlRZE1wEAlg8MQd5o0Qlc1KPSgU8R8kPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuUw4+eC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuUw4+eC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9B0C2BCB2;
	Fri, 24 Apr 2026 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051802;
	bh=zDHdL19FTbvmz0vIjimIXZVWmdpjFoEnRbvisRLUS7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nuUw4+eC3BcGfHBbUoRilmZMb4s2ApBx88bps5fO2JjVqSUr46ORFil64JDTUD2cm
	 zfZYvseF4nfHgc0xT2MKIz0qcojsiXftPwYBvTI0HUKrX8jb6A03pxHwwrQ40TKn30
	 Bh3r+D6Qlkuaoh69hSVJMpILwFCI1+4s9Rs6cJa5xI2MPDGFyFcGymIKELDw3jrGum
	 QuevE/zUj92yI99VhtnLdWJULZHCIET+5//5WHA/ZjRCcQk6pulq95AVZ+250MLLMZ
	 WtqX0IhTQdTHuijIdGfe/QR6NgkKeiurZNdZPkj7ZcB/yutb2+vPPwOXAzYgC5t5Jt
	 c0v1nAcprbqJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 46/58] perf task-analyzer: Port task-analyzer to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-47-irogers@google.com>
References: <20260424164721.2229025-47-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:30:01 +0000
Message-Id: <20260424173001.EA9B0C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Guaranteed crash in file mode due to invalid attribute access on p=
erf.thread
- [High] Unbounded memory leak in live mode due to forever-growing TID dict=
ionary
- [Medium] Incomplete implementation of summary features causing functional=
 regression
- [Medium] Unhandled KeyError on invalid color name crashes the script
--

commit 8267c099d8f1d79e0b7b0dc86b79b9bad42e67cc
Author: Ian Rogers <irogers@google.com>

perf task-analyzer: Port task-analyzer to use python module

This commit ports the task-analyzer tool to use the perf python module and
refactors it to use a class-based architecture. It also introduces support
for both file mode and live mode analysis.

> diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-=
analyzer.py
> new file mode 100755
> index 00000000000000..5894ed0b5a402c
> --- /dev/null
> +++ b/tools/perf/python/task-analyzer.py
[ ... ]
> +    def _print_task_finish(self, task: Task) -> None:
[ ... ]
> +        if str(task.tid) in self.args.highlight_tasks_map:
> +            c_row_set =3D TaskAnalyzer._COLORS[self.args.highlight_tasks=
_map[str(task.tid)]]
> +            c_row_reset =3D TaskAnalyzer._COLORS["reset"]
> +        if task.comm in self.args.highlight_tasks_map:
> +            c_row_set =3D TaskAnalyzer._COLORS[self.args.highlight_tasks=
_map[task.comm]]
> +            c_row_reset =3D TaskAnalyzer._COLORS["reset"]

What happens if a user passes an invalid color name via the highlight-tasks
argument? It looks like this dictionary access could raise a KeyError and
abort the script when the targeted task context switches.

[ ... ]
> +    def _record_by_tid(self, task: Task) -> None:
> +        tid =3D task.tid
> +        if tid not in self.db["tid"]:
> +            self.db["tid"][tid] =3D []
> +        self.db["tid"][tid].append(task)
> +        self.db["tid"][tid] =3D self._record_cleanup(self.db["tid"][tid])

Will self.db["tid"] grow indefinitely in live mode?

While _record_cleanup caps the list size for each active TID, it appears
inactive TIDs are never removed from the dictionary itself. This could leak
memory continuously over long monitoring sessions as new transient processes
are created and destroyed.

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
[ ... ]
> +        # Task finish for previous task
> +        if self.session:
> +            prev_tgid =3D self.session.process(prev_pid).pid  # type: ig=
nore
> +        else:
> +            prev_tgid =3D prev_pid # Fallback
> +        self._handle_task_finish(prev_pid, common_cpu, time_ns, prev_tgi=
d)

Is the pid attribute available on the thread object returned by
self.session.process?

The python perf bindings for threads generally only expose a comm method. If
pid is missing, this could raise an AttributeError on the first event.
Additionally, might self.session.process raise a TypeError if the thread
cannot be found, causing the event processing loop to unexpectedly exit?

[ ... ]
> +    def print_summary(self) -> None:
[ ... ]
> +        # Simplified summary logic for brevity, full logic can be ported=
 if needed
> +        print("\nSummary (Simplified)", file=3Dself.fd_sum)
> +        if self.args.summary_extended:
> +            print("Inter Task Times", file=3Dself.fd_sum)
> +        # ... port full Summary class logic here ...

Does this leave the summary features functionally incomplete? Users passing
arguments like --summary or --summary-extended might be expecting the fully
calculated metric tables rather than just the printed headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D46
