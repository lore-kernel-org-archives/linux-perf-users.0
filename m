Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232282;
	b=YZ+CccD+r7Hmfc64XZaMc0dVh571a1t6WRWmZC6iVuBDulnnN9VBbjMd1zl5jO2Gamgw
	 8EwakGIJ2VamJl19dk8pHPwRz6C/Pme/4gW+9rrSgi3ZR77bCP5MidrsV19sYmX6PAxIM
	 D0HyVJKirwSK530DXkOlb4lcQMcz1g+iB7/PL7fx2q7mtr4oiRoYU6ZTVmaZSSAZYkewk
	 DIuFG9zZoYobbILTAb/RufIlfauJlMBNRj/0i0v3/MPWsumoZefe+bVIMTgF3fCRf9ibL
	 LXCZCiH/JtiU8mMH7ow9XFzb3nIhImcxa58fav6RVdy8US8UGTABwrQlyIzJJqRlgTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232282;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7ZDuWcyJBji8iGSdLhqjA80lAPuMrAV4Pq+ARFqxivY=;
	b=xLORsKX+F6a65nBjx47P88hJ1YsA5wuvUmzpRVRqeZS3bG/YEYFXj7qEaEueR6XKkoY7
	 YqE6b4bAC525f3UIl3Mg+4450jUiz7yZZRbB8rt7NXj2/f1Q+Fg0I5A3klHg2A+Szb/yK
	 tScDot8EhZ62FyBO2iFD0yqoRPosKdsgVs3CBMXs/xjxH1SLSzOI2SnIeFbmB7I0DKbja
	 ty5GL6opQVSG/MO1OLtyJTLlmi0qSlwVBnx3jOULF7xzJzm+sfziuShprD3vbqpaMof3c
	 4fiNePpxoRM4d8KKZTGOIkEashKQ5tE4LskwN3ATeArZzB3stlWCeSipj4vC/LGVDsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsUNRCro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0F606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsUNRCro
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F004B1F01825;
	Thu, 29 Oct 2026 00:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232281;
	bh=7ZDuWcyJBji8iGSdLhqjA80lAPuMrAV4Pq+ARFqxivY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsUNRCroJojuAEGjuDUo7gsA5Ew2sa+xkJ1iyt3Eu2sUUJtX/X4ooNeeHsiT7eT5g
	 rAhEjGo2QEeFzaxFJkVAHlCqggj10ZUMpf0bdlUlhufIdRTfWxFjX2kO91B/S4Ywgo
	 Lj94dF6/obkLROJr2bt6LMIvrjQPAlZUOFQk9CTnODZScbHO91MOmw21XIFVYptR0P
	 kkATrQ+Y/IbFHtPGA85SWKxEH/tdPrbzYyrOe4BOSY/dxVvKScXTlNzU1VI1noz/st
	 oKu1bw0UAUzGCGKpVdI9+u8fmmey638mv3oelnHFj+YWQakC+saZTUlwZfs3xnz59A
	 vK0n1TZV+VzGw==
Message-ID: <sashiko-outbox-188557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] perf test: Test lazy symbol name loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028-perf-symbol-memory-send-v6-5-7e90415f0101@uber.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-5-7e90415f0101@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:04:40 +0000
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
- [Medium] perf test: missing skip when .opd or .gnu_debugdata disables laz=
y names
- [Medium] perf test: script_lazy_load_symbols.sh fails before reaching ski=
p check
- [Medium] perf test: assertion failure or OOB read in sym_loader__init() o=
n kernel DSO
- [Low] perf test symbol-lazy: missing explicit <stdio.h> and <stdbool.h> i=
ncludes
--

commit 80f2faac89471ac12d3bce19d66d36a7c65ef72f
Author: Alireza Haghdoost <haghdoost@uber.com>

perf test: Test lazy symbol name loading

This commit adds a unit test suite in tools/perf/tests/symbol-lazy.c and two
shell tests (lazy_load_symbols_parity.sh and script_lazy_load_symbols.sh) to
verify lazy symbol name loading, concurrency, and parity with eager loading.

