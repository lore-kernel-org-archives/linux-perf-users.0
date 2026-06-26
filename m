Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A041684B0
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458267; cv=none; b=qlLbw0YIH9SJcOFBb0VwlHj2MlpkYXQcKy7xCc9CPhJkx6El6Ub1PHtmonzm3jt6RzrkCY0iEGBVJpAPNZvHyNWp1SAOFZnmyouzbQZOknYBH5fXF/YuX/cUDquE4zVaVwuHiRnaCrxhFPpmm+5/kM2j6FYJ2CKXOuQSklZx70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458267; c=relaxed/simple;
	bh=RnmGGr6a+B+Vz1OP3Jtp/7i1W0WQIewzW3dAqymnrHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ppb0pVKzoGPIiquEUGjAbthjhoGc/ow6HpIRwdfAoVh1HNMnOAPA9y1VkvDXbJuU9sc0p6q1nxPBNqSUMqeeUgRqdjS6BYJ3d0CK07UrrWI3nvtgrCzgbJxQqVFHsKGaQTjK9GkGC2eYSL1bi0jf/rQOS5hHuoVrJgaHGA84NXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScHHs86t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScHHs86t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59FF1F000E9;
	Fri, 26 Jun 2026 07:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458266;
	bh=g76sThX2HSwcl3zGvFJP90Hs2W2mZ31M08ZfI9Ypwws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScHHs86t2kog+pDSi+bFoTQ8DD9tQw/m6M8GiOGr33qgQ78v8MAhk/WZRMFI8U5Vc
	 vbb+CNqsW+FqRDdTEfWq/gstQ+orIU085wdxXokRXKIO1TDU7Y594yZHVf2GYDxHRV
	 +lF9Kr0H0SIDUfAQ7N+mtrV+rNCWrkll0OOLWdXCZaNI/+bigm/ROBYAkP/9DNUvMq
	 lCQ1f70gbx4E3r+xPv+y3JX89pSXwMvd8QxIhawspaGFELjG/O+Hn6bPEdM/XAMNcN
	 VKETvMl3rN3bfD/Xlh/O/ljKDr7D32CKHxnE3E4ukzjJWQp2gszlME3OHU9tNTd4x8
	 4BY39R6trT7Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/14] perf c2c: add stats merging and memory management
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-10-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-10-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:17:45 +0000
Message-Id: <20260626071745.E59FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of nested histogram entries because `hists__delete_e=
ntries()` is used instead of `hists__delete_all_entries()`.
--

commit d68acbe4d76a46f5dbb0cda5a255e3f5f919e159
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add stats merging and memory management helpers

This commit adds statistics aggregation and memory management functions for
function view histogram entries, including c2c_stats_merge(),
c2c_function_he_free(), and c2c_he__free_hierarchy() to handle merging and
recursive cleanup during hierarchy construction.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index c11a81d93c21e..a42378f395f59 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> @@ -649,6 +649,164 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hi=
sts,
[ ... ]
> +/*
> + * Free a function-view histogram entry (hist_entry_ops::free).
> + */
> +static void c2c_function_he_free(void *ptr)
> +{
> +	struct hist_entry *he =3D ptr;
> +	struct c2c_hist_entry *c2c_he;
> +
> +	c2c_he =3D container_of(he, struct c2c_hist_entry, he);
> +
> +	if (c2c_he->hists) {
> +		perf_hpp__reset_output_field(&c2c_he->hists->list);
> +		hists__delete_entries(&c2c_he->hists->hists);

[Severity: Medium]
Does this code leak nested histogram entries that haven't reached the output
sorted stage?

hists__delete_entries() only iterates over and frees entries in the output
tree. Any entries left in the input or collapsed trees might not be freed.

Should this be hists__delete_all_entries() to prevent leaking these
unprocessed entries, similar to the cleanup handling in builtin-c2c.c?

> +		zfree(&c2c_he->hists);
> +	}
> +
> +	c2c_he__free_hierarchy(he);
> +
[ ... ]
> +static void c2c_he__free_hierarchy(struct hist_entry *he)
> +{
> +	struct rb_node *nd;
> +	struct hist_entry *child_he;
> +	struct c2c_hist_entry *child_c2c;
> +
[ ... ]
> +	nd =3D rb_first_cached(&he->hroot_out);
> +	while (nd) {
> +		struct rb_node *next =3D rb_next(nd);
> +
> +		child_he =3D rb_entry(nd, struct hist_entry, rb_node);
> +		child_c2c =3D container_of(child_he, struct c2c_hist_entry, he);
> +
> +		if (child_he->stat_acc)
> +			zfree(&child_he->stat_acc);
> +
> +		if (child_he->mem_info)
> +			mem_info__put(child_he->mem_info);
> +
> +		if (child_c2c->hists) {
> +			perf_hpp__reset_output_field(&child_c2c->hists->list);
> +			hists__delete_entries(&child_c2c->hists->hists);

[Severity: Medium]
Could this recursive hierarchy deletion also leak histogram entries?

Like the issue above in c2c_function_he_free(), using hists__delete_entries=
()
instead of hists__delete_all_entries() skips freeing any entries that are
still in the input or collapsed trees.

> +			zfree(&child_c2c->hists);
> +		}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D9
