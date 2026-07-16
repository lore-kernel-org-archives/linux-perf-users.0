Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D93C3F4C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188845; cv=none; b=UmrSZm+eDsn/ZlM8KGwoqRVcatOupTw6t0iEF02k4rOL9mHYDbnC8dSKHs1Y8rJBs40DFTZtl+afO5U7Ge6MrxHdZ82kcpIbyw1nuKnkzkbasvZKM/jpfwRZz8mt+tiO0UKGo0XVqCZlgDyGG5TPN2bfU8jmD9vdJyZmfNJ/MgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188845; c=relaxed/simple;
	bh=18hvOCsfy0dcy3eBVabWoLFIasygYAmSBmuq7+8Z5/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fMW4HTRs+fryf8YV2/CzSJ9O3fFh7fsan3VZd1cb4a/OuLk0QAFJloirfzP1DkNsKVxK4VLD4DMaMu7eEeD02sFqOIz+HmlJHjEd1b0PhNA+wCu6t2nHk6pHvHp5zl5Fp/ER8N2UfUMbiY6f1Nc9WRGoSMSDUsfUPC75KOe8Ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4mx7bms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4mx7bms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC751F000E9;
	Thu, 16 Jul 2026 08:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188843;
	bh=+XVspqY8m2j3f+4EaJyHZHVmrrk78RqEU4L0l3yvvyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4mx7bmsC+zZ40FKeAZRd0258v4bcuh4QgesMYSMwaNJtNu7F1OoYH8q2RG6MKCsQ
	 t2qRS3wx0xWiUJ3W8fIYCpD1YYZMEmLwYG7DA8Jff0JxqkZMlj4SGWo2HyYarT67I2
	 l+RdF/TBJlhA/f2+9xDiBBS6IC8YN08T+nKzc3JqJaLvxJ305bnmgRmgQBSbH1x1Iw
	 Y6Fk0XS6BTXD0ntxPO4j9T6fKQIB1603iNlgZqlaFSd/r1T59pQVlE1VQHJwae+B1Z
	 Hxa0L22NA3tu4YCzVjlfbQhIdkOhT2ZavSDgAMSFqHXSWeBRMnnGb2AIB/XetA4ejm
	 V1Upo+fc3wqlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf record: Fix destructor invocation and event
 counting in fdarray__filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716073753.567782-1-irogers@google.com>
References: <178383937332.3162711.15710064516636108862.b4-ty@kernel.org>
 <20260716073753.567782-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:00:43 +0000
Message-Id: <20260716080043.BBC751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf record and perf trace hang indefinitely when profiling a targ=
et process that exits.
--

--- Patch [1]: [PATCH v2] perf record: Fix destructor invocation and event =
counting in fdarray__filter ---
commit 586c1ed32764876e9ecee40639dd9f2a7fcfdcd5
Author: Ian Rogers <irogers@google.com>

perf record: Fix destructor invocation and event counting in fdarray__filter

This commit modifies the fdarray filtering logic to separate lifecycle and
masking logic. It removes the early bypass for nonfilterable file descripto=
rs
so their destructors can run, and uses a non_perf_event flag to prevent
clearing their masks.

> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 16a047f1906ee..92d9a3fb652c0 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -115,9 +115,6 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  		return 0;
> =20
>  	for (fd =3D 0; fd < fda->nr; ++fd) {
> -		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> -			continue;
> -
>  		if (!fda->entries[fd].events)
>  			continue;
> =20
> @@ -125,6 +122,9 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  			if (entry_destructor)
>  				entry_destructor(fda, fd, arg);
> =20
> +			if (fda->priv[fd].flags & fdarray_flag__non_perf_event)
> +				continue;
> +
>  			/*
>  			 * Set fd to -1 so poll() ignores this entry; otherwise

[Severity: High]
With the removal of the early continue for nonfilterable file descriptors,
does this regression cause the active event count to never reach zero?=20

When profiling a target process that exits, auxiliary file descriptors like
control pipes usually do not match the revents mask (such as POLLHUP). They
now bypass the revents check block and unconditionally reach the counter
increment at the bottom of the loop:

fdarray__filter()
        ...
		if (fda->entries[fd].revents & revents) {
			...
			continue;
		}

		++nr;
	}

	return nr;
}

In the main event loop, __cmd_record() relies on this function returning 0
to transition to the draining state and terminate gracefully:

    if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
                        record__thread_munmap_filtered, NULL) =3D=3D 0)
        draining =3D true;

Since nonfilterable and non-perf-event file descriptors unconditionally
increment nr when they don't have matching revents, could this cause
perf record and perf trace to hang indefinitely waiting in poll()
after the traced process exits?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716073753.5677=
82-1-irogers@google.com?part=3D1
