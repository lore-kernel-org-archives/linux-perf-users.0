Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AF3A4512
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482301; cv=none; b=osATm0HFJsS5xSQukGdOyn1hQxnU+BCl1vi38CbPZOd94xViDnOm9z3WI7b4v+keD+tM6NjD31hdjMPXjGmr4EpQFqo2cBUHxUOQlq61b8oxz/Qpmitn8t/7Asjz7N9X/ZFWHHP/QBqTVrddknXhqqHFHgHluonOo9qhv4DOfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482301; c=relaxed/simple;
	bh=mHJ0BpO4QXSS1SQnY4v6zIL3hQ3UJ5jecmlvl4jRdVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pals3mTW8QdFhozf5vdt85cwfQTLPp8Jgt3vJYqI865HmxcOmVSW0vrZ6ciZAAgxZoL+XfoSSmSHD10afTha3Ud1AiZgStT/VelpcIQS+NSk6YB3VbcXGNnuVoBTgDrlpeXrXAMhN+EGQwj0KG44sY0zZkC4OMYUs0cWycPq55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUI49yCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUI49yCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA691F00893;
	Wed,  3 Jun 2026 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482299;
	bh=mHJ0BpO4QXSS1SQnY4v6zIL3hQ3UJ5jecmlvl4jRdVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUI49yCfdLw0Pz/K+iu+uA1kORYHpPJckQpB7sSxxuN8GBhR5gNLpyFqh4aZpMdEs
	 awLWn+HSrqMZGRuNIVlFJV+ZTOruWrRNPq3WjH0NTwUtxqdR3FdHBmJQ/SWzAI4Vzq
	 LDM7wLYUERvsgt6gga1JcHMzQFVwNxKqDmXrwnh+IWAyvKdcCDamUQEM40XPH7KgZk
	 j5ULF/J10T7RH+WHWpbLhCBhmVC4yxlLVHxbfQX4k8IcdHTi4nSrfmRIluJLevfzvC
	 OdQBHJZqgBu5xwZYVNawqceiKmJibNhOMYfr1g+YiX5PyTiXJ8ywKeSUHufjyQtt6R
	 BPXYrzLqMvAjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/19] perf test: Add deterministic workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-5-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-5-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:24:58 +0000
Message-Id: <20260603102459.1DA691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Signed integer overflow in 'dt_work' multiplications.
--

commit 89c17c87c140a5545531995cc6d206a8c6fffd71
Author: James Clark <james.clark@linaro.org>

perf test: Add deterministic workload

This commit adds a deterministic workload to the perf test suite for testing
CPU trace decoding. It introduces a new test file that performs repeated
multiplications on a global variable to ensure a predictable execution path.

> diff --git a/tools/perf/tests/workloads/deterministic.c b/tools/perf/test=
s/workloads/deterministic.c
> new file mode 100644
> index 0000000000000..3caea8564043c
> --- /dev/null
> +++ b/tools/perf/tests/workloads/deterministic.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +int dt_work =3D 1234;

[Severity: Medium]
Will this signed integer overflow during the repeated multiplications?

Since dt_work is a 32-bit signed integer initialized to 1234 and is multipl=
ied
by 7 repeatedly across deterministic(), function1(), and function2(), the 8=
th
multiplication operation attempts to evaluate to 7,113,764,434.

This exceeds the maximum signed 32-bit integer limit of 2,147,483,647 and
triggers undefined behavior in C.

Could dt_work be declared as an unsigned int instead? If the perf tools are
compiled with Undefined Behavior Sanitizer enabled, this signed integer
overflow will cause the test workload to crash.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D5
