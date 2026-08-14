Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2F70836
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666351; cv=none; b=HrCYa+JA6+ROaifHDu9ekkZ8NxeQViMA0Y+WIgvqt9viUWadwJZXzX6hSqxl5HdLeIjSt4JU57cLP9XRZ3E6h3hEloGnxn/ksfkUuyK1hjOPUV0pAwmuB/Nq/ADXZlCIw6H4SgffWlYf0o76poSnyWdCNVNnS7hpMoAvdstQ5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666351; c=relaxed/simple;
	bh=LyC8Mkym7m1P4P+7xxONXcze1+658KCiIzabfyBx04c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZCP3sdXPjjgA7ADXUBqgT6FZM6TTNq1Kaxlz+zzW6Gx9iq481reC++ys7wqNtc5IZNy/aXVphGLhL/sm6RChVmQ6amymfDMHY7btXyqFYmFyNcigTWIqEe9xTLWv0yLdZSNAvabablhjEn10U8tOUe4idXRmJ6RS5x8UhxKw7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmw8pxT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmw8pxT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A51F000E9;
	Fri, 14 Aug 2026 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666350;
	bh=LyC8Mkym7m1P4P+7xxONXcze1+658KCiIzabfyBx04c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmw8pxT6XcCzWwXM6xkLcAJoTQiwNKIkLyy6YzI83YU1XJdG8+tFocX837BU4jndC
	 OaIirzEw47/1//5mAkaL8h8sR0IvKwVNXHQGpqzywVzgBwnhyBbRH2DlMoMmUGQgIi
	 I1G7M5yWt54CJkf40jJf0puN+2qreZpbnL31ZU6ROGSdSEPtSMlvLDp+aFLhnuLlX3
	 EZwQ5G8etpArGga3IgLY2PmjnS4xR+G/295GfQtSeNgsfJVseZw65wu4bJIgEwXvgM
	 Q7G/9oI1nrwXiP6xKqSZSHSy2llS9IF4u27yDLMrIQg4Mo3mrvx2iyY5hapGM07biL
	 kXPTMH1lY+GJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/29] perf hist: Remove evsel parameter from inc
 samples functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-10-irogers@google.com>
References: <20260412020833.641177-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:12:30 +0000
Message-Id: <20260814001230.9F7A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> hist_entry__inc_addr_samples and addr_map_symbol__inc_samples
> unnecessarily take an evsel argument. Read the evsel from the sample
> instead.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D9

