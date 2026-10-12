Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107F3314D2
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783514; cv=none; b=thr2ueelyOLIVEHscD4hxz4MRz49mKCme8Z/+Z80Rl5emagoKy1t5++kgJiqiWlfqRPl0xo/SL/Xj3ixXXV4vCKY1Lyd8ioHhCZO/tveCacvSuzp+7KHvMz8AKI9e2WMecequrFd29iXcM2Ykr2q6QKj9afyGPI/DgTwz53I0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783514; c=relaxed/simple;
	bh=O1d3IAGBdx89lZOfRpUEpcQ2m9K5GsYp0xWyuwAtG1Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nMD2JSW8+d0xCV11yRVwInXprCWwVSToCTwFuq+jUBUFLsTYLiCFbmbjfjbgdE9aS+rwGW2/QBvH4tRNrQQjdaEQlVePWdxru6GH3AmiZx89mvXM1aNXZTxiiVSYNs2edQ/sM0GKRDYxEYiPgDoB98itfdTevwFPUmrm4BWFIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4kbhr3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4kbhr3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A121F0089B;
	Mon, 12 Oct 2026 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783513;
	bh=ZoMaGzFPioq9QXhQCB1JZXr4O6pjYa2TjBwrukSvRZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4kbhr3WAdmYYMG9XgqO47t4MLhNt/5C/WjlSWsNqi0t2eYyaEB4KRnej/BDga+Mu
	 fVRhI9G8oY4EdFIA5+K0fK7hZxqZCn5D7iZU/Z2U54hzqfz4a2Igtk3apymtsh7Jtb
	 d7LXeod2zx28SKIG+9b/48lOqt+17sLhBzePQlKssI5+sbWh4kmSz2mQh2NyuU6OWr
	 xINs/pYsLRMbwPHdgBS91vSkVzLPwNKqE2Xc/QeZenmIov05nhK/q1/wFJMK/Q8qd3
	 jbTXFTC7sOBkeHp4edDZl1b5VOXaV6YN/apkDYlr83LL1+oKAafVgHao7iP+L4Fxml
	 r6PRKzhiJm8Hg==
Message-ID: <sashiko-outbox-167683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] perf tools: Factor out dso__find_binary_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-7-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:38:32 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] perf: Deadlock in __dso__find_binary_type retry loop on non-recurs=
ive mutex
- [High] perf: Invalid memory access/crash in close_first_dso() due to miss=
ing emptiness check
- [High] perf: Loss of machine->root_dir context breaks guest/container pat=
h resolution
- [Medium] perf: Stale errno causes spurious EMFILE failure and retry exhau=
stion
--

commit 281cbe5b226891d2bef88be13adaa52f889f6f89
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Factor out dso__find_binary_type()

This commit factors out the binary type detection logic for a DSO into a
separate function, checking for a ".text" section under the DSO lock. It
also introduces retry logic to handle file descriptor limits by closing
an open DSO when EMFILE is encountered.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 913877b84b2d4..851b39c63ec86 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> @@ -833,34 +833,142 @@ void dso__data_close(struct dso *dso)
[ ... ]
>  	do {
>  		dso__set_binary_type(dso, binary_type_data[i++]);
> =20
> -		dso_data->fd =3D open_dso(dso, machine);
> -		if (dso_data->fd >=3D 0)
> -			goto out;
> +		path =3D dso__get_filename(dso, "", &decomp, dso__binary_type(dso));

[Severity: High]
Does hardcoding an empty string instead of propagating machine->root_dir
break guest or container path resolution?

In the pre-existing code, try_to_open_dso() passed the machine down to
open_dso(), which correctly resolved paths using machine->root_dir.

Because dso__find_binary_type() does not accept a machine parameter, it dro=
ps
the root directory context. Any binary types requiring alternative root
directories, such as DSO_BINARY_TYPE__GUEST_KMODULE, might incorrectly
resolve against the host's root file system, preventing proper symbol
decoding.

> +		if (path =3D=3D NULL) {
> +			if (errno =3D=3D EMFILE)
> +				goto open_err;
> +			continue;
> +		}
> +
> +		found =3D filename__has_section(path, ".text");
> +		if (!found)
> +			saved_errno =3D errno;

[Severity: Medium]
Could this read a stale errno if filename__has_section() returns false
gracefully?

If the ELF file is parsed successfully but lacks a .text section,
filename__has_section() returns false without setting or clearing errno.

If a previous, completely unrelated system call set errno to EMFILE,
saved_errno would take that stale value.

> +		dso__put_filename(dso, path, decomp);
> +
> +		if (found)
> +			return dso__binary_type(dso);
> +		else if (saved_errno =3D=3D EMFILE)
> +			goto open_err;

This might cause an incorrect detection of EMFILE, which could then be
mistakenly interpreted as a file descriptor exhaustion failure, triggering
the open_err retry loop.

[ ... ]
> +static int __dso__find_binary_type(struct dso *dso, bool needs_open_lock)
> +{
> +	int ret;
> +	int retry =3D 0;
> +
> +again:
> +	mutex_lock(dso__lock(dso));
> +	ret =3D dso__find_binary_type_locked(dso);
> +	mutex_unlock(dso__lock(dso));
> +
> +	if (ret =3D=3D -1 && retry++ < FIND_MAX_RETRY) {
> +		if (needs_open_lock)
> +			mutex_lock(dso__data_open_lock());
> +		close_first_dso();

[Severity: High]
Is it safe to call close_first_dso() unconditionally here?

If the global file descriptor limit is exhausted outside of the perf DSO
cache, or if the EMFILE error is spuriously triggered by a stale errno on
the very first DSO parsed, the list could be completely empty.

Looking at close_first_dso(), it extracts the first entry from the
dso__data_open linked list via list_first_entry() and dereferences it
without verifying if the list is empty:

tools/perf/util/dso.c:close_first_dso() {
    ...
    dso_data =3D list_first_entry(&dso__data_open, struct dso_data, open_en=
try);
    ...
}

If the list is empty, list_first_entry() resolves to an invalid pointer,
causing a crash upon dereference. The pre-existing caller,
check_data_close(), safely verified limits before closing.

> +		goto again;
> +	}

[Severity: High]
Does the goto again bypass unlocking the dso__data_open_lock?

If needs_open_lock is true and dso__find_binary_type_locked() returns -1,
the retry loop executes mutex_lock(dso__data_open_lock()) and jumps to again
without releasing the lock.

If it fails a second time, the code evaluates if (needs_open_lock) again and
incorrectly calls mutex_lock(dso__data_open_lock()) a second time.

Because perf uses standard non-recursive mutexes by default, acquiring the
lock a second time from the same thread could cause an immediate, permanent
deadlock.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D6
