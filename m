Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873800;
	b=XFIg1P3Z7uPeLfDLXkGDtsagPTR0a2WwqqvaE19N1Hk+8NfQZnYEs+zetaSd4sDqnpQy
	 YP7+xAWgDT8ey/6/474OEWxYWH2sTCZgCzXyOVCcV2mWFvauWsB698qLVd2akR4TU8bz3
	 +VEzb0DWjPgOPv0OiFnmXcuZkjkJb187HztwtOe9vI9FMa1ocbwMI9rplZo4G+b7wt5I5
	 It82VG4FU5m3v996S42GmAC7Crv+5qoIfXEdNpc2zohIo+GZqt2K7Uk1tFWCbvUe5N9Ar
	 v/gaRzzs5gyJGWwY9DrlP1meJ3tINjfe3C7GX47aemhJKYICakOsbpZ2nNgwX1G0r/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RrHr0408xauE5LeT7Tr+ZYBY9yYkiO47KhpTM+J5Y2g=;
	b=FfEGb3tB+Q3NTXCZIdEw3FDh+DejHEzEHlkUGMEKLz+WdhDLUKTAXS1e3TY/sc1Amtz7
	 lm5PvuSa4KvBvN+eeufaidRccZ3DnDxXrUZjz8fM7Gyz+Hbnt1Fedbe0eWeKRNHKgB89i
	 GaEhIs+6Q9K23W7V2fnuSUGT20IMA/uPqNOXQaqmPRwdBXt8H3naQOsgvBWwvKAmUvCnf
	 +fdycbG5Xiq6lMlgV1j5WbSdeD2gkV/QywOpbvecl4awFtEHBHY62rizVmAPmkup0nA/A
	 g/Nftv/IyTqTojjCNXEHFwfUnZwRGJyOagj/YpGEbAVF+7uMqcSFmSASzYbGS9JYAVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxrF+PdM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68B606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxrF+PdM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF171F000C4;
	Tue, 17 Nov 2026 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873799;
	bh=RrHr0408xauE5LeT7Tr+ZYBY9yYkiO47KhpTM+J5Y2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxrF+PdMrsYha+1dpBA5X1zcyuigrSaQ88faXW/VgbzcUWoKpVPUIwW/QMpEdnoSI
	 RnYTeLWiTrJ8o/7mV9LxZFluPmcChcjeLHqSDHwmoQbegZqhTDsra38vKXUgrhw/lr
	 pHDbt7i2dD7FjMGb7sygRQH9afoc4FFQUxfvDOgjQbGa3/HcLF1PPTmL0Oid/AWuhW
	 MmLOBzxb42Y12nzO3G1ozj+bIV+q4LPEg7XRm4rECZYkc/11Ux9LE+vbmTP3714ykw
	 T3G5WvbbHpONUFuN6p5GmVeUHv4hw9HrH/Hy5+pQcclyR7cLnubemtJ5ZltIOckG6j
	 2Vr72ugK9senw==
Message-ID: <sashiko-outbox-217970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/12] perf annotate-data: Resolve DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-4-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:03:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> clang emits DW_AT_location with DW_OP_addrx for global variables in
> DWARF 5, gcc emits DW_OP_addr.  The address index was not resolved, so
> those variables were not found by address; the by-name fallback also
> missed the ones in .bss past the file backed end of the last segment.
>=20
> Resolve the index with dwarf_getlocation_attr() + dwarf_formaddr() and
> use the resulting address in the by-address lookup and in the global
> variable cache.  The new global_data workload keeps a zero initialized
> struct in .bss and its test checks that the accesses are annotated: when
> perf is built with clang and DWARF 5 it goes through DW_OP_addrx, with
> gcc through DW_OP_addr.  The test skips on 32-bit PIE builds, which
> load globals through the GOT, something the resolver does not follow.
>=20
> Fixes: d60469d7c0e5c4e8 ("perf dwarf-aux: Add die_find_variable_by_addr()=
")
> Fixes: d7b60803a790b716 ("perf dwarf-aux: Add die_collect_global_vars()")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D3

