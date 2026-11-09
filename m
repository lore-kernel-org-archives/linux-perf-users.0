Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223698;
	b=5qsdwyBJvA1t2j0qGHWt/XsWMGZ1aGaHnjhym0Cpv2GTxULzoqYHizMKClJ6MsZpF/4d
	 dtXPmipfXWqH+WdS8TKFzUSU5RsJ09hLL8PQ7zOfabZ+uDVObYqxZgfEyFjwy5NS+gHQG
	 9fp7LccTheKH3koPGyHfBMtAIJpTfjoiKU3Sb9yBzgVPBIAU4Cg+XzhIGHpj9PtXC1vhI
	 UmnXgUsR4crO5c7tMPO0TifAxfoP22DPPDgBUwoxkezVn7Gz4D5JbQiULXjg9IFFjOTj1
	 jrBao8PO9h6Emmmvqc7JE7Xjmkr2eCMXh/Y+vBnySGwtq/aN1sEpOL1Wks8UBeC+QyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rkm4nKPYIHk3D2xKi7rjx2Tf1JK/YozUerB72Ntl/3Y=;
	b=pZASNg4YhnoWkZRTgsA5S1ZtxPgsRBB6MPdM3woPgC5I6ANe6DmVaCcsVzbdDxY2XLc9
	 0vuyxFKHRsGol0eS+ybgaMwIGdCndQhPBONKMkUqKkoGltXzGVZY8gkS8IIvTYOZaaGIK
	 AA2V0Bb9Ziys+mUhwr0hB9Xm6FAbpawxnpr/KtjLqSq+diZsWN9zsTa8167yPSRMhypXj
	 2nLfbTmORsqeZGJvRaiqA3VhmtfMVO/mbvukE2387yvATn84q8p528K/IBTFlTbVe1duo
	 hV4TVmxBXvOhP/kgswtN1kDwunh/dtdrkcPaZKtEA+rQK8zCKkk6vC1UbD1dtm+rP0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+M4p6uz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D18606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+M4p6uz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC9B1F008A2;
	Mon,  9 Nov 2026 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223697;
	bh=rkm4nKPYIHk3D2xKi7rjx2Tf1JK/YozUerB72Ntl/3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+M4p6uzqJgWxvgmBqOu4bKpRKlB+WRMFq6FoE6HMdj8qcAgxBMH35N3Xwlluz1K8
	 Q9ZzrC9w0Tj86r6o/cjOrOp2SklgaFJ6gKDzQXxKA8n5Pf7umT82rngELTTil2lqC2
	 8VA9oFJx3MPGfDUTuZPXB5q8q9/kCzvyPQZnNC61vxyZqW1kouABOC70r4AvdMdEmE
	 RHrjTRifz9zF7apX7K1o3uRZz7UBThoY6W6ItWtQg2d9HgprJjeysIAP4VbmtezB6y
	 +YrSAQ30oZJd//PipLYvk1iRKFn9r58qwHIGEWdR9nZ2hCBueUv5+6lMEIATKTyOYB
	 SuZrAP72jMFNw==
Message-ID: <sashiko-outbox-204870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd: Avoid double-decrementing n_pair on
 failed transactions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109111909.31712-1-zhaogongyi@bytedance.com>
References: <20261109111909.31712-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:28:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> On a failed PERF_PMU_TXN_ADD commit, x86_schedule_events() releases
> constraints for newly added pair events. The AMD put callback decrements
> n_pair, and x86_pmu_cancel_txn() then subtracts n_txn_pair for the same
> events. This undercounts active pairs and overstates the GP counter budget
> for later scheduling.
>=20
> Leave transaction rollback to x86_pmu_cancel_txn(). Keep the AMD
> decrement for constraint releases outside transactions.
>=20
> Fixes: 871a93b0aad6 ("perf/x86: Fix n_pair for cancelled txn")
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109111909.3171=
2-1-zhaogongyi@bytedance.com?part=3D1

