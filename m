Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546978;
	b=U8csxxm9hNnsXQT3YK3gMKI2bWYwXJevwitCbaOnsR/6VGilutytZ3oEMoNkTuSTo1N4
	 hDYKQS5zL6nbt8yCWxc7taLKtI3xKJeOvqSlwz5c331S8L36tqiyW2aYhxMPvx+G3B0ak
	 JHc6azlLKja180vyDqo7PeGGFpIvCSIM5DV96AtcBk+YtXyBc/QMRqBn4gftq+IZq3Kqt
	 XbUPFT+++i5EkldBWTR/zw/8tXOQtqi6aK7t5XMhRtWjZYPEmO/nGuAP1bKGddlGK76JN
	 COcQ0Cz58VEjgkHWvcJwXDixzutXiZ7oVI79bQmTGG+RBrDBYz5NGriEDGGm4JZ7jow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TMO31jWz2pR+8dlSlKFhgoUlzsp242tB0faSMpYht58=;
	b=jVZx7nswQhTvIIe+JDs3aS7cydp8ejWuyvCT5nHPE7ufd+l5N8UuWp4IWwtcWuS1wCud
	 uLvjQZDKWGz5CVWFd2lnco1zeg+ak92kvJ5QuVD2ucS9OksZxYZgurQ79WzcZE4AruE5M
	 jHK5bVHuLjKyC0r2ELEG0Pt3zbHVdFmN3pYmSdbULapcsWRDwV4QcH518X/BYpMLHlE9D
	 MvG8SG5B2zcD71dfjW8Ll6qRJKtPwwP2X2yNJ2mygQX6EM+21IY0RR4tuJw2SzM51Y2EX
	 7v7iPZVB0nYLtRsOm5t/3jP5JeVUHM0Dpu03f9H9ugiDdXp6z8azdF14zC99ZYe1PhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3B1Wnha;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EA606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3B1Wnha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D451F000CA;
	Tue, 24 Nov 2026 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546977;
	bh=TMO31jWz2pR+8dlSlKFhgoUlzsp242tB0faSMpYht58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3B1WnhaEWAwevoAAuwvx0T7USyH4/4gvmf/6JXRI0ihvoIPzjy0PdeJvhA9XCl92
	 NwqUcw23n+Re3AhRwHNxqcmD5bFe4RKqGjGQ9B/2r8GD5xw0/uxnR88Ax0VUt78JqX
	 tV06GneR7j36n8CNKToIHVM0DzH81QLosA2egwKG+zux/oW1GPlyVpJzaEHeTsdZIJ
	 cBEvDA8KfVAqu+LoHWQD02tDmikCk0E2WWpK8HxuEacFWuY8VtDCUQQ2FnJJ0fSSi+
	 qs+x03CWyzEtgKlNUmQHi1G/GmHmMGOwT7Hx7cWf7/btkxX1bPZAGPWEmAsDGhDuBh
	 MX8G0i0D47WmQ==
Message-ID: <sashiko-outbox-231873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/17] perf tests sort: Exercise the report and diff
 sort keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-7-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:02:57 +0000
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
- [Medium] perf tests sort: unconditional type sort key fails without
  libdw support
--

commit d19ec29559a834aa0b14ae9d2476eaf1a9318b64
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests sort: Exercise the report and diff sort keys

This commit adds a shell test that records a workload and runs perf
report and perf diff with a set of common sort keys.

> diff --git a/tools/perf/tests/shell/sort.sh b/tools/perf/tests/shell/sort=
.sh
> new file mode 100755
> index 0000000000000..19f42ded2b895
> --- /dev/null
> +++ b/tools/perf/tests/shell/sort.sh
> @@ -0,0 +1,72 @@
> +#!/bin/bash
> +# perf report and diff sort key tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +shelldir=3D$(dirname "$0")
> +# shellcheck source=3Dlib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +testprog=3D"perf test -w thloop"
> +testsym=3D"test_loop"
> +sort_keys=3D"pid,comm,dso,symbol,cpu,srcline,period,time,socket,weight,t=
ransaction,type,srcfile,cgroup"

[Severity: Medium]
Will including "type" unconditionally in sort_keys cause
test_report_sort() to fail when perf is built without libdw support?

When HAVE_LIBDW_SUPPORT is not defined, cmd_report() rejects the "type"
sort key before generating any report output:

tools/perf/builtin-report.c:cmd_report() {
    ...
	if (sort_order && strstr(sort_order, "type")) {
		report.data_type_profile =3D true;
		annotate_opts.annotate_src =3D false;

#ifndef HAVE_LIBDW_SUPPORT
		pr_err("Error: Data type profiling is disabled due to missing DWARF suppo=
rt\n");
		goto error;
#endif
    ...
}

As a result, perf report produces no histogram entries in ${out}, and
grep -q "${testsym}" "${out}" fails.  Gating the "type" sort key on
"perf check feature -q dwarf" would avoid failing on builds without
DWARF support.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D6
