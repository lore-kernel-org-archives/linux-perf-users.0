Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829784;
	b=zpUB2eKjCV7vfvm7BaLyblaFnMsMeoQ9x/V82J5lWm2bws2BVKbPvww3HNt3yiWzR2y5
	 m6Lx3g2SS36gh5I8gmqTbhu1N+roIRkpzcDLOjJHYj0EUIe4Jobd09RdTQ8aU3sgXzsQL
	 ZQzKeHvVkFDL/WbBDivv0AOk1ujTYRbDr168KrdK9BbfLOAF4uRJNuifUfQ+tDHHu53RZ
	 CWipScU+l3wX6J4EOGbHSQhvSy6yzgpXeael7R0TzsnU9J2oSVcv0qCd7QUwIg0YCi46B
	 3vkAvpb8iST6/CyxtgupQaG/1oyKzyJS1JAEDNjCT9KK+xw3P6bt+uTxRgDAKjtixnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pEaRylSblft3jFAjWv0ExPnyKKbtv7QCYB8TcibuOX8=;
	b=ffLvB1Q4o02EYMr3PVzU/u1s3622mCYQAtvlDm8gkQzl8W2wMjwOQZDjofXI80w/YaH+
	 AvsjKjmcTdPxHT4HSTDhMcC3vxtj8xP5fEwAUBWkClmdrDCk4q1EPx45vXLEefkIlDRKR
	 oF4XYxTuAP5B6VNC7JRgt6TuGQoU7y38ceIsH+i5W6eIUHGz8do2Vsh5dLfGCEro0mA3K
	 bbP2/7i5/NxFhCAkNtKX2lFHNN6SsqS4Cw3vqxvh4b/xuwW78dd/7PDwxCz4CCsOnpApU
	 jpOf9UFOYdXnzry6WUcjWaNtOPd3YL7hWM9M8f63OzoOUB9WOtoYFqmVQklzYp4lpdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FG3xsZR4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722F606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Nov 2026 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FG3xsZR4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB711F000C1;
	Sat, 28 Nov 2026 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795829783;
	bh=pEaRylSblft3jFAjWv0ExPnyKKbtv7QCYB8TcibuOX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FG3xsZR4p2epU8iQGlZZOc477Ufppy29uXpwN5WDdoU8KZqiwemuf3xfMLnqMVF1S
	 sCLPxc6P2lU7LlU9hWXavC4aT+6LalYLJyxSn46Ps7ttDoWNphjm3ATkA1gkI3MbA5
	 QzCRqb6HTZTAfDm8LnrTgarCc3gdSqqTgLnZK4sYQZjZJM48/Aq1CC7JN0/tTFG1s6
	 EpBD1ua84GBMSVxE3+tuIE2ELx31cf72APp1OUaN71hqUTYnPocBRJ9unQD8RMc00i
	 wk6B7Lr/QXKKcvOdpRhu/Cwd//RykJabDo2fO18549AeTccc0+FB4+2KBCD87TCLzk
	 Q06KjbIHm0dnQ==
Message-ID: <sashiko-outbox-238407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bpf_counter: Fix the 32-bit build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261128013144.16600-1-acme@kernel.org>
References: <20261128013144.16600-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 01:36:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The bpffs hint added for the perf_event_attr map compares st.f_type with
> BPF_FS_MAGIC.  On 32-bit glibc __fsword_t is int while BPF_FS_MAGIC is
> unsigned int, so the comparison is a sign-compare warning:
>=20
>   util/bpf_counter.c:394:43: error: comparison of integer expressions of
>   different signedness: '__fsword_t' {aka 'int'} and 'unsigned int'
>   [-Werror=3Dsign-compare]
>=20
> It is fatal where perf builds with WERROR=3D1, as the almalinux i386
> images do; Debian builds with WERROR=3D0 and only warns, and Alpine's musl
> defines f_type as unsigned long, so it does not warn at all.
>=20
> Cast f_type to unsigned long, the form tools/bpf/bpftool/common.c uses,
> which is warning-free on both 32 and 64-bit.
>=20
> Fixes: 2ea09b93b4ca61c1 ("perf bpf_counter: Say why the perf_event_attr m=
ap can't be used")
> Cc: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128013144.1660=
0-1-acme@kernel.org?part=3D1
