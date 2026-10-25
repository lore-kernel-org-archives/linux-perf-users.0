Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952242;
	b=LbbjOo8kcY88nwuhSH5VAIw5/6CIjwpXo+3qtijLZNkErJskpDKD0Q+jtrC1qGBqpLMt
	 ypT87nHZ0XxY3hDqSkiJGOIecb7sHiCmg9X0A1/odI1Dr3n4PJj9o/RjsOXkUV+zu58FO
	 CaUWuHgKKJBB+4bqEusdPTHKqub9DLyTQGEL1oCy6GrbHKuCKoOTxnir+HK/Ps2JV+n+Q
	 YeYt0AzZQGJ49pis5QZTtC+Zyf20ygbWYSLYGctILtnP8TAyx/5Fvdz8BZ/tVRgJWWJJY
	 Wmzad5/YlmPIhCWTjIuzHftinNKhfgUWjBc0LiaIKlgm4DCeXw9f1vQs1fAv8xhR1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wRfVowsb248K0HFGM+i5sKMK/VQNf+81sqdSwZOW+WQ=;
	b=yGfqKuTEzOnGY/H9hemANgS7E6P2uTh30cyoGRZYQDb+YTzPQJSC5geyk7fsuPkc0+uS
	 vtHFzQnu78E0CfUGEJZ/wQoi4+hXCBvtLYug2qmx9B0dWTRaH3nFBWUs4R70ZvF6uVIgg
	 +mjpMCLo9XySUn7hxsTi0BL9ZIeqDPlrVeSaaLS96zjD0z1xVLXHHjk8KhlxP2KBBUxKA
	 pBkh4iWxFIUSBXkGInVLAl9r3toWy98UwGfHDzb9RdsP/jzLRnvcVp3BQu8ISN1DoYaWE
	 cKBTjDZo6VW7zEmW+3KoZkmN/SKm3xoh/80ttcwl3A62xM93hAncyGbNjPaPMhmeZrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxvgHUNb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95941606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxvgHUNb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADC1F01828;
	Sun, 25 Oct 2026 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952242;
	bh=wRfVowsb248K0HFGM+i5sKMK/VQNf+81sqdSwZOW+WQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxvgHUNbY3LZ/neLT/iaf1mdAEnnYGcdL9TWORX5MVpphHAh7xxFlWuqmpNoAXiSN
	 ZHVvSqRrx4Fe8Y1h6rRTGfhhbEHhIa9xu5k024164rJb5jpCJYP9pJUkwa24IuNWxQ
	 /jRVkknjcMFx6qxIOXoKjH0odw4nP79LH+6XsrW3j/oe+aZuWkJCru1QR3bZgdSdNH
	 BJMcwDiy+D6PtFl86rMqcLTsedBo35E3fa2+NXh5njDBjM1L6kVTnxSNlX6K6IB3vx
	 2B4GDwVMDNgKg0XoqPZP5aL7kAIUP9RHcQkWaEo7Mn8igmol3QFlZq5MZaJnEE/IjD
	 xNZGSD4xvg9wQ==
Message-ID: <sashiko-outbox-184321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 09/10] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-10-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-10-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:17:21 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D9

