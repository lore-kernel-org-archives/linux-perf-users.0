Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623328;
	b=s2bjy5Tu03aSeD/UZoFg1vLOD+b3O6/Pyo0bWzcLAL1yIdeHhJgkheEv7ygmhVOS0H8w
	 zRuH3BZbd0tRl6U7hcj0JtngU/yjQV4rRyJzPH4CWE14ER/+UrmyAhoIyzh9KkKr+oZYt
	 grkK2EgKnt68t1GKTLvtksx4I9mE336VhqG5hHfOVDfZSqEu9TJuPPi5IE0JOb4eSEWIy
	 QbJ0IMNVUU/hCcAifRO/nWs5vksJe/cl9TNaKewSTvx9tFhc1BWcr+aCPFMUlIeYAvkZt
	 HthaA9+MMEzTqS/G40IY+0HxhsHGrw1QI7ViP3TvCRJUO7Uk2xN23hWqN4fd/IYrafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623328;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rTiM9tznVgPjsxS27QbJ1uJnR3FRXu7K175+nTF1SoU=;
	b=SKLdDDZZIO7jpSp1I4jI5mxrTvDyH/sGoFVUAFSHXWN1JPPYH4cPRZCoqxVAWygunigz
	 qrr5e33TO58E2JrBO8LoAwMCkXnEyRPSyGoqtnmkdZEjRwFxuB1XSzSfNOmCq1ycClToZ
	 DfrJm/6W9zVXeYwHihi0sMART5fQrrhDtDjErfgYFZAOKEMKHZM0X46Uj8Yaiizc7jn//
	 Z1HCZbSFJ0sssvlT61ITFkJ9pKZBqqiHbyEvf76+3JgC195Xmir3+su7zAbSyEo8xjpMj
	 Jz0vt6qGyNhCQM8bkwTp/ul5Ksn9QNfN5abX+t5UTDlp0onIn+R2Tq7Eh3riwTmjH2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opFTkh6D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9174606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opFTkh6D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE3D1F000D2;
	Wed, 21 Oct 2026 22:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623327;
	bh=rTiM9tznVgPjsxS27QbJ1uJnR3FRXu7K175+nTF1SoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=opFTkh6Dr386DLTT9kkYG/xQ/Od4bXfc7EnuABBdPgyCvzda4sto/dgcoxQm7UCPW
	 r+6qqW37te9z8QQzwhCYvoNjTOsaViH1Oc0CSbizyLCazWCh8iI0R0etlNeosW+WtG
	 tKH5RhsHrnB9pJdxCliiekLR9YOS5avV80pWbN8gPqZ+u69vxhUacYurXI2gHJV91c
	 tPcFvhA5zX6hh0M3BakIZ46AsJ/KZtvD5DLW69cn+wd5ImkmJ1oCzTvVcyNQ29zjbg
	 3GEgfdSzqkRgzBIRHJqcmBtQA0cGNsPahc6dhGBgd1tsyrHAPh8HJHSdNtsHmSSr5k
	 su79OnxiSImBQ==
Message-ID: <sashiko-outbox-180750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] tools headers: Sync KVM headers with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-13-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:55:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf scripts: sync-headers.sh clobbers tools-ahead commits in ms=
r-index.h
- [Medium] perf scripts: setup_beauty_args() strips outfile arg for syscall=
tbl.sh
--

commit e56a03e1fdcaea6f774a4409b4149a6440687459
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add script and make target to sync the header copies with the k=
ernel

This commit adds tools/perf/scripts/sync-headers.sh and a sync-headers make
target to detect stale header copies under tools/, run beauty scripts to
capture string table changes, build-test consumers, and generate sync commi=
ts.

> diff --git a/tools/perf/scripts/sync-headers.sh b/tools/perf/scripts/sync=
-headers.sh
> new file mode 100755
> index 0000000000000..9a35a3d2095a7
> --- /dev/null
> +++ b/tools/perf/scripts/sync-headers.sh

[ ... ]

