Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317354;
	b=r7UOg4sEqoPxmNYliZPDjyjy/Jz1h9yUXrK6oKhaWTdypnrbb4g60PLmKb0qYMnueIJZ
	 rjbyWYsnc5ECi/oZjptb1/TdeiXpJVvsTeUdaZ2+Q53KzC94Keff8XNg++tYDuDa3q1/J
	 fnP4wk3c5n/SSUykfhhPtx/LgxtiZ96Ul/Tt4zGgddn93xhyRD7HyRysi1DOibqv5a4mg
	 lPAGarSagasd3XHhd1UsCVfSk/hpoUihNhLGZjyCBlFYPzf7qzGEo8BSPxHoimbIJgi34
	 ePTIG9bWXwXXvIqQI6d2SgJU6b0ItGdk0p+Imu3Ak/f3qUBw5/LZQShwL45DGQfEhEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8EOHQ6bqhHyyE0qPiNc9RKtAxXxJjsPL21iIBd1KUmk=;
	b=zZceqplVBzh95KszN+mDoP+zpjRVFvNOQwGRpVGpNmyF0oHX38f8W9F4S8ytbW9g/94b
	 ieO5AsA/8OfCS1jMJ/f33yYyuC34QXbtYJztX77rUgt6sr5juEGvjYel2YGeN8pt8HJkm
	 kDXhF14co+miBP9vnRNCGVIIz+xEnU7JAVenwuWW8jA3elxv7dw5aW+INLnA2TijhdCmG
	 i/5ch1IJykokj2X5YCMmVOqAxqtFUG+076nTUzSAiQ27Y1meeRoqodENMg89GQXnP8pSn
	 fkubE5atvufPzSa44TU8uWXZTdepCO+Um7ft9+fq3W48PIAt1UTKcIisatdOvN4uHSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kZc/3H98";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A997606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZc/3H98
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE821F000C1;
	Thu, 29 Oct 2026 23:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793317354;
	bh=8EOHQ6bqhHyyE0qPiNc9RKtAxXxJjsPL21iIBd1KUmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZc/3H98PaBiTEQXF3t3xY2nG+ua4Psk/6TqjuhnbAXuwdA7CoPSj6rKW+soSCH3o
	 SOeLRZkgHV2gDnp5pFgeTyr5mHZtZ67Yo9f/Q5VvoNpmw3uXiF3jXPGLI1dIJFetWC
	 HPDn6np/4LqmbtqVMUN5B4NL7Q2F+vjeG1cRzH5i8NJ4ANVrEUFnGJOhp+4hCA2Ih9
	 1KVKWP0TvFFHJe8nvaBCLhvaVZh0V0H8ZwO9UeOv/w0Gh9RQZw1mMqgJ/wiYs2ffeG
	 /6zVP4WtShTRoJnHnfl6XPsDAchtdpN5L8bsN9XmzZKj1TxwbB1taeQzrWpX0W/ynA
	 q9IQ2jtwuT1/w==
Message-ID: <sashiko-outbox-190118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: skew perf_mux_hrtimer_handler firing across cpus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Segall" <bsegall@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <xm265wykhyrv.fsf@google.com>
References: <xm265wykhyrv.fsf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 23:42:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: data race on cpc->hrtimer_interval in perf_mux_hrtimer_han=
dler()
--

commit 21db2df032d9ff638545ff8ead07c480ea100710
Author: Benjamin Segall <bsegall@google.com>

perf: skew perf_mux_hrtimer_handler firing across cpus

This commit adds a per-CPU skew offset to perf_mux_hrtimer_handler() when
the mux hrtimer interval changes so that timers across CPUs do not fire at
the same time and contend on jiffies_lock in nohz_full configurations.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..80d142986eba7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1279,6 +1279,7 @@ static enum hrtimer_restart perf_mux_hrtimer_handle=
r(struct hrtimer *hr)
>  {
>  	struct perf_cpu_pmu_context *cpc;
>  	bool rotations;
> +	u64 offset;
> =20
>  	lockdep_assert_irqs_disabled();
> =20
> @@ -1286,6 +1287,17 @@ static enum hrtimer_restart perf_mux_hrtimer_handl=
er(struct hrtimer *hr)
>  	rotations =3D perf_rotate_context(cpc);
> =20
>  	raw_spin_lock(&cpc->hrtimer_lock);
> +	if (cpc->hrtimer_old_interval !=3D cpc->hrtimer_interval) {
> +		/*
> +		 * Skew the timer to avoid contention on jiffies_lock in
> +		 * nohz_full, whenever we change interval
> +		 */
> +		offset =3D cpc->hrtimer_interval;
> +		do_div(offset, num_possible_cpus());
> +		offset *=3D smp_processor_id(); /* we are PINNED_HARD */
> +		hrtimer_set_expires(hr, offset);
> +		cpc->hrtimer_old_interval =3D cpc->hrtimer_interval;
> +	}
>  	if (rotations)
>  		hrtimer_forward_now(hr, cpc->hrtimer_interval);

[Severity: Medium]
Can a concurrent update to cpc->hrtimer_interval from
perf_event_mux_interval_ms_store() race with perf_mux_hrtimer_handler() and
leave the timer with a mismatched skew offset?

In kernel/events/core.c, perf_event_mux_interval_ms_store() updates
cpc->hrtimer_interval across all online CPUs from the sysfs writer CPU
without holding cpc->hrtimer_lock or using WRITE_ONCE():

	for_each_online_cpu(cpu) {
		struct perf_cpu_pmu_context *cpc;
		cpc =3D *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
		cpc->hrtimer_interval =3D ns_to_ktime(NSEC_PER_MSEC * timer);

		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
	}

Meanwhile, perf_mux_hrtimer_handler() reads cpc->hrtimer_interval multiple
times without READ_ONCE() or caching it in a local variable. Between reading
cpc->hrtimer_interval into offset and storing cpc->hrtimer_interval into
cpc->hrtimer_old_interval, calls such as do_div() and smp_processor_id()
(which calls debug_smp_processor_id() out-of-line when preemption debugging
is enabled) allow the compiler to reload cpc->hrtimer_interval from memory.

If perf_event_mux_interval_ms_store() modifies cpc->hrtimer_interval in that
window, offset can be computed from the previous interval while
cpc->hrtimer_old_interval records the newly written interval, preventing
subsequent timer callbacks from recomputing the skew for the new interval
(and potentially tearing the 64-bit ktime_t load on 32-bit architectures).

Should cpc->hrtimer_interval be accessed with WRITE_ONCE() and read once
into a local variable via READ_ONCE() (or updated under cpc->hrtimer_lock)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/xm265wykhyrv.fsf@go=
ogle.com?part=3D1
