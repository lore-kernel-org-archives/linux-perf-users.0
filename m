Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313426;
	b=GgpmJF5gVqJXA1orDdAklvd4get66BfQvI8RID9FfcP4xxnBN0/gcAvnSaqKm6DxgIt4
	 LtZtzemN39KePpwCwJK/AKHb9VeVrYaBvghQFmptd/DlwwqXCaPxI9EsxzoY+olZK8aJN
	 /U95ta2gsU3z/tBgdIR0Rk7LV6agCrLSDg+BF9JpwSxW8liWZTuYlCUkLgwQ9GnNNgfA4
	 0k330X0B7YYCoR86pt4+y5t2zLZWxtVGxJlVqKZZ9d8QDsJaGTI5XOtkmCbTKrBR3KK7E
	 FhlHx0DMjqhvXVM1fphX0FZ0TyZgecu2oAVudMNkk02UO+BNxE59oKo07bA+7toSGqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dfCn1JNswc8GmW+6eY2OkPyFi7qnIBAIG7XCnuCxqDE=;
	b=akcOjPnQuOunPmqCUe9nd+PcEabDJOwkooXNSOZbn9KYsNNfLtjGrfuET1BG0/qtAdZA
	 JOgDgvID3cZC6NRX+ZUoMnbMOBVX3xzVrpkpSJL5gayCg3xWJrIM4P/yIaPu7L8dZ/PHB
	 E0qy7jldKVygIwDbMBo1nlGfpc+Lx9Nsp15RURh38xPH6XyhwaNpRFYlAYUsITkIzzf2d
	 xdAP15a9VE7Us7cwRlgw3B2Ve6vhNLYWMdV7a9j0IAZgmKb+JOnNCu9p3xe7NCWg2vu1z
	 tf4HhrECc9PQk2+cRMz+2QQLnvQu7+9ovo9bz/b5PqlYXguh97Tcsd7gVHDkZKhid1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GpLo0/XJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF24606A320
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpLo0/XJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3EB1F000C4;
	Sun, 22 Nov 2026 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795313426;
	bh=dfCn1JNswc8GmW+6eY2OkPyFi7qnIBAIG7XCnuCxqDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpLo0/XJHtZL7rUuQhc/QHsquhRGJujEm8pzSBifV07Uaunjf5q7UiDk19lf9nZzt
	 lnMXSsrZrfQXFbCsd+uEE8hMByrKHk3XnFR8ggGCtXmscTdTgjkyAgTOiVHEFS+F5C
	 1WpNHg8ou7Oo0v3QDa6h2I7oIfBcsNxc7F2A+btb5whm0H6yG+VcdVGBJTzp+7ufuY
	 7G4S9yKuZ+eB+d4N+t38pIMEHZoHTZR8K70pUCC68udGicxeslNuUJDIlZbd4c4zw6
	 41bmygjq/WgSQhxwAwFOdnj7LlzDi6uJscHwli+YaYNvYA8+gmzORsmZZ6eY1zD3O/
	 yadd7YVBghvNw==
Message-ID: <sashiko-outbox-227640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Skip cgroup attach IPIs while
 perf_sched_events is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <qiliang.yuan@linux.dev>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121-feat-perf-cgroup-attach-ipi-v1-1-a0e6d3cce8d1@linux.dev>
References: <20261121-feat-perf-cgroup-attach-ipi-v1-1-a0e6d3cce8d1@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 02:10:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The perf_event controller is implicitly enabled on cgroup v2, so moving
> tasks to another cgroup calls perf_cgroup_attach(). For every migrated
> thread, it calls task_function_call(), which sends a synchronous IPI to
> the CPU the thread last ran on, so that a CPU counting cgroup events
> switches to the new cgroup if the thread is running there.
>=20
> Without cgroup events, no CPU tracks a cgroup and perf_cgroup_switch()
> returns right away, yet every thread still costs an IPI. Moving a
> process with hundreds of threads, such as an inference server, then
> takes milliseconds, all with cgroup_threadgroup_rwsem held for writing,
> which blocks fork() and exit() on the whole system.
>=20
> Return early when perf_sched_events is disabled. A cgroup event enables
> it and waits for a grace period before it is installed. With a full
> barrier before the key check, the grace period orders the cgroup changes
> [ ... ]
>        16      4.1 (3.8-5.0)   3.7 (3.6-3.8)     -11%
>       128     9.8 (9.5-10.1)   3.7 (3.6-3.8)     -63%
>       512   21.6 (20.8-22.7)   4.8 (4.7-4.9)     -78%
>=20
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-feat-perf-=
cgroup-attach-ipi-v1-1-a0e6d3cce8d1@linux.dev?part=3D1
