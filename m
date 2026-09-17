Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE343E2756
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622212; cv=none; b=pJkGU/PSc4clcQ0xAquFzn4mUe763smu/LFmC3uqL7eHgrbqh8hlvngwsqmdYjvkCasViB8EA3sZypPgKEcJsTPoDhTzCUfmKtSpgESWMFRu3OQZ2ZgqBH/KcdWSTcuRFai71FSY++UvgyvncGkHtqw6p6QV14TmiobYoWLvKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622212; c=relaxed/simple;
	bh=cHqA9Npgu2NFPEC9CtSFsDmlpwbIpUqiTgX9IM/YVs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s0OuHmxhmmsPsp0wP4LZZJ2nTnIzqFo+32LC/aouPPE7z0fZ+CYS1+m49/j6GHnUC4yxzsG4wEhPfpM08SPpY9B7CXB6zy5AvHfHkh33pEYcHuskbMBGBPTkgG9wJ5k31egloKgwsduYW/onX5+Yh3tr8UzgFzjSVZbhyZIcD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua2N80Il; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua2N80Il"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F011F000FF;
	Thu, 17 Sep 2026 05:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622211;
	bh=9Hl6sr0skJDvak/6GqTBbDgITs3tNPEReg4DHSzCBjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ua2N80Il074i8p3fvQXkoe5qR99wWGPGvW1nSp7WW6dC/1iFO2Rscz2w2virLe4q3
	 tLh0g9bKZvOq6NqlKSsjYRDd9ogydCTXnA4lM16KtbT8xJrMQ1Eov+i/CafEJqGPLQ
	 kqVLGGz0vwykvTa44xdo17MNoVTpKP2oHIdSTCz0hDH/LHAqUOQLKOcePjtLDQv5v4
	 70gPDmkjLZLUtXZ4TjCnQnJ/ap/ad9OqcHFVA53mkV3cToeAj55q/lJhWNEeqMItP4
	 X4gUzMk0LphBfybNdUxgX9Zn5srszYaQ4gkae4Iq49+ASfJsknII4lGXuFr3E4tW3H
	 4U7CLuAlPZfkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] perf ui hist: Add support for aggregated
 total_period and merging entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-3-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:16:50 +0000
Message-Id: <20260917051650.F0F011F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D2

