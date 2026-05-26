Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF8846A
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824537; cv=none; b=GLhh59po3+O2EogtmmixJ4UJtnDnkCTRX+JH00qujeTP41N1wllOPJCHLqYItGhQrf7x2k5OYjVFFp1YVqFpieLEQyF5qBeR9+uaKZPjcmv4w7OyB4HSEFXohRfmdvkFOS6XjaN8d6Cbe2FmDRsn6AooiH+YYHGNUUvvvOc4nKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824537; c=relaxed/simple;
	bh=lZRkUp32EpW38rqzEyu4pZ8fd7Qn7Dw1bIuij67qoGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m7SuOSZkYOE//ePTydUkeXLpX8wIxGyNkroS2wQC2QMVigQhpQ+KtnY5UcVN/JGu4EbT7YHPIGQvit8Kavxbzr9PGIzCcHy2tAj+ri+vhRFEGSWrfDK2LlAj919A1R39eNRqFEWvSnG4hSq7XWB1eeCO5HgX6JdNC65ZELdVzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSrn6yrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSrn6yrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70AD1F000E9;
	Tue, 26 May 2026 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824536;
	bh=iF9XPqVOy7t3ZDahRFHlULHPRhpRvosz1NXLOx1GQ4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSrn6yrVjGEWolru5uh5XED28vA4q4urBAO7+OlaB4iZyw5I/dBYdwDBEjKHtSVPg
	 nfdaICrLI9BXRNMEY1dUSKwS2V84bxcEs2rOL60Bs90laglSSS8zWtWZlEcCor9ef/
	 EkwEWtxHRRcilJhtClESQMCCGA2WWSNtBvXWk3Djh4PV1SGkLUNZhGcXgtWLAWweq8
	 0H9JYMTfp4AQjcqCMBJTLeoZIOs+CRV+ym3ozLx4ij6a3oDObbJf1zPf5W/tAntbiY
	 8Mer4vnylK9Z7xbXsoLMFZyIIoux8wcXx9HcVxJrCpS8G2O9mMEHGK0KqfcnpJSrkI
	 1mrZAY4RRmKeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] perf cs-etm: Support call indentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-5-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-5-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:42:15 +0000
Message-Id: <20260526194215.C70AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The condition for swapping packets in `cs_etm__packet_swap()` wa=
s not updated to include the new `use_thread_stack` flag, which breaks the =
`callindent` feature if branch and instruction sampling are disabled.
--

commit 36aa886e2c5be33efb8d11e03a02df7c74dce99b
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Support call indentation
   =20
This commit introduces a use_thread_stack flag to track whether the branch
stack needs to be recorded. This allows call indentation to function
independently of the last branch record feature.

[ ... ]

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ea2424175558d..b31d0dd46a45d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1914,7 +1915,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  	cs_etm__packet_swap(etm, tidq);

[Severity: Medium]
Will this swap logic still work if branch and instruction sampling are
disabled?

Looking at cs_etm__packet_swap(), the condition to perform the swap was not
updated to check the new use_thread_stack flag:

tools/perf/util/cs-etm.c:cs_etm__packet_swap() {
    if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
        etm->synth_opts.instructions) {
        ...
        // swap packets
    }
}

If a user runs perf script -F +callindent without enabling branches,
last_branch, or instructions, cs_etm__packet_swap() won't swap the packets.

Does the previous packet remaining empty prevent the thread stack from being
populated, causing callindent to silently fail?

Could cs_etm__packet_swap() be updated to check use_thread_stack as well?

> =20
>  	/* Reset last branches after flush the trace */
> -	if (etm->synth_opts.last_branch)
> +	if (etm->use_thread_stack)
>  		thread_stack__flush(tidq->thread);
> =20
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-b4-arm_cs_=
callchain_support_v1-v6-0-f9f49f53c9dd@arm.com?part=3D5
