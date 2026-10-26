Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009746;
	b=URuIGDsLeOcqTxAQWKPpdc4vxbLCBYbLeBPomUHjHQULH27a0xsKvCJCo48on7fuH3B0
	 fxhgtBUjhHe30byRiiARjxhTedmceMuMBlAqN8Fd9WshWkoiIWuc5lFtk+0qiG+B6mRwI
	 92fgJZYeP1/7P4rVj80TMXFGxIa0Ps7tRrt/9VUVXLjvgacAQ45tUwHMThhuPSKxfM/88
	 SF6TEIXepUhhjMPgYERLYxwmHHGCL7/f7SplmNo2CkfhsW3281lGpgccfoQSvvoBgVH2h
	 nQhfyg37RwkRFaW0nMvXM6gsZdCx3GpmVzuek3f6gDtsnBFRKhm6V0wp6dEaZbIxugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2QfGT6HaikspWdTzf97oO1IYRo9xvO+hmZjwVg36P5c=;
	b=ts8YCx4GPQvdT2v0v7jmqgYwafCuugZKNoCtsFa+Zfi50sRu5ECT7KEjlilzeFnKfM84
	 XIZMEU5OJMLbXhXzBQIq+HNxW06YR4o4MrDySrZ1D9a7hav+Xi2ZiKaLx4vQyyglVCHZJ
	 liBPEXO7oRHcjpoCgCBSU6Kr7hp0QV4/EXzdu25o5hwBXwMUoBgKiMa+JHjeN88SG5BZN
	 RbLe9dPhenz+hAs7gv3uPLOIlci3e38gRbI9uHVjbohutHUHYCI8JPtqHSl7ywaELlcMU
	 olHtR6O1YE+wGycQfDuujW0vcDbdbhxYzwLOOTUokYG0Wbvqi2UMNJKwh4VOUyl5QpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCNcswy7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA17606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCNcswy7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813E41F012C1;
	Mon, 26 Oct 2026 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009745;
	bh=2QfGT6HaikspWdTzf97oO1IYRo9xvO+hmZjwVg36P5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCNcswy7x6vauEwki+CfHsmtl4Etjdcn5tKvtcVSJS9uROA6rziSYpy59BulOS5qD
	 Fg9qJH6PK2GfyrRuWFt+0Pt2K7Y8t6D5+Qx2INFE6e8wPo83CTidCcYhQ7YNts6c9V
	 c/EcstI2oXgAdhXI7piko1kVY1EUJNu8JcY03QdDKclHXyNCBoBb3SKedKVB5sHcQy
	 +AE5G+PneN3cxxoH42S4gEdbg6xnhPmJhzC9X8otV/8ni1hYaDbN6GxEO+afyATH+A
	 OTy0DBEblKETNxvmAasLmvUjggcbOQhvUsRE4ksQBith/l7EZioz4w351wob9DOfyF
	 Itx0s2N33L+rQ==
Message-ID: <sashiko-outbox-184905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 09/10] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-10-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-10-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:15:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Linux kernel's function graph tracer displays the execution duration
> of completed functions by default via the funcgraph-duration trace
> option. Whilst informative, in scenarios where the user is solely
> interested in the call graph topology, call flow sequence, or inlined
> hierarchy, the duration column can add visual clutter and widen each
> trace line.
>=20
> Introduce support for omitting function duration by exposing the
> noduration sub-option under --graph-opts. Consistent with the existing
> nosleep-time and noirqs sub-options, it accepts an optional value, so
> noduration=3D0 explicitly retains the duration column; when specified
> more than once, the last occurrence takes effect. When enabled, perf
> ftrace configures the kernel's tracing instance option
> funcgraph-duration to 0, and restores it to 1 upon resetting tracing
> options.
>=20
> Because the profile subcommand fundamentally requires function execution
> duration to compute timing statistics and call counts, combining
> noduration with perf ftrace profile is rejected with an explicit error.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D9

