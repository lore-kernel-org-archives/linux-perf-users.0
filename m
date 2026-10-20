Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508382;
	b=uxTvScorpiaZBsQ9q/bCGGlZPbe2tkcIZnq4Ym1UFl6EfW0bzNKzHjGom3ppRb6+GTv+
	 uh2++/WqcridoE2cA9v7D4cK3NT9M6OND5oElPvr1QJ852Wp/pcPdtrIYWgxBrzy+Nq23
	 lciX+HBXzisb4KCwqnEX8XEB4rQhuewCIBrINlYM+bhl8A3ifNgKaXTgNslQ6KUNv7Iu0
	 zDAppMu9WMvcUx3/sjEVUP5YozxkZ1pesec90mhcyQzx9n0rT2P1W7MUM7jN+9BCdD8/U
	 l9QDTQbINsJg+RUr8467mCCqJex/AK+fPkQXs/Wm5mx532Z06RHGKJnKBUj7rn2avEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508382;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e33R3MB7M3mEPbv9/fZv0G/XP2ElBPPB/Oy2PdFEW5s=;
	b=jwo+fEK8E0Y0p8FiGDwgG1JQto8ZJCJ3q3MOwLzL63GpfXtMPJHfShiFA2VAtzAikAU4
	 z8uVktCb6iyWF8INYMR2ey1vFl1H0WSdUaxF7XKZd1w8qgYat3j3PExBpTFvoBq7Hqxs+
	 z/Dllpw5Blebyfq/Qn8XxXkaOd2zIkQykAB9SwUpF1/0xz75CslF5iod5PQ0Q75UQBHfc
	 fg6UFo5yZidCbXn036jFZnG8KuSZ8nyeFpasEEPp3iWhgSMQA8jiq2+/yvmGtnbPjl9MZ
	 NtX6Vn2puauPq29rzvsEFKLaISXqoy1B012B2RVE0tCjdqzGXDuYUnOOZqZgssnGZRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5E606A319
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000EE1F000C6;
	Tue, 20 Oct 2026 14:59:41 +0000 (UTC)
Message-ID: <sashiko-outbox-179203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/15] perf annotate-arm64: Support stack variable
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1915e2def1cdd0d85fe91ebc0b9ca227ef7d4851.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <1915e2def1cdd0d85fe91ebc0b9ca227ef7d4851.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:59:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend update_insn_state_arm64() to track data types stored on the
> stack.
>=20
> The implementation handles:
> 1. Stack Loads: Identify when a register is loaded from a stack
>    slot and update the register's type state based on the tracked
>    stack content or compound member types.
> 2. Stack Stores: Update or create new stack state entries when
>    a tracked register type is stored to the stack.
>=20
> Similar to loads, stores also support saving one or two registers
> (in the case of 'stp'). Therefore, propagate_store_reg_state() is
> introduced.
>=20
> With these changes, the instruction tracker can now follow data types
> as they move between registers and memory, specifically for function
> local variables and compiler-spilled values on arm64.
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D10

