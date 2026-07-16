Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738582F3C18
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187650; cv=none; b=ISIbklK2yoyPQOLgMopU9SlmF+QDKirUaHzWFV+5lzFc3mnPY8r0AE257jsmQYO7qIjDTeckwGP2opRQ9ygPskH3YVJq9VQfwlz3j0pei5vZdiIyHWGiKRaYfl64BPJtjJW3wJ7sjqpKplDOJuLFiNqLtepiVvtyhKEgVlBcRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187650; c=relaxed/simple;
	bh=yqOF1RJ03n7w88/+KtdhHJiWJr4pgY5YNd6NeSxA2v8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vF6jftXiG625/u3ggvvd40PEy2YQ3ypZBYeBlqYRoPx7hhEMdCCPS4QRwUivAVUlHHk8F89kT3RubtIArIecVJZsTNDOCddHsX7vvS+u2eBaO8ohaIe7xxJp6mqg/emeFcMfbMtJDKsQNy/tPk6J9rzfahYN29jcYla5haeMNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFIvuwWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFIvuwWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037D21F00A3D;
	Thu, 16 Jul 2026 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784187649;
	bh=yqOF1RJ03n7w88/+KtdhHJiWJr4pgY5YNd6NeSxA2v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFIvuwWjGL3DwfQRtfEw5sTEWpJkAiyLLBuO8cvpgF4DQgvLZpAPyu/GrQ6zDPo6h
	 Dpr8fBEHe2Z2gKsIg2pi0y9VJXQOU2ZKwT5ONsdbe6QoMx6+A3Y4Qjs3XzvAUa1Ird
	 k3tcy5BTLQzMvSKiFHPrc0W5wuCgp+NnGNClO74xCAfTBTpJCJtodLv91ENjk2+VPG
	 kPruzRZrsATHF1tqN3BN+16aLVUNX4zBVg0ka8JbTlG7EJ+xbLu4vuYIp3oOhQFL2I
	 B+BwAlNVoKB0r7s+y2gy9Or77fYGPZd0YBZzcuArw0TtULhZI8XQ2KoxQ65XLnbOA2
	 ad1e7hjrA2KPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] perf disasm: Fix potential NULL pointer
 dereference and use-after-free in arch__find()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716072351.560311-5-irogers@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
 <20260716072351.560311-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:40:48 +0000
Message-Id: <20260716074049.037D21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing explicit inclusions of POSIX standard headers `<stdio.h>`, =
`<limits.h>`, and `<string.h>`.
--

--- Patch [5]: [PATCH v6 05/10] perf disasm: Fix potential NULL pointer der=
eference and use-after-free in arch__find() ---
commit ca1fd445ff68f5d4f2326b24e16c260e3dc0cb4f
Author: Ian Rogers <irogers@google.com>

perf disasm: Fix potential NULL pointer dereference and use-after-free in a=
rch__find()

This commit fixes a NULL pointer dereference in the error path of
arch__find() by printing the e_machine ID instead of the uninitialized
name. It also prevents a use-after-free by correctly updating the global
archs pointer immediately after successfully reallocating memory.

Closes: https://lore.kernel.org/linux-perf-users/20260709035721.9EE901F000E=
9@smtp.kernel.org/

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 0a1a7e9cf3efe..6cfdbabbb8c7d 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c

[Severity: Low]
This isn't a bug introduced by this patch, but there is a pre-existing
issue in the include block at the top of tools/perf/util/disasm.c.

Because musl libc strictly separates declarations unlike glibc, missing
explicit inclusions of POSIX standard headers such as <stdio.h>, <limits.h>,
and <string.h> can cause compilation failures when building the perf tool
in a musl environment.

Could we add these explicit headers at the top of the file to ensure
consistent musl compatibility during the build?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716072351.5603=
11-1-irogers@google.com?part=3D5
