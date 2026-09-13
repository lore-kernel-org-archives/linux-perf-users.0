Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7E3009E2
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338981; cv=none; b=frDkLZMwDxX8kM7wmUq1QzdEEQ/Os/65rFCJF5iNabLz0QQ1mZX0DMcOvHL1/boqOYxYH0hhEbtMwd3dElm0OeDQ+9FWahCXPUfAdF22dkQkJfWyAASaVN/v0l2VXj9XOAmbicI1w9/XQfYJEnw1JjkUNLtXrf1kuKP39v3QM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338981; c=relaxed/simple;
	bh=m6QIy3dJ9NC1WWc0EDDr1wbEwgzlQRmpHoGxU+hYjtw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P0rkChLLa1XlGK/0P+jf1o3FSrwjiVEccc9Y9bp8v+mrUgPDZUktkrfs/IaP2U2OsOBAoq3ZJlKCUA7wvqWWjevCfRJcbtyIaoA9ZT4ij0pQ9AH8Qfw1ztt3e2eYzG830sQJi6aFDUK8WY17zDgemoVZW+nyXUhMGtCqokzLWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN4Cwsla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN4Cwsla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2271F000FF;
	Sun, 13 Sep 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338980;
	bh=kFKodb4/0etJ9C70NVr7Fe6gmQfrQf0lLdmV+4d4L+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KN4CwsladpASw118H5d/gksq+ry1TXpyXUIxNQVTKi8Z4lqYJ4c2fBIyUdjVkZsqJ
	 a2b0NfaksC8sFCv0j0cdQo+IZqeAyYT6QofP3woR8vlGjbACSqe/ZYZwBtZukMAXjj
	 Gsmi77YHajNLMJaKGqtKgXP3WAPQqRSjqX26qnl9grBtmhuZ5QspGDu6csz3sqfwWj
	 4gGIi/zcA9xMs+iIMuY32Hgb7IvM+J8GF9dHCHHnIk6uOFvSXTcT+CrI4/t1VSL9la
	 whOE++L3t1PUzqNhpqAe8kjUWPqBfQXLe7UmqqBXtEOMvPpfx3ha9rTKrLpEns0du7
	 +wrWuYmMwBKNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-7-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:36:19 +0000
Message-Id: <20260913223619.EB2271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] GDB `printf` with `%s` on `NULL` pointer causes script abort whe=
n `dwarf_diename` returns `NULL`.
--

commit 65695a427d0e95be616d39c680b3d1d8ddb81e11
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf scripts: Add perf-stuck, to tell where a running perf is stuck

This commit adds a stopgap utility for sampling a running perf process to
identify if it is stuck in a loop. It uses a shell script to poll /proc for
progress and CPU usage, and optionally calls into a new GDB command file to
print the DIE chain if the process is stuck in a DWARF type chasing loop.

> diff --git a/tools/perf/scripts/perf-stuck.gdb b/tools/perf/scripts/perf-=
stuck.gdb
> new file mode 100644
> index 0000000000000..53e9019828b6e
> --- /dev/null
> +++ b/tools/perf/scripts/perf-stuck.gdb
[ ... ]
> +define perf-die-chain
> +  if $argc < 2
> +    printf "usage: perf-die-chain <function> <die variable> [iterations]=
\n"
> +  else
> +    frame function $arg0
> +    if $argc =3D=3D 3
> +      set $perf_die_chain_n =3D $arg2
> +    else
> +      set $perf_die_chain_n =3D 10
> +    end
> +    set $perf_die_chain_head =3D $pc
> +    set $perf_die_chain_i =3D 0
> +    while $perf_die_chain_i < $perf_die_chain_n
> +      printf "chain[%d] die=3D%p addr=3D%p cu=3D%p off=3D0x%lx tag=3D%d =
name=3D%s\n", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off=
) dwarf_dieoffset($arg1)), ((int) dwarf_tag($arg1)), ((char *) dwarf_dienam=
e($arg1))

[Severity: Medium]
Will this script abort execution if dwarf_diename() returns a NULL pointer?

When perf-die-chain processes DIEs that lack a DW_AT_name attribute, such as
type modifiers (e.g., DW_TAG_const_type or DW_TAG_pointer_type),
dwarf_diename() evaluates to NULL (0x0).

Passing a NULL pointer to GDB's printf with %s forces it to read from
unmapped memory at address 0x0, which results in a "Cannot access memory at
address 0x0" error.

Could this be adjusted to check if dwarf_diename() returns NULL before
attempting to print it, to prevent the debugging macro from failing
unexpectedly?

> +      until *$perf_die_chain_head
> +      set $perf_die_chain_i =3D $perf_die_chain_i + 1
> +    end
> +  end
> +end

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D6
