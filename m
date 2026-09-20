Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAB3D333C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882926; cv=none; b=Q6P4xsIk9Qe4SThHY6eGsdqB9qHU5l6UsWkb0ev+BDJ3M4i2rA9FusqU58lvs8+IrKP9AewSTMBjagzj9x70ONoupc0wVBwW4cJ2EXhurTfyz46uSvXVmV2eZYw/q5JrQIhSQ3BrkUkID9Nn9InPJs2SANZDbhw367YkprPmOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882926; c=relaxed/simple;
	bh=U0dSjS3bVYfg4Zn9tA3/RbV2grY+6NgQmeTxS+wISag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEbDEyv7/eUiiiJvMQ3Q9JPPIToIWmLMq+Am2XRR1u2F679ftdPCL0Uw0xHFar2FoSK9J5DoHp5POj4dQxOanIO9yyQvWvKZ0iacoM9rAQurXJ0TN0r1GE2VLLS9V2z9CvPEdf7dFVXAf5ZgrD+ZeykNqSu3Jzh6TUBo1P9tGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxdCUtZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxdCUtZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A5F1F000FF;
	Sun, 20 Sep 2026 05:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882925;
	bh=l8UWwXkXxboniSXbamvBRm68H8P4+vqgK01HPyabUEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxdCUtZgw8NxU3+YIyYSmcd39MDZUaub3OoT0IUBdbH0JcJDLpFTRIRi/qQjtJmCW
	 H4TjB1LjwX6K+ddGH0RmdO5XScf5T6hTooviqBkc/p62ExXNpvs3DJTxZHomMQTe97
	 Sbt9/3Aeurl0+IHtmbcIYSbiSNjHfedjWIMTJNAvhFSQJlZsohSO3bak4Oz46sek2Q
	 OnFp0ZsazwCq3RSuplXyzQN4sxT2NIMtLLq4Oh2FCL/sW8DmfCQJhjZUPB3s7xjiaK
	 fZFHPAloFNHxYsacyhd+5qoRTcn96emK7hunP5bNmRHE3Cn5QYASOLTlNn2Prf18Fa
	 MksN28FRqO0OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a87f87541e6b2caddc90232c2742f4a41076ce5c.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <a87f87541e6b2caddc90232c2742f4a41076ce5c.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:42:04 +0000
Message-Id: <20260920054205.22A5F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: coresight disasm test skips due to bad PYTHONPATH
--

commit c62fb057c9bb2395ae6702ac71b41a2e2b1788ed
Author: Ian Rogers <irogers@google.com>

perf python: Port arm-cs-trace-disasm to perf module

This commit ports the arm-cs-trace-disasm.py script to a standalone Python =
script
using the perf module. It also updates the ARM CoreSight disassembly shell =
test
to invoke the new standalone script instead of using 'perf script -s'.

> diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.s=
h b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> index f3ebad5963783..96c6bdc13a178 100755
> --- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh

[ ... ]

> @@ -44,8 +45,15 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl=
|vs|vc|hi|ls|ge|lt|gt|le|al)
>  if [ "$(id -u)" =3D=3D 0 ] && [ -e /proc/kcore ]; then
>  	echo "Testing kernel disassembly"
>  	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $fi=
le > /dev/null 2>&1
> -	perf script -i ${perfdata} --itrace=3Db -s python:${script_path} -- \
> -		-d --stop-sample=3D2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${f=
ile}
> +	# shellcheck source=3Dlib/setup_python.sh
> +	. "$(dirname "$0")"/../lib/setup_python.sh

[Severity: Medium]
Will this sourcing of setup_python.sh on line 49 cause the test to silently=
 skip=20
due to a bad PYTHONPATH?

When running tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
directly without explicitly setting PERF_EXEC_PATH, bash source leaves $0 as
the caller script.

This means dirname "$0" inside setup_python.sh evaluates to the caller's
directory (tools/perf/tests/shell/coresight/). The relative path checks
(../../python and ../python) in setup_python.sh are designed for scripts
located directly in tests/shell/ and will fail here because this test is ne=
sted
one level deeper.

Could the path resolution be adjusted to account for nested test scripts?

> +	$PYTHON -c "import perf" 2>/dev/null || {
> +		echo "Skipping test, perf python module not found"
> +		glb_err=3D2
> +		exit 2
> +	}
> +	$PYTHON ${script_path} -i ${perfdata} --itrace=3Db -d --stop-sample=3D2=
 \
> +		-k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
>  	grep -q -E ${branch_search} ${file}
>  	echo "Found kernel branches"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D38
