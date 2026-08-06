Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7913CF1F2
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002895; cv=none; b=mvt+VEbsUn8motRbdmMG3Ak+e23drhtQ6xYBMSVajx423IjNMBbELpdikr8epgu2nFjxBt9nKcSgBRX0kKxN8Aq0DYdj/5rBZJFW+IktqMFH/0vdWFMIVQqIQ9HqaaxtUIy91ZevjPJv/gi3mcPdO1U0s8Q018bs+AIAsmsisD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002895; c=relaxed/simple;
	bh=2xO5tbA4SXjsK5Bdlyom69pnk30hmxkIWAQWmhgf6AM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jjEyoJievshU68V2XDXw8EYRF8zb2BPXyHER28RpxuOg/6MnXZA4W4dY6p/1RbqURlFfT7UomWd3N8/IQbFzNPZfZjUSut9CM+Znq8fx+D2iWs3dNbb6EeRkMqywoDRv7ZWObXZKKAlHLV94qkqKFaAWkDF1yntPu7R51ThzBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvmWULaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvmWULaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6371F000E9;
	Thu,  6 Aug 2026 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786002894;
	bh=N3gD7I50uhpODS+/nDJ3p+XS4HS7/UxT7lt89l3kcI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvmWULaPU8UoVmdHQuXiVnBFaUfd1I2KcBm2pTTRp7ZS8BgTongaHGeK0tOlpJ3rs
	 vHYD7P9xGa7U9XZSeSga6UawLYA5tua7BjjoiOjNH/aHhhGRzHNJ2+jImv8JvgRuV1
	 r+NU/5rKWwh6icG3A/hdEcN4AYu6ZN+JZCdylU96LJ1eCbJqjrNZ3Dp+4Kk6QnMV+q
	 LijOfAbxJUxq6xKfG54RTjdVxsfHPTtRqpqy8ilqbB1mVKn5VcaHn6XQsk3OPf4bEW
	 4StBQz7rWM+XWDEDFWTDjQ/T5k2l1fDkS0zGGZ5qku59R2g95U11aUQW1cTGJ9gQFI
	 L6hV615rGQ48g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] perf c2c: add function view hierarchy entry
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806074217.2846596-7-jiebin.sun@intel.com>
References: <20260806074217.2846596-1-jiebin.sun@intel.com>
 <20260806074217.2846596-7-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 07:54:53 +0000
Message-Id: <20260806075454.4B6371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Manual allocation of `hist_entry` with 0 callchain size causes a=
n out-of-bounds heap read and arbitrary free during `hist_entry__delete()` =
if callchains are globally enabled.
--

--- Patch [6]: [PATCH v7 6/9] perf c2c: add function view hierarchy entry c=
reation ---
commit 6f1d1721493d4fdd45959567a8ed7813681126d5
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view hierarchy entry creation

This commit adds the entry-creation layer for the perf c2c function view. It
introduces owned-reference child allocation and insertion, reusing the exis=
ting
cacheline_idx to preserve source entry identity for the browser.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index fc9a4c4bcb03f..fb85f9aeb7415 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -845,6 +863,259 @@ static int __maybe_unused c2c_he__prune_empty_write=
rs(struct hist_entry *l1_he)

[ ... ]

> +static struct c2c_hist_entry *
> +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *=
src_he,
> +		       int depth, u64 ip)
> +{
> +	struct c2c_hist_entry *child_c2c;
> +	struct hist_entry *child_he;
> +
> +	/* Function-view children never own or display callchains. */
> +	child_he =3D c2c_function_he_zalloc(0);

[Severity: Medium]
Does this allocation cause an out-of-bounds heap read and arbitrary free
during teardown if callchains are globally enabled?

Looking at hist_entry__delete() in tools/perf/util/hist.c, it unconditional=
ly
calls free_callchain(he->callchain) when destroying an entry:

void hist_entry__delete(struct hist_entry *he)
{
	...
	free_callchain(he->callchain);
	...
}

The free_callchain() function checks the global symbol_conf.use_callchain f=
lag
rather than verifying if this specific entry actually allocated a callchain.

Since 0 extra bytes are allocated for the trailing flexible array here, if
callchains are globally enabled (e.g., running perf c2c record -g), wouldn't
the teardown process read unallocated memory, interpret it as nodes in
free_callchain_node(), and trigger memory corruption?

> +	if (!child_he)
> +		return NULL;
> +
> +	child_c2c =3D container_of(child_he, struct c2c_hist_entry, he);
> +	child_he->ops =3D &c2c_function_entry_ops;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806074217.2846=
596-1-jiebin.sun@intel.com?part=3D6
