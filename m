Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F537B40A
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195253; cv=none; b=iU8Bjp9YeTZ3YJ9FQbx8j9ROUJPPydE/f0ssPtmjwg/1mIlkFUUQPmykHPPZSmTl6ovqEdOBrIxgm84npwm2Wqj+nBYydvXiCVZszJO6L2EvSeuresMuaGJwQBvXuh/z80PYbVFWAR9hQEbDmMV6YSnnUbXGax906C95Don8Z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195253; c=relaxed/simple;
	bh=P5gLoTzhTpOKAwcJEWrIXcFEaSQ84BQ9BXCfpiQDjKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nE5spfOWp5asi6w4gDrIYLqFrDGbQ75npPhF3iOZkDZjgCIHj5WN9x3nrjR3vT3EWrmVU53xRKIX9cKUOp2Y2qke3dlpGCtoPxJUU/UQEIk2gz2iw1yQ8m0PXQs7gLkdIrc5S9tHCxkx0I2eH3ECI5kL7sbFSgmjJF0P7IndisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbSzPeKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbSzPeKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4261F000E9;
	Sat,  8 Aug 2026 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786195251;
	bh=oKjO4AYHxyPtR9xPE+h1NuP7Ji1NIjRfGJ6AzWaWxbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbSzPeKA793xiPzI9olmseyYfjEP9MRCAdb+7l9UmOx+VX/SXFYcK/7WdIG0vnW0Z
	 mI26XEUnZ3WAdb0d5BGE4WYi/mwKf3Kp6TsIzfqJnC+5b6QZIII4b75p6n1JSVV7Ye
	 FH10DtorIApWn+f5z+W5OBiNQokk/CdY/Y9GSuLkgbR09BSwpuPlawAHoVdFh3f4nG
	 xOSN+NCaKihWBespTqmouSb67p5t4vFx79OdG3Ldtj9OTE9VU3L2F5/Om413G4yDGf
	 cEeuEg1Bapa0F0xFWqN8ut42lH/d64kjDiDlMMm9AZVJFKI2kkwkJA2NlibgbIIaf1
	 deIVHd5mkz/0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/23] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-24-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-24-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:20:50 +0000
Message-Id: <20260808132051.7F4261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The global `task_struct_cache` may permanently cache a DWARF offse=
t for an incomplete forward declaration of `struct task_struct`, breaking t=
ask tracking globally.
- [High] The globally static `task_struct_cache` caches a raw `Dwarf *` poi=
nter as a validation key, which is susceptible to an ABA problem when DWARF=
 handles are recycled, leading to corrupt DWARF parsing.
- [Medium] Calling `die_find_inlinefunc()` with a Compilation Unit DIE (`cu=
_die`) instead of a Subprogram DIE (`sp_die`) causes a severe O(N) recursiv=
e DWARF tree traversal.
- [Medium] Caching the DWARF offset of `struct task_struct *` relies on a b=
rittle non-deterministic order dependency, silently failing for compiler-ge=
nerated code like stack canaries.
- [Low] Missing explicit inclusion of `<strings.h>` for `strcasecmp()`, whi=
ch violates subsystem guidelines and causes build failures on musl libc.
--

--- Patch [23]: [PATCH v4 23/23] perf annotate-arm64: Support 'mrs' instruc=
tion to track 'current' pointer ---
commit 9ea98019ec4e55f722077c51c12557f82e4d5f60
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer

This commit extends the arm64 instruction state tracker to handle mrs
instructions reading from sp_el0. It attempts to track the current
task pointer by locating the get_current() inline function and caching
the struct task_struct DWARF offset for subsequent resolution.

> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/=
util/annotate-arch/annotate-arm64.c
> index b01fa6cf865ff..9d1f315dcb280 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c

[ ... ]

> @@ -889,6 +890,96 @@ static void update_adrp_insn_state(struct type_state=
 *state,

[ ... ]

> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {

[Severity: Low]
Is the <strings.h> header missing for strcasecmp()?

Building perf with musl libc requires explicit inclusion of POSIX headers,
and omitting <strings.h> can cause musl build failures.

> +		invalidate_reg_state(tsr);
> +		return;
> +	}

[ ... ]

> +	/*
> +	 * Invalidate cached DIE offset if the debug info handle changed
> +	 * (e.g. switching between vmlinux and a kernel module).
> +	 */
> +	if (task_struct_cache.dbg !=3D dloc->di->dbg) {
> +		task_struct_cache.dieoff =3D 0;
> +		task_struct_cache.dbg =3D dloc->di->dbg;
> +	}

[Severity: High]
Does checking the raw Dwarf pointer expose an ABA problem?

If debug info handles are freed and reallocated for different DSOs during
analysis, the memory address could be recycled. This would bypass the cache
invalidation and cause perf to use a stale DWARF offset from the old DSO
on the new DSO, potentially leading to out-of-bounds reads in libdw.

> +
> +	if (!task_struct_cache.dieoff ||
> +	    !dwarf_offdie(dloc->di->dbg, task_struct_cache.dieoff, &type_die)) {
> +		struct strbuf sb;
> +		char *type_name;
> +		/*
> +		 * Find the inline function 'get_current()' Dwarf_Die

[Severity: Medium]
Can this cache mechanism create a non-deterministic order dependency?

If the first mrs instruction processed is a stack canary, which does not
belong to get_current(), the search will fail and the state is invalidated.

However, if a true get_current() is processed first, the cache is populated
and the function check is bypassed for subsequent stack canaries, allowing
them to succeed.

> +		 * and obtain its return value data type, which should
> +		 * be 'struct task_struct*'.
> +		 */
> +		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||

[Severity: Medium]
Will passing the Compilation Unit DIE (cu_die) instead of a Subprogram
DIE cause a severe performance regression?

Because the underlying callback returns DIE_FIND_CB_CONTINUE, passing
the entire compilation unit forces die_find_inlinefunc() to perform a
full, inefficient O(N) recursive DWARF AST walk across every node in the
file when the cache is empty.

> +		    !die_compare_name(&func_die, "get_current") ||
> +		    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
> +		    !dwarf_formref_die(&attr, &type_die)) {
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +
> +		strbuf_init(&sb, 32);
> +		die_get_typename_from_type(&type_die, &sb);
> +		type_name =3D strbuf_detach(&sb, NULL);
> +
> +		if (!type_name || strcmp(type_name, "struct task_struct*")) {
> +			invalidate_reg_state(tsr);
> +			free(type_name);
> +			return;
> +		}
> +
> +		/*
> +		 * Cache the 'struct task_struct*' die offset globally.
> +		 * This allows us to resolve stack canary accesses even
> +		 * in CUs that lack a full task_struct definition (e.g.,
> +		 * compiler-generated entry/exit code).
> +		 */
> +		task_struct_cache.dieoff =3D dwarf_dieoffset(&type_die);

[Severity: High]
Could this code permanently cache incomplete forward declarations of
struct task_struct?

The string comparison matches "struct task_struct*", but there is no check
to verify if the DIE is a complete definition (e.g., by checking
DW_AT_declaration or dwarf_aggregate_size()).

If the first processed CU only has a forward declaration, its incomplete
offset will be cached globally, causing all subsequent member offset
lookups to fail since an incomplete type has no children.

> +		free(type_name);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D23
