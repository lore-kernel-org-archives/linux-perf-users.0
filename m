Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623216;
	b=vgDLRKXjXrnSy8+TjluIQajAmm2LxYowssHN+1XR8Ke7KqxigAKirwES0ub0K3tRRKQP
	 DJewrNTZKvAgIp/3REeQkzl+5cA/tShKCs1otm00kR7ik15WEEWzTUDym3Xv5HATgaWG/
	 DEaNG3Pr2oBNKTYzq0xyiC7nl5seIMSqL8AGsSvwK8O26IE1Dc+Ko/QlitnoyBrH0uj64
	 ACHEMUBYFrzY5sCiCFPq3FGMus/To9r+HprqRLMOZSk9nMSqSZ36xoxcoBq4T0OvQALeB
	 W0DXLK50qP/TNq+ELAG14M5qYqkRz7o3+Wlc1gAKZkCA3jQ2sCRH8AnXYk5tXtIMJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GhDnKrolwp1cKm4ZCpKxXBZn/d2kIvgr2ukF+kTg9Uc=;
	b=w/77n2me3fUFz0Pb6xcHV4yB13kgmO2myw0lV2yPM+zaPy6U2i6YRDk18sp9FCCLS1q1
	 N6uHl1eyJVwDMnp2uvXurgqG/2msziuvOUFI4LSvMpph9i2LtA++8+wsB388wRbmxs9MQ
	 QDUeUnYYwQ8LgPm4I8Ucep56UWBDbfv3jH8sbq2tVh8knZ1NAHUhaF61kf8xDU+TM/wjv
	 0HDa31bZZLpZUksyd1EGqcDfDqhJg5vpp+hbbZsa77vvZ9GK5AsSELAP+EXYK/xl4LN9i
	 g+BDoLaHCf2CkX7GUGdLwOWAyIJ/CqjYPxGtQV2RaiMJxidt44adkrCkaeu0xgUCNiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBlWoHAw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B21606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBlWoHAw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A761F000C1;
	Wed, 21 Oct 2026 22:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623216;
	bh=GhDnKrolwp1cKm4ZCpKxXBZn/d2kIvgr2ukF+kTg9Uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TBlWoHAwys7x7O/AZUG7Iom25E5IU7VF717aTV8kPqprNoTRaVND5hTNAHfYuXU9/
	 l4uk4dqeJuObJ0X3StEZHXHMUnGlmvbvlvM2zruD3Dx5hFQyScNT2JfyPAwfuaEbB8
	 lMMb+KWLGiB3vChCmSdQLUFXBtbMFGEB1PVBgR55eZbC35ORP+wDtibNixqrNeJ+ot
	 4P9y+ScwCovSFsfPVDHqunBc/eEE60qrQ15B0DsB81e4sS5a+mEG6ekQzaNDq0cYsP
	 /KlAAsrbVNGUWNG9qUa9zS2J1GDoo6uGvnUaC6rOIcsznIoGe8ejjiDmoMWKEsgrUn
	 LLfA2aA5xbZjQ==
Message-ID: <sashiko-outbox-180748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] perf tools: Add script and make target to sync
 the header copies with the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-2-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:53:35 +0000
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
- [Medium] perf tools: process_header() overwrites intentional tools/ heade=
r divergences
- [Medium] perf tools: setup_beauty_args() strips output file argument for =
syscalltbl.sh
- [Medium] perf tools: find_beauty_scripts() matches unrelated headers by b=
asename
- [Medium] perf tools: build_target() fails when OUTPUT_DIR is a relative p=
ath
--

commit e56a03e1fdcaea6f774a4409b4149a6440687459
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add script and make target to sync the header copies with the k=
ernel

This commit adds tools/perf/scripts/sync-headers.sh and a sync-headers make
target to detect stale tools/ header copies, run beauty table generators,
build-test consumers, and create standardized sync commits.

> diff --git a/tools/perf/scripts/sync-headers.sh b/tools/perf/scripts/sync=
-headers.sh
> new file mode 100755
> index 0000000000000..9a35a3d2095a7
> --- /dev/null
> +++ b/tools/perf/scripts/sync-headers.sh

[ ... ]

> +# --- Map a kernel header path to its beauty script(s) -----------------=
---
> +#
> +# A beauty script is relevant if it reads from the directory containing
> +# the header being updated.
> +
> +find_beauty_scripts() {
> +	local kernel_path=3D"$1"
> +	local header_basename
> +	header_basename=3D$(basename "$kernel_path")
> +
> +	local scripts=3D()
> +
> +	# Search all beauty .sh scripts (including subdirs) for references to t=
his header
> +	while IFS=3D read -r script; do
> +		if grep -F -q -e "/$header_basename" -e "\"$header_basename\"" \
> +			"$script" 2>/dev/null; then
> +			scripts+=3D("$script")
> +		fi
> +	done < <(find "$PERF_DIR"/trace/beauty -name '*.sh')
> +
> +	printf '%s\n' "${scripts[@]}"
> +}

