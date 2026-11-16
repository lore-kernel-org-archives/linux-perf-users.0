Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810268;
	b=IniqFrJ9UIxN97HtOrjv5IjkAB18Q3oqjLOLP5vWaFOxDhKcFukd/MI5Ys1oKf2k2ci7
	 JL+Ehy/nXy3AS9JrODxj2mHZzQtdQIq1KvvllNHYESxRRP0U7n5T7tXRTLCSmJBisOXca
	 GmqsC8xQDM4VeXusEMTxUBSRFAMX+J+CgT40WaPMddAVtM1zRFSc3QmBgaYW/9ZZdw7dG
	 Lu9vKRp3jJMGu2yQTRRbVGAfBUckYENDDUO2DKuZpJxVhDa1GHU3nB7vHTKpag87S5C3o
	 Juw5sxgBf1uQe7qkeD6rg/jDILeB5pWhABNHB3UzGhzyM9SUTY75KQRMq0AaXjgEhVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810268;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d6OOQIxy7K2OqCiaertVQrm788qnC8i9l5+BKMlCLi0=;
	b=RQrGjkYsrwZvMg07ZcxcRXZftJoteFBfqwdUmJSWbvSPDcFPWHzMEmkktpjMT1gbCx4o
	 vmhulUJ5IYNFS3yu7ZKnshrinK6+P0FBgq+i3GhguFWSfKzCpdX/a0L29SrSpTF6uYvK3
	 U50dJR4RaYwwH9kMIXmaIM+263tqeH7ntb0Pk+mhQwYlQnJLKL+hqBgoBN81in01/lHBD
	 AzXXddIWROt2uU88hPBQ1NpTQIVwqWz3Y/6zOdXpBzA5Vu382i8oxVQeQJFiyTuo6UIH/
	 k6LB8klnRDXrQ/psRfavxrmOQRJrAcC33Q8fa5uuZUL5TRt7JIO9il+H8u9Yh5kJQOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7Zt7x1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5A606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7Zt7x1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49FC1F000C4;
	Mon, 16 Nov 2026 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810267;
	bh=d6OOQIxy7K2OqCiaertVQrm788qnC8i9l5+BKMlCLi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d7Zt7x1tSIu9thcLcwgQeV42vNtT+GoriRB9bNCg2KcHOpJO1GiYNJJ+d/n8SNNXm
	 cOhKOD6q9Nb677M3RnoTm7KeWerUYT7PFq3JhfViQiZA1hPYSkB7ixsfsJhLGA+3uZ
	 dCuN8qf9Yz9CAsaJ9sRLxmsX4LZ+sAfes8Hus2Q6ECFfPYJcBarWenRuszvWpmAruM
	 8SAleO9L1vl+HxJDbHgSgkE6ce+86WTUf78jQYV0LRK6h++zm4NVeeUGrVMq9jNg3M
	 RTcwv5+2yXV2gi3+u21U5tBWm4J2zo8MPp04QicaLY/fwu/huzAUQJpV4WdtzX7EDs
	 CZ8f6iK5vXWPw==
Message-ID: <sashiko-outbox-216273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] perf tests: Add namespace, nsinfo, and boot ID
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-12-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-12-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:24:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Medium] perf tests: unlinked DSO triggers assert in
  run_mountns_and_chroot_tests()
- [Low] perf tests: raw nsinfo pointer comparison in
  test__nsinfo_thread_liveness()
- [Low] perf tests: missing signal.h include in namespaces.c
- [Low] perf tests: TEST_ASSERT_VAL() skips cleanup in
  test__nsinfo_boot_id()
- [Low] perf tests: leaked thread ref on failure in
  test__nsinfo_thread_liveness()
- [Low] perf tests: leaked chroot path string on failure in namespaces.c
- [Low] perf tests: unchecked allocations in
  run_mountns_and_chroot_tests()
--

commit c5ab486958138682ed6911ecda820dca7b29d74d
Author: Namhyung Kim <namhyung@kernel.org>

perf tests: Add namespace, nsinfo, and boot ID tests

