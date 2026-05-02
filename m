Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DEE54B
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705733; cv=none; b=mJ1XUZD6sUThmfpcfV/N08H+Moo06kspVOI6llkayrSieCSA3hFE/V9XQByUwMwKWnARKQEd2EnYE+4Ba/7TysxgUReH/CzYNIX2soKtOmPyur92WJT1V5Ltz47lSIFPHWBPVjHOWF/fsyRMMcDFUT4fFtN38lhbqUJfLSUMCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705733; c=relaxed/simple;
	bh=7irrj0Sfaw+MEosH0rc2GAapruDSw+8QHC95cugPTKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oojWB3g/NWEWZCsrTGSG0SSg5bpoeTsoFH1aPGSZPO5niFiKl+Zu3cUe8Cn7s2xPIZAD5NWojtf3Gq/6ZTchQtvkDttZQ+PGyToIwYzBmOCmZPvgxQ9QSfZdJ8UguvzJmITnCpDpDi/VifpuCU+829XTaaMQfK9fFLn+v0SmmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmIIEzI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmIIEzI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C9EC19425;
	Sat,  2 May 2026 07:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777705733;
	bh=7irrj0Sfaw+MEosH0rc2GAapruDSw+8QHC95cugPTKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HmIIEzI6ja19AbnOgv2TAk836cedJOGIPGsdKVC/WntmyBDLbrg29Hnw3R0Irwexu
	 J5WmHjsnNOKKbBflfS5gl4VxFiF9fsDgOtwgoofgU1pCG51Ucx1rt+iypsuROY1Ak1
	 LitRgcKat4Uxvwdbn1Af1mC6QI8Or1EUna0RLS7DDAeUxmEJu/qfU32WHJQ6IrvsQT
	 Z8q7XEFeRQe6shRiNakqkJLGBE0nIuucSrl6jeg2BYfWF+cocdn7DeYZMbxOSBSV2z
	 67gNcE3URVqFsQvPys9f7JYSjsQSorzon4R0q+np441YzNUK9Q/OXhOe7KVIXHTIr/
	 sWcutZN48i9cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf dwarf-aux: Fix libdw segmentation fault in
 cu_walk_functions_at
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502064839.282422-1-irogers@google.com>
References: <20260502064839.282422-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:08:52 +0000
Message-Id: <20260502070853.02C9EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] AI-generated patch introduces unnecessary performance penalty ba=
sed on hallucinated API contracts and prior state.
- [Medium] The patch introduces a guaranteed segmentation fault by uncondit=
ionally dereferencing uninitialized memory via the newly added `dwarf_dieof=
fset` call.
--

commit ca6e407e35269e28aefe15260d7649e9b686da59
Author: Ian Rogers <irogers@google.com>

perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at

This commit modifies DWARF processing in perf kmem to prevent alleged
segmentation faults. It reconstructs Dwarf_Die structures using offsets
to avoid dangling pointers and rewrites a loop in cu_walk_functions_at
to address an uninitialized memory read.

> 2. Uninitialized memory access in cu_walk_functions_at:
> A logic bug in the for loop of cu_walk_functions_at attempted to
> avoid in-place modifications by using a separate next_die buffer.
> However, it performed a memcpy(&die_mem, &next_die) at the end of the
> loop body *before* next_die was actually initialized by

Is this description accurate?

Looking at the original code in the diff, there was no next_die variable
at all before this commit. The original loop passed &die_mem directly to
die_find_child.

> 1. Dangling pointers from dwarf_getfuncs:
> dwarf_getfuncs passes temporary Dwarf_Die structures to its
> callback. Copying these via memcpy leads to dangling internal
> pointers (such as to Dwarf_Abbrev structures) once dwarf_getfuncs
> returns and cleans up its temporary state.

Does libdw actually invalidate these pointers when dwarf_getfuncs returns?

libdw Dwarf_CU pointers typically remain valid until the Dwarf session is
closed, so the copied Dwarf_Die should not have dangling pointers.

Reconstructing it via dwarf_offdie appears to add binary search overhead
without changing the underlying pointer.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 92db2fccc788..52fdf6d49d3b 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c

[ ... ]

> @@ -661,8 +670,11 @@ Dwarf_Die *die_find_realfunc(Dwarf_Die *cu_die, Dwar=
f_Addr addr,
>  	/* dwarf_getscopes can't find subprogram. */
>  	if (!dwarf_getfuncs(cu_die, __die_search_func_cb, &ad, 0))
>  		return NULL;
> -	else
> -		return die_mem;
> +
> +	if (dwarf_offdie(dwarf_cu_getdwarf(cu_die->cu), dwarf_dieoffset(die_mem=
), die_mem) =3D=3D NULL)
> +		return NULL;
> +
> +	return die_mem;

Could this introduce a regression where it crashes if dwarf_getfuncs returns
an error?

dwarf_getfuncs returns -1 on error. If it returns -1, !dwarf_getfuncs
evaluates to false, causing execution to bypass the return NULL and
fall through to dwarf_offdie.

Since the callback wasn't executed on an error, the die_mem structure
remains uninitialized stack memory from the caller. Calling
dwarf_dieoffset(die_mem) will dereference this uninitialized memory and
likely cause a segmentation fault.

Should the error check be changed to if (dwarf_getfuncs(...) <=3D 0) to
safely abort on errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502064839.2824=
22-1-irogers@google.com?part=3D1
