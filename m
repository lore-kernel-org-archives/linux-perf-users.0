Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541484;
	b=NbJZtLQmzdDl30802itiVgekkX1mmpR6ZRHjyw5PWoLbGJOzEzSbanwcNSgp1Ida+TEZ
	 r4fVe5BtEZveEyVaReiuP0FdKW0VyEoL0YB07l8Y9UgqyVwqz+2IlEdtRjde5y8IWlyvV
	 zI9YbrQavxpd0kjPGsvOWtBnqCBEfezNKj+T1czM6Q7d9+oQ8Ytpp++viejh3IGatvCy/
	 nPEf9nzIjz0fxGmFWInlO1DkdkOwWBlvdc7i+ZBMZKVWohjdD6w2C75mhjk8b5sY6KODX
	 /ylbg1hCLk78+H1a8ZWnFaHHgMAfvg7gv+bjHX3MWwzRBL7lemWgpk3CDr17ont4Skg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541484;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2LrhZv4qYS1YRLdwhIw6AIa65D/pA/RM13VypR+9c2U=;
	b=TcdS7SC92aZZLBIjmOABbNE1Ae7bHrpvetJ2JOAlG7KMYg+zb4a/3/h/Unf7bwglj8CV
	 8jf1Y6hxIGcJ3pCv9klgKoGpwMkDyjtfC6kKetb3ETZb8GKXckGBtBbGRgFZnDhXkWcYs
	 wAOf/vOcogb+lN017ckSXQ1Ns3PFOzRWcLaR16c3WJqxHnYPduPg0WzuZfcT1IizBKvbv
	 tB9yj8mdMACGr9XJJT1votOi6zmbP/aEouFRsBn1nTAp3KWcsqNsGrax58nhQSBoM0Q/K
	 kt7GhA6J2zwDqq2qee/GpBnitBjnP+pFsnrKVJQHv5VbD5Kidx7jV0jaVWxKSqrPGng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5SIcPJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10A606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5SIcPJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC4A1F000C4;
	Fri, 13 Nov 2026 03:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794541484;
	bh=2LrhZv4qYS1YRLdwhIw6AIa65D/pA/RM13VypR+9c2U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a5SIcPJPYeqUzy7UubVa41uSeF3o0Mn9+2vEMTPF6m3cfoKuOKFs17ms1U43+sI5l
	 tQ7JWZr8ZEZ4nG/attrYwqX5jvPR+KNZO++LGEbj+YpDZSWWF6Xc+zSUI47yeElZhZ
	 lL6Uec3m3REIZCo9MAEwvhQt8JqzsObSayzVWl0w5hbnhhmUkus9EqhdYEFIHm8AcW
	 LmmkFJHcg7MKuszXx3X8bbPZwFSI59lyh88KRzpR0Rpb2tRk4DkzNKpQZAeCupKq0P
	 7H4cLOx2K+iYiBi+Zw9ZsMi9TdK3iRPKcfGDaGrgggyb+xJ/X8k02hwSLE6s1XTXHp
	 7ygPWEdHMNj/A==
Message-ID: <sashiko-outbox-212136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/1] perf jevents: Check the keys of the JSON tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113032927.634183-2-takano32@gmail.com>
References: <20261112222526.462146-1-takano32@gmail.com>
 <20261113032927.634183-1-takano32@gmail.com>
 <20261113032927.634183-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 03:44:43 +0000
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
- [Medium] perf test: jevents_check.sh never checks in-tree PMU JSON
  tables
--

commit 1b41788b6e87acfa8066606100a1198d73e6bf8c
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the keys of the JSON tables

This commit adds a --check option to jevents.py to report unknown keys in
PMU event JSON tables and adds a shell test for it under perf test.

> diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/s=
hell/jevents_check.sh
> new file mode 100755
> index 0000000000000..b596f8bc509d9
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_check.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# jevents_check: an unknown key in a table is reported (no_mlock)
> +#
> +# A key that is spelled differently is dropped without a word, so the ke=
ys of
> +# the tables are checked against the list jevents.py reads.
> +
> +jevents=3D$(dirname "$0")/../../pmu-events/jevents.py
> +python=3D${PYTHON:-python3}
> +
> +# An installed perf has the test but not the generator, and a python that
> +# cannot run the generator is not a failure of the check.
> +[ -r "${jevents}" ] || exit 2
> +command -v "${python}" > /dev/null || exit 2
> +
> +tmp=3D$(mktemp -d)
> +trap 'rm -rf "${tmp}"' EXIT
> +tables=3D"${tmp}/arch/x86/model"
> +mkdir -p "${tables}"
> +
> +# Known keys pass.
> +printf '[{"EventName": "a", "EventCode": "0x1"}]\n' > "${tables}/events.=
json"
> +"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null || exit 1
> +
> +# A key the generator does not read is reported.
> +printf '[{"EventName": "a", "NotAKey": "x"}]\n' > "${tables}/events.json"
> +"${python}" "${jevents}" --check "${tmp}/arch" > /dev/null && exit 1

[Severity: Medium]
Does jevents_check.sh ever run jevents.py --check on the in-tree tables und=
er
tools/perf/pmu-events/arch?  The test only runs --check against synthetic
one-line JSON files in ${tmp}/arch, and nothing in the build invokes
jevents.py --check either, so perf test passes without validating the
in-tree JSON tables or checking that _TABLE_KEYS stays in sync with them.

Also, the NotAKey test treats any non-zero exit status as success rather
than checking specifically for exit status 1, so an unexpected script or
argument error (exit status 2) would also pass that check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113032927.6341=
83-1-takano32@gmail.com?part=3D1
