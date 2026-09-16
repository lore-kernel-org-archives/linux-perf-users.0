Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471135F5E1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542284; cv=none; b=X5kpxBj5n5dKCvBW6m0ycqPm4cqcKHDJisjym33k04Hy57rt1ert6+NAy2VauAgLLuIOSPRB+oRU5k7fOvybbMRy2As3vIXrVv9lhZAsH/XybtcQecxfhTI+FNIEnIr2rnZvBx7Xf+A+JJ2UJrcwbZuQUGdXqHhxpCw65jy+vIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542284; c=relaxed/simple;
	bh=pryBSU+8clfMCSUVHNcyjU+u81VQvEnNtD+iIrWRLtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9o3Yr3K5xTemA8lyGHGDwP7JueASZ7djQyE6jTxZahefFNKu0MbL8C3nNxJ74dGfOUWHs2kje2oltMMe+5t0t0mAfePUWCINm5pmOBzKkrnOaF+ogBX9GZedKvylv8yR/olzri8khlQGTWscyYdV4TrqGlr2/RawEy91ez8YUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCJXHHV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCJXHHV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A86D1F000FF;
	Wed, 16 Sep 2026 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542283;
	bh=6dLC++LZ9wcxS4ojYxLXwvJljlzeaptRM2O+W4Htuw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCJXHHV2piKtp7im0HcqtgmH/G1kROl2pz/LqDYa+3IEcNZ8a4OSf3cpy98ZPjEon
	 hkf2U3+xvL+z63kAOGpN18/d+wsVzf362QN8PpUCg295lbgE7Z1k49xX0LjxMB/5Xq
	 Qk/TwsUMnX95sUTKwXAJpi3so1/8A6xXVRYQpwagQ+vwMWYwRqHKWE0s5DhRoI+Uol
	 vf7y7MxL6AshkYhf6MZsfWdYSnNXVnrgs5PjCXDKUHJz6lnZ+PrMKvF1s0pO8jebH4
	 i9glAA1FCXpnu99dv+nzWUKbmMb8kCyosTfKL2OXFoitEANnqbdQ6c69qtBeWrwZqF
	 IIcpV2wPZZAIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] perf ui hist: Add support for aggregated
 total_period and merging entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-3-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:04:43 +0000
Message-Id: <20260916070443.7A86D1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D2

