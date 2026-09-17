Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0E3769E4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627785; cv=none; b=XZC1MvRBFN44Hc0x0kZLaEe6qdw8J4UKz/OpncyMjsCqLF22LGhxFrT9s2x43TNpmtNZDj8rZVf1IUO7UK+oVlxol/fqHSEZwzZ1ptuiN0TSOAH7GATP+yUzBzygqcV9yGzLJ5yF4WP9rSjd8u2wtlwyaTDtbzFHlzqNbQsgny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627785; c=relaxed/simple;
	bh=LJDu4r266Hi3wQmLdzkr0lpnlBDtmoaLvkLZqfQCuAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6TzE6L9syld1/vx9TxEPpOURkfgggpw1crbOG+wRcJpm+1IbHDPKge5sOgUrDMh4jJF8AiegOFgPxYbWfRfXxAhsTMLNjk8vJSUZ54S1pmwZBVSQGP8U4JKlOE9yoy8Q+WovCe8oD/2JefBY5mtFG81bchxpgOKzatGZu4A+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgw8TM5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgw8TM5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A7C1F000FF;
	Thu, 17 Sep 2026 06:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627784;
	bh=UJkX8FT2EY/GVNdq0bF/hmU6KyT0Hs0RkLqabsmbIqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wgw8TM5IpCng7r1goVfdzJIeAnZjsFg2nLdQORretSZ6cb+5zifh25H1FglNBnFY2
	 B6ia5BaYbSRK4+kO8CWDdlb8hEeW6FORD3hqHUdBlx7s61xzIigq0zXDwiT1Jw9QMO
	 dpBT7KRr/aK0Aao4DjuzO+ZeQup85P+4oj83im71NJDuX13uFMuG1OfLM1wju70yDg
	 2pNLPBlAcZhLb5EfCTyznIlWst0UeuOuoHcSihk02tY9pdt7IOP67wYutbxYDuFr4B
	 Ip6RYGlnVJ1kv9ayLF1iAcK8MAO0U88aw7fenuITr0cFY9hbRA0Y5WIqIgTTXkACLC
	 3YgrVlPhdAO5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/13] perf test test_task_analyzer: Isolate in
 temporary directory and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d1ed9832b1d73eb04405a78425a1aa4afa4a8cb6.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <d1ed9832b1d73eb04405a78425a1aa4afa4a8cb6.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:49:43 +0000
Message-Id: <20260917064944.15A7C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: tmpdir leak on cd failure in test_task_analyzer.sh
--

commit dfb340cf14f6e7255460556df8553dcb2273aaae
Author: Ian Rogers <irogers@google.com>

perf test test_task_analyzer: Isolate in temporary directory and make non-e=
xclusive

This commit changes the test_task_analyzer script to resolve its execution
path absolutely, create a temporary directory, and change into it. This
isolates the test environment, allowing it to run in parallel without
collisions.

> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/te=
sts/shell/test_task_analyzer.sh
> index 0314412e63b43..6f729d9508f8d 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> @@ -1,8 +1,13 @@
>  #!/bin/bash
> -# perf script task-analyzer tests (exclusive)
> +# perf script task-analyzer tests
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +# Resolve the source directory before changing the working directory bel=
ow,
> +# $0 may be a relative path and would no longer resolve from $tmpdir.
> +perfdir=3D$(cd "$(dirname "$0")/../.." && pwd)
> +
>  tmpdir=3D$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
> +cd "$tmpdir" || exit 1

[Severity: Low]
Does this error path force an immediate exit before the cleanup trap is
established? If the change directory fails and the script exits here, it
appears the newly created temporary directory will be orphaned in /tmp.

>  # TODO: perf script report only supports input from the CWD perf.data fi=
le, make
>  # it support input from any file.
>  perfdata=3D"perf.data"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D6
