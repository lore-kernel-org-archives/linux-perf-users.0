Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADA43DA25
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622795; cv=none; b=P2khdhhCVdPOmnOzCD+4pKlM41kmGrVEuymliKrLTiwt9SDnMG86Ez/ZISu9lQFVQ8CMlOuv3zgH0jpJujgdMP04HvU2Wr2UUypAip9k7o+BH8oHZf4e714VbGSrmCN5RRXw2owCl7wLratxip4gsm2so1CgZaFs3SEsUXyy5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622795; c=relaxed/simple;
	bh=5UkbU+QWOX83a71MjnagT8sCxY3K6R7qSuOk5Z/bmHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kfm+7DattybVROzuwHkoHGgjYh0cOwEG3+EE8NxyTRHhH1gDsa5LZhrabdnRcAtTguf68gzfoOLiSlA8DF2P1DhPKmNT36CkRrRgMrvM+QDqTUBajK1HRMbjPy065LSj7xEgKy10Nv0+ChynyvXmn1dKrZzxPquGQM7Ec8ejniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT+SUqbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT+SUqbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBD11F000E9;
	Tue, 16 Jun 2026 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622794;
	bh=s4Rrjo24trf5HuZ5I5hCN6fXaozYjQtPzkUHYUALVGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XT+SUqbbV3BtDkuymfxd1yhNuPH4rDQ+M3Kwo3gpmZR8T6tRGT1pw9iQ3ztMw3JtI
	 Z4NhCle52cERwDi4+tW31cURSooZ8xKEP7pyqJYYxdP8TCzGfAEttiEImS/x2SnNCM
	 2RNbQ0aIMOc3YCPKWk6osRn0IY+MX4S56r20QLdHbsNSv3jxYf5ZK1qu1+9WBmGdL2
	 IlmhzG6E3kh2GwjoI6bJK5br/fgAiTo4RRcbtjjCiXXNdjtY/3oHC0rusS8YDCuuZw
	 sP7fX1K+wiyXM60frXd8YEeIcMTEexP+xDPYXULs+OrOd2Kwd8uewQKSBgryvPDN38
	 +wH7vjSlt2XqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] perf cs-etm: Use thread-stack for last branch
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-5-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-5-f8fad931c413@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:13:13 +0000
Message-Id: <20260616151314.5BBD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Cross-CPU state corruption when flushing shared thread stacks on l=
ocal trace discontinuity
--

commit abf6f97a0108ff607c740e49b61365089d433985
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Use thread-stack for last branch entries

CS ETM maintains its own circular array for last branch entries, with
local helpers to update, copy and reset the branch stack. This
duplicates logic already provided by the common code.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 6827ef8871a8f..51b05a0bc1898 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -2025,7 +1965,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> =20
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->frontend_thread);

[Severity: High]
Can this cause cross-CPU state corruption when flushing shared thread stack=
s?

When cs_etm__flush() is called due to a local trace discontinuity or the en=
d of
a block on a specific trace queue (CPU), it calls thread_stack__flush() on
the frontend_thread.

If the traced thread is shared across multiple CPUs (such as the global idle
thread pid =3D=3D 0), thread_stack__flush() will iterate over ts->arr_sz and
reset the branch stacks for all CPUs associated with that thread:

tools/perf/util/thread-stack.c:thread_stack__flush() {
	...
	for (pos =3D 0; pos < ts->arr_sz; pos++) {
		int ret =3D __thread_stack__flush(thread, ts + pos);
	...
}

This replaces the previously safe localized reset for the trace queue with a
global flush. Could a localized discontinuity on CPU A silently wipe out the
active branch stack and callchain history of the shared thread executing
concurrently on CPU B?

> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-b4-arm_cs_=
callchain_support_v1-v9-0-f8fad931c413@arm.com?part=3D5
