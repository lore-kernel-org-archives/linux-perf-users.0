Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6087426408
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182658; cv=none; b=ofvzykq6PLQrYSgyBSVnLgzuQUNjtsQ0PUUOCj7dIZ+qsIDLAfI7sAht5zed1GpSNGEAbwkoBWia85QEC1PWrp01FkJkZdSSQuUKL0ORFD6LMIYsszckYZus+k5PDMKf3B3Cd8UTK7uDHvWIseBlcWUbJSgBKjj2/fOnLJcRXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182658; c=relaxed/simple;
	bh=V1OcXVKFEqWCF30zpCHzwyVjVIkrUNDP6nPOGxkkFE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfaeJ2ND6jDAPLn4owBxahixGw0OaDWJS3kMxoEAnOKk9iMBgP9V4t59RfN7EPr9CwLDEl8RJY3HlYO4ZwFNPP5A6cNg90ejHJ2f49a+hA9jIiKR0iAZYwKXENQqu7V4d1wT/s04BpF0ohN6Q91Vm/y+c8xHZM/pj+a6QbZX6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjd9oHd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjd9oHd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB001F00A3D;
	Mon, 31 Aug 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182657;
	bh=yHoqhL0OAIVdta3+y+NII04sw830c55qIZGiFnfzqd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wjd9oHd5+lpup7CToqQnEPP8dIu9+Uox5OLZNvLDsZSBbKgXMWcvlH34MN+IK1UTA
	 bAGR0YNxmUd4FdJHduHrog9EQKg96ebHEcmCtC3u0kEGw8ZuOgXPOLmNuAbY8bm7WH
	 WzRcVqrC6HhAjllzbCw17kJUDlXW2ZOkJM7LzYU4iC8bZ8UtP69vnUyCBvXU7FZM9h
	 5waKBzEq3NlMACAoc6VrlyVrk9xrbowHiQ6BLJmwtwLhT3x+3+UyxricVbcS/tXlA6
	 1B9+So4d1Iibho443J0n0tIDxrF87138OvDtXqrIPUNY0oSJVMz8fFXhVNEnIfwlHD
	 6m6i/MHgmTrmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf jitdump: Fix debug_data and unwinding_data
 leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-3-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:24:17 +0000
Message-Id: <20260831132417.7DB001F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_repipe_debug_info() overwrites jd->debug_data without freeing the
> previous allocation.  If two consecutive JIT_CODE_DEBUG_INFO records
> appear without an intervening LOAD record consuming the data, the first
> allocation leaks.
>=20
> The sibling jit_repipe_unwinding_info() already frees the old
> jd->unwinding_data before reassignment =E2=80=94 add the same pattern to
> jit_repipe_debug_info() using zfree().
>=20
> Also add cleanup of both buffers in jit_close() so they are freed when
> the jitdump session ends, even if no LOAD record consumed them.
>=20
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D2

