Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E1526ABA
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923856; cv=none; b=BZoH0bp3/0LWZsdJy/TDlxV0lzXeAFHOsropqkZ0ks/Fwzf/7cRqmRL2tJoBeFlTXdq0uxB9c3XnJ8JtCjhn1ppo2+iLqvs12VSlU09IzmgcZj9YH5hDbF5ulfurqT59ntph9p23rVqTJPYxcb+ljkkKnbZjj2YVRyiMgPLBFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923856; c=relaxed/simple;
	bh=mIPCWTTX1r54jKNtTBY5BPkDlJNI9MiY/KyQlettD3M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E3akseY4VK2J4skr/KWq45TldiJQIoocivlBpvRITb6qVxzntpxdn230LDAfL8Ls8nCCbQ08Z3aVAZyaGFc7Ek6fV3otA0+QnQVn7xr1IsTNcJt2UNtgseM1fwSV2yBcC4+izWbd7ugAY7kxrgPqEJ/kNT7Rm4cY8tyX06gAm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJCwLb2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJCwLb2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633D41F000FF;
	Tue, 13 Oct 2026 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923854;
	bh=YnUZGZAIZsfBomhQ+sy41S2lKH71z/1FFdoaUBqLDn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJCwLb2jJ1m4SanDufFoJ1hLp8kVleWyhitSZNgcPI6J8V11DfZhAlpxnV6HLbjdc
	 oOekOIUuUAX3a2q35pSZBUOuphvxoNd9c4h4IFSw5X119yD6hqAjwFKSXZwLMhwO64
	 +ATz6SvwTn8BRZmDUdk3JEEkku3vXQlM+0BBzPyQeXjE8IWL6q5C3PcGkQ25uk5FxG
	 vXBLf8QEF69j9jKdO7/GdNC6w5HCkP5tB9QgJBN1czH6ztA9IjAwxRJJuv0GphfbfY
	 T13DPkMGwJL6yfj6su8SE7m1fOv91KgM0rmeeZ+USWw1MIeiPIqfyj9HKxHOpCbYP1
	 KYv6nKZqgdpMw==
Message-ID: <sashiko-outbox-170470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/19] perf test attr: Fix default stat metrics
 expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-5-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:37:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit c7adeb0974f1 ("perf jevents: Add set of common metrics based
> on default ones") and commit 2dfc0cab3da4 ("perf stat: Add detail -d,-dd,=
-ddd
> metrics") the perf stat default metrics open their events in groups, so
> group leaders and members have read_format=3D15 and members are enabled
> without enable_on_exec, while standalone events keep read_format=3D3 and
> are disabled until exec.
>=20
> Also, since commit b1c5efbfd92e ("perf parse-events: Remove hard coded
> legacy hardware and cache parsing") bare hardware events resolve to the
> core PMU sysfs/JSON events (type 4), so add the raw encodings seen on
> Intel and AMD for instructions, branch-misses, cpu-cycles and
> stalled-cycles-frontend/backend to test-stat-default and
> test-stat-detailed-1/2/3.
>=20
> Add base-stat-group, that accepts both the standalone and the group
> variants of read_format, disabled and enable_on_exec, and point the four
> default/detailed expectations at it.  test-stat-basic, test-stat-C0 and
> test-stat-no-inherit keep base-stat, whose events aren't opened in a
> group: for those, a change that groups or enables them differently is
> still something to catch.  test-stat-group1 does open its events in a
> group, but pins read_format, disabled and enable_on_exec itself, the very
> terms base-stat-group loosens, so it doesn't need it either.
>=20
> Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy har=
dware and cache parsing")
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D4

