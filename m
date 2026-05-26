Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B83AA9DA
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828975; cv=none; b=QMLmlf/uqkTR6zGOmF9fjn+L/C7wGRqDeJzD+QA62UJr/1SCbjs8+3xR/Ju76wXkph0lKfQV6E0Ufs22yeu5TR2agJlnojvuFg2ctFbs5kjSNuwkYStA0xxQSoj7BRaHu5P2i2FWk7D73vKWU/IQ9DXxgpM8TLXFL4IQCbuDQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828975; c=relaxed/simple;
	bh=RTBdwc/TaC1uiY739CUAv1o6cw5bbTD5vUuaGJI5gMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPkaRRTYLJX1528pMlTRkXHxH+gP36991wILRhFOAaHm/OtDYyrFC7Rs4lxGT/70JRMeJ/UTAR2Xw0KADvfHDeac6/MkYzSyDWz27oti5gWTWFN2uSsMjnMaiW1D7NIRUZmjyIepGjAFFIwxl0jzUwDPBxL9coNSqswdEA5q0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRkNt7Zu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRkNt7Zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C191F000E9;
	Tue, 26 May 2026 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779828974;
	bh=4xWpMRqGiUdz88mlVMwOTy3suaSFK4i+zIij7xyXTbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IRkNt7Zui/dDJS4h2kIHHfg7uhVyaMlN8NYbtqpDI31dXkh7n6b7O+yazfDTejeTv
	 QXs7leQMtBhh6lNEavp2joEW+duxv14EzaUlKBnI6Gjq5yrHsOcB1uUhreQ9JaQoWC
	 JQaFuPuBCSRgcM9cXqZqhzAfCbtqOs84baD6mEiqoU/5pOlEaVEJp2T6s2boulrlJ5
	 2YMQHlhpTIGAFDZBHBbOT+OGFGUVG0skATTf0RG/eLho0fVfSchDQuOhcljrwteKKt
	 MFX8NsXV0VC3ljvWFK1Q6cI3t7cvyjMoc1YfCmtXB7MHKv/K6/ze4c4YiVlNl8xGwm
	 WosX4AvYs+yHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] perf test: Add Arm CoreSight callchain test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-8-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-8-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 20:56:13 +0000
Message-Id: <20260526205614.17C191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The regular expressions for matching `perf script` output do not a=
ccount for the timestamp field, guaranteeing test failure.
- [Low] The `.size` directive for the `main` function incorrectly excludes =
its `ret` instruction.
- [Low] The `adr` instruction is used to reference a symbol in a different =
section, which can cause a linker error.
--

commit c68e5facc9f76be5097ddc178f00bfa18d0f188f
Author: Leo Yan <leo.yan@arm.com>

perf test: Add Arm CoreSight callchain test

This commit adds a shell test for synthesized callchains from Arm CoreSight
trace data. It builds a test program for syscalls, records them, and
decodes with itrace callchain synthesis enabled to verify the push and pop
callchains.

> diff --git a/tools/perf/tests/shell/test_arm_coresight_callchain.sh b/too=
ls/perf/tests/shell/test_arm_coresight_callchain.sh
> new file mode 100755
> index 0000000000000..0e5a5d1129ae7
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_coresight_callchain.sh

[ ... ]

> +do_svc:
> +	stp	x29, x30, [sp, #-16]!
> +	mov	x29, sp
> +
> +	mov	x0, #1
> +	adr	x1, msg

[Severity: Low]
Can this adr instruction cause a linker error?

The adr instruction computes a pc-relative offset but has a strict +/- 1 MB
range limit. If the linker places .text and .rodata further apart than 1 MB
(due to page size alignment or hardening constraints), the build will fail
with an out-of-range relocation error.

Would it be safer to use adrp and add here?

[ ... ]

> +main:
> +	stp	x29, x30, [sp, #-16]!
> +	mov	x29, sp
> +
> +	bl	foo
> +
> +	mov	w0, #0
> +	ldp	x29, x30, [sp], #16
> +	.size main, .-main
> +	ret

[Severity: Low]
Does this .size directive incorrectly exclude the ret instruction from the
main function bounds?

Placing it before the ret instruction might cause profiling tools to fail to
correctly attribute an execution sample on that instruction to the main
function.

[ ... ]

> +callchain_push_regex()
> +{
> +	printf '%s' \
> +'callchain[[:space:]]+[0-9]+ \[[0-9]+\][[:space:]]+10 instructions:[[:sp=
ace:]]*\n'\

[Severity: High]
Will this regex fail to match because of the perf script timestamp field?

By default, perf script output includes a timestamp field, formatting lines
as "comm tid [cpu] time: event:". The test invokes perf script without
restricting the output fields (for example, it does not use -F,-time to
disable the timestamp).

Since this regex strictly requires spaces immediately between the cpu
identifier and the event name, it seems it will fail to match the timestamp
and cause the test to fail.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-b4-arm_cs_=
callchain_support_v1-v6-0-f9f49f53c9dd@arm.com?part=3D8
