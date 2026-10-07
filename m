Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAA17D6
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331493; cv=none; b=Nio4nte+QWvMbI4DfrPWF/eapTrg20jyTypNtJzgB9KpyTuaZfmDzZvcB/CUJevUEYaDJVanUnbIt496HtCl133+NSG2eAXd2M26GPVaA+uMKwvEVD4SrJHw1Kb9VOZ0zZugToA63Km95vWqk/Hkxc6TUc8gwNRsGvDk5RHZeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331493; c=relaxed/simple;
	bh=2+gBwrBetNZ2zlRRWy5gH5sfom0EpDxFjq3iu3WFvJs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=B/fscUlbhyavc086mVusQU8JXMlB7xH5HNs9ADU3jaEQuFv2BXu0FFYfCx+Z7JDsUFu+wdqhHYwoq7AJKem+Z9hSiXmTHQ4hnvPLSFziLYxufgJ6d0A6pp+l4HkZXZtGWL/gt5LpHQ3Fk9Vg5dEGnzF3S4V6RO7L00PHjnyAENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmIG9x2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmIG9x2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3C61F0089B;
	Wed,  7 Oct 2026 00:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331492;
	bh=z1scd8Vk08PbxUAiT+VkB2vUXUnlJ+vUyw71eOJ1bpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmIG9x2iLiJBCdAsky0LJd2UZqdaZrJaRR1lifLUG8KD/yNY4fLI6IWnkM9/T8nbm
	 m9BsIkqFGHwT325iMHVXWlZ6Ydo1n84KJynjbs0B4vjHj+s6GGktzaPiXXfNUdpUJe
	 vYc8Coaai0LDZq3aC4nUmKhgLjXdNXznIt52pYLaw8CR+U5wlyXCcbmEgYsz2RoD3Q
	 rFVH95RMnkAKuOR7+wtyf31pONoLePxHi9iJAB9RbNGn1VFBXzcXEq56pPI9bkKcvW
	 vnRV9x3T2WZU/w0+vWPG7/LKTcf+vPFWdb/blHv9KjnuUmw+ZByaShUmZeYQdNmP90
	 rleJZ6IgfdgHg==
Message-ID: <sashiko-outbox-162548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] perf tools: Factor out dso__find_binary_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-7-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 00:04:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] perf: Guest kernel modules fail to open due to hardcoded root_dir
- [High] perf: Strict .text section check breaks data-only DSOs and NO_LIBE=
LF builds
- [High] perf: Concurrent Read-Modify-Write data race on struct dso bitfiel=
ds
- [High] perf: Use-After-Free of dso->nsinfo in __dso__find_binary_type due=
 to missing dso__lock
- [Medium] perf: Explicitly resolved binary types are unconditionally overw=
ritten
- [Medium] perf: Bypassing do_open() permanently caches EMFILE failures as =
NOT_FOUND
- [Low] perf: Redundant double decompression of compressed kernel modules
--

commit 8b41de1355b0e2f1d37b604c80238237fc833f0f
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Factor out dso__find_binary_type()

Separate out the logic to detect binary type of a DSO.  It checks if the
candidate file contains ".text" section.  It should be called under the
_dso__data_open_lock.

