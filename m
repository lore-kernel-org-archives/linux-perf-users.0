Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741916;
	b=1sO7cd82xQge1sKeoGRjPjpAsl3kAzvptkw88eIZXYdA49eSca4QINp2z2QLsN2qj1Jd
	 qaYs6Clw0AXO0dqcYNG/RejZAHotyViXz15o6o5lpMhyBpOsTDDeoh/gAqD6UFSDK1r2Q
	 YQMvctH9aHPiSKEd1H5dh242LyW41nICH1/l7mX/GzpgeaZUCmNQ/P73SuoLj57wn4UBJ
	 KKFF2iZzoXQ2vxuWuCtNKCK2ICNHAla6k9a7RmKw0cGaB3zsugEfqXaHpecw1Av8aeFYz
	 a66xWRqb1Xd6Vd1QtLGtIy2uM/ouMS/xNrjYd/XVPTeNnNT6t4LQyMyjiwJubbTLf3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vzbgCmxRNry4f8QruF77U4zlFHlkJYFbRa3zih71aB4=;
	b=AnSMUspUOrg5IBZBugmiqYZM+/2KU9P7ero1nvlPtjMWHXc9SgvdzX1+RzBo03rIvSKX
	 XZEgyi7O//mBTfg/cvhMfYbbi5L3Zl36P9AWTONsMnWtH4zTU3Yx9ksQx/Ik8s+7mrVmg
	 YHq+98pHNDaRCdWsnF3gOF6A/iCLcEz2+A0Ii/4zH+wZUl86bX5uw7s5vJF+EsVHQp9MX
	 Rkad8nTYwhOSQ1ZDNt6mldK6msgi9Zs0kHlBLUsuefp6w4PyxaZ2NQob4VbCG58qyD0tA
	 /jgUPlEyNa3ZBLjsRBDBto+pxR0ecX+2W4dmPKawMWG3wHF6+KROfukjCZpsjPHXlQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsRJSOkR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308B60A2618
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsRJSOkR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFFE1F031E5;
	Fri, 23 Oct 2026 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741915;
	bh=vzbgCmxRNry4f8QruF77U4zlFHlkJYFbRa3zih71aB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsRJSOkR1yqyLtzxI3REp+tL/XqYonS3ffHMz4UAtTSAGKlIpT0x80dR5C+cuKQKg
	 Cd+KToDMfHw2VuAk3qW70AEL3JSQk/IEdtENL37rk4Npx7OYkbjg4IOu1CriIfFd1J
	 fx6wnLZSVUli9N/HrCS0XDTSTXgg9l5T9HN4C0IR1zUwRCTQL+rs6dHqs+UGXmFKit
	 t8iXGXde6Kx3B5NqOCDAXRwNbvsVWd6fNQORylUyYNkex10rk/sE6zwpmm/gNwhoZA
	 VuJY9VGpcs95euLATuR1prNWufQjTAokxPOge+ga9zVZca412fFy6I/Y1ngJo6IrEB
	 P86JX0ZhFX9nQ==
Message-ID: <sashiko-outbox-182448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/11] perf tools: Handle chroot inside
 nsinfo__mountns_enter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-8-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:51:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf namespaces: missing chdir() after chroot() in nsinfo__mount=
ns_enter()
- [Medium] perf tools: chroot in nsinfo__mountns_enter() breaks symbol__dis=
assemble()
- [Medium] perf symbols: dso__load() stores unprefixed chroot path in symsr=
c_filename
- [Medium] perf namespaces: chroot() in nsinfo__mountns_enter() breaks DSO =
path lookup
--

commit 28000ab89e0070838a25b538801deec9ee819524
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Handle chroot inside nsinfo__mountns_enter()

This commit reads /proc/<pid>/task/<tid>/root in nsinfo__init() and enters
and exits the chroot directory alongside the mount namespace in
nsinfo__mountns_enter() and nsinfo__mountns_exit().

> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index bb119a6cc6064..1ec6b1ed4db23 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c

[ ... ]

> @@ -405,13 +439,30 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
>  			goto errout;
>  	}
> =20
> +	if (RC_CHK_ACCESS(nsi)->in_chroot) {
> +		oldroot =3D open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> +		if (oldroot < 0)
> +			goto errout_setns;
> +
> +		if (chroot(nsinfo__chroot(nsi)) < 0)
> +			goto errout_setns;
> +	}

[Severity: Medium]
Should nsinfo__mountns_enter() in tools/perf/util/namespaces.c also call
chdir("/") after chroot(nsinfo__chroot(nsi))?

Calling chroot() updates the process root directory without changing the
current working directory. When need_setns is false, the working directory
remains at oldcwd on the host filesystem, and when need_setns is true,
setns(newns, CLONE_NEWNS) sets the working directory to "/" of the mount
namespace, which is still outside the chroot subdirectory.

When a caller such as opt_set_target() -> nsinfo__realpath() in
tools/perf/util/namespaces.c resolves a relative path for a chrooted target:

tools/perf/util/namespaces.c:nsinfo__realpath() {
	nsinfo__mountns_enter(nsi, &nsc);
	rpath =3D realpath(path, NULL);
	nsinfo__mountns_exit(&nsc);
}

