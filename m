Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFF4CF477
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196305; cv=none; b=jJGH6/uHgbSYRkgj4Za7K8nq+8pXlBYcZTRyRE7HOrxKgwuYJaqV16HDslV8MqHUX2lDlDgEkGP8zhrElBonIpgpjiW0GVlpXuIXggesES+S3bjfauXolz2OHGw1RjZoeDwNMFvPe9hC/WsR0nYqhUUOXuz4yniXgYwGarBB7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196305; c=relaxed/simple;
	bh=i6mYjsB1RqhvQFbrdFZrbSElZkxxNC01gUh6ocJ3aJk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OpudkQhJUGMcRINCl8VfMSQAgZh1syAJBJZcnSTqy2psavgnccrrfpoA3ucrLrNNI5+TL1OP7YmhYoSqPg+/tCdwDP4sjI0yAsZ1cUEb1buqc7bfpjJZ5pmTJjP24NDbeavo8S6+nipBWuaieZPUErU2yamve/0xFaA1Ff9jb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQgwZmHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQgwZmHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994AB1F000C4;
	Sat, 17 Oct 2026 00:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196303;
	bh=C7ohun09Xy2F/ONqkb6qMWSxvGSjKicJYl9BW21KrJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQgwZmHzzwIJLRCJArm+1xBUvxqOP3p3z6gmpoxRmk3b06DN1rmWiNbsj0iwlY8Ii
	 gS9Bk/JXresb+KdOudwZG/oIIXa5BswmFVsU+5Fi6qtt7BcpAoP63MaM29Kl6n0+f4
	 WV9RZRTaClIpBScsOAdfyMUtHmaAkThgaDYMlfj1uSg37EDchg8T7adZqQx0P/AuYj
	 BoouIHUZ3vivqZIgV4FaXLNBnkNv3KpZIhNYyWefi4OmWhaA2DZ5AFugklIpMQ6tvg
	 eApjimv2jUvNQHyM7V5GaUW64UmQmlAqZo3SdF3PCzpiaCnNbfSErrb71GkI0Gur8e
	 1aut+urTv70Bw==
Message-ID: <sashiko-outbox-175062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf unwind: Find separate debuginfo without
 loading symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017000158.1178269-3-thepacketgeek@gmail.com>
References: <20261017000158.1178269-1-thepacketgeek@gmail.com>
 <20261017000158.1178269-3-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:18:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] perf dso: dso__find_debuginfo() returns unverified first regular=
 file
- [Medium] perf dso: dso__find_debuginfo() ignores symfs when reading build=
-id
- [Medium] perf dso: dso__find_debuginfo() skips mountns and chroot lookup
- [Medium] perf unwind: __find_debuginfo() skips fallback when symsrc is ma=
in binary
--

commit c3719700a5c64b73424eb58a041d6711fca9b8d4
Author: Matthew Wood <thepacketgeek@gmail.com>

perf unwind: Find separate debuginfo without loading symbols

This commit adds dso__find_debuginfo() to locate separate debuginfo files
for user space DSOs without loading symbol tables, and wires it into the
libdw and libunwind DWARF unwinders.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e03e2cb9212b1..36f5ab94c7e70 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -598,6 +598,37 @@ int dso__read_build_id(struct dso *dso)
>  	return dso__has_build_id(dso) ? 0 : -1;
>  }
> =20
> +/*
> + * Look for a separate debuginfo file for a user space DSO in the places
> + * dso__load() would, without loading its symbols. Returns an allocated =
path,
> + * or NULL if none was found.
> + */
> +char *dso__find_debuginfo(struct dso *dso)
> +{
> +	static const enum dso_binary_type debuginfo_types[] =3D {
> +		DSO_BINARY_TYPE__DEBUGLINK,
> +		DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
> +		DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
> +		DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> +		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> +		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
> +	};
> +	char filename[PATH_MAX];
> +
> +	/* The build-id cache and /usr/lib/debug/.build-id need the build-id. */
> +	dso__read_build_id(dso);

[Severity: Medium]
Does calling dso__read_build_id() here ignore symbol_conf.symfs when
--symfs is used and the DSO does not yet have a recorded build-id?

In tools/perf/util/symbol.c:dso__load(), perf joins symfs before reading
the build-id:

	if (!dso__has_build_id(dso)) {
		struct build_id bid =3D { .size =3D 0, };

		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
		if (filename__read_build_id(name, &bid) > 0)
			dso__set_build_id(dso, &bid);
	}

In contrast, tools/perf/util/dso.c:dso__read_build_id() passes
dso__long_name(dso) directly to filename__read_build_id() without
__symbol__join_symfs():

	if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
		dso__set_build_id(dso, &bid);

If the binary only exists under symfs, dso__read_build_id() fails to read
the build-id. If a different version of the binary exists at
dso__long_name(dso) on the host root filesystem, dso__read_build_id()
populates the DSO with the host binary's build-id, causing subsequent
dso__load() calls to reject the symfs binary with
DSO_LOAD_ERRNO__MISMATCHING_BUILDID.

> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(debuginfo_types); i++) {
> +		if (dso__read_binary_type_filename(dso, debuginfo_types[i], /*root_dir=
=3D*/"",
> +						   filename, sizeof(filename)))
> +			continue;
> +		if (is_regular_file(filename))
> +			return strdup(filename);
> +	}

