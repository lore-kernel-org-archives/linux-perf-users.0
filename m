Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703989;
	b=bNdMvKxqJTuyk2Nya9piifAdW3nzG/f43X/hCfoMyMoWrTmw5zDISog7qAYHYO7+CLT6
	 9RXlDL0xeIIiojJpcSS2GaccrphYqy2cjOJiXvGYcFpl7X+YrUXoAATkOLve8J5uYfRmk
	 kwSm9NnQUDCXiJ1DR2tGoDFp5bfuiRSUSVclquKvUw1K9KQDIUJlwk/xbs3eirZkpoH3T
	 Y4cPDBATL4RmFwE+3dRIXrPlAl+5WWOYbIhIpru29eMa8mlDIy2aS2FZ6lDN8Dju68rnH
	 gjxTUXz4ABXnPkl9kv82cLJP5I3TtVlo6NteC8XvmZ16LuMffyB1CeonVQGNpcAlFwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fQyjPvF7cDpWDJ78X60k+h9fSxuc9J2WK3AD4e1wegA=;
	b=TfQ+IsYtQuFs4ZNIddUFVESfdL3PCjURl26oOQmqP4Klr2HAw6zzVhcQPYFQHEWzPoAs
	 KfSTmFGYBuUQPhpSR0cMfOcE5ecanvRC8+DhxTkaJpxF+VWlSbuqOE7C4CGBeD//n/sJz
	 7yZY2Ye0aZqGsd3MxRAEu2jj0tIeiH5laVdPqGZjk38TIJxkX/hDcbzCM0zSRmxAvgjrS
	 aZURJQb+v8Iz//fEbjEFGarlTteYK/XFavjgkdqoGYkiJkssruMUK8dbkBmkF3k1Gvm9u
	 apVQtBFRI30mStxH+xnlVud05smA6wJafSnGDYiC15tM4dPQQB9UkGTmmqRz0+EESkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V7/7Wt4c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53824606A329
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7/7Wt4c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DADE1F000C4;
	Sun, 15 Nov 2026 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703988;
	bh=fQyjPvF7cDpWDJ78X60k+h9fSxuc9J2WK3AD4e1wegA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7/7Wt4cG8MPqLNMGe8jEWtBNnkXXzbwCo9lfCBk6q0/wP6WxafEiLrBUSOfDANCX
	 NFlLmwXeXJxZb8o0eAnvsnCzPpNYN7F8TCCISIU5vY4GpVrD1Wg5VRsFxAW8CB1JRO
	 JmQD1rxY/bAj9Rq44WKFuMr3lQgX6Bfa2x2dZyXKi4ZElhdnsh+6VN0Zefx/7mANZl
	 B2bDKs7/j4rmTvPspiiRllm5S3y4Y42hTOZTMZ8/ZOGumzWG7IgLZjVMP8LPVfj9Xg
	 /k4SLsEKnUXa4jYjAtVelb+pl7h8abOz5nVuHvYy8Tvl6d9UKDgragCZRHHKSXJ+n5
	 fG7doOWcDkRTg==
Message-ID: <sashiko-outbox-215158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf python: Add perfetto script to open profiles
 in the Perfetto UI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lalit Maganti" <lalitmaganti@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115003916.1873857-4-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
 <20261115003916.1873857-4-lalitmaganti@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:53:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf python: NO_ID sentinel mismatch in process_sample()
  causes ValueError
--

commit cffb2c3ec0bc0ef022e32f9177d74617f3f52e47
Author: Lalit Maganti <lalitmaganti@gmail.com>

perf python: Add perfetto script to open profiles in the Perfetto UI

This commit adds a Python script that converts samples in a perf.data file
to a Perfetto trace and serves it to the Perfetto UI, along with a shell
test for the conversion.

> diff --git a/tools/perf/python/perfetto.py b/tools/perf/python/perfetto.py
> new file mode 100755
> index 0000000000000..e168b146e5385
> --- /dev/null
> +++ b/tools/perf/python/perfetto.py
> @@ -0,0 +1,625 @@

[ ... ]

> +# perf reports these when the sample type lacks PERF_SAMPLE_CPU/TID/TIME.
> +NO_CPU =3D 0xffffffff
> +NO_ID =3D 0xffffffff
> +NO_TIME =3D 0xffffffffffffffff

[ ... ]

> +    def process_sample(self, sample: perf.sample_event) -> None:
> +        """Writes a perf sample as a StackSample packet."""
> +        if sample.sample_time =3D=3D NO_TIME:
> +            self.nr_skipped +=3D 1
> +            return
> +        self.nr_samples +=3D 1
> +        event =3D str(sample.evsel)
> +        if event.startswith('evsel(') and event.endswith(')'):
> +            event =3D event[len('evsel('):-1]
> +        seq =3D self._sequence(event, sample.sample_time)
> +
> +        stack_sample =3D b''
> +        pid, tid =3D sample.sample_pid, sample.sample_tid
> +        if NO_ID not in (pid, tid):
> +            self._update_names(pid, tid)
> +            stack_sample +=3D varint_field(StackSampleField.TASK_CONTEXT=
_IID, seq.task(pid, tid))

[Severity: Medium]
Does checking NO_ID (0xffffffff) against sample_pid and sample_tid miss
samples without a valid PID or TID and raise a ValueError in varint()?

Unlike sample_cpu (T_UINT), the C binding exposes sample_pid and
sample_tid as signed T_INT:

tools/perf/util/python.c:
	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \

When a sample is recorded without PERF_SAMPLE_TID or for a task with no
PID in the event namespace, sample_pid and sample_tid are -1 rather than
0xffffffff.  That passes the NO_ID check and reaches seq.task() ->
varint_field() -> varint(-1), where out.append(-1) raises ValueError and
aborts the trace conversion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115003916.1873=
857-1-lalitmaganti@gmail.com?part=3D3
