Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B136654F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887966; cv=none; b=Mod/KZRHjlydTZ4aG4EDdn284W4oa8Hy0JmVa6w5P6FwazqdI84Byh3whpNBPh7ptfAf5GKVFvqqSLKsWrLqljt+o4+cAla9mrjrnvD4e3Ax3FVndE7ff7ocpFs21DVOgnKSKHh4hE/ou+eNX19hncprji98dfNOnF8+lM5hGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887966; c=relaxed/simple;
	bh=zexg5Nh7cIMT5/JREy80j4R9hoQg8eEwIBgF3FAScX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pWa/wtqxFTJWHJN5NQW+n/gb3yuuvn+KCQ9d3KhLnzo9pOID6BqoM6MHH2KAL8Xpn519trCFrBbu8ZxMR7orOIasFkHHcpWd4c3tEyyCsjGtQ6uk/nsh1PE6jDlTKxJT4/+KmpqoRsW5rVkHU/rpi3IQjkdGAINnDmja5JsnKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwPntDPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwPntDPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1C01F000E9;
	Fri, 24 Jul 2026 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887964;
	bh=cz6A3cIV2y0HDx8OLISBMM2XEauh5pmBOeapXk1Hh3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwPntDPN1yKP1Wzy8YF00XqOcD3kRe6EOUK1X8UTWtaafPIxqNarq3icjX2XWc/qh
	 Odaiw/FyCErlqqQAyZXTKUkN3s2Lse2rm0xFu61vKd33Xgd0Cz/UjLY4ieVDp6qdPl
	 QPYLb8sUc5H7q5APqH2l1teCJihAjQHD8KsgAmKzyqQ9keZyegF6bOBrGIBsv+ekBc
	 ihvo9DrakLnwq1h5AfpI/1ls3bPLcY0kmlZwMvVETkC8hnH7AiTTAfOJmUv1qBWk0U
	 IfXfTRf2NrvkmfTdZG4kUhLNNYbjjufpFrS8v0j+6r4LHccEX946vgyVrITofXtfEg
	 SUcZzxiIdGR2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] perf c2c: add function view browser skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724095842.995920-3-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
 <20260724095842.995920-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:12:43 +0000
Message-Id: <20260724101244.5D1C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit header inclusions for `bool`, `u64`, and `__maybe_=
unused`.
--

--- Patch [2]: [PATCH v4 2/9] perf c2c: add function view browser skeleton =
---
commit c25169191e0e48643ab4ff1b7b22eb6d0762403b
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view browser skeleton

This commit adds the skeleton of the c2c function view, introducing a new
TUI browser in tools/perf/ui/browsers/c2c-function.c. It wires up the entry
point, registers the file in the build, and adds the TAB key handler to the
cacheline browser.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> new file mode 100644
> index 0000000000000..3f6822f616004
> --- /dev/null
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +#include <linux/list.h>
> +#include <linux/rbtree.h>
> +#include <linux/zalloc.h>
> +
> +#include "../browser.h"

[ ... ]

> +struct perf_c2c_ext {
> +	struct c2c_hists	function_hists;
> +	/* Cached across all level-1 entries; 0 means "not yet computed". */
> +	u64			total_cycles;
> +};

[Severity: Low]
Does this file need explicit header inclusions for u64, bool, and
__maybe_unused?

Code compiled under musl libc strictly separates declarations and may fail =
to
build if headers are not explicitly included. Including <linux/types.h> for
u64, <stdbool.h> for bool, and <linux/compiler.h> for __maybe_unused would
ensure compatibility and prevent build breakages on environments with strict
standard library separations.

> +
> +static struct perf_c2c_ext c2c_ext __maybe_unused;
> +
> +struct c2c_function_browser {
> +	struct hist_browser	hb;
> +};
> +
> +static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *=
stats)
> +{
> +	return stats->tot_hitm;
> +}
> +
> +static inline __maybe_unused bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +{
> +	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.=
c. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724095842.9959=
20-1-jiebin.sun@intel.com?part=3D2
