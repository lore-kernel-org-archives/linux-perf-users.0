Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683E286415
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254549; cv=none; b=TDcVYrN3Fs7hEQyw21mJfl1LZHQaVFQsfkjSoXXpjSBasCB/7NIKrWEEEQ8OFCMgU3XT0/5ysZ/dTJGZ2idy7Woir4OPCoGqNulKlHPsFYlcOaCLtEqBF3lLeLsL0b1an1l0SyAAdilNVI8X51XMpdiKFkTH3VqviholR1wz6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254549; c=relaxed/simple;
	bh=LIy6/4zQD2qbciuv5O33eA/mf+sgCYA2BbeKGwkkHF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+o2TQi3ukNyW+9t9DqN8kEp4mPN1YWQ99awvzVcE9JEaLNzEh7JEX/Yu80wmeokwuQbbqTm/sYypnuuWTHnXkxBSXPCmZVrNw9hREZ4TyyZyoRcoLgyj62CVM2rf1AfI3ALOQZly+iTQsavsfPDOJu6QHxsJ0pPC9k5HtP7OAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUXgvAj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUXgvAj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F283B1F000E9;
	Fri, 17 Jul 2026 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254548;
	bh=AxhO7xaxnG8I+4FcODa0WPyMg6GdSt3e5bcftnsDedw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BUXgvAj0s4Yt7IjP/5HylGBoOMddXsD0SWrDOqDwXRlGxLzQcDezkev4ALXBsn4SF
	 R8v3ezmjnUmBB+HMd4UaSsmN0EdrtIf9SFcTo5CxXdk+a49TiCCclusEcoVilqIFh1
	 DHoLWcwJQE4hlqBpS6dXLhysKIB6itgrQUV0KM6mGXFh68Y2uVjUAwa80iWwv+22pa
	 pJvih2exErpwYL56U9mIuFUC1yZfaC92jVXe950bYW19dPVTPqhogtJpXr9EEFIRMt
	 5RlFtgbZlI2e5OMcQGt+quS++ZRoU1Mq2VsIOMutJ9amektpxmqWH5kg7x81WUrUmx
	 8vn0oG+5jf2eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] perf c2c: add function view browser skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-3-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:15:47 +0000
Message-Id: <20260717021547.F283B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing header fallback stubs for optional UI features in `tools/pe=
rf/c2c.h`
- [Low] Comment in `c2c-function.c` directly contradicts the `c2c_hist_entr=
y` struct definition regarding per-entry state.
--

--- Patch [2]: [PATCH v3 02/14] perf c2c: add function view browser skeleto=
n ---
commit 828f082bf7b49b53ad3bfe52de9accfa632ad4f5
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view browser skeleton

This patch adds a skeleton for the c2c function view browser. It introduces
c2c-function.c with a stub perf_c2c__browse_function_view() entry point and
registers it in the build system.

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> index 79dbd35184eda..6fc3fda40fb6c 100644
> --- a/tools/perf/c2c.h
> +++ b/tools/perf/c2c.h
> @@ -142,6 +142,7 @@ bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct per=
f_hpp_fmt *b);
> =20
>  #ifdef HAVE_SLANG_SUPPORT
>  int perf_c2c__browse_cacheline(struct hist_entry *he);
> +int perf_c2c__browse_function_view(struct hists *hists);
>  #endif

[Severity: Low]
Should this feature guard include an #else block with dummy inline stubs?
The perf tools subsystem guidelines mention that header files should provide
fallback stubs (e.g., returning -ENOTSUPP) when a feature define is absent
to prevent build failures if callers miss the #ifdef guards.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> new file mode 100644
> index 0000000000000..c50c8ca825c10
> --- /dev/null
> +++ b/tools/perf/ui/browsers/c2c-function.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C2C Function Browser - function-level cacheline sharing analysis
> + *
> + * Planned UI: 3-level hierarchy showing which functions share cacheline=
s (not implemented yet):
> + *   Level 1: Primary functions sorted by Cycles % (estimated load cycle=
s)
> + *   Level 2: Other functions sharing cachelines with the level-1 functi=
on
> + *   Level 3: Specific shared cachelines between each pair of functions
> + *
> + * Uses c2c_hist_entry->hists to build the hierarchy without adding any
> + * per-entry state to the existing c2c data structures.
> + */

[Severity: Low]
This isn't a bug, but is this comment accurate regarding per-entry state?=20
It mentions avoiding adding any per-entry state to existing data structures,
but it looks like child_stores was added to struct c2c_hist_entry
specifically for this function view.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D2