This commit adds a unit test suite for namespaces, nsinfo, and boot ID
handling, and extends the perf header shell test to verify the boot ID.

> diff --git a/tools/perf/tests/namespaces.c b/tools/perf/tests/namespaces.c
> new file mode 100644
> index 0000000000000..cfc654db48f92
> --- /dev/null
> +++ b/tools/perf/tests/namespaces.c
> @@ -0,0 +1,1035 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>

[Severity: Low]
run_mountns_and_chroot_tests() calls kill() with SIGKILL, so signal.h
should be included explicitly rather than relying on transitive headers.

[ ... ]

> +static int test__nsinfo_boot_id(struct test_suite *test __maybe_unused,
> +				int subtest __maybe_unused)
> +{
> +	struct perf_env live_env, off_env;
> +	char host_boot_id[64];
> +	const char *bid;
> +	int ret =3D TEST_FAIL;
> +
> +	if (read_host_boot_id_str(host_boot_id, sizeof(host_boot_id)) < 0) {
> +		pr_debug("SKIP: cannot read host boot_id from procfs\n");
> +		return TEST_SKIP;
> +	}
> +
> +	perf_env__init(&live_env);
> +	perf_env__init(&off_env);
> +
> +	TEST_ASSERT_VAL("NULL env should match current host boot",
> +			perf_env__is_same_boot(NULL));
> +
> +	TEST_ASSERT_VAL("live env should match current host boot",
> +			perf_env__is_same_boot(&live_env));

[Severity: Low]
Does TEST_ASSERT_VAL() return TEST_FAIL directly and skip
perf_env__exit() at the out label if either check fails?  Jumping to out
instead avoids leaking live_env.boot_id and leaving the perf_env locks
undestroyed.

[ ... ]

> +	thread__e_machine_endian(off_sub, off_m, NULL, NULL);
> +	if (machine__find_thread(off_m, self_pid, self_pid) !=3D NULL) {
> +		pr_debug("thread__e_machine_endian() unexpectedly recreated exited lea=
der\n");
> +		goto out;
> +	}
> +	machine__remove_thread(off_m, off_sub);
> +	thread__put(off_sub);
> +	off_sub =3D NULL;
> +
> +	/* Live thread tracking, reset on exec/namespaces, and exit propagation=
. */
> +	th =3D machine__findnew_thread(live_m, self_pid, self_pid);
> +	if (!th || !thread__is_alive(th)) {
> +		pr_debug("current live thread reported as dead\n");
> +		goto out;
> +	}
> +
> +	nsi1 =3D thread__get_nsinfo(th);
> +	if (!nsi1)
> +		goto out;
> +
> +	if (__thread__set_comm(th, "execed", 1000, /*exec=3D*/true) !=3D 0)
> +		goto out;
> +	nsi2 =3D thread__get_nsinfo(th);
> +	if (!nsi2 || nsi2 =3D=3D nsi1) {
> +		pr_debug("exec did not replace thread->nsinfo\n");
> +		goto out;
> +	}
> +
> +	ns_ev =3D calloc(1, sizeof(*ns_ev) + sizeof(ns_ev->link_info[0]));
> +	if (!ns_ev)
> +		goto out;
> +	ns_ev->nr_namespaces =3D 1;
> +	if (thread__set_namespaces(th, 2000, ns_ev) !=3D 0) {
> +		free(ns_ev);
> +		goto out;
> +	}
> +	free(ns_ev);
> +
> +	nsi3 =3D thread__get_nsinfo(th);
> +	if (!nsi3 || nsi3 =3D=3D nsi2) {
> +		pr_debug("PERF_RECORD_NAMESPACES did not replace thread->nsinfo\n");
> +		goto out;
> +	}

[Severity: Low]
Should nsi2 =3D=3D nsi1 and nsi3 =3D=3D nsi2 use RC_CHK_EQUAL() instead of =
raw
pointer equality?

Because struct nsinfo is declared with DECLARE_RC_STRUCT(nsinfo), each
thread__get_nsinfo() call allocates a distinct wrapper pointer when built
with REFCNT_CHECKING, so raw pointer equality will always evaluate to
false even if thread->nsinfo was not replaced.

[ ... ]

> +	memset(&ev, 0, sizeof(ev));
> +	ev.fork.header.type =3D PERF_RECORD_EXIT;
> +	ev.fork.header.size =3D sizeof(ev.fork);
> +	ev.fork.pid =3D self_pid;
> +	ev.fork.tid =3D self_pid;
> +	ev.fork.ppid =3D 1;
> +	ev.fork.ptid =3D 1;
> +	if (perf_event__exit_del_thread(&tool, &ev, &sample, live_m) !=3D 0)
> +		goto out;
> +	if (!RC_CHK_ACCESS(del_nsi)->exited || nsinfo__check_proc(del_nsi) ||
> +	    machine__find_thread(live_m, self_pid, self_pid) !=3D NULL) {
> +		pr_debug("perf_event__exit_del_thread() did not mark nsinfo exited\n");
> +		goto out;
> +	}

[Severity: Low]
Does calling machine__find_thread() directly in the if condition here and
after thread__e_machine_endian() above leak a thread reference if a
thread is found?  machine__find_thread() returns a refcounted struct
thread * that must be released with thread__put().

[ ... ]

> +	/* Guarded chroot/build-id lookups must bail out immediately when exite=
d. */
> +	dso =3D dso__new("/bin/sh");
> +	nsi =3D nsinfo__new_thread(getpid(), getpid());
> +	if (!dso || !nsi)
> +		goto out;
> +	nsinfo__set_exited(nsi);
> +	dso__set_nsinfo(dso, nsinfo__get(nsi));
> +
> +	if (dso__filename_with_chroot(dso, "/bin/sh") !=3D NULL) {
> +		pr_debug("dso__filename_with_chroot() did not respect exited nsinfo\n"=
);
> +		goto out;
> +	}

[Severity: Low]
Does this leak the heap string returned by dso__filename_with_chroot() if
the check fails (as well as in the exited chroot check in
run_mountns_and_chroot_tests() below)?

[ ... ]

> +	dso =3D dso__new(target_bin);
> +	if (!dso) {
> +		machine__exit(&machine);
> +		goto out_wait;
> +	}
> +	dso__set_nsinfo(dso, nsinfo__get(nsi));
> +#ifndef HAVE_LIBELF_SUPPORT
> +	/* Without libelf, filename__has_section() cannot auto-detect binary_ty=
pe. */
> +	dso__set_binary_type(dso, DSO_BINARY_TYPE__SYSTEM_PATH_DSO);
> +	dso__set_bintype_searched(dso);
> +#endif
> +	if (dso__data_read_offset(dso, &machine, 0, magic, sizeof(magic)) !=3D =
sizeof(magic) ||
> +	    memcmp(magic, "\x7f" "ELF", 4) !=3D 0) {

[Severity: Medium]
Does calling dso__data_read_offset() on a standalone dso without adding
it via dsos__add(&machine.dsos, dso) trigger an assertion failure in
DEBUG=3D1 builds?

dso__data_read_offset() -> data_read_write_offset() ->
dso__data_file_size() -> file_size() -> try_to_open_dso() -> open_dso()
calls dso__list_add(dso), which asserts that dso__dsos(dso) is non-NULL:

tools/perf/util/dso.c:dso__list_add() {
    ...
	/* Assume the dso is part of dsos, hence the optional reference count abov=
e. */
	assert(dso__dsos(dso));
}

[ ... ]

> +			if (cpid > 0 && read(cpipe[0], &sig, 1) =3D=3D 1 && sig =3D=3D '1') {
> +				struct nsinfo *cnsi =3D nsinfo__new_thread(cpid, cpid);
> +				struct stat st1, st2;
> +				char *resolved =3D NULL;
> +
> +				chroot_dso =3D dso__new("/chroot_elf");
> +				if (chroot_dso && cnsi) {

[Severity: Low]
If either nsinfo__new_thread() or dso__new() returns NULL here, does the
test silently skip the chroot checks and still set ret =3D TEST_OK?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D11
