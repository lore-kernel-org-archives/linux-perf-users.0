Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406343;
	b=iUc16f4v5LInKxhCGbvR34Av969icFhGx5DgDKb6dDPeSsNNoIM0SmeAQSbP3iDOpuKb
	 Bf96qNNeo9BR/G/4lQVwRN8rk0OOSvRA8SKUiDqCBIHmnkLoQaJ8uzaNwiv+t2DIiznJH
	 PnNbD0z13qNsP2oXeYHPxtcefmBLw0NBkTwo4YyCz8yoMgr/P+i6pW+KmNXx7U/kG25Io
	 /+inc8YiP+yoYjghHniIBAWqaAARbHmhFbmEXmkSidGID+YyxQYvJ0q+zQu0r72b5DFpH
	 dpFkCf/tKynHQi9gagchEv3lIIjQYhavpLs8L6RcWh1isgR748RJpjCbNge2F9k6ofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406343;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DOIoOniqBzbktgySwrKpvouK5D4KqvnwxWuWRrJNr6Y=;
	b=NiB7jnRTIzYffHPKP47MOsuqr9bUaZfoGa4PkaRjHJA8Ha2d883DDZNG/hwFyCk5eJ04
	 pLNGr2eopny2hysE6vqoo8Fe+X8bQabP/ps5lkDvwS2jtuKdDQkm5bgwFhtkj5dH3jk5C
	 NCct8/c5Cj2ZJ1sZrVugM+Xz0Zo2nz32N3rxIGMksriLHeeYfUHTZJoyXn+fLqABUFV4X
	 cAnwlNRjV8JehXMwJ23W1d157QO8lq7LWUrnvr+FMO52/s8daAnICQw9Via0vUGeN8bFR
	 f7bIE2zT31DTZW93rn+lKWVTxqrR/e2UqWyWjA91cuFXkGV94/8/bEs41TyTGjm0XWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Np74bZXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F40606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Np74bZXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039D91F00A05;
	Wed, 11 Nov 2026 14:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406343;
	bh=DOIoOniqBzbktgySwrKpvouK5D4KqvnwxWuWRrJNr6Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Np74bZXawcaNWXj9hsHYhwfO2FdPbBNh7Ih5YyE5645wJxMrzjnBEmSWziEWpAV0n
	 2dSGs4VryVlf4Tm+vlKyeYM3IrgLV71shViPbauF9fQYU4+t/Pf4/Ltc62nijb5Zrd
	 /YVVgjFMhBAHi5XPztPiM7mHjkxwfuWglZYWJ1gWECEkVzYWWvYN3w86jrcNHfQsXm
	 20enUL6Bso8lmq9QuPouIpdnHp98TqVwsCB9rIZU56uWVtklCD+7wpx/712Ao/fPjQ
	 /JtVDUKISIkX5kS4vqA0rx2NBhRoxzhyffBMTC3fylEiWTmgufNtfhRt1t9bldnPbK
	 JIHdIY1tOEq4A==
Message-ID: <sashiko-outbox-209122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] perf jevents: Check the JSON keys a table may
 carry
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111132622.2349165-4-takano32@gmail.com>
References: <20261111041045.2031464-1-takano32@gmail.com>
 <20261111132622.2349165-1-takano32@gmail.com>
 <20261111132622.2349165-4-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:12:22 +0000
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
- [Low] perf tests: jevents_check.sh truncates test description and
  omits (no_mlock)
--

commit 92181aaa26288cfbfa72d268994737820fd76f90
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf jevents: Check the JSON keys a table may carry

This commit adds a --check option to jevents.py to validate JSON keys in
pmu-events tables, along with a check-jevents make target and a shell test.

> diff --git a/tools/perf/tests/shell/jevents_check.sh b/tools/perf/tests/s=
hell/jevents_check.sh
> new file mode 100755
> index 0000000000000..311ca5f5ab15e
> --- /dev/null
> +++ b/tools/perf/tests/shell/jevents_check.sh
> @@ -0,0 +1,62 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# perf jevents tests: --check reports a key the generator does not read,=
 and an
> +# architecture that is not there is an error rather than a clean tree.

[Severity: Low]
Does wrapping this header comment across two lines truncate the test
description in perf test?

In tools/perf/tests/tests-scripts.c, shell_test__description() reads only
the first non-shebang, non-SPDX comment line and stops, so perf test list
displays "perf jevents tests: --check reports a key the generator does not
read, and an".

Also, append_script() and shell_test__requisites() default needs_mlock to
true unless that single-line description ends with "(no_mlock)". Since this
script only runs jevents.py on temporary JSON files and never maps perf
event ring buffers, could the first comment line be a single-line
description ending with "(no_mlock)"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111132622.2349=
165-1-takano32@gmail.com?part=3D3
