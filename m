Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FE3F99FC
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533590; cv=none; b=VvrGACee2TV8q3LgsHw1jMbhZvw0o9yWhtWCXpfGnalZGWyhznn08arQkRaxsEfM9maMmfwkbI/RBEG3rXGx1GhYb//KBiOLebtTvGbl8O1sRkp+bZu3TrbgYVq7HLdbTDknGFRY28QQ5V3cPh79L071VTKswvWY5e1AirTUmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533590; c=relaxed/simple;
	bh=Su+8SQ1uXpWIPcux3jGY3eamYaMaZIwXbeNN7YlQDQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NdU4K5ImCyCktFvfRrRVwebBjTeTInkb4fIw1vksXYnJC/MdVxsSVfV+APozNeiWpwwBPZI3WkBr7UkAegtlB5Re3ui6rhUswuYDL7prCU4zRAa5QUvgCRRyXHECZ8v3Z7c037vLwal3KGAAjx8skIWSUfd15MG5my+u7ukwDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5P1DmLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5P1DmLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567701F000E9;
	Wed,  8 Jul 2026 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783533588;
	bh=QKSMCFFO0F0lJAJY5+38uMG6Y3PaGmB6P8+qngmDTsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5P1DmLGh9vnYvqIfqJ2/Vv7Us3SVT2CS/M1R5Uvd5zchbAjnOqvo3mIvjQmzJkWI
	 eOAvoOoe/JEYe29aff2n7vn7Y9xjOVQ+lJOVHJP5DrZ5exb9LGdACOMRwN6lsAf3Tu
	 f5B9Nn2vym9d432EWD7G9LmG2mDHoh40s4+f856va0r5QEXgnzDUEdFAOUvTJI0jMt
	 7alzLB5vcIj7S07VCtoKftwDHlE8KfTTq76k4KU0veIhhMUhCK57KHLu6pcOOgQASJ
	 Nswu8CMOqpiu4J+UojVpNJfqxaZFP62cMeypEVR4Su/Hn0/7EPnX68wUzDeGZNJnrW
	 5BX0vRhMtjn/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf tests: Restore -p flag to lock contention test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708175311.858850-1-irogers@google.com>
References: <20260708175311.858850-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:59:47 +0000
Message-Id: <20260708175948.567701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Adding the `-p` (pipe) flag to the global workload unconditional=
ly disables the stack filter tests.
--

--- Patch [1]: [PATCH v1] perf tests: Restore -p flag to lock contention te=
st ---
commit b4bb7054950dea7123c601308622ddcd596c94cf
Author: Ian Rogers <irogers@google.com>

perf tests: Restore -p flag to lock contention test

This commit restores the -p flag to the perf bench sched messaging workload
used by the lock contention test. By defaulting to pipes instead of
socketpairs, it ensures architectures like s390 generate sufficient lock
events for the BPF trace filtering logic to pass.

> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests=
/shell/lock_contention.sh
> index ba598370be738..5df9a0cd48a34 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -11,7 +11,8 @@ errout=3D$(mktemp /tmp/__perf_test.errout.XXXXX)
> =20
>  # Workload to generate lock contention.
>  # Using 1 group (-g 1) keeps runtime low while generating sufficient loc=
k events.
> -msg_workload=3D"perf bench sched messaging -g 1"
> +# We include -p (pipes) because socketpairs don't generate enough lock e=
vents on s390.
> +msg_workload=3D"perf bench sched messaging -g 1 -p"

[Severity: Medium]
Will adding the -p flag cause test_stack_filter() and=20
test_aggr_task_stack_filter() to unconditionally skip?

These tests explicitly verify filtering behavior by searching for unix_stre=
am=20
locks in tools/perf/tests/shell/lock_contention.sh:

test_stack_filter()
{
	echo "Testing perf lock contention --callstack-filter (w/ unix_stream)"
	perf lock contention -i ${perfdata} -v -q 2> ${result}
	if [ "$(grep -c unix_stream "${result}")" =3D "0" ]; then
		echo "[Skip] Could not find 'unix_stream'"
		return
	fi

Since pipes use pipe locks instead of AF_UNIX stream socket locks=20
(unix_stream), the shared perfdata profile will no longer contain these loc=
ks.=20

Does this mean we lose test suite coverage for the --callstack-filter optio=
n=20
across all architectures because the grep will always return 0?

> =20
>  cleanup() {
>  	rm -f ${perfdata}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708175311.8588=
50-1-irogers@google.com?part=3D1
