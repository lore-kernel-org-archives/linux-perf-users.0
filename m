Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551651;
	b=PKro5ldDsSy5DSv/fZqC53CT31TdiT2DNa+/eIqaUFgTAl8gSbAUGLXAZmUDNJPX0QdR
	 OI2Jv7PX/pJ5+IVyzgYTgMV3grY1vZJ2+lDD0WJngT9LPei4RhuSYFzGcHux+Qk6YFthu
	 6/vbGnGDnnZXZhm/KAtt0p664KUgG+CUSs08eAa4ijkb8BvqxNlJlhT8NVv0+EIaJX3bH
	 b2BSTJvn3jvx3pWdbXiIoaXGw71HiGe+fKK0EWkfNDP/zQ33ONIfwcYAnU9lDVmJFWf8y
	 5Z75TJ0faqqMHgzOhKr+ebFEjCvp19DQhRynYvg1U28dlIHvoUOZ5VvQBdMtSXNtsZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QyWtlHAmBJXGSX0SJJMruDFJn1uamc0Po5o2Pdj4NU8=;
	b=SAUW8vmmw9oPMY8fZpb0DD9KCFhoyIxZPh+L79aZtS0y67DUtYdSIW/mEx6tDoMJtvh3
	 MybLUZLaBBnMy1SGEv571NpwzAcj6r6EDsK+EGL6/1tPgZzxcTKZyI/a44yDd6mGx49My
	 0cCQui8G67GfYdSjHlPNQHAep3hsl9R8tBE0EhPaC/nWEedvLbgQ9Pc8aF6EbilvwV2TD
	 dH0YVp/KrHnEReXv3YNQCVihethLc59uPaq3SYyvkih3x8i/de97W3OTufhFz5d1kf70p
	 mwntbYiD1gmbhaKhuuOG+t/pAVuS4W0svix9FMOjIpYVRoSgNK1/Rjz3sdUEX0zuyUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQvCEuAi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E6606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQvCEuAi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541DD1F000C9;
	Wed, 21 Oct 2026 03:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551650;
	bh=QyWtlHAmBJXGSX0SJJMruDFJn1uamc0Po5o2Pdj4NU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQvCEuAictP4JqwDYpAXpIB7+bpUhfJgyEVOICp+6kxuwt85Vb5+pZexAdcCj7Eji
	 sOdUQePqXl2LSmrbNH2ZtGEEG8QJckPWZk0ZJOs7aaUWXiMYJMWGGAaisIG9h1eoyr
	 B/5rnsGdOLdasU0LiXwbdtwZRjA1AC4j4P79GQ04cRsOHldZhJmGGAbLILjTRwKQ5t
	 rB3tf2gUdlX+ZALuYEhRS44/dL0XS8tkMiz5B6a9gvbDvu0G8UKvVlNPMyKXe7RPwm
	 +451cjDQx4BjusAq1j01Jw/5ypf6xxu+gWYOD++mzaTPHmkl45+LAIR4n9lbxXdLvz
	 mjXhkmUa74f6A==
Message-ID: <sashiko-outbox-179737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf timechart: Fail IO recording when no syscall
 tracepoint is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Zhengyang" <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
References: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 03:00:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
>=20
> 'perf timechart record -I' skips the syscall tracepoints that are not
> available.  When none is, e.g. tracefs is not readable or the kernel lacks
> CONFIG_FTRACE_SYSCALLS, perf record falls back to its default event and
> succeeds, and 'perf timechart' later fails with a misleading message:
>=20
>   No trace sample to read. Did you call 'perf timechart record'?
>=20
> Fail at record time instead, reporting why like parse_events() does.
>=20
> Fixes: b97b59b93d10 ("perf timechart: Implement IO mode")
> Assisted-by: LLM
> Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-timechart-=
io-no-tp-v1-1-71779e7db01e@gmail.com?part=3D1

