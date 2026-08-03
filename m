Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9037B01E
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729695; cv=none; b=nxV1wr69lCsdE6MeVjaKiuFFOZrEPWeasXhF4YVjCnwLv1vrzm5n1CjSK3F1QUEAyKpCuhepKFhx/Av0JiZbivCa0YVTjNiv+T/K0bhR4P1jzpFyZ35z91oyInyFIWjZQ1Wf4NN9i8fMoXs3BW0SDQg8CeiFVb37DzcmzZSyyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729695; c=relaxed/simple;
	bh=iPMKn5NFPGvxEE7Y2BpYAC/rFGKicKPUVbwClrWYFDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IMva3Ueodk0mX+yj17KYP3tkffqRTZT6hmYkD176ntP3hnSUgJjMNwfWm6wTMkjNWPbpi++2Udv/KqA+VEAmqTH6z8LS8ZsVDbyiHgD2x7Tpb8pG6hcp32wuF+lavopsX+PCVmwLulwn+L5GCMIJWJmSS0UiRwipxHtBovHYb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3PrxlOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3PrxlOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC001F000E9;
	Mon,  3 Aug 2026 04:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785729691;
	bh=h7ePshQOEeE638NNwI4lqq6JYQz3NJyo3IVMhKPKEVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3PrxlOncI8YVQ0n0gFiWwZi4WDXZfZmIZKmOtSglIGfqWcVYsie4HL9Hiy0Ae0Wb
	 7aXv0VlAm5gpdxj2XJ4oZz8kBJygEgNvBW2r91eli3kD+h1IdnCyTq4nhmefCC5wa+
	 RhBJllYTLbh0BaCQT5u38/mhyynV3Sgqk9FQmMgRrxeZ9tHw4TcDp3wjVTIuSGlQYf
	 Kwj/jM8Kbyv3UzlQQobpCXKONgjeMZGbkfxCiA/34jEaVoK8YPU0FOZqWm4oiyTf5o
	 A/M5seLpZmjmxZdmXd+fVH3jjksa7kXtgezBZeNME9HIygbl00OSVnivleIVfNrtNl
	 hbV/CoVRfPnRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] perf c2c: add function view stats merge and
 memory management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803035220.172022-6-jiebin.sun@intel.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
 <20260803035220.172022-6-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 04:01:31 +0000
Message-Id: <20260803040131.6BC001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Pruning level-2 writers leaves dangling pointers in `hroot_in` t=
ree.
--

--- Patch [5]: [PATCH v6 5/9] perf c2c: add function view stats merge and m=
emory management ---
commit 0e7c26167764aee56c787657f5359beaaecb5f75
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view stats merge and memory management

Add the per-entry stats/cstats aggregation helpers and hierarchy teardown.
Child common fields are released through hist_entry__delete(), while the
function-view free callback handles the private child tree and containing
allocation. Also add a helper for pruning writer entries with no stores or
cacheline children.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 7e26c4d1147f4..fc9a4c4bcb03f 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -683,6 +683,168 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hi=
sts,

[ ... ]

> +static int __maybe_unused c2c_he__prune_empty_writers(struct hist_entry =
*l1_he)
> +{
> +	struct rb_node *nd;
> +	int surviving =3D 0;
> +
> +	if (!l1_he->has_children)
> +		return 0;
> +
> +	nd =3D rb_first_cached(&l1_he->hroot_out);
> +	while (nd) {
> +		struct rb_node *next =3D rb_next(nd);
> +		struct hist_entry *l2_he =3D rb_entry(nd, struct hist_entry, rb_node);
> +
> +		if (l2_he->has_children && hist_entry__displayed_stores(l2_he) > 0) {
> +			surviving++;
> +		} else {
> +			rb_erase_cached(&l2_he->rb_node, &l1_he->hroot_out);
> +			hist_entry__delete(l2_he);

[Severity: Medium]
Will this leave a dangling pointer in the parent's hroot_in tree?

When hist_entry__delete() frees l2_he in c2c_he__prune_empty_writers(), it
appears to only be unlinked from l1_he->hroot_out. If l1_he->hroot_in is
subsequently traversed (for example, during a TUI resort operation like
hists__hierarchy_output_resort()), could this lead to a use-after-free
crash when dereferencing the freed l2_he pointer?

> +		}
> +		nd =3D next;
> +	}
> +
> +	if (!surviving) {
> +		l1_he->hroot_out =3D RB_ROOT_CACHED;
> +		l1_he->has_children =3D false;
> +		l1_he->unfolded =3D false;
> +	}
> +	return surviving;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803035220.1720=
22-1-jiebin.sun@intel.com?part=3D5
