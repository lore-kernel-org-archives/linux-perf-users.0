Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3135675E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603036; cv=none; b=ojy4zAvrG5bQLmghRbPTJlPIcoYLwJM6HCWZSaKMgXXi3CVG7V24VRhKH1jKalLE1e3XYB1Ei1QvNvn70S2qeg24vCKTaDq5XQ/x0t3oWIMUI/Ep44uqLE2dguGnCT/5hOal4u/COgjWsk+cQXy/NledWMRzr+L2GT281w/si7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603036; c=relaxed/simple;
	bh=ovLy4bsW/hQccyuPv3MJiyZCilfyrkWPzEa0kNgY+68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/zLbzF8l1HPgrQqhVoCKG9ZcM3O9guzQ9IZeI6hFoi3KPWhbGXzJWbJw8aaStGLB4fAD9iCgnpmkFDvFaxBRhJYiY8jZAXvbMUHtQSJdRlxmJhFMj71IMnbMMzCGXSAp/QiVLoTJDYvYRTDGQS5E9hfjVvq7l0rDWfAc/11UX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5hU/edx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5hU/edx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE291F000FF;
	Wed, 16 Sep 2026 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603033;
	bh=hOBPxvPvrAgFaXx2IZpk+IpXKYr8O8LstWwy0ubQq6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b5hU/edxTjrGme6Cble8MADxKQE6dbqM88q8zl+N5nnTz+tGpfc23tEnktfQGQNdz
	 KbpLHiRbSOdKXrvJgdn7ATzY/1ybtxtSy1VHiBOHmcQw4NnmUSbFF8NY7wpxN859nY
	 NWQdBi9jrLa2K7JjfegTbYoCocHU4rb4TKy+noVMcP0TPKc9Ofo9jlqyf894FsDwBW
	 PoDtQe5rlesocThu3Kvx5B2DwTGLQrVco0eowFE/8oNZagL3h5REe3TcRiL6Te94KK
	 QVm68aVMpBkhd8RZ1N0rvRIxj5gwF3EdMUcVHSZPPkRqHdYMzPfeF0l/MSDbTzYBPQ
	 eWPzAulR6YrWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] perf ui hist: Add support for aggregated
 total_period and merging entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-3-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:57:12 +0000
Message-Id: <20260916235713.3DE291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add the histogram side of hybrid event merging.
>=20
> When events are merged the entries of the other events are linked to
> the leader's entries as pairs, and a row is then displayed as the sum
> over an entry and its pairs. Teach the hpp code to work on that sum:
>=20
>  - The formatting and sorting routines add up the value of an entry and
>    of each of its pairs, so a row shows, and is sorted by, the total
>    across the core PMUs rather than the leader's value alone.
>  - Percentages are taken against the summed total_period of the merged
>    hists. Computing each event's share against its own PMU's total
>    would leave the column not adding up to 100%.
>    hist_entry__get_percent_limit_merged() does the same for
>    --percent-limit, which would otherwise compare against the wrong
>    total and filter out the wrong entries.
> [ ... ]
>=20
> Merging is never combined with --hierarchy, which the merge_entries
> tests rely on.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D2

