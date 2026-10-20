Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504673;
	b=eM76yZMI6xILesBaA67MbE8fr95BAO3porBp0ioc9o3KbnWF/u7uBMssFzQcnXnXdJYp
	 ewqiP+QJOvL5tzihrrBHjgpjYzk7igOKQeflpF0qo6feorwPpTEjaQa6QoOh5WLnD2W94
	 XPr2DMdBHximNFXqvyq21MxEPKM6ANgeFbRMnT/F3Pvo66LxeekxTpxkBkgbE0IMtkdM5
	 mpRVH8f1Zdr6eTJQprmn/dLL68XzjUK4mSOdTDPf4InsWlzjaNVcasWx351C1jERDX+0c
	 iB03VsvRTN+dS0qYFSqH429p9Jn4/F6JHi+ukx9y3sO2CNHUh6UOi+ooWJV9KGg6WmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2NoDwHhopSRtvctLrlyn5D0rYtHnr+3NVGVckyZfHY0=;
	b=1ao3k2T4IwyElNPRlSeycTZlYWwqfMbqM+awcbQkpb5aaVfbpqJHd/sFaAg50Q5MZBks
	 bhYUnVLU8pX+/9jtrDBZk+Y3wgSeALhpmJrcgWdQt0UW1qvwcNxwnA7iBgU7UZ9U9ou2h
	 1El8FJHRnOsAiL3eHqEV66YPrZxsRqIPUezHndvASk5ZImDMSYAN/C3r7tcVwz9g6ADFw
	 QLhHEswCtRN90ECmWNTZJoOY3YPK5GOU2fXpo2+REEiGlZZq+vKVLD5IDNtAbIfPrNIOh
	 l7NoKZiWB29LvQgJCwZhK72zDjlU/gWlSdvcrph0LVfJJIelE8Y/7S38jlU5V39u/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzUGmB89;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722A606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BzUGmB89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B1A1F000C4;
	Tue, 20 Oct 2026 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504672;
	bh=2NoDwHhopSRtvctLrlyn5D0rYtHnr+3NVGVckyZfHY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BzUGmB89N626k8mip5k+1+54hotsVKWDT7N6FCA33Jz4a+6rWhtcHhqFbUzeIinA7
	 mnRLq7VRWOmkE5lXv51AVaPQ6U85S9/eW8G8N7tYii3Le2L1eJ9Ty8Ff10wKMyuNvl
	 SAj0oELayFk1a7/Q+qkuxz5x95TW7j1KhP9Kvf7ll5wxS6GbbPWlHGxw5P9O+YtFy+
	 GdWy+e33nWr4Os/4/f8s7q/87R0LAwwmHVlFd7zoZWIjjBSO1ijNTX26VOQcHVQEqy
	 hUW242+/YqOS10uqx7+rlEYKNIxHQrWHHI9sVq0Rxdoj9SNrUPH6b1oegY43RsMM5s
	 efijeW+DfTlGQ==
Message-ID: <sashiko-outbox-179063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/15] perf annotate-data: Extract
 invalidate_reg_state() as a common helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6edcf683883edd9191b36ab4880fb64ce79a5821.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <6edcf683883edd9191b36ab4880fb64ce79a5821.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:57:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The invalidate_reg_state() function is currently static and only used
> within the x86 data type profiling implementation. To prepare for adding
> arm64 instruction tracking support, extract it as a common helper that
> can be shared across architectures.
>=20
> No functional change intended.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D1

