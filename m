Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809805;
	b=IfX5nBz87qUy5CAykDWMAPb8kstQcdQgFGbd4OLO3KFANu4J5Bb02xCqDwcYhRDCpHCl
	 W9WakZPz8NnWi4zeDjD9q5tJxWxUTxpHiIHWxRhdXK8mqaOnzGyQoVAI1ZOzUIdvotfFV
	 eQlZT8B6btpNkla9LV+gW0mTII+D5StHdkTQpQyXj43Ukl/5HYJAskNwnHjBaEJBwopW1
	 9HMzDKJue//r2YKSC2GDa1UPr6ro4LPUp2g4kWr9LuFhGyTrmBYFBPIjYS37WZnbdmeJk
	 tgDxMKCUsTSyRVM9knlCk44DUEVoVjMs8t+p6lakF/RhBHuhFsUaV1K01KgRdAhxTGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mR0MsIrpKQieMwPuHKA4JLdyXN3XJcLIw/AJN76cFLA=;
	b=BtiCqSM0WmbS8cjU/8kgge0Jt3RGBedh/CG7TDqPwljazK6QppuRGYaf6QRk01H1wRYf
	 RIlGdssJ+ZsjZ/y11co3WIuXKUIYEbN8NAp72h8JK39XfUQFvEddZkdW/VbgGllHViNCZ
	 enhLEM++U8YUU1LcPLSSDJ9sHib2frl2jSYo4V2dQGOLoNnP14D9xc5fdvkFaY3F93KD0
	 oI08IeMZzGjOfaqKr2LQ1T/qYvVMeEvKOhcJU5zwiUaBTp47M8yuSgGavI5koYIXMzQwv
	 vHpvEMnUvifbPlN28Y0toDUD6+IZ7h7yMs/sKHzOpiofY3kggT1fntgq+Yv6sgBu5gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/yccqBd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CC606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/yccqBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1DF1F000C4;
	Mon, 16 Nov 2026 06:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809804;
	bh=mR0MsIrpKQieMwPuHKA4JLdyXN3XJcLIw/AJN76cFLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/yccqBdBMP+Dj1SdnITlx+J7k/4/Q0RjRVLIUVOLpZpBqOePHM5OZ3638SB5Ogzu
	 6AyjDq7yYSpzLprKi1t+ezyPfkmWUYK2W+Q+jFTWunmpAQhY0TNruxNOe24x+6Bfmg
	 YDazYfK/c43suPTIUsSvULNnbhK0R9VGhWg67X8ejkglfff/f1vHXWjF18EvewDJK5
	 mvT6bc1iwSY5g7XejZF+xNCJKFOuWtdXNeZh+R0JN3o9RBRdpVt0OQFffhdAbzHa8J
	 dvzC8L8LYKftNHYrmJIFCZPVWvXQhcFFQ7zDFbjl5bmlh2ylnPCFP8sJt9BuM/Bdnt
	 /rODdSGhsiytA==
Message-ID: <sashiko-outbox-216256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] perf tools: Add nsinfo__new_thread() to track
 tid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-4-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:16:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Record the thread ID (tid) in struct nsinfo via nsinfo__new_thread() and
> access /proc/<pid>/task/<tid>/ status and ns/mnt paths instead of only
> /proc/<pid>/.  Also recreate thread->nsinfo when the pid of the thread
> is updated.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D3

