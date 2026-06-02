Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246CE3D1CB0
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414001; cv=none; b=FsX8vre+V2xYNOvhwwB6G1ylUDgR6FxI8UESwcxV7Zocz5AEMm13RCg9XdGJxjZLMoPHpcRbEinMc9MQ0DtdK7EJlOSdSdnrsdbf9eBMNj6COQFmox5o8rHkLwB6mR6N2mUs/uugk7G3IDFdhtjJiWvXdfuT2Ed8zhFf9OjtQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414001; c=relaxed/simple;
	bh=VEDOcYJkbKhCm0+tdPXYa8GV64xJgRO4k55dIzjgPko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QnvEYxS27ulY9u0vpHyVGFq0aynpWOPMbGSbn2i/GNIIrsYbPUJa70DIf/zlCQYMywMbLSAwMT5sOx4HyWPrrVf5o2nrmovJH18AOVBTZuCK0lftNWWz10i/xWlN0PmKMXxN3QzwgLCu+v0kipYDV+NSXvvklWE/ZLnhAJJKtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRHKef3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRHKef3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914971F00893;
	Tue,  2 Jun 2026 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413999;
	bh=2Bsc4Gr6rQFXsyb8GpKG4InK0Vm0nMOWQRWtARqjSuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRHKef3bwEobIaxRrc43Nmspv6DhJ0ivarVsqDeaesAO4AF3uVD+OvG4sIoCXLJeo
	 CGuFBCTzQfPr9PaiNJfhoF+LAsP9p/Eu3MOP7SFsasqFdnq53o7I3+reTFHqyfENRD
	 Ll2qwcd2Poi17twAyHYBKuPR2fvxX79X85WolR0zBXtmcVyJYgPSOdonX8gRcrTiil
	 CkzXy3o8gpCrtJnevpkr4ZHA+5YQlFjIYbtIOcKlsSDpMcqQW7onGuAHScphLQpE8v
	 U/MUbraGJAE3Qc+m7+wh60LHlzGRTzvyG0NzBJbcWKfCTXFghYV0v3BQhaNe+qb70q
	 47Om8TbfWW2Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/18] perf test cs-etm: Speed up disassembly test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-17-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-17-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:26:39 +0000
Message-Id: <20260602152639.914971F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Limiting the disassembly test to `--stop-sample=3D2` makes the t=
est highly flaky, as early trace blocks split by exceptions will contain no=
 branch instructions.
--

commit 6abc0c1405ac75056533c403bf19e73b43a0c26a
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Speed up disassembly test

This commit attempts to speed up the disassembly test by using exit snapsho=
ts
and limiting the perf script output to 2 samples instead of 30. This avoids
expensive objdump calls, particularly when using kcore.

> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> --- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> @@ -43,9 +43,9 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|=
vs|vc|hi|ls|ge|lt|gt|le|al)
>  ## Test kernel ##
>  if [ -e /proc/kcore ]; then
>  	echo "Testing kernel disassembly"
> -	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/n=
ull 2>&1
> +	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $fi=
le > /dev/null 2>&1
>  	perf script -i ${perfdata} -s python:${script_path} -- \
> -		-d --stop-sample=3D30 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${=
file}
> +		-d --stop-sample=3D2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${f=
ile}

[Severity: Medium]
Could this tight limit cause the test to become flaky?

By reducing --stop-sample to 2, the Python script processes exactly 3 events
before exiting. The first event is usually a Trace On discontinuity packet
which produces no disassembly.

If the following trace block is interrupted by a kernel interrupt before a
branch instruction occurs, the decoded block won't contain any branches. The
third event would just be another Trace On packet, and the script would exit
having produced an output file with zero branch instructions.

Since the test script runs with set -e, wouldn't the subsequent grep fail
and trigger a false positive test failure?

>  	grep -q -E ${branch_search} ${file}
>  	echo "Found kernel branches"

[ ... ]

> @@ -55,9 +55,9 @@ fi
> =20
>  ## Test user ##
>  echo "Testing userspace disassembly"
> -perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
> +perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev=
/null 2>&1
>  perf script -i ${perfdata} -s python:${script_path} -- \
> -	-d --stop-sample=3D30 2> /dev/null > ${file}
> +	-d --stop-sample=3D2 2> /dev/null > ${file}

[Severity: Medium]
Similarly, does this risk introducing flakiness in the userspace testing due
to early page faults?

As with the kernel trace, if early userspace execution hits a page fault in
ld.so or another exception before taking a branch, the limited events
processed won't include any branch disassembly.

Would slightly increasing the stop-sample limit avoid these intermittent
early execution trace interruptions while still remaining faster than 30?

>  grep -q -E ${branch_search} ${file}
>  echo "Found userspace branches"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D17
