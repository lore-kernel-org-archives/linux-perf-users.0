Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FA1C5D59
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306447; cv=none; b=LNKUfSm65HAnweJfBxyjxGJarseR4fhlqWsuoQoEKMyWu06aJdsHrsxd+6+2oHho8k9tReAPmHbWXhmvy38EqUDfR7jwyRpgpWRMZuBfkrD62wUmLcA5dnjFq6B+LVgPAemCqEjGywLBT9cxES27udd3wpsWkoU9ff4oHzXEEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306447; c=relaxed/simple;
	bh=EOnvVj6rvR4ghvh4MWAIELxoExN9If5jkLjTV1gDvh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EE+MtxnHKw28LMicTOZ6R0VUNzFgWH8YwRdlVQbdRADhs9nSeoO5Oem7Mfnuk0/tWeJKTMaJujxK62hwUAWr1Tf9nbpewzKDrYRNhLBP8P+80LMjMWSqhSIq1IekmuQlSHSehd4xVWSy5p3lJ3Vcxwo8+rbysFk2QfxUk8Y+gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLSleFg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLSleFg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9C91F000E9;
	Fri, 21 Aug 2026 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306439;
	bh=EOnvVj6rvR4ghvh4MWAIELxoExN9If5jkLjTV1gDvh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLSleFg8V5Ku/27M5KYG1SDgOpSKeifOPTU+QS4eZlUonp4i+T4JY1HhjyIj3hOwK
	 Cdy5IXeBo5jM7mRTMMslMH5YO9wqjIzdp+5R1xrSizk9S5jYJXPyP0+h1FI60uBdwI
	 7OOC0sO+M5VPEYnLfgzNeQzLJiBOTUSqh7fHI5m6DwaT6k54xbwqIFkyg93rD8pBdG
	 9bMCx3DC2vMbSOBZNS3guXNCTkmz4OEFfU3gJ6LdtdzKxjzupoZp5+B7x9DdQb7kwn
	 XiWk1x8hEULnU7qDgvwdPd+JBVcUkfoz87SByKjQMokTdX1s7SXbStouCM0w+U4FXy
	 68AKtDgbke49g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] perf auxtrace: cs-etm: Capture wrapped
 snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-11-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-11-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:00:38 +0000
Message-Id: <20260821100038.DE9C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> snapshot_has_wrapped() isn't implemented for Coresight, so when a wrap
> occurs we only save from offset 0 to current head, modulo buffer size,
> rather than capturing the whole buffer. Coresight drivers currently use
> a monotonic head pointer even in snapshot mode, which gives a lot more
> information for taking snapshots than a wrapped pointer. It means we
> don't need to search for data at the end of the buffer to guess if a
> wrap has occurred, and we can go back to saving partial buffers after a
> wrap by checking if the next size to take is less than the buffer
> size.
>=20
> The drivers will always be able to generate a monotonic head because
> TRBE has a bytes written counter, so even if we stop generating an AUX
> record on every overflow, we can check if the counter indicated an
> overwrite and offset head by a whole buffer size if it wrapped. This
> forces userspace to read the whole buffer rather than between last and
> current head. ETR and other sinks use software double buffering, so can
> continue as they are.
>=20
> Add a much simpler 'monotonic_snapshot_head' path for tracers to use,
> and use it for Coresight.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D11

