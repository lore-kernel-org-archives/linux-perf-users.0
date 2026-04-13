Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112472882D7
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055524; cv=none; b=U+F3S37pb4P4bOt479zSgqX/K4QsxFOURTRsMrbwET6fDyhcgz4G2HeUHKnXOIP6EDpW6tnArERFtZfboMl9+s6+vKs7snCQS4D/zm1NrB4BaKXHK0cac0aWkciUcT8v9/Y1AYsdNzvLCjJg+0q/l6w1MDBxvY5M9Ef4OfVDZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055524; c=relaxed/simple;
	bh=YmmNoi1ckGQAZIcnH9enr3tzrNQFKAo6BWUWnGy6FP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4jfWqTKYu26bUx1VxPxGN7jgyQc4GIzB1Gej2VGUeuLdAnsE3BwteqBCd3OcRL7MGeD5ShCTR60Md/wdh3mHNFGAb6P2bE9AWMGmZPaIB+HQ/g19wRyeOW2rYNlWPm8iuLbnDC+2sHwqGcKJDfYWQuj3bCopSdd/stbPoh+E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOxIFUCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOxIFUCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2E5C116C6;
	Mon, 13 Apr 2026 04:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776055523;
	bh=YmmNoi1ckGQAZIcnH9enr3tzrNQFKAo6BWUWnGy6FP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JOxIFUCRZAwCvx6sd5Mb0uJKxQ9YI6WPgjciqzxQF1fkxHLHQadSFTC5fi2y08irt
	 trXab6w037d2hbCRCK9fXg1LbAd967m2AcDYiv/IBQf0y4KpUILVVb4M8fhH+UDon0
	 s8a0w+TFwOdrpTqegD7r7rWcjZ3CIoDy5V0ue5lWzp626+0BR1C+EnCDkh+zAmyz0o
	 cyX7RNAXRhLpiVXB/9pt+4ujBdSWYHnt2NE/AYhMdIlWrWLt0CyqrXKN9K8qA7abyw
	 QavbQSPHSDlxrxKnaakc3OQCStFtk4RX5E5o/Xtc4kzQ/Qhok55ilVJ2Oq6O3tiGdf
	 dufBZbXd63K2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 28/33] perf kmem: Add bounds checks to tracepoint
 read values
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-29-irogers@google.com>
References: <20260413041143.1736055-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 04:45:22 +0000
Message-Id: <20260413044523.8B2E5C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Returning -1 on out-of-bounds trace data aborts the entire perf =
session.
--

commit 67635d34bc11f12c6dc78c6031f71bc9fb086276
Author: Ian Rogers <irogers@google.com>

perf kmem: Add bounds checks to tracepoint read values

This commit adds bounds checks for order and migrate_type tracepoint values
in the page_alloc and page_free event handlers to prevent out-of-bound
memory accesses.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index daf2272c73372..33585e353efe5 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct pe=
rf_sample *sample)
>  		.migrate_type =3D migrate_type,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;

Will returning -1 here abort the entire perf session? In the perf events
subsystem, returning a negative value from an event callback causes
perf_session__process_events() to stop processing the rest of the perf.data
file.

Since kernels can be configured with higher max zone orders (for example,
via CONFIG_ARCH_FORCE_MAX_ORDER on arm64), would this strict abort behavior
prevent perf kmem from analyzing valid traces from those configurations?

Could this return 0 instead to safely skip the unsupported sample while
continuing to process the rest of the valid trace data?

> +	}
> +
> +	if (migrate_type >=3D MAX_MIGRATE_TYPES) {
> +		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
> +		return -1;

Similarly, if a newer kernel release adds new migrate types, will this also
abort the session? Would returning 0 be safer here as well?

> +	}
> +
>  	if (use_pfn)

[ ... ]

> @@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct per=
f_sample *sample)
>  		.order =3D order,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;
> +	}
> +

Does this order check have the same abort issue for the page free events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D28