[Severity: Medium]
Can this loop return the stripped DSO itself or a file with a mismatched
build-id before reaching the remaining candidates in debuginfo_types[]?

When checking DSO_BINARY_TYPE__DEBUGLINK,
tools/perf/util/dso.c:dso__read_binary_type_filename() tests
debuglink_paths[] using is_regular_file():

		for (i =3D 0; i < ARRAY_SIZE(debuglink_paths); i++) {
			snprintf(filename, size,
					debuglink_paths[i], dso_dir, symfile);
			if (is_regular_file(filename)) {
				ret =3D 0;
				break;
			}
		}

When .gnu_debuglink has the same basename as the DSO itself (such as on
Debian/Ubuntu where /usr/lib/libfoo.so has separate debuginfo at
/usr/lib/debug/usr/lib/libfoo.so), debuglink_paths[1] ("%s/%s") resolves to
the stripped DSO binary itself. Similarly, for
DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO, __dso__build_id_filename()
ignores is_debug=3Dtrue for vDSOs or flat build-id cache links and returns
the cached main binary.

In dso__load(), each candidate is opened via symsrc__init(), which checks
that the candidate's build-id matches the DSO:

	if (dso__has_build_id(dso) && !symbol_conf.ignore_vmlinux_buildid) {
		...
		if (!dso__build_id_equal(dso, &bid)) {
			pr_debug("%s: build id mismatch for %s.\n", __func__, name);
			*dso__load_errno(dso) =3D DSO_LOAD_ERRNO__MISMATCHING_BUILDID;
			goto out_elf_end;
		}
	}

and verifies symsrc__has_symtab() before stopping, allowing the loop to
continue to BUILD_ID_CACHE_DEBUGINFO, UBUNTU_DEBUGINFO, and
BUILDID_DEBUGINFO.

Because dso__find_debuginfo() returns the very first regular file without
checking if it is distinct from the DSO, if its build-id matches, or if it
contains debug/unwind sections:
- In __find_debuginfo(), if the returned path equals file_name, it is freed
  and libdw receives no debuginfo without trying later debuginfo_types[]
  entries.
- If a path-based candidate (DEBUGLINK, FEDORA_DEBUGINFO, UBUNTU_DEBUGINFO)
  on the host has a mismatched build-id while the matching debuginfo is in
  BUILD_ID_CACHE_DEBUGINFO or BUILDID_DEBUGINFO, libdwfl rejects the
  mismatched file and never calls __find_debuginfo() again for that module,
  while libunwind's read_unwind_spec_debug_frame() reads .debug_frame from
  the mismatched file and overwrites dso->symsrc_filename with it.

[Severity: Medium]
Also in this loop, how does dso__find_debuginfo() find debuginfo files
located inside a target process's mount namespace or chroot?

In tools/perf/util/symbol.c:dso__load(), perf enters dso__nsinfo(dso)'s
mount namespace (exiting for the build-id cache types) and falls back to
dso__filename_with_chroot() when is_regular_file() fails with ENOENT:

		if (nsexit)
			nsinfo__mountns_exit(&nsc);

		is_reg =3D is_regular_file(name);
		if (!is_reg && errno =3D=3D ENOENT && dso__nsinfo(dso)) {
			char *new_name =3D dso__filename_with_chroot(dso, name);
			if (new_name) {
				is_reg =3D is_regular_file(new_name);
				strlcpy(name, new_name, PATH_MAX);
				free(new_name);
			}
		}

