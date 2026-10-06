Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308B1A2C0B
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304012; cv=none; b=oUolBtOUIn7mgdqRqW0e6+g0nQOjjEOiPxBfvF3X51Nj3AJ1psmNSCNOVxUt20PhYrpHFa6eepVJ4Ubsy9QyRg6+YX4/kzgGY/q8zNs6QJlG3qn/ZHb/KnmjtBh+7/Uds5rkvijBIFtXKuew7pqic/XJfHaoJ8g2esLeO24qlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304012; c=relaxed/simple;
	bh=CHSBBo/oAWuqM9CGHXL2fAiCf8YDRjIzCA7LoS6mAqs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=D95/2wz8QTN2LRcUWjyma3UttO14iUvguh5FUb1xaXO7fMWEP4TQnZRRq0pppPpdE/i3Gz57CA61cMPTPf3Ko49fG7tC1rajm7FzD5MoSXyJCJZdzjSH14FVqx1bKnm5dJkYaz2YQ0Jj0YXNOM2az4+nmAeYKAn/a518ZIqF5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO+uRQ+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO+uRQ+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC01F0089B;
	Tue,  6 Oct 2026 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304011;
	bh=DmQRlsj+vgFviO6mt03Ae6O61HA8po/6HaTkfLWwbYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MO+uRQ+L4af7dm63GBvgFArDkD2+FvTpPEUr6Yw0o+9sAGotwt8CNK7u6kXmd0AMz
	 sfQwPa3tR6zNjxgQRspuY4ksHZ8ZPmV70pS0rDxPMY/ZhRtjy6v4jJ93LSWUawNjFg
	 uN4EK6lZVOPXcZHZJZx7YmYBnfrJ1XVxn0HBEDZ+bX2AyIQ4b2Cm/7Hv6PiIeV/itG
	 Cuj1zJNdI5u1iUy7qsZv1jGN6p7rAv9XT1ClldvXoRKvuEg8xlE5Lq1PujpXZq0KOS
	 uGKTRPFAeMj78TThZfQjMXgyTeJZw5CYkNR6fC4PZzg68Pl4pWClUHz8i2rgl8QVfd
	 o6mtBdh0mNhbw==
Message-ID: <sashiko-outbox-162255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] perf test attr: Fix default stat metrics
 expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006161309.3078488-6-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
 <20261006161309.3078488-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:26:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: x86-specific hardcoded configs break attr tests on n=
on-x86
--

commit 6df29817a2edc466c96d59a9f6ec9a8a8616ca28
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: Fix default stat metrics expectations

This commit updates the perf stat default metrics test expectations to refl=
ect
changes in event grouping and execution. It also hardcodes raw hardware eve=
nt
encodings specifically seen on Intel and AMD architectures into the default
expectation files.

> diff --git a/tools/perf/tests/shell/attr/test-stat-default b/tools/perf/t=
ests/shell/attr/test-stat-default
> index 8dd27c1fb661f..e79bc56389fda 100644
> --- a/tools/perf/tests/shell/attr/test-stat-default
> +++ b/tools/perf/tests/shell/attr/test-stat-default

[ ... ]

> @@ -233,4 +233,32 @@ optional=3D1
>  fd=3D29
>  type=3D4
>  config=3D4269
> +optional=3D1
> +
> +# PERF_TYPE_RAW / instructions (core PMU sysfs event)
> +[event30:base-stat]
> +fd=3D30
> +type=3D4
> +config=3D192
> +optional=3D1

[Severity: Medium]
Does adding these strictly x86-specific event expectations cause the attr
tests to break on non-x86 architectures like ARM64?

Since commit b1c5efbfd92eb84d, standard events dynamically resolve to core =
PMU
sysfs/JSON events based on the host architecture (e.g., dynamic type 8,
config 0x8 on ARM64).

When the test is run on non-x86 architectures, the actual generated events
will use the local PMU type and config. Because these expectations do not
use platform-agnostic wildcards, they won't match the local PMU events.

The validation script in tools/perf/tests/shell/lib/attr.py tests
expectations bidirectionally. While optional=3D1 allows an expectation to be
missing from the actual events, the reverse direction strictly mandates that
every actual generated event matches an expectation:

tools/perf/tests/shell/lib/attr.py:compare()
    ...
    raise Fail(self, 'match failure')

Because the actual non-x86 events lack a matching expectation, the compare()
function will unconditionally raise this match failure for the unrecognized
actual events, breaking the suite on non-x86 platforms. Is there a way to
handle architectural variations dynamically here?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006161309.3078=
488-1-acme@kernel.org?part=3D5
