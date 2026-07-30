Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10933F4125
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403816; cv=none; b=fetIQ4ZHkflRsr2gyatfnNnUOLxQmP5O/JaNUSvrlSSiCYoANAJ8Srr9YpGCT8EQfXfxnUYIh8t9xcpCBVMLszoN0iRdg8RdQ10VQIjT55rsD/BJI6BHpI3bwzK8YlYWGLsuyjRgiJAdXZ6rTFVR6VF1ZG47L0G4MsSrX4MajwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403816; c=relaxed/simple;
	bh=G1krHI58UttjandMcSoMfZpdBdC86aghkwFgHbNCntA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jtvPvK1QhT6DSFwMGvSzyiari9wVCd5sGedrESFeV5Fp0BCVOe0HgUgkri0zGSQwkzrruU+6bdiQeKMW26aFYXvdQXqiQDecCnhihc/W76zhF4tB/pdMTdAM2NO1D3tEQbRfA/H/VPBUm0J6EH+a/E6Q87Ldz/+H1S4Kkhq2SRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImKJF5ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImKJF5ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDCA1F000E9;
	Thu, 30 Jul 2026 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785403815;
	bh=+YxbymiNbMF2MLJ4dUMsAsatQy+I8NlUAOKTfslLHZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImKJF5ve+l/MRFq8bDrcOM0j5Iz88d8PmUYn/PpbNzGjrYYRt062vAdn+DJuI84Zg
	 JEig3IY3Idu4hh/BkKpCRUgbSMODT+sLE0bNomLFDin/ov0Nk7kaL3GzZGALR9uDgW
	 4VfQHr/twEbK4azZY9bk92L+LRrYWnFDBP2LhZCF5neN6ND2kOg5By+gd9nkz8ZWlf
	 gHIFZsszbt4LIEbI8fxo/DdAKCy1kd7K4z4xq343IH0sO+yqcINvG0RCH2ml7q32Ee
	 +/UlIizyxmRscD3zdl0q7rE1ZNN4zRNqeXCvVoo5CFjpx9EG6AwUP/RrDwjx9O4ul/
	 8M0TnQVQIalDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 v5 8/9] perf c2c: add function view browser UI and
 cacheline detail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260730090521.2206375-9-jiebin.sun@intel.com>
References: <20260730090521.2206375-1-jiebin.sun@intel.com>
 <20260730090521.2206375-9-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:30:14 +0000
Message-Id: <20260730093015.1FDCA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Raw pointer assignment of reference-counted `struct thread` and `s=
truct map_symbol` bypasses pointer handle validation and reference count li=
fecycle checking.
--

--- Patch [8]: [PATCH v5 v5 8/9] perf c2c: add function view browser UI and=
 cacheline detail ---
commit 88acf11c42d184996fd7a80ec56730143d63b227
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view browser UI and cacheline detail
   =20
Add the browser front end: create/run/delete the hist_browser and add the
title. The d shortcut opens the existing per-cacheline detail view for the
selected level-3 cacheline. Level-3 entries retain the source cacheline
index, so the shortcut can locate the original entry without relying on a
potentially ambiguous virtual address.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 9a95355eedf50..44fb072fa9371 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -1591,8 +1650,182 @@ static int __maybe_unused build_function_view_hie=
rarchy(void)
>  	return ret;
>  }
> =20
[ ... ]
> +static struct c2c_function_browser *c2c_function_browser__new(struct his=
ts *hists)
> +{
[ ... ]
> +	/*
> +	 * Note: symbol_conf.report_hierarchy is deliberately left unset.
> +	 * The generic browser still descends into hroot_out children via
> +	 * rb_hierarchy_next()/can_goto_child(), which key off he->unfolded,
> +	 * so 'e'/'+' expands L1 -> L2 -> L3 correctly. Setting the flag would
> +	 * additionally make hist_entry__delete() recurse hroot_out and free
> +	 * each child, but our children borrow thread/ms (see
> +	 * c2c_child_entry__alloc()), so that would underflow their refcounts.
> +	 * Teardown is handled by c2c_he__free_hierarchy() instead.
> +	 */
> +	return browser;
> +}

[Severity: High]
Does this code safely manage the reference counts for struct thread and str=
uct
map_symbol?

The comment mentions that the child entries borrow thread and ms references
from the parent in c2c_child_entry__alloc(). This relies on raw memory copi=
es
and pointer assignments instead of explicit reference acquisitions:

c2c_child_entry__alloc() {
    ...
    memcpy(&child_he->ms, &src_he->ms, sizeof(struct map_symbol));
    ...
    child_he->thread =3D src_he->thread;
    ...
}

When built with REFCNT_CHECKING, pointer handles are validated to track
lifecycle state. If we bypass the explicit thread__get() and map__get()
lifecycle helpers, could this raw aliasing corrupt the tracking and lead to
use-after-free crashes or false positive traps when the borrowed references
are later used?

> +/*
> + * perf_c2c__browse_function_view - Browse function view with TAB key su=
pport
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +int perf_c2c__browse_function_view(void)
> +{
[ ... ]
> +	/*
> +	 * The level-2/3 children borrow thread/ms (see c2c_child_entry__alloc(=
))
> +	 * and are torn down by c2c_he__free_hierarchy(). report_hierarchy would
> +	 * make hist_entry__delete() recurse into hroot_out and put those borro=
wed
> +	 * refs (and call a NULL ops->free), so refuse to run if it is ever set.
> +	 */
> +	if (WARN_ON_ONCE(symbol_conf.report_hierarchy))
> +		return -EINVAL;

[Severity: High]
Given the restrictions mentioned here regarding borrowed references, would =
it
be safer to update the hierarchy generation to properly acquire reference
counts for the children instead of borrowing them?

This would ensure the pointer handle validation remains correct and avoid
needing these workarounds to prevent refcount underflows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730090521.2206=
375-1-jiebin.sun@intel.com?part=3D8
