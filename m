Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7A3C10A9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185895; cv=none; b=WWccz7yrcqp1Mvj9NItwKdGK4WqNlLn9IQ97xZotvaKiFGnOQNYE3WTJ7WW1MmoBarQMP5L4fSoELnCUkygtvCc3WemJATMEX8YVTjHhQ6+xiMp7nllo+L7TBFuxn3Hske0AiS0wgP8Sc00aVM8CWnPcWYCbkrVP3HkuqwNBz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185895; c=relaxed/simple;
	bh=fzMzLarrzKIvUuXP791cbF9RlxlaohFqSF3ozk9Uvws=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QvbVtafNw7vKY5ZYJinw3yb4+qmbQCuDNJOnLO30Qk3aPJLxzdT3yk/drSan9jqfpsUKZ35yf+uQkg3jKrWKpU1FOgWmOUHnHuYHYM/x0H7TV2Hxx3j2KrRGf3rzbg2z531W3xGguj+nUJ1ANoAms1pI1H4eB9yJd6+rcbgMCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqAeiIK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqAeiIK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EA31F000C5;
	Fri, 16 Oct 2026 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185893;
	bh=fzMzLarrzKIvUuXP791cbF9RlxlaohFqSF3ozk9Uvws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqAeiIK9XxcuI7Qa2S23If71oTLARhmpSSNgT/nMo/9zQoaXtyRa0PDBT5TSuBm15
	 9Wta+5MXEBi0jDmT6t6eSxhelWsUCKOgwhszDUoHz6H8HrnBGX0ATKxYL0ZXgoF+cI
	 IA1GqBL/hX4ybcsTLe/3P3ql/ViRfTOCtAtoZW69+e1cGEgxSbZDvnuWtOmdoMp6fd
	 FM2f3592uuAQVAh2SoGECoNULmaYLkX2A6T6k9f1xlZUlJVk5K05xDxS41xYgatK7Y
	 lD8kuzQFJ+9oLugSuk8pQeH36DcXKDlfASoOCa7GFdR1mkGKhqwX1vOrKl+g/AmgL8
	 x0pb9kfG07Cxg==
Message-ID: <sashiko-outbox-174960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/21] perf evsel: Close the fds opened so far when
 disabling missing features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-11-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> evsel__open_cpu() opens the events one by one and, when an open fails
> with EINVAL and evsel__detect_missing_features() has a feature to leave
> out, goes back to fallback_missing_features to open them all again from
> start_cpu_map_idx, without closing what the abandoned attempt opened:
> the fd of every CPU or thread that was opened before the failing one is
> overwritten in the FD() array, leaking it.
>=20
> Close them first, the same way out_close does when returning an error,
> leaving the entries at -1 for the retry.
>=20
> Fixes: af954f76eea5 ("perf tools: Check fallback error and order")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-173532@kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D10

