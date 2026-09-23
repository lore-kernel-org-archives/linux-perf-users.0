Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77F5616B3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182612; cv=none; b=fC/6RvW/sOMofBjRyQLKoadtBEuDqISHQIJPTlSZQswIdnrnxRHEmKxWlP+oiKR5InFGR/gr697b09putOz/0XhdH/K4nmoGqnfpYS2XQ3wonFgcvI3x2xNsraJRxEo1KruTdBcmVx7cBeG7gT2qkOGOmTLuog7UQogUmoYDFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182612; c=relaxed/simple;
	bh=fOvBsU5sAGD0H5AOUCkcGjihT3s+GlNCT3rtI9rYDIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SnlyyOeNhaMyD65Z7oW9YkSodTclT5kMM5n00fhgtEm5FcerpIbsF14VvvnE5qT0kMfkkv2EzjJJ0oOlmoziZBTWdPetbkQRL0vkqZD/IJGkZLhgPPRCgS/vZR/QRotgmqhTEQuE5lkr3RuO0JUfTFIQ6klEpB1k5xwAFUQ5ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3p6Pg2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3p6Pg2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62F61F000FF;
	Wed, 23 Sep 2026 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182611;
	bh=pqkYTEZP1TkDaHw43/UzV/6kQ3Lh+T/pcWKKy92WZXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m3p6Pg2K2TcIjUTbB+C/69wahJMcp6MQNub0YfSOxQE1l82NaYpdtLPwyofpoY9KU
	 qlNAgYADDtqYl/LFviC5Xr8qWh8++6nl/ZpUIIohdHt5ZUmv11PiGgi6M0Yn0ZillP
	 nOFETwuyA63Y/769xXrBwvddbohhlmQTc/iEpZXyhv3Mv1ZaG064sjVJDgrk+VqTtr
	 P1b7vEFjefeYezHbDztyGyf9T+5YnPy/2mOo1W41NO2uyY9IeponeBJNazgJLOlqcZ
	 UoIDjEE1K3qHaYuMsC9L8fAr4xc3dpGPlHB3IsD2Xdmh1Vy3qPd1enRyZ/P/sNJ3mV
	 pmVSihdMGxd+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] perf tests: Check CoreSight emulated
 instruction entry and exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-14-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-14-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:56:50 +0000
Message-Id: <20260923165650.C62F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf tests: test flakiness due to page faults on the emulated MR=
S instruction
--

commit 2d0bd9a9a4d9e3186e0f8fab3a726c18a86eb407
Author: Leo Yan <leo.yan@arm.com>

perf tests: Check CoreSight emulated instruction entry and exit

This commit adds a test to check CoreSight emulated instruction entry and
exit by recording traploop's EL0 read of ID_AA64ISAR0_EL1. It uses
instruction encoding to filter out irrelevant exceptions like page faults,
expecting a 4-byte PC advance for the emulated MRS instruction.

> diff --git a/tools/perf/tests/shell/coresight/trap_entry_exit.sh b/tools/=
perf/tests/shell/coresight/trap_entry_exit.sh
> new file mode 100755
> index 0000000000000..3ebd4033b247a
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/trap_entry_exit.sh
> @@ -0,0 +1,24 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# CoreSight emulated instruction entry and exit (exclusive)
> +
> +# shellcheck source=3D../lib/coresight_exception.sh
> +. "$(dirname "$0")/../lib/coresight_exception.sh"
> +
> +test_trap_entry_exit()
> +{
[ ... ]
> +	decode_trace || return 1
> +	# Page faults also appear as "int", but retry the same PC. Select MRS
> +	# Xt, ID_AA64ISAR0_EL1 by its encoding; the low five bits select Xt.
> +	check_exception_pairs "int.*insn: [01][[:xdigit:]] 06 38 d5" "iret" 4 |=
| return 1

[Severity: Medium]
Will this test become flaky if an instruction page fault occurs exactly on
the MRS instruction itself?

The test filters events using the MRS instruction encoding to skip
irrelevant page faults. However, if a page fault happens directly on the
MRS instruction, the exception type is still int and the fetched
instruction bytes will match the MRS encoding.

When the page fault is resolved, the kernel returns via iret to retry the
exact same PC, resulting in a PC difference of 0.

Since check_exception_pairs strictly enforces a PC difference of 4 for all
matched pairs, wouldn't this 0-byte advance cause the test to falsely
fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D14
