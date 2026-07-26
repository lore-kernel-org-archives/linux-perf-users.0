Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659C381EA3
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109864; cv=none; b=Lf5wL9ogi/RHBnlkEgyZa8WLtjaGWxiNtE/KJvYpaTFkhIglrJ+5nBQtwO4fduJOgfYrMyMZliYuebsR7rKmxT6Wmko1Qct/f4QOXJQ1tCD8dSiVYkZDOu4FNP0ls+6qXa4EXT7yx7QGuuORPbf/nhUmOxOuMA2duWz7CJ0AFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109864; c=relaxed/simple;
	bh=5AYYjIHzIQxchbNHHb8h6x6TRf97XlF4QD5KLr1rtIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QljvY1t50RrkqlvJnBGqzxWPAw2Y41gHDaFUbweF4FBydeshrQsm2iQZij0ELldFIAQOQCUq9v4p0SDuadEBhuWJc33IQKWSB88BPH7SU7zhuvRSVh6OEuAzOpF8k54Dxi1/+OisdiZMYTmMXVOoAdyXmV+ER9KDVXjj7zG7K1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxRp58AI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxRp58AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DA91F000E9;
	Sun, 26 Jul 2026 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109861;
	bh=j/pO9KjeLCN6N/N4Fqe8jUFk9bqZSLXtksRnluB9TEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CxRp58AIdvWSHlOkP6ZkIQFPs00XLBaErhTlKgPMf9xhecKr/ofZoYVlTUSx76Vuv
	 sO4tXicFRp7c5kPY6yvkrW2RC0C0Ki9NDYLCr+f4sCiHsbO36wLIjNeh5rzTzYw4P0
	 u6Mt5Q5JYwfz5qaqfO8QDL9AX1ZN/Pyx71Q3e13HLWzVceabquEsPFIfUNhvTiLCOc
	 V5CX3Ek0Py4Cvho4cjxDZ73RyJsiX6+vpqQzXMKeYQx62A2FxEOiceDi2Pd5KEk5GJ
	 eIYlYU8kny7f8ZRdRE8BBD+fvgTnTaFsWtJbOkutdwkNm4yIQr0SUQGrMyyIv512tt
	 F7xUetZagtV2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf machine: Free scandir entries in guest kernel
 map creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726234014.63111-8-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
 <20260726234014.63111-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 23:51:01 +0000
Message-Id: <20260726235101.66DA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Crash during cleanup if `maps__insert()` fails when creating kerne=
l maps.
--

--- Patch [7]: [PATCH 7/8] perf machine: Free scandir entries in guest kern=
el map creation ---
commit 39417761e2f7dcdcc875be7b6d926b0a7b9bade6
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Free scandir entries in guest kernel map creation

machines__create_guest_kernel_maps() calls scandir() which allocates
both the namelist array and each individual dirent entry.  The code
frees the namelist array but not the individual entries, leaking memory
proportional to the number of directories under guestmount.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 1700130adedb3..48c4b963e8097 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c

[ ... ]

> @@ -1265,6 +1266,7 @@ int machines__create_guest_kernel_maps(struct machi=
nes *machines)
>  			    (errno =3D=3D ERANGE)) {
>  				pr_debug("invalid directory (%s). Skipping.\n",
>  					 namelist[i]->d_name);
> +				free(namelist[i]);
>  				continue;
>  			}
>  			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
> @@ -1272,9 +1274,11 @@ int machines__create_guest_kernel_maps(struct mach=
ines *machines)
>  				 namelist[i]->d_name);
>  			if (access(path, R_OK)) {
>  				pr_debug("Can't access file %s\n", path);
> +				free(namelist[i]);
>  				continue;
>  			}
>  			machines__create_kernel_maps(machines, pid);

[Severity: High]
This is a pre-existing issue, but since we are executing the guest kernel
map creation path here, could this lead to an out-of-bounds memory access if
map insertion fails?

If machines__create_kernel_maps() ends up calling
__machine__create_kernel_maps() and maps__insert() fails:

tools/perf/util/machine.c:__machine__create_kernel_maps() {
    ...
    machine->vmlinux_map =3D map__new2(0, kernel);
    if (machine->vmlinux_map =3D=3D NULL)
        return -ENOMEM;

    map__set_mapping_type(machine->vmlinux_map, MAPPING_TYPE__IDENTITY);
    return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map=
);
}

A memory allocation failure in maps__insert() will return an error code, but
leave the uninserted map attached to machine->vmlinux_map. Later, during
teardown in machine__destroy_kernel_maps(), this dangling map is passed to
maps__remove().

Since it was never inserted, maps__by_address_index() in __maps__remove()
returns -1 (UINT_MAX):

tools/perf/util/maps.c:__maps__remove() {
    ...
    address_idx =3D maps__by_address_index(maps, map);
    map__put(maps_by_address[address_idx]);
    memmove(&maps_by_address[address_idx],
            &maps_by_address[address_idx + 1],
    ...
}

Does this use the UINT_MAX index directly to access and memmove the
maps_by_address array, causing an out-of-bounds memory access and potential
memory corruption during cleanup?

> +			free(namelist[i]);
>  		}
>  		free(namelist);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726234014.6311=
1-1-acme@kernel.org?part=3D7