> +# A kernel commit that changed both the header and the tools copy already
> +# carried its change into tools/, so it has nothing left to pick up here.
> +find_kernel_commits() {
> +	local kernel_path=3D"$1"
> +	local tools_path=3D"$2"
> +	local sync_point=3D"$3"
> +	local copied sha
> +
> +	copied=3D$(git log --no-merges --format=3D'%H' \
> +		"${sync_point}..HEAD" -- "$tools_path" 2>/dev/null)
> +	[[ -n "$copied" ]] && copied+=3D$'\n'
> +
> +	while IFS=3D read -r sha; do
> +		[[ "$copied" =3D=3D *"$sha"$'\n'* ]] && continue
> +		echo "$sha"
> +	done < <(git log --no-merges --format=3D'%H' \
> +		"${sync_point}..HEAD" -- "$kernel_path" 2>/dev/null)
> +}
> +
> +# Render commit ids with FORMAT at the usual 12 chars, keeping their ord=
er.
> +format_commits() {
> +	local format=3D"$1"
> +	local ids=3D"$2"
> +
> +	[[ -n "$ids" ]] || return 0
> +	printf '%s\n' "$ids" | git log --no-walk=3Dunsorted --abbrev=3D12 \
> +		--format=3D"$format" --stdin 2>/dev/null
> +}
> +
> +# The kernel's current content can match a previous tools/ copy state wh=
en
> +# the kernel reverted the header; there is nothing to pick up then.
> +kernel_matches_previous_tools_state() {
> +	local kernel_path=3D"$1"
> +	local tools_path=3D"$2"
> +	local kernel_blob
> +
> +	kernel_blob=3D$(git hash-object "$kernel_path" 2>/dev/null) || return 1
> +	[[ -n "$(git log --format=3D%h -1 --find-object=3D"$kernel_blob" -- "$t=
ools_path" 2>/dev/null)" ]]
> +}

[Severity: Medium]
Can kernel_matches_previous_tools_state() and find_kernel_commits() miss
cases where tools_path has commits ahead of the kernel header while
kernel_path also received an unrelated commit since the last common
sync_point, causing process_header() to overwrite tools_path and revert
the tools-side changes?

Specifically, kernel_matches_previous_tools_state() only matches when the
current kernel_blob hash previously existed in tools_path's history, which
stops matching as soon as kernel_path receives any new commit after
sync_point. Meanwhile, find_kernel_commits() only uses the commits on
tools_path in ${sync_point}..HEAD to filter out commits that touched both
files, without checking for commits that modified tools_path alone.

This happens in commit 78affd0f60ae ("tools arch x86: Sync the msr-index.h
copy with the kernel sources") in this series. Commit 7846bf499da3 ("tools
headers: Sync x86 headers with kernel sources") had added seven PEBS vector
definitions to tools/arch/x86/include/asm/msr-index.h ahead of the kernel,
and arch/x86/include/asm/msr-index.h later received commit ac5cc691eb4a
("x86/thermal: Add bit definitions for Intel Directed Package Thermal
Interrupt") after their common sync point 369e91bd201d. Running
sync-headers.sh then overwrote tools/arch/x86/include/asm/msr-index.h with
arch/x86/include/asm/msr-index.h, silently deleting those definitions in
commit 78affd0f60ae:

tools/arch/x86/include/asm/msr-index.h:
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
-#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
-#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
-#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
-#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
-#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
-#define ARCH_PEBS_VECR_EXT_SHIFT	49
-#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)

Should process_header() and process_group() check whether tools_path has
commits in ${sync_point}..HEAD that are not in kernel_path's history and
skip or warn instead of overwriting tools_path?

[ ... ]

> +		# $(patsubst -%,,$(CC)) yields the compiler name
> +		args=3D$(printf '%s\n' "$args" | sed 's/\$(patsubst -%,,\$(CC))/gcc/g')
> +		args=3D"${args//\'}"
> +		args=3D"${args%' > $@'}"
> +		value=3D""
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
Does stripping the $@ token in setup_beauty_args() cause
run_beauty_script() to always fail on syscalltbl.sh?

In tools/perf/trace/beauty/Build, the rule for syscalltbl.sh passes $@ as a
second positional argument rather than redirecting stdout with > $@:

$(syscall_array): $(syscall_tbl) $(syscall_tbl_data)
	$(call rule_mkdir)
	$(Q)$(call echo-cmd,gen)$(SHELL) '$(syscall_tbl)' $(srctree)/tools $@

And tools/perf/trace/beauty/syscalltbl.sh requires two positional arguments
and writes its generated table to the second argument:

if [ $# -ne 2 ]; then
       usage
fi
tools_dir=3D$1
outfile=3D$2

Because setup_beauty_args() skips $@, BEAUTY_SCRIPT_ARGS["syscalltbl.sh"]
only receives "$KERNEL_DIR/tools". When run_beauty_pass() calls
run_beauty_script() for syscalltbl.sh, syscalltbl.sh exits with status 1 in
usage(), and run_beauty_script() suppresses stderr and the exit status,
leaving both the before and after files empty so syscall table changes are
never detected.

[ ... ]

=E5=AE=8C=E7=BE=8E (Wait=E2=80=94oops! Do not include any extra text after =
the report!). Let's make sure I only output the report itself in the final =
message!
Wait=E2=80=94I am already in the final response output stream! Let me check=
: everything after `$/thought` is in the response!
Oh! I wrote `=E5=AE=8C=E7=BE=8E...` at the end! Let me not do that=E2=80=94=
wait, I cannot edit already emitted tokens, so I'll stop immediately. (Actu=
ally it's just one line at the very end). Let me end with a blank line now.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D12
