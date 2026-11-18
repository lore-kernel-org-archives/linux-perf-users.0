Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021871;
	b=rwsCnm6mihQygENdX8Rg4TXFoR/XaZVIJMluzSIfoH/EiHkz/Z5MbaLeue5EcG97U+48
	 DFdXbnlcXRJXS7VEVIyuPC8+zMSE0mPv4gLLz7x9LSkPrsHmquMOV2zo3EaatyqUU1b4t
	 Z5A5uRdCxgq2ESGp5n7TRhhJfvHMRWa6UDNUkxMB9WgXNZEgP3LclpAtiF9zZep1X/d1j
	 uvJ0PWYWQHFhX+ZfY9X9LyehSnFrPYyhaghzqdgzic/YAk92QOAP+mWdR/uJzy5rvahTN
	 OqDmvOUtRy5NM13M+Dzkp6P6FyTMjUSqsNCXDcgPX07oWLIAXw5i5Cn8KgUj2W+SOcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TFEFwCX98Kuwclfxe3YRPRseGGDjH2JXTp89bpM9+WM=;
	b=EvR1oB+hd1IXW6IniAVsV4OCPqKEJNVLF7sPzfpHjmM57wr1+GjiSqhqsoVAkVRbRmNm
	 PD8Z+pLPITBWg72c0GAbtTm+KILdLS2tkpIN0B9EWGQ2tIOkcTcFDAONH9DkvtbtpNeCh
	 wfEoEzIFBLqD/jB25epq9z56cgWbm7mHOU1rhTf3rXHLYjsglJYCehJcw+p5eIQeAwY2U
	 /cd6JWHBBaLLM8gzjCuDQPmZ+lFLKD9FcRL2LK5/M/XDwImW+mywEb47YJeGbd6MksgeO
	 KtsjfjV5wLyvYMHrr735FTMGYsvNc40nnIrpbxvBUAQscMOlbAM393BZvqVhDtvMZwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksbyLV5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF428606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksbyLV5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2FF1F000C4;
	Wed, 18 Nov 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021871;
	bh=TFEFwCX98Kuwclfxe3YRPRseGGDjH2JXTp89bpM9+WM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksbyLV5j46z9Fe8V1LvJMGQBx5np/zkTfwy8rJsSq08z0PEHJ2RgMvbeP1janfsJT
	 4AZoFTnOp8MLrqeQUBElKJOkyWQuhDZ+52uRUfn1xSWi/cgaGYdy4W51NutovEl1CL
	 Gv/izZCSav2x3cbb6QmUGgMUsP3pjCeq4bAm82EoZ93CWnKrz5Mc1brbdM0aeOVs2l
	 CwVbKA76pX/WixmHI5I4XXDGc+lRFPBG0IcnPZjJ7BO+rwf+mr6tgJwT443KBWFRGy
	 G11Byr3It/y1UIow35m/WoXO2kheclBUJBiXzHY5MezIXZnG9ptCSfSr4cRVJqbw3y
	 Mti+LTkLmXIDw==
Message-ID: <sashiko-outbox-221593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/34] perf test cs-etm: Add a Java JIT source-line test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-31-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-31-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:11:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf test cs-etm: java-jit.sh fails with EPERM for
  unprivileged users due to -m ,8M
- [Low] perf test cs-etm: missing libopencsd and dwarf checks in
  java-jit.sh
--

commit cea9e66501af7e76ede12eae8cd4a06ada95d4ae
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Add a Java JIT source-line test

This commit adds a CoreSight shell test that records a Java workload with
the JVMTI agent, injects JIT symbols, and verifies the decoded source line
sequence across address reuse.

> diff --git a/tools/perf/tests/shell/coresight/java-jit.sh b/tools/perf/te=
sts/shell/coresight/java-jit.sh
> new file mode 100755
> index 0000000000000..cb6099efa8991
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/java-jit.sh
> @@ -0,0 +1,65 @@
> +#!/bin/bash
> +# CoreSight Java JIT source lines and code address reuse (exclusive)
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -o pipefail
> +
> +script_dir=3D$(dirname "$0")
> +
> +# Requires a HotSpot JDK (11+) and libperf-jvmti with line number suppor=
t.
> +perf list pmu | grep cs_etm > /dev/null || exit 2

[Severity: Low]
Should the prerequisite checks also verify "perf check feature -q
libopencsd" and "perf check feature -q dwarf" before running the test?

The cs_etm PMU is exposed by the kernel and tools/perf/arch/arm/util/cs-etm=
.c
is compiled unconditionally on arm64, so perf list pmu and perf record
succeed even when perf is built without CORESIGHT=3D1, causing perf inject
and perf script to fail in cs_etm__process_auxtrace_info_full() instead of
skipping.  Likewise, jit_write_elf() only emits DWARF line tables via
jit_add_debug_info() when built with HAVE_LIBDW_SUPPORT, so builds without
libdw produce no source lines and fail the diff check.

[ ... ]

> +# Compile only run(), and collect trace only while it executes.
> +# A small code cache and class unloading encourage address reuse.
> +timeout 60s perf record \
> +	-o "$tmpdir/data" -e cs_etm//u -D -1 -m ,8M \
> +	--control "fifo:$tmpdir/ctl,$tmpdir/ack" -- \
> +	java -Xbatch -XX:-TieredCompilation -XX:CompileThreshold=3D100 \

[Severity: Medium]
Does "-m ,8M" cause perf record to fail with EPERM when running perf test
as an unprivileged user?

Passing "-m ,8M" sets opts->auxtrace_mmap_pages to 8 MiB while leaving
opts->mmap_pages at UINT_MAX, bypassing the unprivileged 128 KiB AUX /
256 KiB data fallback in cs_etm_recording_options():

tools/perf/arch/arm/util/cs-etm.c:cs_etm_recording_options() {
    ...
	if (!opts->auxtrace_mmap_pages) {
		if (privileged) {
			opts->auxtrace_mmap_pages =3D MiB(4) / page_size;
		} else {
			opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
			if (opts->mmap_pages =3D=3D UINT_MAX)
				opts->mmap_pages =3D KiB(256) / page_size;
		}
	}
    ...
}

Because --per-thread is not used, perf record mmaps a 516 KiB data buffer
and an 8 MiB AUX buffer on every online CPU.  In perf_mmap_calc_limits(),
the per-CPU data buffers consume the entire user_lock_limit and the 8 MiB
per-CPU AUX buffers exceed the default 8 MiB RLIMIT_MEMLOCK, aborting the
test with exit status 1.  Since tracing is only enabled for a single
work.run() call per phase, can this use the default buffer sizing from
cs_etm_recording_options() or skip when unprivileged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D31
