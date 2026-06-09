Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEB2E7BD3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023730; cv=none; b=BlLP1N1+vO3BEyDtIXcBjpgZPUSNBQJzjbG+p/x/FRVW57JfFWiyMhCxiYstJUkF+dZhz2T7cUNBjDxcv8cXZBz6wRZOjX+HLiZS09EloxEygdX2P79HdnWavlitaICdKjZH3JpM5jNoauta6ViJIFyx5KA7fE1sgAO7va0QRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023730; c=relaxed/simple;
	bh=L3NEGNUh5XiMl7m6RjMDGg3mgx59lSadjT3bT6qOpy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hkFRLmWC4GVjJU5TD4wx+BYRvvECHxcGwLWRgcFy6v86kPxwjvewGjslTsus4DnxKA1Fa3WKt41CS0C10lUQGn81wc2xEiQvHp4gWs+G15YHByF0w/bd6Aygp6igl8xTpGvjICPT+y4OOn752GPD3spJLPa97142qUQl3Blvb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccj/n1wf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccj/n1wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE6B1F00898;
	Tue,  9 Jun 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781023729;
	bh=u6DfgYB/kjoYIlPbnIcl0KBiav8nPGx697XbzASoSAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccj/n1wfr4Y6f0FyYcT6KXPxyDnPV7dlRpyEQ/eI/qkmqmL6lakWsZ9LeUNAQdIA4
	 oHS+cRm+ZptM5a9StA/ZHb8VSQKQ7cBSIeNpAlzhIwWtuD8LVguIi1GmzLRUjqkb3l
	 KFU+8l5kz+Zm3bhjm0BsCSblIwJotSN01gH0vPQS+bkZ69htsuIkn1ykrMYpez22Iy
	 nIUc2zriVJqlfOoRt41BgREcqw9Ct0Xs0Q1GhwrumbniLDe5Shhwtgdwob+lv7ZJVw
	 yrYFoXfY6NHWOkKH+Pc9wjujJ5d6Y3QO6rDkdMzMZBPOB/8MYL6u5PhsjnHP7p20D2
	 wf8bGcluzVS8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/19] perf test cs-etm: Speed up disassembly test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-18-d53a7d096a19@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v5-18-d53a7d096a19@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:48:48 +0000
Message-Id: <20260609164849.6CE6B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Reducing `--stop-sample` to 2 causes extreme test flakiness due =
to sample exhaustion and limited branch coverage.
--

commit ef4a0ff67bea24ddbc6e5c1bb7bfc2c172bd783d
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Speed up disassembly test

This commit limits the amount of trace to decode by using exit snapshots
and reduces the objdump sample limit from 30 to 2 to speed up the
disassembly test.

> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> index f78dfb6bf73e3..f2fb1aa92252a 100755
> --- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> @@ -43,9 +43,9 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|=
vs|vc|hi|ls|ge|lt|gt|le|al)
>  ## Test kernel ##
>  if [ "$(id -u)" =3D=3D 0 ] && [ -e /proc/kcore ]; then
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
Will this severe reduction in sample limit cause test flakiness?

Because sample index tracking in arm-cs-trace-disasm.py starts at -1,
setting the limit to 2 allows exactly 3 samples to be processed. The
script requires at least two branches events on the same CPU to invoke
objdump, since the first event only initializes the cpu data.

If a trace-on event or any instructions events are synthesized first,
they will consume the limited sample count without ever triggering objdump.
This could result in an empty disassembly output and a false negative
failure from grep.

Additionally, the branch regex lacks 32-bit return instructions like bx
or blx. Previously, larger sample sizes hid this gap. Processing only one
block might guarantee spurious failures on 32-bit systems if the block
ends in an unlisted branch.

>  	grep -q -E ${branch_search} ${file}
>  	echo "Found kernel branches"
>  else

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
Are userspace disassembly tests similarly affected by this sample
exhaustion?

Like the kernel test above, reducing the limit to 2 might not process
enough events to trigger objdump if trace-on or instruction events are
encountered first.

>  grep -q -E ${branch_search} ${file}
>  echo "Found userspace branches"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v5-0-d53a7d096a19@linaro.org?part=3D18