the kernel getcwd() syscall prepends "(unreachable)" because the working
directory is outside the new root, causing glibc realpath() to fail with
ENOENT, while relative paths passed to nsinfo__stat() resolve against the
directory outside the chroot. Since nsinfo__mountns_enter() already saves
oldcwd and nsinfo__mountns_exit() restores it via chdir(nc->oldcwd), calling
chdir("/") right after chroot() would keep the working directory inside the
new root.

[Severity: Medium]
Does entering the chroot in nsinfo__mountns_enter() break symbol disassembly
in symbol__disassemble() in tools/perf/util/disasm.c when profiling a
chrooted process?

In symbol__disassemble(), dso__find_binary_type() and dso__get_filename() a=
re
called outside nsinfo__mountns_enter():

tools/perf/util/disasm.c:symbol__disassemble() {
	...
	mutex_lock(dso__lock(dso));
	symfs_filename =3D dso__get_filename(dso, "", &decomp, dbt);
	mutex_unlock(dso__lock(dso));
}

At this commit, when a chrooted binary does not exist at the same path in t=
he
host root, dso__get_filename() in tools/perf/util/dso.c falls back to
dso__filename_with_chroot() and returns a path that already has the chroot
prefix prepended. When symbol__disassemble() then calls
symbol__disassemble_llvm(), symbol__disassemble_capstone(), or
symbol__disassemble_capstone_powerpc(), __dso__read_symbol() in
tools/perf/util/dso.c and symbol__disassemble_capstone_powerpc() in
tools/perf/util/capstone.c enter the chroot via nsinfo__mountns_enter() and
call open(symfs_filename, ...), resulting in a double chroot prefix and
failing with ENOENT (or failing to open the host build-id cache path when t=
he
DSO comes from DSO_BINARY_TYPE__BUILD_ID_CACHE).

In the later commit in the series ("perf tools: Remove redundant chroot
handling"), dso__filename_with_chroot() is removed from dso__get_filename(),
while dso__find_binary_type_locked(), symbol__disassemble(),
dso__find_dbginfo_type(), and debuginfo__new() still invoke
dso__get_filename() outside nsinfo__mountns_enter(), causing
is_regular_file(name) in dso__get_filename() to check the unprefixed path in
the host root and return NULL.

[Severity: Medium]
When dso__load() in tools/perf/util/symbol.c runs inside
nsinfo__mountns_enter() for a chrooted process, how will downstream callers
that open dso__symsrc_filename(dso) outside nsinfo__mountns_enter() locate
the binary?

Inside dso__load(), because nsinfo__mountns_enter() has already chrooted in=
to
the target root directory, is_regular_file(name) succeeds on the unprefixed
in-chroot path instead of falling back to dso__filename_with_chroot() (which
is later removed in "perf tools: Remove redundant chroot handling"):

tools/perf/util/symbol.c:dso__load() {
	...
	is_reg =3D is_regular_file(name);
	if (!is_reg && errno =3D=3D ENOENT && dso__nsinfo(dso)) {
		char *new_name =3D dso__filename_with_chroot(dso, name);
		...
	}
	...
	dso__set_symsrc_filename(dso, strdup(name));
}

As a result, dso__set_symsrc_filename() records the unprefixed in-chroot pa=
th
before nsinfo__mountns_exit() restores the host root. When
dso__symsrc_filename(dso) is subsequently used outside
nsinfo__mountns_enter() by dso__libdw_dwfl() in tools/perf/util/libdw.c,
srcline_dso_name() in tools/perf/util/srcline.c (for cmd__addr2line() and
libbfd__addr2line()), __find_debuginfo() in tools/perf/util/unwind-libdw.c,
and read_unwind_spec_debug_frame() / __libunwind__find_proc_info() in
tools/perf/util/unwind-libunwind.c, opening that path in the host root will
either fail with ENOENT or open a different host binary.

[Severity: Medium]
Can calling chroot(nsinfo__chroot(nsi)) in nsinfo__mountns_enter() also bre=
ak
DSO path lookups for synthesized MMAP2 events and for processes that chroot
after mapping libraries?

First, when perf_event__synthesize_mmap_events() synthesizes MMAP2 events by
reading /proc/<pid>/task/<pid>/maps from perf's own context, the kernel's
show_map_vma() -> d_path() resolves each VMA file path relative to perf's r=
oot
(the root of the mount namespace), so event->mmap2.filename and
dso__long_name(dso) already contain the chroot prefix (for example,
"/var/chroot/usr/bin/app"). When perf_record_mmap2__read_build_id() in
tools/perf/util/synthetic-events.c, dsos__read_build_ids_cb(), open_dso(),
dso__load(), or dso__cache_build_id() enters nsinfo__mountns_enter() and
chroots into "/var/chroot", opening that path resolves to
"/var/chroot/var/chroot/usr/bin/app" and fails with ENOENT.

Second, for daemons that map their executable and shared libraries before
calling chroot() into an empty directory such as "/var/empty", both
/proc/<pid>/task/<pid>/maps and kernel-generated PERF_RECORD_MMAP2 events
record host-root-relative paths such as "/usr/sbin/sshd" and
"/lib64/libc.so.6". Entering chroot("/var/empty") in nsinfo__mountns_enter()
causes lookups of those pre-chroot paths to search inside "/var/empty" and
fail with ENOENT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D7
