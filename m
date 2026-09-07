Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0941E3DDE
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753694; cv=none; b=fploJCyYVB4OoLWefQ13H8YcJGj+PlrYs//1qm+gBL+QTTwcFnwri8Te89WHJzYd2LHYeJVPSYydMjzfr3VJxHx9uFjSkYC/ZjO3qgy5RdjzukaZyCZUGtn6vbvhyW6jE6VfjCqvguHyv9hCoc7trX6JGDknbEYGaSUuhKC6LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753694; c=relaxed/simple;
	bh=fzI1wmmB9+m+21jOWZqUDPd4V+/PYesntQqEgwWvGOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=USBi9I4giAhzPLMydvl/puYCyDL/NSVAqecK7rsKpG+PqTidwIojLvueGlzloknb8sp6POcGRmfeEbsTAgOWnA6Hy3ZBeC+JttuchSH6CxSnM0ikYT29ZvdgRVqX5lvT9lsZRH2euD/dE3OVZZOED11c8x14s04oMZJz106WDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyCGBVqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyCGBVqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D241F00A3A;
	Mon,  7 Sep 2026 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753693;
	bh=mmsozPMXKg6koZJhraDelvGhcftoSal+meIg8gMQC0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyCGBVqSN4gjMWCKDNFuzA82gyEwA/DaLuuJGwKATU8AU95fSMyBYmhJVH5F894k9
	 tL+GYrvyTaboIX9bEdldcYYVz/lSaMwRnQdsKceH6PdYS1/21yOEL5oMP1GsSjyTyI
	 vrq2TTh0vKDln5WuPSgz9SIjdcOGJBvmE2QTaL3+H4mjyiNVzpwuX14VyDT3Yi+yCh
	 qPm+Khi96K8nzxsVLsZJRgQyJo16jfzldemdQNTM+42FeRjcSy7+xTWPNGi6fWzRPk
	 VPyn/w0rNmKZ4OeNcjKR5Z6H+wd6XaC1hyw9dKSBeVt1TrBTptQUwOKu8YCkOm4viQ
	 UlTGRXJNrYY0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf buildid-cache: skip caching non-ELF files and
 treat unreadable build-id as mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907034554.714-3-atrajeev@linux.ibm.com>
References: <20260907034554.714-1-atrajeev@linux.ibm.com>
 <20260907034554.714-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:01:32 +0000
Message-Id: <20260907040132.E6D241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The `is_valid_elf()` check operates in the host mount namespace on=
 a container-namespaced path, causing false rejections of valid container E=
LFs.
- [High] The strict ELF magic number check in `is_valid_elf()` incorrectly =
rejects Portable Executable (PE) files, breaking symbol resolution for Wind=
ows binaries.
- [High] Returning an error (`-1`) when skipping a non-ELF file inadvertent=
ly aborts the entire build-id cache population for all remaining DSOs.
- [Medium] Path-based ELF validation is vulnerable to a TOCTOU race conditi=
on, undermining the patch's intended fix.
- [Low] Missing explicit POSIX header inclusions for standard libc function=
s used in `is_valid_elf()`, causing musl compilation failures.
--

commit f4dea4bc65d83ac2422c7f8d5b38053c12d6437c
Author: Athira Rajeev <atrajeev@linux.ibm.com>

perf buildid-cache: skip caching non-ELF files and treat unreadable build-i=
d as mismatch

This patch hardens the build-id cache population by ensuring only valid ELF
files are cached and treating unreadable files as mismatches.

> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 28b6b3f8d5d35..32ddbd5e61f65 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -684,6 +684,10 @@ build_id_cache__add(const char *sbuild_id, const cha=
r *name, const char *realnam
>  		if (is_kallsyms) {
>  			if (copyfile("/proc/kallsyms", filename))
>  				goto out_free;
> +		} else if (!is_valid_elf(realname)) {

[Severity: High]
Does is_valid_elf() operate in the host mount namespace on a
container-namespaced path?

When profiling a workload inside a container, nsinfo__realpath() returns an
absolute path valid only within the container's mount namespace. Since
is_valid_elf() attempts to open this path in the host's mount namespace, wo=
n't
this falsely reject valid container ELFs and break symbol resolution for th=
em?

[Severity: High]
Does this strict ELF check reject valid Windows Portable Executable (PE) fi=
les?

is_valid_elf() checks for the ELF magic:

    if (read(fd, magic, sizeof(magic)) =3D=3D (ssize_t)sizeof(magic))
        valid =3D (memcmp(magic, ELFMAG, SELFMAG) =3D=3D 0);

If libbfd__read_build_id() successfully extracts a build ID from a PE file,
this strict ELF magic check rejects it. Could this break profiling and symb=
ol
resolution for Windows binaries (e.g., via Wine) because valid PE files are
rejected from the build-id cache?

[Severity: Medium]
Is this path-based ELF validation vulnerable to a TOCTOU race condition?

The validation is performed statelessly by path in is_valid_elf(realname),
completely separate from the subsequent copyfile_ns() or link() operations.

If a test harness (like SPEC CPU) replaces the binary with a placeholder in
the split-second window between is_valid_elf() closing its file descriptor
and the copy/link reopening the path, could the build-id cache still end up
containing a shell script placeholder instead of the genuine ELF binary?

[Severity: Low]
Does is_valid_elf() lack explicit POSIX header inclusions for standard libc
functions?

The is_valid_elf() helper uses libc calls like open(), read(), and close(),
but the exact POSIX headers (<fcntl.h>, <unistd.h>) appear to be missing
from the file. Could this cause build failures on musl libc systems due to
implicit header reliance?

> +			pr_warning("build-id cache: skipping non-ELF file: %s\n",
> +				   realname);
> +			goto out_free;

[Severity: High]
Will this error path abort the entire build-id cache population for all
remaining DSOs?

When build_id_cache__add() starts, err is initialized to -1. By jumping to
out_free here without clearing err, -1 is returned.

This propagates up to dso__cache_build_id(), causing the dsos__for_each_dso=
()
loop to immediately terminate. If a single non-ELF file (like a shell script
placeholder) is encountered, are all subsequent valid DSOs in the session l=
eft
uncached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907034554.714-=
1-atrajeev@linux.ibm.com?part=3D3
