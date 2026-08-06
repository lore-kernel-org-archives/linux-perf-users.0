Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30738736E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002454; cv=none; b=i4tq61Kd2wnNtHdm0V5QdWex4cWfIWNcK4+BVcTYCsxdW6S6pEeLdTIepR3nFhj2OxTvY28UykkiksegnEWepWbrLsS0n60yLgl8apLQ1o/hrJAuEFZ4JL8Q2/rdXAtu507Dknexy6XrILN0qh9FAX/NldTHZv23c+iE2ODYhyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002454; c=relaxed/simple;
	bh=LHMaU8GrCsMdNkBk9LWMP8MmN4UMas5sHOfECpqx8zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nmoigxQlEhOfyp/hY6cVtNz9QKu5jZP7LEqVrVy7V17B5nTTQoz0h9s2zxkhrbPPZkZxt9ApR/lI3nQk+kYEYnGjyXxzuqa+GDc91VnLAEofq/fJ6txhFeZ7H8pIcysyfTV/DyV9c9UEgap2rkVCq0eAHEw2S5Otm43botBGM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUAJQlVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUAJQlVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7D21F000E9;
	Thu,  6 Aug 2026 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786002452;
	bh=LHMaU8GrCsMdNkBk9LWMP8MmN4UMas5sHOfECpqx8zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUAJQlVepnvXSb0HpauMzI+m4a6i1hz9TBKUPBhdjHMvklD+PSq3INLaSrqG82lIA
	 ydPshXpH8+kZje094iDgOOmAWlqIXl4c3oMdg/uEXpkORwHY9OXu36j7o6iyyBHZs9
	 uc5AiRvw0cpSdY+pD7vL9xTXWbgz9mvNelEjp8cMQ+Bq2MSwlaRQZFn5Ny5Yy+EjOx
	 h3tOVLu9Cke5KkOezZKlvewBhIy4siLQkmigUbzuJldvB/zhaM/jZrkmJdea0CUQc3
	 2qtd5aF7RsKTD+9s8FonCS2bQHoMtjvUfHgvQF/DvTqtXlUMILVmLvH3wRLmKGfyj6
	 jzqfDevhEZ7ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] perf c2c: add column rendering for function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806074217.2846596-4-jiebin.sun@intel.com>
References: <20260806074217.2846596-1-jiebin.sun@intel.com>
 <20260806074217.2846596-4-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 07:47:31 +0000
Message-Id: <20260806074732.4B7D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macro `C2C_FUNC_FOLD_WIDTH` is defined but never used.
--

--- Patch [3]: [PATCH v7 3/9] perf c2c: add column rendering for function v=
iew ---
commit a3883eb9f33b41bc5b4463fa0fd2cb2ff6a32559
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add column rendering for function view

This commit adds the function view's column renderers for the perf c2c tool=
. It
introduces the necessary width and header helpers, the per-function estimat=
ed
cycles computation, and dimension tables to link columns to their renderers.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index c0fd7799e4f85..89e4e65022b52 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c
[ ... ]
> +/* Spaces of indent per hierarchy level, like the normal report view. */
> +#define C2C_FUNC_INDENT 2
> +
> +/* Width of the folded-sign prefix ("%c ") each identity cell emits. */
> +#define C2C_FUNC_FOLD_WIDTH 2

[Severity: Low]
This isn't a bug, but is this macro intended to be used?=20

It looks like C2C_FUNC_FOLD_WIDTH is defined here, but the code later in=20
symbol_view_entry() and cycles_percent_entry() hardcodes the "%c " format
string and calculates lengths without referencing this macro.=20

Could the renderers use this macro when calculating the remaining buffer=20
widths instead of manual adjustments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806074217.2846=
596-1-jiebin.sun@intel.com?part=3D3
