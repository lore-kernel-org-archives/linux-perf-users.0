Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE2272816;
	Tue,  9 Jun 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989360; cv=none; b=JI886n2COTj5IydJZC7rexSe3iKBHn5gfXk7ruMIWeocL0NZdb0tyELTLylG8wCxyGrJowD1fyaM6DLATiJ/tSUmixRbHgHl4zbjGTZlEdW1mCZxHX9dsx075SKtl1PMqxpmbDaFv/hfsy6v95ky9LgKt+h4OZbLvT0KMt4rJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989360; c=relaxed/simple;
	bh=0xtSPRKwb9RjJhxu6/oq9S9k+XWh1/PG8k+7RmRtpi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rK1N4JuXOxTnXKkLFHxaNwpL6p8tyidOhz9E5VonWSeWEldro22QqysWuRLALPm3A6DAfQAW9ZVn3nvzDY48SO78fGtGblA5VfB5VZqdAMjlSQWQg9nZYFYD1wTwWnjBxVrL0XI+SrVOENhdaoyLHzN2kLSk5uCS3FRuKoFlNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPwnS/Ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPwnS/Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB91F00893;
	Tue,  9 Jun 2026 07:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989359;
	bh=iGWDnQPvmZ21u35Fo1QSUS2G7TUcHzCAgYvcOkZvxYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPwnS/VeG6+0yH+abPSU4vUHJEood3ecjibSg3p61eLl6Ltr3RNev7kER8seQVeZv
	 OcvtR2eDvrYigHqxNgYvyB0YWDbA6tdYxQZteWkWHZTFQLVIXBPqfpWjdpodpk93KJ
	 +bnc22v0CN5Yk5NSExOSA8UYNEMg0Qztflx5EIUFb11PupUmFWgjR2gHDtCQ7TYa7O
	 2OMuVsfiOc/m/Wb4QipIvWuxDYdOrF7itxwpuo6N0ij35fWgZmw12E2BPdSH8Y4SCb
	 mbya1ZhF+e2pZqMUYSq5a+06nRodA4BZ7xNOc/BRG2VT30vUdgwzfvyScWKAZlDfY3
	 XJMScrsKB9nkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] perf test: Enhance annotate test coverage and
 isolate config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609070732.545416-6-irogers@google.com>
References: <20260609070732.545416-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:15:58 +0000
Message-Id: <20260609071558.C8CB91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized variable and incompatible data format causes `test=
_disassembler` to unconditionally fail.
--

commit 5f0bdfa4980785631dd9a8024ff9f43baa234caa
Author: Ian Rogers <irogers@google.com>

perf test: Enhance annotate test coverage and isolate config

This commit updates the annotate.sh test to support different disassembler
backends via the new --disassembler command-line option. It also isolates t=
he
test script from host environment pollution by exporting PERF_CONFIG=3D/dev=
/null.

> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> index 689de58e92384..2c06d2670cb18 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
[ ... ]
> +test_disassembler() {
> +  disassembler=3D$1
> +  feature=3D$2
[ ... ]
> +  perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 1=
0 --disassembler "${disassembler}" 2> /dev/null > "${perfout}" || ret=3D$?
> +
> +  if [ "x${ret}" !=3D "x0" ]
> +  then
> +    echo "annotate with ${disassembler} [Failed: perf annotate error]"
> +    err=3D1
> +    return 0
> +  fi

[Severity: Medium]
Does this evaluation unconditionally fail the test when perf annotate succe=
eds?

If the perf annotate command is successful, the short-circuit `|| ret=3D$?`=
 means
ret is skipped and never assigned. Because ret is not initialized as a local
variable at the start of test_disassembler(), it remains empty. The subsequ=
ent
check then evaluates to `[ "x" !=3D "x0" ]`, which is always true and incor=
rectly
flags a success as a failure.

Additionally, will reading `${perfdata}` as a regular file here cause an is=
sue
due to the test execution order?

>  test_basic Basic
>  test_basic Pipe
> =20
> +if [ "${err}" -eq 0 ]
> +then
> +  test_disassembler "objdump" ""

The test_basic sequence runs `test_basic Pipe` immediately before executing
test_disassembler(). This overwrites `${perfdata}` with a pipe-format strea=
m,
so attempting to read it using `-i "${perfdata}"` inside test_disassembler()
may cause perf annotate execution failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070732.5454=
16-1-irogers@google.com?part=3D5
