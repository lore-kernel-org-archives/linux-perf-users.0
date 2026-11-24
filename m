Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546657;
	b=aCqOH/8DgPKDzyuag46wS/kgUTFuI7JS8ecbtKCB2bhkclytd/0zvqMxF5WNCUuz1n+c
	 EPKYrFarXsb04p2MlUb72CMKCcyLue1aSY5AG861nreWkh3aIpO4VmNW8EMndJhMwNw53
	 ws+Plux30m6mBDInb4Tq5NWJsrB0ybMaeIinqgM1H5zXEYjEzkEbzu0v+0hOA39CEXNkx
	 Zp2Xi8I6mYMeZj16qlDu6V3mdioSW1nnSJAe3kbBmcUFx5/GoxLoz1+eWEZKiUX7N72K8
	 TknXXpkxyTp9OeWs4sVxpHifUkmYhvGH+ADQwxuc/RFx4gzPStE9f1rw8hWZKy20LAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7QupmNOvUOJHNc1ByILZ4phjLTVSs/hKd/6e2jWGrjw=;
	b=IviUXC53YTgwmqBf1iWE2zIHT79vgley33w26u/s0yirWdVsJLgRYTfShMOb1j/l5Qf4
	 ZLgBxDcFypNIaiTenObfmIPCqhX4m8b0QzFfcUazcnUgF4E2iq169F1VtIhD+AJRRf+pm
	 KWXcuPfWNVBAQMjH0+thucJHIIKWXmx/DDmSLpirT3d4IQ5eKmo8eawS+R0ONlGKJYj1O
	 8RveaUg/WMWiEoxmCDs0HULbJMrG9aoSmpoMzUMA2eaZ5tpriSvxDOFZcWmedfGlUJ6nX
	 Th8GIlO6AlWH1SRGUXe6VeKUsCWR6ieBFWr7ODRn/fWnCcL1EHikXQkGEkFcySMwkfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZMy0T/4U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E2606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMy0T/4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75441F000E1;
	Tue, 24 Nov 2026 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546656;
	bh=7QupmNOvUOJHNc1ByILZ4phjLTVSs/hKd/6e2jWGrjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZMy0T/4UlttRr+dmrWYmn141MnT8mxFywlSscruJXneJSTSYALpWgJ3/2R5bNc6uo
	 DCPCOI/ewUn7gW+up5iGVd7qV11v68KT5IBqWh1iNI1WCEjxMJfRsq1OfC2Vl5HPcV
	 W0jTjBne8vV88QMmZJptVlG7PqjsPgNeQCYiJc8cUm+9EfhaWavNVf0gnqIQOBbCwt
	 /Ic4Y1tkhkOLXJhN/jg17ZGs7CxFofuzweXJW/QarTzrdj0MzHnidVVgaR2+jAyTxL
	 uc/h0BsNnAr2Hn6NY/XMwu3br7dIoDcXn2JAHwypErAg4qezMMUqO2CJmIT+xeWdJL
	 eavsZyPFkc+uw==
Message-ID: <sashiko-outbox-231867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/17] perf tests kmem: Add a basic perf kmem test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-14-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:57:36 +0000
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
- [Low] perf tests kmem: missing libtraceevent feature check in kmem.sh
--

commit 99c0cb23329714ac0762285488be24974461c863
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests kmem: Add a basic perf kmem test

This commit adds a shell test exercising perf kmem recording and stat
reporting for slab and page allocators.

> diff --git a/tools/perf/tests/shell/kmem.sh b/tools/perf/tests/shell/kmem=
.sh
> new file mode 100755
> index 0000000000000..c1eda5b2261f7
> --- /dev/null
> +++ b/tools/perf/tests/shell/kmem.sh
> @@ -0,0 +1,215 @@
> +#!/bin/bash
> +# perf kmem tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# Root permissions required for tracing events.
> +if [ "$(id -u)" !=3D 0 ]; then
> +	echo "[Skip] No root permission"
> +	exit 2
> +fi
> +
> +if [ ! -e /sys/kernel/tracing/events/kmem/kmalloc ] &&
> +   [ ! -e /sys/kernel/debug/tracing/events/kmem/kmalloc ]; then
> +	echo "[Skip] No kmem tracepoints"
> +	exit 2
> +fi

[Severity: Low]
Should this test also check "perf check feature -q libtraceevent" before
running?

When perf is built without libtraceevent (NO_LIBTRACEEVENT=3D1), cmd_kmem
is defined via DECLARE_LIBTRACEEVENT_STUB(kmem) and fails with -1.
Because the tracepoint check above inspects tracefs/debugfs directly and
set -e is active, test_kmem_record() will hit trap_cleanup() and exit
with 1 (failure) instead of 2 (skip).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D13
