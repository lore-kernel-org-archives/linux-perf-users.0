Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F31446052
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148357; cv=none; b=nO9o3AsX6OhslJDe5Wyfew9s/eBwCRCVZPKqV4FGNGjiMp+3hgui4atjZQiXHvAHLSddku9fpl8C9q1R8Zgj3RHCxpwAViAJ/qFTm+VVsN6NTNitMQ1lsjWOYDYdhbzbuRvSwamLtAnk1j5vhSL5CjvImKSO1rKXtLFZoip1FIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148357; c=relaxed/simple;
	bh=bDIznaCMMwB8q50MajzRkYrfwGi2rsKUhYoH+/1xjkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u4GM+uC6jxN8yabY+bFLk/Mk7AA+n9KHhYwNytiLHd6fSTs73TgKmXTS03zX5pktx9X0s8ieE5ye4mHcPqo7Vio3OiBcM+ULGbcAs7nxtKGCMODyDj5ij1Rf/ubDJec6692CXXAPvzKqYIgMZR1vD1/wmUKRmtMgWQCtgeIBYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icz+WU4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icz+WU4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAF31F00893;
	Wed, 23 Sep 2026 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148356;
	bh=bDIznaCMMwB8q50MajzRkYrfwGi2rsKUhYoH+/1xjkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Icz+WU4Lc/dkwQyZdU/TjKH9lOrouTh+KlZx+I3bIR/HmRJTGiLO5Dkpv5OBngaDJ
	 jbitGDX8nfF5t6mP6tKU6gcGEjLBw11D+3N67YKZ7MySEQ2NdnuLU7SBzhOBZ0wp8y
	 ddydwS9C3D6K5/cFYkvPjJJGimN+gkKMYWNm8rHjy6LaqQaCj5+c9iA7UzCw1ucBsO
	 SmYp8UWFwyj8Tqq9vwUsyQ5SmjimRtOyFf4Zew/5U7LfYD6nrps1aHSKtwOuVQkblb
	 plF8Qp1WviuPl0sYqcIOIvAe+Fq4dUjAA3pshs/JjIC6W1zH12jO0LrHB58DPLixbw
	 Yw9HFsCIHdHyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/23] perf trace: Set the augmented arg header in
 the augmenters that omit it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <aa751d26ad55f8a7d72db30dc23a67fae66e4b6b.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <aa751d26ad55f8a7d72db30dc23a67fae66e4b6b.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:25:55 +0000
Message-Id: <20260923072556.5DAF31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> An augmented argument is a struct augmented_arg header, holding the
> length of the payload and an error code, followed by the payload. The
> augmenters build it in augmented_args_tmp, a single entry per-CPU array
> reused by every syscall on that CPU, so a field left unassigned holds
> whatever the previous syscall on that CPU put there rather than anything
> about this one.
>=20
> The string augmenters get both fields from augmented_arg__read_str(),
> and sys_enter_perf_event_open() bails out when its read fails, but
> sys_enter_connect(), sys_enter_sendto(), sys_enter_clock_nanosleep() and
> sys_enter_nanosleep() copy the payload and output the record without
> ever describing it, and augment_arg() sets the length but not the error.
>=20
> This has gone unnoticed because the beautifiers for those payloads take
> a fixed sized type and so read the value without consulting the header:
> [ ... ]
> looks at it. augment_arg() reported a string it could not read as an
> empty one before this and still does.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D1

