Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448049;
	b=wuKObt8mSbzwFj6O5xy2Z1UgYD5hGLB4s+dABTJrO3ScWqtgeM519SFOB4RQ/YHsPCzw
	 VpCAhUwUaDoNCLV0pMfWQJuMwL4ycqwoADrkXEQGyZT51U05Guv1MtnOcSUISn3kvcRiT
	 n+hUxv6dzurWHVgfwO9o7EHGlw8MjfO4ylfprKl1BRRTp1DYVtXO7iS/YP0Iw9nsUZjYt
	 TbOUfi/xRKqgo14qXOCxM4870c0pa0EXNbYviTCv9zDwNX/WEbvK8z1IR6sE6oPJ9v8JE
	 ECrAcVR5K4idCK1iL4oIdUmn5973st6Hjub0R5PUL4W3YflmEIgoEkE6wTWKxsOUdvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0OT85V6djpGsyX4Y8A4uiZbZ+uzrGfsmSYbNu7iyB2o=;
	b=CKolNS9K9ARzoF5GPGPvwkPfmBsVHAJ1jIpWQ7DCQbkw/JyEUc8IUgADlyo1VRLqATGp
	 xaQWG3xUjSnh2A44UGETcUgMgM7qy5Kv6yloefP54sLkPKCORXSrphRP1jw8u5HiXqrxG
	 d7xpKuSs4s1s/uN81AQtS3uFrlgWkCTNZU1JDIafGA8XKOGORZ2gpRhmWpevwTp/eWyA7
	 /ojrCKRwkFtdJxrYiNE46oOO2VybLE9ybphhmPMa+yCwyXkzm4nBcofop90gnEyEY58Ix
	 VPEisOhjaWIOjMHxAc9KnowOyDr0pvYPVl83s8xceb9Yxa8P9/9evVlKoFpDIZcLOSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O86KulQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7F606A319
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O86KulQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3854B1F000C4;
	Mon, 19 Oct 2026 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448048;
	bh=0OT85V6djpGsyX4Y8A4uiZbZ+uzrGfsmSYbNu7iyB2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O86KulQI3Pbb2S0sfEXeLyoHSzLQmmZtZMf0nLtQhUKF/1t7oFLHQPMc0n+ERuwHJ
	 eXj5JxRDgyrx/+1R6tLX7Ob6Bxm4DlqK0X7jPTGaPKlI2OEHyVvcuY1nS1P53M+Q2Y
	 cbSUBLLpcLUG411b9LB/HtoUAhcbIMmQiFFvamnW/OtIP6WD4Y3JlL/b/oOxxXJhzj
	 sJf7utHAlO57cJbhh0CNPqseSrh7yfKERmWffgPIciaKb2D0qMjBf1ZQ/4mjCB3Z5E
	 AgXeOlxh6wQ9c6g9FCOiqTsz/dQMydA1MMvXSe+Z5ChFkbVVGNnPGSVWM/q3UPQZ+s
	 KZCTwYrgo+igg==
Message-ID: <sashiko-outbox-178300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] perf lock contention: Filter events before
 creating lock_stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019220915.3943592-2-irogers@google.com>
References: <20261018053710.2572636-1-irogers@google.com>
 <20261019220915.3943592-1-irogers@google.com>
 <20261019220915.3943592-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:14:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In report_lock_contention_begin_event(), lock_stat_findnew() was
> called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
> and match_callstack_filter() (-S).
>=20
> When a filtered-out lock event (such as a mutex contention when
> running with -Y spinlock) shared the same aggregation key as a
> subsequent matching event (for example, contention on the mutex's
> internal wait_lock spinlock from the same caller), the first event
> created the lock_stat entry with the filtered-out lock's flags and the
> second event reused that entry, causing non-spinlock entries to appear
> in -Y spinlock output.
>=20
> Check the type, address, and callstack filters before looking up or
> creating the lock_stat entry.
>=20
> Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019220915.3943=
592-1-irogers@google.com?part=3D1

