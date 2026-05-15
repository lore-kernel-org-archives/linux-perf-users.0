Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BF49659
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804325; cv=none; b=UYe6EMNjoDJ6OnJVHkkXRdBFUhW06vQts4Ld20zMtHMkuPyFVbSjCo48Xls/N3eTFKchAnWfUppo+ZssssdYLaFZ9Hk44qlR2PQP5y7HohRx4mzEp88Vuurw1vCcLeWAWhnR5vsq1nBDB6/IWQz4ZyU9fp34D9hWqznUCxNrqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804325; c=relaxed/simple;
	bh=DgiZXSF4p29SQhJZJAYhlT5Pg7nYuuHpqhaNccxw4B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9eQ841jfrJmfAh+6iSFChnDx5qd/RMLEVxPmVzLIlKOA2csXTWjEjhBlPgqojAOPjnccCOt4v5jNo3m5G/s1ouNaqv+8InDzlykdo4tRGZbq5ukaUWVBUeSZCRzwYsUTDxFyKgtyFJUPZX2cmb7RrCnzZU09cYrhAMft3Vzc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqCcBCuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqCcBCuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7126C2BCB3;
	Fri, 15 May 2026 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804324;
	bh=DgiZXSF4p29SQhJZJAYhlT5Pg7nYuuHpqhaNccxw4B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lqCcBCuGWq6kzwGtzPlt2gkLk6SBLasnagQhl9ExuzJZEQ+HuFicr8EXTbHaIbrz9
	 s3GF86/u8kVI6uA2eo6R5myWS8vCNrNGoTCkFjIcU/+lTkm7qviS9H4zFaNamOBU6e
	 fUFj21uEheeQjHvGfJdsI5HR8/9+vyDmgbwIL1bkVHlaOuLo98Rqnv18eN4Thv9Cz1
	 9P5ZQb1hiTGRgtCAt544iLgAdmrv/of88M1/kNdwbld5Nx7VxYPIE2Mj4M3VZQGEa5
	 sDFEa6IO1gdH5HAbybof6AI7LyzoofNGgUCKwx+McdIHV9kKQfTXJGgL7FroCtZiPf
	 Gz/953N/G9WeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 27/32] perf kmem: Add bounds checks to tracepoint
 read values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-28-irogers@google.com>
References: <20260512223001.2952848-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 00:18:44 +0000
Message-Id: <20260515001844.B7126C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Returning `-1` when `order` or `migrate_type` exceeds hardcoded =
bounds aborts the entire perf session instead of safely skipping the unsupp=
orted sample.
--

commit db2c8ef329ed71e391ac9e15ab5d65c621b1d207
Author: Ian Rogers <irogers@google.com>

perf kmem: Add bounds checks to tracepoint read values

This commit adds bounds checks for order and migrate_type in
evsel__process_page_alloc_event() and evsel__process_page_free_event() to
prevent out-of-bounds memory accesses when reading tracepoints.

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
[ ... ]
> @@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct pe=
rf_sample *sample)
>  		.migrate_type =3D migrate_type,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;

Does returning -1 here abort the entire perf session instead of safely
skipping the unsupported sample?

MAX_PAGE_ORDER (11) and MAX_MIGRATE_TYPES (6) are statically hardcoded.
Legitimate traces from architectures with larger page orders (like ARM64
with 64KB pages) or newer kernels with additional migrate types could
naturally exceed these limits.

Returning a negative value from the tool->sample callback bubbles up through
perf_session__process_events(), terminating the parsing of the entire
perf.data file. Because this uses pr_debug(), the user will likely only see
an opaque "error during process events: -1" message.

Should this return 0 to gracefully skip the unsupported event and allow the
tool to process the rest of the trace?

> +	}
> +
> +	if (migrate_type >=3D MAX_MIGRATE_TYPES) {
> +		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
> +		return -1;

Similarly, should this return 0 to avoid terminating the session?

> +	}
[ ... ]
> @@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct per=
f_sample *sample)
>  		.order =3D order,
>  	};
> =20
> +	if (order >=3D MAX_PAGE_ORDER) {
> +		pr_debug("Out-of-bounds order %u\n", order);
> +		return -1;

Would returning 0 here be better to prevent aborting the trace processing?

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D27