> diff --git a/tools/perf/tests/shell/lazy_load_symbols_parity.sh b/tools/p=
erf/tests/shell/lazy_load_symbols_parity.sh
> new file mode 100755
> index 0000000000000..af1555d7f8d09
> --- /dev/null
> +++ b/tools/perf/tests/shell/lazy_load_symbols_parity.sh
> @@ -0,0 +1,284 @@

[ ... ]

> +# check_parity NAME FILE [eager]
> +# Lazy loading must leave names of FILE unread, or none if "eager" is gi=
ven.
> +check_parity() {
> +	local out=3D"${tmpdir}/parity.out"
> +	local lazy=3D"[0-9][0-9]* symbols with lazy names"
> +
> +	if [ "$3" =3D eager ]; then
> +		lazy=3D"no lazy names"
> +	fi
> +	perf test --dso "$2" -vv "Lazy and eager symbol parity" > "${out}" 2>&1=
 || true
> +	if grep -q ': Ok$' "${out}" && grep -q "^$2: ${lazy}$" "${out}"; then
> +		echo "Lazy-load parity $1 [Success]"
> +		return
> +	fi
> +	grep -E 'symbols$|names$|mismatch|lookup|no symbols' "${out}" || true
> +	echo "Lazy-load parity $1 [Failed]"
> +	err=3D1
> +}

[Severity: Medium]
In tools/perf/util/symbol-elf.c, dso__load_sym_internal() disables lazy
symbol name loading when an .opd section is present (such as on PPC64 ELFv1=
),
when symbols come from .gnu_debugdata, or when .strtab has SHF_COMPRESSED:

tools/perf/util/symbol-elf.c:dso__load_sym_internal() {
	...
	bool lazy_allowed =3D symbol_conf.lazy_load_symbols && !dso__kernel(dso) &&
			  !kmodule && syms_ss->type =3D=3D dso__symtab_type(dso) &&
			  syms_ss->type !=3D DSO_BINARY_TYPE__GNU_DEBUGDATA &&
			  !runtime_ss->opdsec;
	...
}

In lazy_load_symbols_parity.sh, test_split_debug() and test_dynsym_only()
call check_parity() without the eager argument, requiring a non-zero count =
of
lazy names in the output of test__symbol_lazy_parity(). Similarly, in
tools/perf/tests/shell/script_lazy_load_symbols.sh, skip_test_missing_symbol
passes as long as eager symbol loading resolves test_loop, and then
test_lazy_load_identical() and test_lazy_load_mount_ns() require lazy names
on perf_path.

Won't these tests fail with err=3D1 instead of skipping on PPC64 ELFv1 hosts
where the compiler emits an .opd section, or when the perf binary uses
.gnu_debugdata MiniDebugInfo or SHF_COMPRESSED string tables?

> diff --git a/tools/perf/tests/shell/script_lazy_load_symbols.sh b/tools/p=
erf/tests/shell/script_lazy_load_symbols.sh
> new file mode 100755
> index 0000000000000..88840bfafdf64
> --- /dev/null
> +++ b/tools/perf/tests/shell/script_lazy_load_symbols.sh
> @@ -0,0 +1,177 @@

[ ... ]