Here, dso__read_build_id(dso) enters and immediately exits the mount
namespace, so the debuginfo_types[] loop runs in perf's own mount namespace
without mountns or chroot handling.

> +	return NULL;
> +}
> +
>  static char *dso__get_filename(struct dso *dso, const char *root_dir,
>  			       bool *decomp)
>  {

[ ... ]

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 63a5c2253174f..a2e70e4f206f7 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c

[ ... ]

> @@ -39,11 +40,20 @@ static int __find_debuginfo(Dwfl_Module *mod __maybe_=
unused, void **userdata,
>  			    const char *file_name, const char *debuglink_file __maybe_unused,
>  			    GElf_Word debuglink_crc __maybe_unused, char **debuginfo_file_nam=
e)
>  {
> -	const struct dso *dso =3D *userdata;
> +	struct dso *dso =3D *userdata;
> =20
>  	assert(dso);
> -	if (dso__symsrc_filename(dso) && strcmp(file_name, dso__symsrc_filename=
(dso)))
> -		*debuginfo_file_name =3D strdup(dso__symsrc_filename(dso));
> +	if (dso__symsrc_filename(dso)) {
> +		if (strcmp(file_name, dso__symsrc_filename(dso)))
> +			*debuginfo_file_name =3D strdup(dso__symsrc_filename(dso));
> +	} else {
> +		char *debuginfo =3D dso__find_debuginfo(dso);
> +
> +		if (debuginfo && strcmp(file_name, debuginfo))
> +			*debuginfo_file_name =3D debuginfo;
> +		else
> +			free(debuginfo);
> +	}
>  	return -1;
>  }

[Severity: Medium]
Should __find_debuginfo() also fall back to dso__find_debuginfo(dso) when
dso__symsrc_filename(dso) is equal to file_name?

If symbols were loaded from the main binary itself (for example, when the
binary retains a .symtab after strip --strip-debug, has .gnu_debugdata
MiniDebugInfo, or matched DSO_BINARY_TYPE__BUILD_ID_CACHE in dso__load()),
dso__symsrc_filename(dso) is non-NULL and equal to file_name while
.debug_frame is in a separate debuginfo file.

With the if/else structure above, strcmp(file_name, dso__symsrc_filename(ds=
o))
is 0, so *debuginfo_file_name is not set and the else branch calling
dso__find_debuginfo(dso) is skipped.

[ ... ]

> diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-=
libunwind.c
> index 73d191ce51a55..d92f1d4852851 100644
> --- a/tools/perf/util/unwind-libunwind.c
> +++ b/tools/perf/util/unwind-libunwind.c

[ ... ]

> @@ -301,19 +302,10 @@ static int read_unwind_spec_debug_frame(struct dso =
*dso,
>  		}
> =20
>  		if (ofs <=3D 0) {
> -			char *debuglink =3D malloc(PATH_MAX);
> -			int ret =3D 0;
> -
> -			if (debuglink =3D=3D NULL) {
> -				pr_err("unwind: Can't read unwind spec debug frame.\n");
> -				return -ENOMEM;
> -			}
> +			char *debuginfo =3D dso__find_debuginfo(dso);
> =20
> -			ret =3D dso__read_binary_type_filename(
> -				dso, DSO_BINARY_TYPE__DEBUGLINK,
> -				machine->root_dir, debuglink, PATH_MAX);
> -			if (!ret) {
> -				fd =3D open(debuglink, O_RDONLY);
> +			if (debuginfo) {
> +				fd =3D open(debuginfo, O_RDONLY);
>  				if (fd >=3D 0) {
>  					ofs =3D elf_section_offset(fd,
>  							".debug_frame");
> @@ -326,12 +318,12 @@ static int read_unwind_spec_debug_frame(struct dso =
*dso,
>  						"%s: overwrite symsrc(%s,%s)\n",
>  							__func__,
>  							dso__symsrc_filename(dso),
> -							debuglink);
> +							debuginfo);
>  					dso__free_symsrc_filename(dso);
>  				}
> -				dso__set_symsrc_filename(dso, debuglink);
> +				dso__set_symsrc_filename(dso, debuginfo);
>  			} else {
> -				free(debuglink);
> +				free(debuginfo);
>  			}
>  		}
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017000158.1178=
269-1-thepacketgeek@gmail.com?part=3D2
