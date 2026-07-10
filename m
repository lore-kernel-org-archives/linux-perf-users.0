Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C83955FF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674077; cv=none; b=uhD3VQTRRwQZBBk12XZUi2hJhuEnK5mGHKvnOkw48eYOeQlqMA3vrq/UcoBucYXyPjVtu1mWBm2PEqijiB8XWx214qjXI4oOUtgDPseDfl8olDMAwK74yEI4elnflDqBc5FpudLxqXu4OaX+TLb4YiGr31Zq9BrrxTky9/eH8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674077; c=relaxed/simple;
	bh=FxMOOEQuRPIHHmPfLMlfkOxzFWf5+oQ3Ld5JKNdjTik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HmYEznxa/Uzy6rBfeMElP1Z3IED9I+Iwef7xch28Tg4silhU43JDz+u/0IgZPlDfo96SWZyOEPe7jjVn7d3sicMbRO4aGlj7yOv0mHJe0lQxR/xum22LwXBBDEJjnT3GY6NyGmTyk+uLmnqSm+P1pIJIQqPi8ZKzufta99KPR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr+Q5yCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr+Q5yCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DA71F00A3A;
	Fri, 10 Jul 2026 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783674075;
	bh=99ASRrrlVYZ/s3cXipadHn2v5fOdVrHxllGL1LMEpCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gr+Q5yCOuy1HuInFpzZbqHxeY4gRPvctc1tYdJ2SJKZPwKMXDx95SVMYBs/x2kxoY
	 hPGAUFrNOL0rFrXRXBwMT8mcyk4eD9CuMLd3RBxYWdjLAFZUWzFvLowQ8E9xqSry8Y
	 nRZeQHI3FZiX1ikv9EMbi9Jge3CEq3eNX8xu+9bE6TwWCplpRMmduEnhsa4bwFQOKw
	 q+X1g9wZ60nn3/sP6V4D6OXkeESTFhO7dHEpzEkwTMGXZCr42Duk/J1yRW442wDHNT
	 /HWEgTctvrnDnQXzYEWLxrH57sxzgV/ZYxeMt45j1fRBiuOfax4QawOV9aLc81FZol
	 num897RTFDHsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] perf c2c: add function view hierarchy builder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710084247.3576706-12-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260710084247.3576706-12-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:01:15 +0000
Message-Id: <20260710090115.B9DA71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stranded entries in `entries_in` are leaked on the error path be=
cause `hists__collapse_resort` can abort early.
--

--- Patch [11]: [PATCH v2 11/14] perf c2c: add function view hierarchy buil=
der ---
commit 7fa08f7966668758027f5725f57fcfebac5eaf48
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view hierarchy builder

This patch adds the core algorithm to construct a 3-level function view
for perf c2c. It traverses cacheline entries to build the hierarchy and
aggregates C2C statistics at each level.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 47d6fdf66b47b..80e032d5e31c5 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +static __maybe_unused int build_function_view_hierarchy(void)
> +{

[ ... ]

> +out_err:
> +	/*
> +	 * On error, migrate any entries still in entries_in to entries and
> +	 * delete them, so a later rebuild does not strand them (the top-level
> +	 * __hists__init() memset would otherwise lose the pointers).
> +	 */
> +	hists__collapse_resort(&c2c_ext.function_hists.hists, NULL);
> +	hists__output_resort(&c2c_ext.function_hists.hists, NULL);
> +	hists__delete_entries(&c2c_ext.function_hists.hists);

[Severity: Medium]
Does this error path leak memory if hists__collapse_resort() aborts early?

Looking at hists__collapse_resort() in tools/perf/util/hist.c, it can exit
early if session_done() is true or if hists__collapse_insert_entry() fails:

tools/perf/util/hist.c:hists__collapse_resort() {
    ...
	while (next) {
		if (session_done())
			break;
		n =3D rb_entry(next, struct hist_entry, rb_node_in);
		next =3D rb_next(&n->rb_node_in);

		rb_erase_cached(&n->rb_node_in, root);
		ret =3D hists__collapse_insert_entry(hists, &hists->entries_collapsed, n);
		if (ret < 0)
			return -1;
    ...
}

If it exits early, the remaining unprocessed nodes are left behind in
entries_in. Since hists__delete_entries() only deletes from the main
entries trees, these stranded nodes will be permanently leaked.

Would it be better to use hists__delete_all_entries(&c2c_ext.function_hists=
.hists)
here instead to ensure both entries and entries_in are properly cleaned up?

> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710084247.3576=
706-1-jiebin.sun@intel.com?part=3D11
