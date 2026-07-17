Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20C1C5D59
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254523; cv=none; b=VEcNAgExVEbfgS7IyWyQYv8h5G/sZXqjiU84EuGu5LeFX/SpCKNbQIOh2v7jpVd4CvR6dMMnDe74jSiEw0HGcPO750brwPri50bslsshWS02fA0Z7pO5WAB4AK+xnb1611uIvYQT9IssiZ31K+PLsZtCBVRc1cWABSGoYbBoYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254523; c=relaxed/simple;
	bh=cMCD1N+BXR92V6OImQr0yHpzS8CuyYnxn8/ELiqclI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jgBmOV5Hb5a80ysFBhxJfPUM20wzR9iw9CjHNPUbyYWJ8PldKvMJg7+ANkhPa9Jq1SWrnBq98C07PrzBn97ja9WGHxQDTrek2nDym6a9BE9ES/h8JkByLdNHuvXCPcMFRG90BfyewJqFcU4b7LLhsrWHGU5Y4EExysOAT1KJszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onuUq5/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onuUq5/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FA01F000E9;
	Fri, 17 Jul 2026 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254522;
	bh=eUa2Q5MqKTn9g9zIMv7sBYVkVAVy09fTbJfKWvyGbIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onuUq5/1fVrji9f/vPmUaCRAPSTBDayFVM3aBNH9hrjNHlJJqARhh63lqmC2LQ2oJ
	 Bzt50j7rvbRL06OZC157H+IeIYWuTn0KdFE3mwuAh7kvHFzCV4GlFEv9w6tzHlGhiT
	 +gdOlyN5q2OT7b2XhhrChWtb1JyIgmtN8L2wg2wB3TN4L4yfBKx1+L3JxtAl3PiePB
	 YxPBkX93LHP+N9HcENvuaS5T/ilOGl+a91tSP/IOm3qLmTwAPzcXtbH2t1tZfywWkZ
	 b1I12C4+6qT3La1W4qOpCt0jorhBLIXB4R4flu+b6hOJlWqECRQ8ASUb3eXMIjrk5a
	 f9+XkrXoHjTzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/14] perf c2c: add function view type definitions
 and helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-4-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-4-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:15:21 +0000
Message-Id: <20260717021522.16FA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] symbol_name_equal() incorrectly returns false when both symbol p=
ointers are NULL, breaking the reflexivity property of equivalence relation=
s.
--

--- Patch [3]: [PATCH v3 03/14] perf c2c: add function view type definition=
s and helpers ---
commit 59fce059d2f2f9e78151ef993b4629ca2917c709
Author: Jiebin Sun <jiebin.sun@intel.com>
Subject: perf c2c: add function view type definitions and helpers

This commit introduces foundational type definitions and helper functions
for the perf c2c function view browser. It adds the perf_c2c_ext and
c2c_function_browser structures, alongside inline accessors and symbol
comparators.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index c50c8ca825c10..1ef5d08e81c39 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> +static __maybe_unused inline bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +{
> +	return a && b && arch__compare_symbol_names(a->name, b->name) =3D=3D 0;

[Severity: Medium]
If both 'a' and 'b' are NULL, this returns false. Does this cause issues
with reflexivity where two identical "unknown" symbols are treated as
distinct?

If this is used for grouping or looking up symbols, it might create
duplicate entries for NULL symbols or cause failed lookups.=20

Should this return true if both are NULL, or are NULL symbols guaranteed
never to be compared here?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D3
