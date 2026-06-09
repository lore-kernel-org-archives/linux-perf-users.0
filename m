Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE708481649
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017617; cv=none; b=qk/gYFltOYdUFxmXsbr9aK8NciSr/l3KQcxL1Ekz6GVa38oF7MvBHHsw2FFaBaxWApJ6HuFfz3A+98YnCJp4oTviCCVAJ+Etph0ycRM/TvcuLGXsMMDqn+c9tsEeqEDKqZ9Sfs3Cmb8zdSpFNZ0o2snYEHlnZHE972+EbqEyA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017617; c=relaxed/simple;
	bh=qrA+tRM2aHf7ptkS0YAW4UM7EZ2qoI2fxn2ySu9Mses=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=keZOk2/dWRN9axPi2NShy/f9xnZkpzMYoHHfFWgWAP3KYzMopyeLWcISFn4J4FdH5/WRa3xFXYS48KzMO0doN1qHysRf0+oXk97R9n1Mwko2Z9JF7hHI7pbpNZBANu/EV5GUr0aL1i347o/RzS8j/BVwZKs9ePZAnygvfgxUiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANi1kq9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANi1kq9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CECD1F00893;
	Tue,  9 Jun 2026 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017616;
	bh=UAeOFIJBk2h6wPC7l1ygpr/rLB0aCCVRLwJv4ZoV2OI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ANi1kq9sKI3oMl4KqTK1mnLc3VJAeHxcx7inH1+F3/rl0iRzZ49cJjaSocGK9ZSKu
	 ho6agmhN9tylCQmg9sG5utxJED14DOtGm3azcqwD9tADZPOTgn6Ttyc08+H+FUO/SY
	 HXfYTLqa5zcEVhHI7bRl6GAe4MSh2+YU4wpOYxDeN1hSHpLENRP58m7I72hwVtEtW8
	 F0iBXCPqIj18FndBTcEVooHBQtF78SFfrxgvDOoTNsHlBiyiy+L+UZwY0mUA5MfwDy
	 oQbQx9zBtmxrjBcj7cXZDOAjTD4VZAjwsghoyAqVdexcKzrlW9L+DCfVo9JMgkWKIo
	 +Em2tKoPQ602g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/19] perf test cs-etm: Speed up disassembly test
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-18-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-18-44f9fb9e5c42@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:06:55 +0000
Message-Id: <20260609150656.3CECD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Reducing `--stop-sample` to 2 causes the disassembly tests to sp=
uriously fail on multi-core systems because the Python decoder limits the r=
aw number of decoded events rather than objdump calls.
--

commit 4c3c2bcace55cfb656bbb5453c90886308b6f40e
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Speed up disassembly test

This commit speeds up the coresight disassembly tests by using exit
snapshots to limit the amount of trace decoded, and by reducing the
stop-sample limit from 30 to 2 for both kernel and userspace testing.

> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> index f78dfb6bf73e3..f2fb1aa92252a 100755
> --- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
[ ... ]
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
Will this reduced sample limit cause spurious test failures on multi-core
systems?

The Python decoder (arm-cs-trace-disasm.py) increments a global index for
every processed event, regardless of CPU. Printing disassembly for a single
basic block requires at least two events from the same CPU (one to
initialize the address cache, the next to construct the range and call
print_disam()).

With events interleaved across CPUs, and cs_etm synthesizing both
instructions and branches, could the 3-event limit (indexes 0, 1, 2) be
exhausted by cache initializations or non-branch events before a single
print_disam() call occurs? If the script exits before generating any
disassembly, the grep check below would fail.

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
Similarly for the userspace test, is there a risk of the script exiting
before generating any disassembly if non-branch events or interleaved CPU
events consume the strict limit of 2?

>  grep -q -E ${branch_search} ${file}
>  echo "Found userspace branches"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-james-cs-c=
ontext-tracking-fix-v4-0-44f9fb9e5c42@linaro.org?part=3D18