Introduce bintype_searched flag and it accessors to prevent repeated
(failed) search.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 913877b84b2d4..f5054c18a2e93 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -833,7 +833,7 @@ void dso__data_close(struct dso *dso)
>  	mutex_unlock(dso__data_open_lock());
>  }
> =20
> -static void try_to_open_dso(struct dso *dso, struct machine *machine)
> +static enum dso_binary_type __dso__find_binary_type(struct dso *dso)
>  	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
>  {
>  	enum dso_binary_type binary_type_data[] =3D {
> @@ -842,25 +842,103 @@ static void try_to_open_dso(struct dso *dso, struc=
t machine *machine)
>  		DSO_BINARY_TYPE__NOT_FOUND,
>  	};
>  	int i =3D 0;
> -	struct dso_data *dso_data =3D dso__data(dso);
> +	char *path;
> +	bool found =3D false;
> +	bool decomp =3D false;
> =20
> -	if (dso_data->fd >=3D 0)
> -		return;
> +	if (dso__bintype_searched(dso))
> +		return dso__binary_type(dso);
> +	dso__set_bintype_searched(dso);

[Severity: High]
Does this code introduce a data race on the struct dso bitfields?

The dso__set_bintype_searched() function modifies the bintype_searched
bitfield under the global _dso__data_open_lock. However, adjacent bitfields
like debuginfo_searched and long_name_allocated share the same memory
location and are modified under different locks (dso__lock(dso) and
dsos->lock).

Concurrent execution could cause compiler-generated read-modify-write
operations to overlap, resulting in dropped flags or memory leaks if
long_name_allocated is clobbered.

[ ... ]

> +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
> +		/* We don't expect these are set; fall through */
> +	case DSO_BINARY_TYPE__NOT_FOUND:
> +		/* Let's find it out (for user DSOs or kernel modules) */
> +		break;

[Severity: Medium]
Does this fall-through discard valid binary types that have already been
resolved elsewhere in the system?

When symbol.c successfully resolves and sets the binary type (such as
DSO_BINARY_TYPE__SYSTEM_PATH_DSO or DSO_BINARY_TYPE__BUILD_ID_CACHE),
this switch statement deliberately falls through. The loop below then
unconditionally overwrites the previously valid binary type.

If the fallback types lack a .text section (such as data-only DSOs), the
state is permanently left as NOT_FOUND, preventing perf from reading them.

[ ... ]

>  	do {
>  		dso__set_binary_type(dso, binary_type_data[i++]);
> =20
> -		dso_data->fd =3D open_dso(dso, machine);
> -		if (dso_data->fd >=3D 0)
> -			goto out;
> +		path =3D dso__get_filename(dso, "", &decomp, dso__binary_type(dso));

[Severity: High]
Does hardcoding the root directory to an empty string break path resolution
for guest kernel modules?

When the fallback logic looks up types like DSO_BINARY_TYPE__GUEST_KMODULE,
it passes "" to dso__get_filename() instead of machine->root_dir.

This causes dso__get_filename() to construct an invalid path missing the
guest's root directory. The file cannot be found, filename__has_section()
fails, and subsequent calls to open_dso() will fail.

[Severity: High]
Does calling dso__get_filename() without holding dso__lock(dso) cause a
use-after-free of dso->nsinfo?

The new __dso__find_binary_type() helper executes with only the global
_dso__data_open_lock held. It calls dso__get_filename(), which invokes
dso__filename_with_chroot() and dereferences dso->nsinfo to read the
process ID.

Concurrently, another thread could call dso__set_nsinfo() (which acquires
dso__lock(dso)), replacing the nsinfo pointer and freeing the old one via
nsinfo__put(). Since this read path ignores dso__lock(dso), it can read
the freed pointer.

> +		if (path =3D=3D NULL)
> +			continue;
> +
> +		found =3D filename__has_section(path, ".text");

[Severity: High]
Does this strict .text section check break data-only DSOs and NO_LIBELF
builds?

Prior to this patch, try_to_open_dso() discovered the DSO by calling
open_dso(). If the file existed and was readable, the open succeeded. This
patch introduces a strict requirement that a DSO must contain a .text
section.

Perf commonly profiles memory data accesses (like perf mem or perf c2c)
hitting data-only DSOs. For these files, filename__has_section() evaluates
to false, forcing the binary type to NOT_FOUND. Furthermore, if perf is
compiled without libelf (NO_LIBELF=3D1), filename__has_section() is stubbed
to unconditionally return false, breaking user DSO loading entirely.

[Severity: Medium]
Can this bypass of do_open() permanently cache EMFILE failures as NOT_FOUND?

The filename__has_section() function uses a raw open() without the FD limit
(EMFILE) handling and LRU eviction logic normally provided by do_open() and
close_first_dso().

If perf hits RLIMIT_NOFILE, open() returns -1, and filename__has_section()
silently returns false. __dso__find_binary_type() then assumes the binary
is invalid, sets bintype_searched =3D 1, and permanently caches
DSO_BINARY_TYPE__NOT_FOUND, breaking data access to the DSO for the rest
of the execution.

[ ... ]

> +static void try_to_open_dso(struct dso *dso, struct machine *machine)
> +	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> +{
> +	struct dso_data *dso_data =3D dso__data(dso);
> +
> +	if (dso_data->fd >=3D 0)
> +		return;
> +
> +	__dso__find_binary_type(dso);
> +	dso_data->fd =3D open_dso(dso, machine);

[Severity: Low]
Does this result in redundant double decompression of compressed kernel
modules?

The call to dso__get_filename() in __dso__find_binary_type() decompresses
a compressed kernel module to a temporary file. After checking for a .text
section, dso__put_filename() unlinks this temporary file.

Immediately after returning, try_to_open_dso() calls open_dso(), which
ultimately calls dso__get_filename() again, forcing a second decompression
of the exact same kernel module.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D6
