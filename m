Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754546C846
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719373; cv=none; b=cJ9FOrWFWou4isn212PwV8o1OBUbg/hJeOssoY7ROwPaw3H4+J9bF3QyGwPNb+5tVrl+FI8qU2PuIetmhkuy0ZNHqyIOZ11PgUs57oARyf4toQQTargEceYwSBqrjCj/MrFPrNWdsT+0BGTgOGKNLSmnvBEU80Bq+q/BrApjKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719373; c=relaxed/simple;
	bh=wiZCp7eGEYk/5BQNkXrCX9M42QFxOBLVYO4pTo+CuCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PY3i5jer+igMGkJqgyr25UYENjnU5+eevtLXbTxiMp9729NGuPRyZ+p/Csbd0piqCKuhUI7CtykTun8z97omZZkNqcdyqGYmc0apnUbASsPSvVHT1whPo/XZu56kqLH4AR4EgF/SW9TaYHYt1r2+9GFt+wKxKnufTugpC/Fgmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVbWlMJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVbWlMJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F9C1F000E9;
	Fri, 14 Aug 2026 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719371;
	bh=Y3zU2MbOsEkSNgajCPzFtz6QpP52dYCL4KgrvLK0LGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVbWlMJAMLtW8HJeF3jfz+xFLvbe/DLLiy8EsnylBlbFt/9YyUbNffYZmVCFVs8kD
	 wXqbrGISE38APa9f6mf0vOKWtcHyhbbr2EW6it1UMDl06jEUTOovrjWT1RJYcAg8EB
	 +0sJepjsXTTs/YulllDqc32BahvEVBNmo/GDHoMgmwqteKyi+oBOF/xpyepUEH40so
	 RQJ7lsLbR1jLafwnLCWMO/gxSVtOsPLObAWx4QZ/RaPmLxmYYE/AG0gtzX/jH3CPRP
	 sx9Y1RsfbcP67wyK0Ro6cSwJtBePlpUCN2p8ewQcMANYdF0o9bl/5Ip5LdW28rM8bK
	 mqEmIZ0UndAFQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] selftests/perf_events: add AUX kernel API
 selftest script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260814144927.489172-6-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
 <20260814144927.489172-6-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:56:10 +0000
Message-Id: <20260814145611.57F9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Selftest unconditionally fails in installed environments by expe=
cting kernel source files to be present.
- [Medium] Userspace regression test is improperly skipped when the selftes=
t is run from an installed location.
- [Medium] Selftest hardcodes `gcc` for runtime compilation, breaking cross=
-compilation environments.
- [Medium] Insecure predictable temporary directory name in `/tmp` allows l=
ocal arbitrary file overwrite.
--

--- Patch [5]: [RFC PATCH 5/5] selftests/perf_events: add AUX kernel API se=
lftest script ---
commit 3dec31f6b5ec09fc257a6fee2e10670ad1c14b3c
Author: Kunwu Chan <kunwu.chan@gmail.com>

selftests/perf_events: add AUX kernel API selftest script

Add a shell script that runs the perf_aux_kernel KUnit suite through
debugfs, builds and runs the userspace regression program, and
performs static-analysis checks on the source tree.

> diff --git a/tools/testing/selftests/perf_events/aux_kernel.sh b/tools/te=
sting/selftests/perf_events/aux_kernel.sh
> new file mode 100755
> index 0000000000000..431f59ef02e7d
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/aux_kernel.sh
> @@ -0,0 +1,563 @@
> +#!/bin/bash
[ ... ]
> +RESULTS_DIR=3D"/tmp/perf_aux_kernel_test_$$"
> +mkdir -p "$RESULTS_DIR"
> +exec > >(tee "$RESULTS_DIR/output.log") 2>&1

[Severity: Medium]
Does this predictable temporary directory name create a local file overwrite
vulnerability?

Since this selftest might be executed as root, a local unprivileged user co=
uld
pre-create a symlink with the target PID pointing to any system file (like
/etc/shadow). The tee command would then follow the symlink and overwrite t=
he
target file.

[ ... ]
> +SRC_EVENTS=3D"$ROOT/kernel/events"
> +for f in core.c ring_buffer.c internal.h; do
> +	if [[ -f "$SRC_EVENTS/$f" ]]; then
> +		pass "Source file: kernel/events/$f"
> +	else
> +		fail "Source file: kernel/events/$f missing"
> +	fi
> +done

[Severity: Medium]
Will this unconditionally fail in installed selftest environments?

When tests are run via make install on target CI systems, the kernel source
tree is typically not present. Checking for source files in kernel/events/ =
and
invoking fail() will cause false positive CI failures.

[ ... ]
> +# Build and run the C regression test program
> +UMODE_SRC=3D"$SCRIPT_DIR/aux_kernel_usermode.c"
> +UMODE_BIN=3D"$SCRIPT_DIR/aux_kernel_usermode"
> +
> +if [[ -f "$UMODE_SRC" ]]; then
> +	if [[ ! -x "$UMODE_BIN" ]] || [[ "$UMODE_SRC" -nt "$UMODE_BIN" ]]; then

[Severity: Medium]
Will this skip the userspace regression test when run from an installed
location?

Because source files are not installed by TEST_GEN_PROGS during make instal=
l,
the source file won't exist on the target system. This conditional causes
the script to skip executing the already compiled binary, reducing test
coverage in CI pipelines.

> +		echo "  Building aux_kernel_usermode..."
> +		gcc -o "$UMODE_BIN" "$UMODE_SRC" -Wall -Wextra -O2 2>&1 | \

[Severity: Medium]
Does hardcoding gcc break cross-compilation environments?

If the binary is missing and the script attempts to compile it dynamically,
using gcc ignores the CC and CROSS_COMPILE environment variables set by the
kernel build system. This can lead to compilation failures or building for
the wrong architecture.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144927.4891=
72-1-kunwu.chan@linux.dev?part=3D5
