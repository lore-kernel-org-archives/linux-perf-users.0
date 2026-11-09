Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259516;
	b=vmdYMVF1R0PCRM/9wkpLeZGnXteCn6MLtG/aQLbHgvYSS1IGoJblgE3ucBw8OHq5omkR
	 5d4KJC42pSe0xUQ4U2J3TaXEeX2inu+E7rVc+MBClfcIJJYQPgw5mDxTohC1P0l0W89kE
	 WxsX67qaXVthfJ8OHGR7GiGysuJCvaqqIAPTqgFBOVa2BJujNFCDc3vU3a8DeykVkWTaQ
	 axZY5g0ADWmbJmlIyUA5FSjEqP1cSj/xYn/x42w5HccjLxSwYdCthFQcbHuJkUbjV5Ogr
	 VNOjwLrZt5IG6volZxo3E3tuODh+jZDVeggcM0fX7KUth4GFphRFBbhdEJEtLCGZEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259516;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i3fMruZjx6WeGpfe1fkzT7bPIMF/0wXpxYeI9dbtOK8=;
	b=EyJltFv9/LUSPoB++hAZ47uoE9divq2lk7DTb/syOYZ+gPAWu/0bJDezteV7bbYOkfu4
	 MwW4E7MGVWTUQacjWYjsSZ1FeJ3WgbTELoeQYI0DIu1I0myF/aIvrig7I7QTVvEbsJrei
	 nMZ1zDvv+fCbewSfoZnzMKPKtwHc5bdUR3pgYY8I73kXCMsV3cCHgx9Ck3hgi6rON3xtz
	 PnIKHOFXaxoSpyfQW21AL6BD2sRBUyZ3MTOyf87/nuVioOJveUpV02MC/1sndY3aTVEbB
	 pqi04RBi/SxRr1neOem/lfrb/oV0pl78fEWM/yyLL981c54Nw35bdKb5YNDSzAf6DmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3iD37tb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312D606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3iD37tb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F6F1F008A1;
	Mon,  9 Nov 2026 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259515;
	bh=i3fMruZjx6WeGpfe1fkzT7bPIMF/0wXpxYeI9dbtOK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3iD37tbiPwU1U69HIk1tJi1rFaj33Ed/BPjj4TIDbImsbZi+0LNwQzfe2q4QcfkM
	 Tqca0OYem7nThXZih4C5pkTcdIRKr7zUvvWaLn9xW3MFi+H//4o1PXDmE339UezlZ6
	 omrMqWBdpdNIF9P2FOcJTAg1VsNTR7RYl18M1aiit1un7XSZh4MAff0M8gft/1MwAf
	 rRiYsIL2Kz1EKmFvOOpDaA9+mjgEeU3wbngph7ZqAciVHdbcfVk/qaZzpJ8PEybVv9
	 SQVjxgbrKMz2iePuDY0zBC15C+GN5J5aHWrgH2Swz4vcodlgBHgxGcwQX8kqQz0DXn
	 jJEf1ZhjqPUGw==
Message-ID: <sashiko-outbox-205667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/20] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-15-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:25:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D14

