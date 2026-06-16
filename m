Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE51D7995
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622482; cv=none; b=BVNJO9/S5yjK3mMGF1V5vPIR7I2IOOZBQoTFXJU3CAz5CzPUi52SiSy4acIHSyDpwg/yHg1c27pGYJA65dG8hFHR+tiDZh9rs764z2MPYNHJrEsJ0efExU133TAsLiPVlSNg69ak8sDvnL9R20N8Z260TKWmMY7VoJ5bMgfZXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622482; c=relaxed/simple;
	bh=8DxZYfvi6n9YXkvm/oEKe5t1l6bASMkqM8ede1Pg+50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BZstty/gTq/En8xJF3ILwfVz2VIYz6kazRIed0/JJbHVqjPVSyPlPC2iiSxqnRxrvDtIt6rMKtWEAnjmkIHV5US2c20Myi7wSfqNAVzTQ/suA15Fe3oOZk46CCB+ZFQGVHp930sJn2Pqbc+TP+QVZR44QiIdQqtA7Jr5Rf1AWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFiTnG46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFiTnG46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1704A1F000E9;
	Tue, 16 Jun 2026 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622481;
	bh=tGM79c+VzMaL/XU1J5hmR0TZDWIIQtg3eHiQS8nZW/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFiTnG46ZbNcuDFI71crQ05CZGGY/MNXWkVDZaY1QDQlQ8wnwYt4N3TjunQsJs2hR
	 ObMugyGtw4tmhr3NMWcOGAv152n3ni1qCdi2eu/Yyd0uggT5Ky2sRkcEwkWWVpZ0Wm
	 DGJjt+1xCsXXufIklpUowRYmfks/DiwwU+J9OOEYP+QEtAyv6YHX+60nLCWRygWXwG
	 UxzLuL1wmNUYTGm4vfRPsbZ97zBi/T+1Pl5AujPYImjcGXf+8kSS4FCJ3YTzV5SNjL
	 Zk1tu1X8wjW3XoCcs1SUZeelrv2BfPa+yaKPAis8rvhoYKhmBpGbU+vvZg4J6B098k
	 FWvbvbwAwnHrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] perf cs-etm: Support call indentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-7-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-7-f8fad931c413@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:08:00 +0000
Message-Id: <20260616150801.1704A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Thread stacks for per-thread traces (CS_ETM_PIDFMT_NONE) are not=
 flushed upon a trace discontinuity, leading to stale callindent depths.
--

commit ccf60466ef97abd9a958c518b0578321fda247d0
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Support call indentation
   =20
The perf script callindent is derived from call stack in thread context,
CS ETM ignores the requirement for callindent without pushing and poping
call stack.

Enable thread-stack when either itrace thread-stack support or last branch
entries are requested, allocate the branch stack storage accordingly, and
feed taken branches to thread_stack__event() whenever thread-stack state
is needed.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d41aad583a26f..e18d2dec79431 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -2027,7 +2030,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_q=
ueue *etmq)
>  {
>  	enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
> =20
> -	if (!etmq->etm->synth_opts.last_branch)
> +	if (!etmq->etm->use_thread_stack)
>  		return;
> =20
>  	switch (pid_fmt) {

[Severity: Medium]
Will this skip flushing thread stacks for per-thread traces upon a trace
discontinuity?

In cs_etm__flush_all_stack(), the switch statement explicitly skips flushing
the stack if the format is CS_ETM_PIDFMT_NONE:

    switch (pid_fmt) {
    ...
    case CS_ETM_PIDFMT_NONE:
    default:
        break;
    }

Because the frontend thread for per-thread mode is still attached to the ho=
st
machine, the flush is completely skipped.

As a result, could instruction samples generated before the first branch in=
 the
new buffer inherit the stale thread stack depth from before the discontinui=
ty,
and break the newly added callindent output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-b4-arm_cs_=
callchain_support_v1-v9-0-f8fad931c413@arm.com?part=3D7