> +test_lazy_load_identical() {
> +	echo "Lazy-load output matches eager loader"
> +
> +	if ! perf record -o "${perfdata}" -g -- perf test -w thloop 2> /dev/null
> +	then
> +		echo "Lazy-load identical [Skipped record not supported]"
> +		return 0
> +	fi
> +
> +	if ! perf script -i "${perfdata}" 2> /dev/null > "${eager_out}" || \
> +	   ! perf script -v --lazy-load-symbols -i "${perfdata}" \
> +		2> "${lazy_err}" > "${lazy_out}"
> +	then
> +		echo "Lazy-load identical [Failed perf script error]"
> +		err=3D1
> +		return
> +	fi
> +	if ! grep -Eq "${lazy_names}" "${lazy_err}"
> +	then
> +		echo "Lazy-load identical [Failed lazy loader fell back to eager]"
> +		err=3D1
> +		return
> +	fi
> +	if ! grep -F "${perf_path}: " "${lazy_err}" | grep -Eq "${lazy_names}"
> +	then
> +		echo "Lazy-load identical [Failed controlled DSO has no lazy names]"
> +		err=3D1
> +		return
> +	fi
> +
> +	# The comparison is only meaningful if something actually resolved;
> +	# two all-[unknown] outputs would also match.
> +	if ! grep -q "${testsym}" "${eager_out}"
> +	then
> +		echo "Lazy-load identical [Skipped no ${testsym} resolved]"
> +		return 0
> +	fi

[Severity: Medium]
In perf script, user-space DSOs are only loaded on demand via
thread__find_symbol() -> map__find_symbol() -> map__load() -> dso__load()
when a sample or callchain IP falls within that DSO's map.

If perf record succeeds but captures no samples in perf_path (for example, =
in
a virtualized or CPU-constrained environment), dso__load_sym_internal() is
never called for perf_path, so lazy_err will not contain lazy symbol messag=
es
for perf_path.

Because test_lazy_load_identical() checks lazy_err before checking whether
testsym was resolved in eager_out, won't it fail with err=3D1 before ever
reaching the skip check for testsym? Should the check that testsym is prese=
nt
in eager_out happen first (and likewise in test_lazy_load_mount_ns() when t=
he
1-second attached recording captures no samples in testsym)?

> diff --git a/tools/perf/tests/symbol-lazy.c b/tools/perf/tests/symbol-laz=
y.c
> new file mode 100644
> index 0000000000000..52d4a9850e19b
> --- /dev/null
> +++ b/tools/perf/tests/symbol-lazy.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <pthread.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include <linux/kernel.h>

[Severity: Low]
In tools/perf/tests/symbol-lazy.c, lazy_fixture__init() uses FILE *,
fdopen(), fputc(), fwrite(), and fclose(), and test__symbol_lazy_choice() a=
nd
other functions use bool, true, false, and ELF symbol constants (STT_FUNC,
STT_NOTYPE, STT_GNU_IFUNC, STB_GLOBAL, STB_WEAK, STB_LOCAL).

Could <stdio.h>, <stdbool.h>, and <elf.h> be explicitly included at the top
of tools/perf/tests/symbol-lazy.c so the build does not rely on transitive
header inclusions, particularly when building against musl libc?

[ ... ]

> +static int sym_loader__init(struct sym_loader *l, const char *filename, =
bool lazy)
> +{
> +	memset(l, 0, sizeof(*l));
> +	perf_env__init(&l->env);
> +	symbol_conf.lazy_load_symbols =3D lazy;
> +	l->machine =3D machine__new_host(&l->env);
> +	if (l->machine)
> +		l->thread =3D machine__findnew_thread(l->machine, 100, 100);
> +	if (l->thread)
> +		l->map =3D map__new(l->machine, 0x100000, 0xffffffff, 0, &dso_id_empty,
> +				  PROT_EXEC, /*flags=3D*/0, (char *)filename, l->thread);
> +	if (!l->map) {
> +		sym_loader__exit(l);
> +		return TEST_FAIL;
> +	}

[Severity: Medium]
In sym_loader__init(), machine__new_host() populates l->machine->dsos with
the host kernel and all currently loaded kernel modules (which have
dso__kernel(dso) !=3D DSO_SPACE__USER).

If a user runs perf test with --dso pointing to a currently loaded kernel
module or kernel DSO, test__symbol_lazy_parity() passes that path into
sym_loader__init() -> map__new(), where machine__findnew_dso_id() returns t=
he
existing kernel DSO:

tools/perf/util/map.c:map__new() {
	...
	dso =3D machine__findnew_dso_id(machine, filename, id);

	if (dso =3D=3D NULL)
		goto out_delete;

	assert(!dso__kernel(dso));
	...
}

In default builds, won't this trigger assert(!dso__kernel(dso)), and in
builds with -DNDEBUG, cause dso__load() -> dso__load_sym_internal() ->
map__kmap() to read past the end of the map allocation because map__new() d=
id
not allocate space for struct kmap? Should sym_loader__init() handle kernel
DSOs similarly to create_map() in tools/perf/tests/symbols.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-perf-symbo=
l-memory-send-v6-0-7e90415f0101@uber.com?part=3D5
