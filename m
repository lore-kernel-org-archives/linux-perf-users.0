Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCA33E355
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022795; cv=none; b=QIFmVHPnVmn/UylJNbGjq1CxU1uwswLhIWzZAYnVKSxC8oVF/xftR+DHMitwHMPhGwKoYjoBL0bQCF0ngKu8UQL+8wFg/aYUtnbFdT/Lfzzfn9ncJZgbxK5yBRrWu6AJHenakBCE2mpI33TiKin7Hhjo1fTQZAymaymPEwkp+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022795; c=relaxed/simple;
	bh=xkP/bctLelZFKuWMmzc1els3n2wcJs5hYHDpw0Zslgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KOQoo5x6PTQ1uFn9sfU2/UMG9i5ln/x9mcBjPDlUv0hM2GEpL9dJm0Vc9Io3MB4cI5a3rJ6gUhAbTDM77R1HBxEKewDBD/DfbDPdW5C/rSJ2sOzCgVNwyvWkgiQ2BqS4qXLJCb15v6N84WnkexNFi+5jabJJ7o7Z0ge+2mDa98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPsC8EPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPsC8EPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AE51F000E9;
	Thu,  2 Jul 2026 20:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022794;
	bh=DcLMRn9xg/hh6BTLN/dhJMs7Tg+q286eB5EmN4htkoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPsC8EPUhCGIyrbkQTZNqG0T2oGANx5Xc2lGKXFAcrweXiyuMrS5Ka0wJYWFFC7Yq
	 yTykUhPLUz920vO3LVbKS3hgqxoYrnyrlMpwhqRH0R6S9ZMULZ5pwba9zwJGn00EUw
	 EFhfYYtoR6X8LXwfjOBx3CMqiMR0B4f8dUmbTX3sANDMb/ARypp9TbCzau6TjBlpcZ
	 03gYpYJ0uWlKDSDWvQt1Y7S8w79sLFxQiy68uFJ6U9Yr+pai43YiSats/ZqgLkG7S6
	 usuanXqZQPmvRPaOTNIRBici05iw5lQq3cX2X2GzojqNj+I9Ckk00N3nuawQQJef05
	 RMEKnH+S9T9KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/9] perf cs-etm: Flush thread stacks after decoder
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-6-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
 <20260702-b4-arm_cs_callchain_support_v1-v11-6-846abbf600d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 20:06:33 +0000
Message-Id: <20260702200634.10AE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] cs_etm__flush_all_stack() explicitly skips flushing thread stack=
s when the trace PID format is CS_ETM_PIDFMT_NONE.
- [Medium] Globally flushing all thread stacks on a per-queue decoder reset=
 indiscriminately destroys valid callchains for unrelated threads on other =
CPUs.
--

commit 2fc83ea7678b445a0b66d5aa7740246139b71821
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Flush thread stacks after decoder reset

Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
causing global trace discontinuity. This patch flushes all host (and
guest) thread stacks after a decoder reset to prevent stale call/return
histories from being attached to threads that are decoded later.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ba9ffb7bdb4bd..996317687ce7b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> +static int cs_etm__flush_stack_cb(struct thread *thread,
> +				  void *data __maybe_unused)
> +{
> +	thread_stack__flush(thread);
> +	return 0;
> +}
> +
> +static void cs_etm__flush_machine_stack(struct cs_etm_queue *etmq, pid_t=
 pid)
> +{
> +	struct machine *machine;
> +
> +	machine =3D machines__find(&etmq->etm->session->machines, pid);
> +	if (machine)
> +		machine__for_each_thread(machine, cs_etm__flush_stack_cb, NULL);

[Severity: Medium]
Does this globally flush the stacks for all threads in the machine, even
those executing on other CPUs?

Since the decoder reset triggered in cs_etm__get_data_block() happens
per-queue (per-CPU) when it hits a buffer discontinuity, wiping the stack
for all threads indiscriminately might destroy the valid, continuous branch
stacks of threads executing on unrelated CPUs.

Should this flush be limited only to the threads actively traced by the
queue undergoing the reset?

> +}
> +
> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
> +{
> +	enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
> +
> +	if (!etmq->etm->synth_opts.last_branch)
> +		return;
> +
> +	switch (pid_fmt) {
> +	case CS_ETM_PIDFMT_CTXTID2:
> +		/* Clear the guest stack if virtualization is supported */
> +		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
> +		fallthrough;
> +	case CS_ETM_PIDFMT_CTXTID:
> +		cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
> +		break;
> +	case CS_ETM_PIDFMT_NONE:
> +	default:
> +		break;

[Severity: Medium]
When tracing without hardware context IDs or in per-thread mode, pid_fmt
evaluates to CS_ETM_PIDFMT_NONE.

By explicitly breaking here, doesn't this skip the flush entirely for these
traces? It seems this would leave the stale call and return histories intact
for those workloads, skipping the exact fix this patch intends to apply.

> +
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-b4-arm_cs_=
callchain_support_v1-v11-0-846abbf600d7@arm.com?part=3D6