[Severity: Medium]
Could matching only on header_basename in find_beauty_scripts() associate a
beauty script with the wrong header copy when multiple tracked headers share
the same filename?

For example, include/uapi/linux/stat.h is copied to both
tools/include/uapi/linux/stat.h and
tools/perf/trace/beauty/include/uapi/linux/stat.h, while statx_mask.sh only
reads the beauty copy. When process_header() updates
tools/include/uapi/linux/stat.h, find_beauty_scripts() matches statx_mask.s=
h,
and run_beauty_pass() swaps tools/include/uapi/linux/stat.h while
statx_mask.sh reads the unupdated beauty copy. Because the output does not
change, process_header() then writes:

  That don't result in changes to the string tables generated from this hea=
der.

instead of:

  That just rebuilds perf, silencing this build warning.

Similar basename collisions happen between include/uapi/linux/prctl.h and
arch/x86/include/uapi/asm/prctl.h (matching both prctl_option.sh and
x86_arch_prctl.sh), arch/{x86,powerpc,s390,arm64}/include/uapi/asm/kvm.h
(matching kvm_ioctl.sh, which only reads tools/include/uapi/linux/kvm.h), a=
nd
arch/mips/include/asm/errno.h (matching arch_errno_names.sh).

Also, setup_beauty_args() only reads tools/perf/trace/beauty/Build and matc=
hes
lowercase variable names in re_tbl:

	local build=3D"$PERF_DIR/trace/beauty/Build"
	...
	re_tbl=3D'^([a-z0-9_]+_tbl[s]?)[[:space:]]*(:=3D|\?=3D)[[:space:]]*'

Should setup_beauty_args() also parse
tools/perf/trace/beauty/tracepoints/Build and allow uppercase characters in
variable names so x86_irq_vectors.sh and x86_msr.sh (which uses
x86_arch_MSRs_tbl) receive their directory arguments?

[ ... ]

> +# Keep build output out of the source tree; perf, tracing and objtool ta=
ke
> +# O=3D, the libraries and bpftool take OUTPUT=3D.
> +build_target() {
> +	local name=3D"$1"
> +	local dir=3D"$2"
> +
> +	case "$name" in
> +	perf)
> +		make -C "$dir" O=3D"$OUTPUT_DIR" -j"$(nproc)"
> +		;;
> +	tracing|objtool)
> +		(umask 077 && mkdir -p "$OUTPUT_DIR/$name")
> +		make -C "$dir" O=3D"$OUTPUT_DIR/$name" -j"$(nproc)"
> +		;;
> +	*)
> +		(umask 077 && mkdir -p "$OUTPUT_DIR/$name")
> +		make -C "$dir" OUTPUT=3D"$OUTPUT_DIR/$name/" -j"$(nproc)"
> +		;;
> +	esac
> +}

[Severity: Medium]
What happens in build_target() when a user passes a relative path via -o,
--output, or OUTPUT_DIR?

In main(), the script changes directory to $KERNEL_DIR and creates
$OUTPUT_DIR without converting it to an absolute path:

	cd "$KERNEL_DIR"
	...
	if [[ $BUILD -eq 1 ]]; then
		# umask covers every level created, -m with -p only the last.
		(umask 077 && mkdir -p "$OUTPUT_DIR")
	fi

When build_test_targets() or process_group() then calls build_target(),
make -C "$dir" changes the working directory to the target subdirectory (su=
ch
as tools/perf, tools/objtool, or tools/lib/bpf) before evaluating O=3D or
OUTPUT=3D. In tools/scripts/Makefile.include, the existence check resolves =
that
relative path from $dir rather than from $KERNEL_DIR (or the caller's worki=
ng
directory), causing the build test to fail and sync-headers.sh to revert the
synced header. Should OUTPUT_DIR be canonicalized to an absolute path before
main() changes directory?

[ ... ]

