Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC69369203
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339235; cv=none; b=QSNljbB4q8+zT5geUgcNVTFYGiEQRrdurbX2zLls/kZVTmVshnyHTMoVndQTagchaNuf4WXOKKeKdC90rMhDTZ3hH0Qzrw67FADYVCp6BMlHC7Go17r4mbUA/rIMaI5P+T7NCy+xnk7JnVdHXBeWYz4jsfhLx8MxKtIODqHZjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339235; c=relaxed/simple;
	bh=nerrtE1W4n9YqZmwrbKjryKnbdX01Pk+vLvGvDTqHj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZPIBSMeXd9Bj1lmfzCwPCUhF6FSO+KBeTRIw2hfirnPvNNi67BSXtBw7EWK1kKx0OPEU1Pi3o5K5hA9oKmFbAfqdCsQdR7FrrTNSee7y6mhRiVDBCaAOI8qTdq605PjbXFZYG1PjR+/tdpUoRK5nwtBvIOQZpUJj9yshLIf+WoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGy0vqmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGy0vqmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034801F000FF;
	Sun, 13 Sep 2026 22:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339234;
	bh=ajn31g1wGGIiwoew/Bncvk9WMYpWLK37p1jncU2o7c8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGy0vqmqp/N8W8KukOD++ek+i2Aeqna3HAZGiBRnoiU74QDyR6NhPHLFPd/YnpUzD
	 emWzG6NQQnVt8V9jiYE1FkNAw5NHwrlyqBnvEZEw6kNKaZVndcKvcBwucMrvrJoy/8
	 VXDXLZngcGNsNmaMIS3BMVneTO6ck/000HmoT9NDlUXP87liTrgdmhVvGrY6lbsTqa
	 dsU02ynfdM/6qN2vUOzy+jf4sJDC6y2iMFWUKs1NOkXOvMtRXjnHvkPs1I2Ax5djuB
	 K+/LYfoR9cCmeKjrtrFzFaQvDwgaCx23oq7tLGCuV6W9cSHqHAej06Ujv5j/uh+mrL
	 EUn1auZRvAL+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] perf symbol: Fall back to fetching the vmlinux by
 build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-4-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:40:33 +0000
Message-Id: <20260913224034.034801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition in debuginfod vmlinux fetch discards successful d=
ownloads
--

commit 808ca5b7ae0805113b62f51bed90e6469e600d15
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
perf symbol: Fall back to fetching the vmlinux by build ID

This commit adds a fallback mechanism to fetch the vmlinux by build ID using
debuginfod when local kernel symbols cannot be found. This allows kernel
samples to be correctly annotated even when the profile is processed on a
machine with a different kernel or restricted kallsyms access.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -2257,7 +2280,50 @@ static int dso__load_kernel_sym(struct dso *dso, s=
truct map *map)
[ ... ]
> +		/*
> +		 * dso__load() holds dso->lock while it calls us, and the
> +		 * fetch below can take a long time, blocked on the network
> +		 * or on the terminal, waiting for the user: do it with the
> +		 * lock dropped, as dso__debuginfo() does for the debuginfo
> +		 * of a DSO, so that the threads that need this dso don't get
> +		 * stuck behind a server round trip.  Nothing of the dso is
> +		 * touched by the fetch, the symbols are loaded with the lock
> +		 * held again, and only if the fetch brought a file back.
> +		 */
> +		mutex_unlock(dso__lock(dso));
> +		err =3D dso__fetch_vmlinux_build_id(dso, &fetched_path);
> +		mutex_lock(dso__lock(dso));
> +
> +		if (err) {
> +			zfree(&fetched_path);
> +		} else if (dso__loaded(dso)) {

[Severity: Medium]
Does this logic safely handle concurrent fetches where one thread fails?=20

Because dso__load() unconditionally sets dso__loaded() even on failure, this
could discard a successfully fetched vmlinux if a concurrent thread previou=
sly
failed.

For example, if Thread A and Thread B concurrently attempt to load kernel=20
symbols via dso__load():
1. Both drop the lock to fetch via debuginfod.
2. Thread A fails its fetch, reacquires the lock, returns an error, and its
   caller (dso__load()) unconditionally sets dso__loaded(dso) =3D true befo=
re
   releasing the lock.
3. Thread B succeeds in fetching, reacquires the lock, and checks
   dso__loaded(dso).

Seeing it is true, wouldn't Thread B incorrectly assume Thread A successful=
ly
loaded the symbols, discard its own fetched file, and return success?

Would it be better to use dso__has_symbols(dso) instead of dso__loaded(dso)
here to correctly detect a successful concurrent load?

> +			/*
> +			 * Somebody else got the symbols for this dso while
> +			 * the lock was dropped for the fetch, use those
> +			 * instead of loading the file that came back a
> +			 * second time.
> +			 */
> +			pr_debug("%s was loaded while its vmlinux was being fetched, using it=
\n",
> +				 dso__name(dso));
> +			zfree(&fetched_path);
> +			err =3D 1;
> +		} else {
> +			/* Takes ownership of 'fetched_path' even when it fails */
> +			err =3D dso__load_vmlinux(dso, map, fetched_path, true);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D3
