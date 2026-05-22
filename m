Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF38368277
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488019; cv=none; b=bX9y63gqBkSyk0P8IFUWoRKuYVNA2JCT/q8aJkJjkahIqFrcI/JDbvNvy5K7QbJQfhdQE1KfPWmlTK5Kco+F4YamBXMviuoYVQ2pcx/OnoBl3sjCR1llE+Wcw7NlbooPclAPGTz2E7Nw7U0KWQFKRGopqyBlNzR3Z+9sWE9Nats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488019; c=relaxed/simple;
	bh=It4VrFz9XFnQeV9/1vodzlHj0xhbdkH0/s/YHcPnz28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCiBT6YSDbUsLH4hfJVTNqRLRgXpCKN47rw9Qmqf77JxA8Rso6mpZsxYC4eQjnxRvt0a+cbXw250jBc/ELA6AKhgSnLX+TX4GpirpcV1LvYGlIavvCUoRW81W+JnOlkHMlL71Pb/7ufLUob8ikjJ9w/k/X+Cd4EacA4mvlXUygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKlAHfbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKlAHfbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039751F000E9;
	Fri, 22 May 2026 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488018;
	bh=6QXsVhJZeEsvf1wghnfWEiBoxmk0MFgVPjytUSvhqmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hKlAHfbEAeJBkrQYrf0lYEspx162BKx7Ud8N7SM2JTdauXnEFHQljTqFrwogMDneX
	 PPZTZtcVuHqDqtvJlMNt717MdeMC7hnKCe1XV1/gYjhD1jiTd4Dy+av7TcME4KWO0U
	 y4ePhuj048VMmDAJNgeSb6FhSRDla76RNlhMbFKqwO7BcwE5QdeyR8HgbdyUu42gAK
	 1WaGk1LauvCQ223e8jW9yUPR7pmzAWuWih3axdtzTXe1x98jyTiIFI72y1Q/0ntYOa
	 B3EI7CpGDZGwSS5IgSXU6lms/mBOWtzZENZJK4qDQc9dShEcPgMbxm/nrcXUixZlH+
	 9bCXWxDxKXlGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/23] perf python: Add missed explicit dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-7-irogers@google.com>
References: <20260522220435.2378363-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:13:37 +0000
Message-Id: <20260522221338.039751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Including `<Python.h>` after standard system headers violates th=
e Python C-API contract and can lead to macro redefinition warnings, build =
failures, or ABI mismatches.
--

commit 37ded89f453597ef269f0bcb73c5907738b8e5d9
Author: Ian Rogers <irogers@google.com>

perf python: Add missed explicit dependencies

This commit fixes a missing include of pmus.h that was discovered
while cleaning up the evsel and evlist header files. It also sorts
the include directives alphabetically.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc1019d29a5d0..dd937d714e991 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1,30 +1,35 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <Python.h>
> -#include <structmember.h>
>  #include <inttypes.h>
> -#include <poll.h>
> +
>  #include <linux/err.h>
> +#include <poll.h>
> +
> +#include <Python.h>

[Severity: Medium]
Could moving Python.h here cause build warnings or ABI mismatches?

The Python C API requires that Python.h must be included before any
standard system headers. Python.h defines preprocessor macros that
alter the behavior of standard headers. Because this alphabetizes the
list, standard headers like inttypes.h and poll.h are now included
before Python.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D6