> +		for token in $args; do
> +			case "$token" in
> +			'$@')
> +				continue
> +				;;
> +			'$(srctree)'*)
> +				token=3D"${token//\$(srctree)/$KERNEL_DIR}"
> +				;;
> +			'$('*)
> +				token=3D"$KERNEL_DIR/${BEAUTY_MAKE_DIRS["${token:2:${#token}-3}"]:-}"
> +				[[ "$token" =3D=3D "$KERNEL_DIR/" ]] && { value=3D""; break; }
> +				;;
> +			*) ;;
> +			esac
> +			token=3D$(printf '%s' "$token" | sed "s/\$(SRCARCH)/$srcarch/g")
> +			if [[ "$token" =3D=3D *'$('* ]]; then
> +				value=3D""
> +				break
> +			fi
> +			value+=3D"${value:+ }$token"
> +		done
> +		[[ -n "$value" ]] || continue
> +		BEAUTY_SCRIPT_ARGS["$script"]=3D"$value"
> +	done
> +}
> +
> +run_beauty_script() {
> +	local script=3D"$1"
> +	local -a cmd=3D()
> +
> +	read -ra cmd <<< "${BEAUTY_SCRIPT_ARGS["${script##*/}"]:-}"
> +	bash "$script" "${cmd[@]+"${cmd[@]}"}" 2>/dev/null || true
> +}

[Severity: Medium]
Will run_beauty_script() ever capture string table diffs for syscalltbl.sh?

In tools/perf/trace/beauty/Build, syscalltbl.sh is invoked with $@ as a
positional output file argument rather than via stdout redirection:

	$(Q)$(call echo-cmd,gen)$(SHELL) '$(syscall_tbl)' $(srctree)/tools $@

And tools/perf/trace/beauty/syscalltbl.sh requires two arguments and writes
directly to the output file:

	if [ $# -ne 2 ]; then
		usage
	fi
	tools_dir=3D$1
	outfile=3D$2

Because setup_beauty_args() strips the $@ token,
BEAUTY_SCRIPT_ARGS["syscalltbl.sh"] only contains $KERNEL_DIR/tools. When
process_group() -> run_beauty_pass() -> run_beauty_script() runs
syscalltbl.sh, it fails the argument count check, discards the usage message
via 2>/dev/null, and ignores the non-zero status via || true. That leaves t=
he
before and after files empty, so process_group() always reports:

  That don't result in changes to the string tables generated from these he=
aders.

even when syscall tables have new or modified entries.

[ ... ]

> +	# Do the actual copy
> +	if ! cp "$KERNEL_DIR/$kernel_path" "$KERNEL_DIR/$tools_path"; then
> +		err "Failed to copy $kernel_path -> $tools_path"
> +		COPY_FAILED+=3D("$tools_path")
> +		cleanup_tmpdir "$beauty_tmpdir"
> +		return 1
> +	fi
> +	info "Copied $kernel_path -> $tools_path"

[Severity: Medium]
Does copying $kernel_path directly over $tools_path in process_header()
clobber intentional tools/ adaptations in files that check-headers.sh
compares with ignore rules?

In tools/perf/check-headers.sh, several tracked files intentionally differ
between the kernel and tools/ and are checked with -I patterns or
check_ignore_some_hunks:

	for i in "${SYNC_CHECK_FILES[@]}"
	do
	  check "$i" '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
	done

along with arch/x86/include/asm/amd/ibs.h, include/uapi/asm-generic/mman.h,
include/uapi/linux/mman.h, include/linux/build_bug.h, include/linux/ctype.h,
include/linux/unaligned.h, lib/ctype.c, arch/x86/lib/memcpy_64.S,
arch/x86/lib/memset_64.S, and lib/list_sort.c.

When check-headers.sh reports other differences in one of those files,
process_header() overwrites $tools_path with a verbatim copy of $kernel_pat=
h,
removing the tools/-specific changes (such as mman-common-tools.h in
tools/include/uapi/asm-generic/mman.h, the static_assert guard in
tools/include/linux/build_bug.h, __isdigit in tools/include/linux/ctype.h,
relative includes marked with __ignore_sync_check__ in x86 insn/inat files,
or omitted kernel hunks in tools/lib/list_sort.c). If the host build still
passes without those adaptations, process_header() will commit the clobbered
file.

In addition, find_sync_point() assumes that files with intentional differen=
ces
never had matching blob hashes and will fall through to the last commit
touching $tools_path:

	for ((i =3D 0; i < ${#candidates[@]}; i++)); do
		if [[ "${blobs[2*i]%% *}" =3D=3D "${blobs[2*i+1]%% *}" && \
		      "${blobs[2*i]%% *}" !=3D *:* ]]; then
			echo "${candidates[i]}"
			return
		fi
	done

	git log --no-merges --format=3D'%H' -1 -- "$tools_path" 2>/dev/null

For files that were initially copied verbatim and only later adapted for
tools/ (for example, tools/include/uapi/asm-generic/mman.h, which was
byte-identical in commit fb7df12d645c before commit be709d48329a added
mman-common-tools.h), doesn't find_sync_point() match that older
pre-divergence commit and cause find_kernel_commits() to list and Cc commits
that were already synced?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D1
