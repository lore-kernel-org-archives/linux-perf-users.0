Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957780;
	b=sk9rVOibwS9wzD5I3unLOPdohflXgDfGwDfK0Mj7f5eYwi92bqh1J3DCQdhz0Hm76yEh
	 /rlO1H+FJkHauUlIaJ2dyOgW5eSQ4sJe448WEszkgkHPh4p54EtyEMLJNBoICnoC9McBB
	 eMYuBKCHZpSnkZ5cjKO1j80EruXvKbvp7RbtQCk0/KryyIGvN8X8CwXEjVUk7VE2ng3Ty
	 OgZl9Sm83d+X7iwv7O2DZqp7U4PRqMC5HX6qFd5aCbFR4Ynx7Cb9OLNcsOi9Q/UgAd25a
	 rAsr1N9w19ZTw5ORTlt7xnKQLzYPCWfpmmfwMXFHLX1FGA9ncev6F+BOMID/FW9CbjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q1hqcbTG3rhdZx/9gfUyzxGMvtU1bwp4KeexPPpLb4I=;
	b=cElAhGNfizwX76XvYoQOH15V80cpZIGhEPDBkmFsn44rrfT+/Jdhto/pCXaPd4fjNkQ6
	 Mlt9TswmS3D7BLPRWDdxFzL5hf7fCaKbr1Jln3geUzzT7Pap6YkA8SqDZPoTj2qtTBaOI
	 7lwBxzlSvF3gitivhgz+srpSXAPGHB7Or4l/+DYikWodsm5nd99ReOSiGZxPhdQtRtpzS
	 lUJWMeWmY9cOQmg1ju3GegCZzwY7WOel+OoEcLn/uPKbzJ5fnc7epmH5t5zq3Iu4MtI4b
	 CYtRR+1omBC5tfvc+BaAzeVbPn8Xe/8BUt+a8v5s5/5Hv6fojEgl1fqHS3UvjTcV4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqsXKuuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33366606A921
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqsXKuuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3B81F0089F;
	Fri,  6 Nov 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957779;
	bh=q1hqcbTG3rhdZx/9gfUyzxGMvtU1bwp4KeexPPpLb4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqsXKuuf7sKxkUB8CAlcaocNOBAy3l6MwqC6EGxPpnedxOxnr+RntMaPwaz/Ga8NH
	 CTVFj0Isv2xIn1qm3RMrML6cxFGyuk6w7bdM6YQPS9xbx/hyfabLMtZ2L/JTO1HdYQ
	 NN5He+hiuP9QOG7NZYlCJot9dyYVyVKQa0iSxqZitx3ajB1OOmItCehLXRrNa2pytY
	 UQqLu+2ZFaHIxdYhOxLSIqjEwo8gqz4io03xF1rpgxmhedyTcWjj+h5ETekt35oWsH
	 eLmGsW93k0j8dMIy63Zi8DGMdyNK8yxxsHRePmP7IyVUVHOta7Kr67s6ZftKYTCpEY
	 fxlSQoCH1tJKg==
Message-ID: <sashiko-outbox-201127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf tests: Assign return value of ioctl in
 wp_modify test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106092808.6914-2-yangtiezhu@loongson.cn>
References: <20261106092808.6914-1-yangtiezhu@loongson.cn>
 <20261106092808.6914-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:36:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf tests: missing Fixes trailer for test__wp_modify() ioctl
  check
--

commit 36cc478a3007ff125acd9f095ef1c72b59deb4aa
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

> perf tests: Assign return value of ioctl in wp_modify test
>
> In test__wp_modify(), the return value of ioctl PERF_EVENT_IOC_ENABLE
> was not being captured. As a result, the subsequent error handling was
> checking a stalled value of `ret` instead of the actual result of the
> enablement operation.
>
> Fix this by properly assigning the return value of the ioctl call to
> `ret` so that the test can correctly catch and report failures when
> enabling the watchpoint event.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

[Severity: Low]
This fixes a missing return value assignment introduced when the
watchpoint test was added.  Should the commit message include a Fixes
tag?

  Fixes: 2e85d5979e8d ("perf test: Add watchpoint test")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106092808.6914=
-1-yangtiezhu@loongson.cn?part=3D1
