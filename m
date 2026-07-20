Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A482F7462
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546306; cv=none; b=T74POI2LIWSanrSyy7qe42m6J5WfFb2OirMmCWEb3jCB+KjrwyKogT9vddxajatl7MyBtp3gJpshegxncrJMt1RsgZ4fukTR4EC6FXcIF+iSj/OOvhWppgw7mlJl4aOxc3FmTTguGr2In8Exq+uLzkyhy2pKGviPRWjNjEn3iTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546306; c=relaxed/simple;
	bh=WvX283ZdSukkr7m2P/jFH8nTlefvriAgGMK/xrvLqqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oRnrskoYbnmFDPp7NDE0g39wJJvCHZbZb8z/7aOq83Ne0LqAm3smBvbbvoZ8wGpl+GECc8okHgDJVCzNI+AxCa8tWtCiSorim+5T/z9w8s6Zs13/3VT4Ls15QUZtXxipJNODEBvbk3c5+CWaiEln2Tpw67p69XGsTnPtydQb4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLrZ4j/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLrZ4j/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37591F00A3A;
	Mon, 20 Jul 2026 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784546305;
	bh=PAZlVkij6LDN34aBpu6RHkzJlEuzHcoCzNH4Zwd3Vyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLrZ4j/OWp2YyhzA5JJsYri9ufqWCgQXjXXnTw6c/kVWYW+zAfP4mhp9GMb8W3JVz
	 PTD9/ut0VSkSmEbDLKS38oOswBNICAKJjVDIEfy3twtCDuazFuyXyYnnaz94BnodSX
	 KJWAFV3v0nQB1DD09XILNlEEyqKlzzErPmnzjYftPr0STrFzhhc3cddN6HvpzhXMPq
	 tOkTWG4r10gUp14CA7zLSU9yBfVreGyikmR9YDpqJAaUe/R8/wct6H+VDsS+Q6cSgW
	 i6X/4ivkVcXsydaErLblhqLlurtM4vJQTpJlS27fiahF8Nu8zTeM9Lr5wqcpgaselk
	 UACEuwyTLPjTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 4/6] tools/perf: Add powerpc callback support for
 arch_perf_record__need_read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720105218.14277-5-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
 <20260720105218.14277-5-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:18:24 +0000
Message-Id: <20260720111824.E37591F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The function identifies HTM events using a highly brittle prefix=
 match on the event name (`strstarts(evsel->name, "htm")`), which will erro=
neously match unrelated user-named events or tracepoints.
- [Low] The file uses `strcmp()` and `bool` but fails to explicitly include=
 the standard POSIX headers `<string.h>` and `<stdbool.h>`, violating the s=
ubsystem musl compatibility guidelines.
- [Low] The string comparison against 'dummy:u' is mathematically unreachab=
le and constitutes dead code.
--

--- Patch [4]: [PATCH V2 4/6] tools/perf: Add powerpc callback support for =
arch_perf_record__need_read ---
commit 08efcd22d3e33aa6575dbd818f05eb3b46a80a92
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc callback support for arch_perf_record__need_read

Implement the arch_perf_record__need_read() architecture-specific hook
for powerpc in arch/powerpc/util/evsel.c. The hook reads event counts for
open htm evsels to determine if data is pending.

> diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/power=
pc/util/evsel.c
> index 2f733cdc8dbbe..8f2805a680261 100644
> --- a/tools/perf/arch/powerpc/util/evsel.c
> +++ b/tools/perf/arch/powerpc/util/evsel.c
> @@ -1,8 +1,77 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
> +#include <linux/string.h>
>  #include "util/evsel.h"
> +#include "util/record.h"
> +#include "util/evlist.h"
> +#include "util/debug.h"
> +#include <internal/xyarray.h>

[Severity: Low]
Does this file need to explicitly include <string.h> and <stdbool.h>?

This file uses bool and strcmp(), but relies on implicit inclusion or
<linux/string.h>. Compiling perf against musl libc requires direct inclusion
of standard POSIX headers for these types and functions to avoid build
failures.

[ ... ]

> +int arch_perf_record__need_read(struct evlist *evlist)
> +{
> +	struct evsel *evsel;

[ ... ]

> +	/* Read HTM event counts to check if more data is available */
> +	evlist__for_each_entry(evlist, evsel) {
> +		struct xyarray *xy =3D evsel->core.sample_id;
> +
> +		if (!evsel->name || !strstarts(evsel->name, "htm"))
> +			continue;

[Severity: Medium]
Is it safe to identify HTM events using a prefix match on the event name?

If a user traces a standard event and names it with an "htm" prefix (e.g.,
perf record -e cpu-cycles/name=3Dhtm_cycles/), this hook would falsely
identify it as an HTM event and read its event count.

For standard events, this count contains the actual accumulated hits, not t=
he
0/1 driver staging flag, causing total_pending_bytes to always be > 0. Would
this force arch_perf_record__need_read() to always return 1 and cause the
drain loop in record__final_data() to instantly abort with a spurious warni=
ng
about making no forward progress?

Would it be more robust to identify these events by checking the PMU type
instead of the name?

> +
> +		if (!strcmp(evsel->name, "dummy:u"))
> +			continue;

[Severity: Low]
Is this string comparison reachable?

The loop explicitly filters events above with:
if (!evsel->name || !strstarts(evsel->name, "htm")) continue;

Because "dummy:u" does not start with "htm", any "dummy:u" event is already
caught and skipped by the first condition, making this check dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720105218.1427=
7-1-atrajeev@linux.ibm.com?part=3D4
