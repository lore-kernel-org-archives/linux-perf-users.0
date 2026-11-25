Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647598;
	b=jlffbgLy4FJbowIEEOHZef6KVNjlFf3aB9OBMvmVsrJ9wiUBwFNIwySsR1UvAujloXRR
	 YhkXn/rUIWVPfa8xiCySdEKB+nT10b/KNPKFn2+241OvhN4nA75UGrDcYBfUcReVH9n0i
	 zOUwFHDDIEHNCxrnayUx4X0RL3wvriScmBGaBOfAMszVYpfNnM9gyDUKq1AdOOlBQ5d2Q
	 F/vQEGqzpaw7jmIP3/VGfVkUt4z93XnFLVP1qtXjDyddf61424t+3SvOaZfCtxI+1f9Fp
	 Cf6JCzr/zt/UMhBQ9gKTPgBB21O4mv9n12h99J+cxo2jl/WGULNsxirJ3T5Rc6BX6XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cxbs8h8lhkAMPEIoY/rOefzXufbMhNtOizfFSF5kYkQ=;
	b=q59N7bACxVb+X9GQD7zvFeTrpH3MVvI99qVR1nEKcZ1yIkgFvI/ZA/jkeRr7sK4I9HbY
	 cyfIYF7Oqx6MjTxJzWX9elWrmaVmfTu5fX+sabp56ZfUO1ZJcOiM8G8IUORUdtXi/nahm
	 wY5fbjdpbRPhg+LR37hH9khAl6AtKa4Abet+3I4BPs5k3sEVtAO2rPKGHqEoIeDEYLA8G
	 k+7xIDm05odhKFn+aPrpwQr4zDg26dYhoPks/ZlvDu4i7Vtl4RNQRiOuyeBFUiroMSxz9
	 4yZYDNsn0HCqENr31VdAJ3+OXc7kUVaUJcansvbCsgAMXXg4NmIWTtHjyhStZx8am5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHoZRT0F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0D606A33A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHoZRT0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690B1F000CA;
	Wed, 25 Nov 2026 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795647598;
	bh=Cxbs8h8lhkAMPEIoY/rOefzXufbMhNtOizfFSF5kYkQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CHoZRT0F1J2F1AvGxGzvPPOD+TN5u7klkdBUEuwVeQn1Waz9yJb5X6I8ffsj0ZZ0h
	 r233LfJbFAIag2ccmVis3dxHo3CFBcwQ3Mgn1s6cEKd0XYUpuoabba1HQ7vfxdBs4v
	 ZCdysjMap/7n39jeceKgrx80Uu9HvBa70K4s6jGVKPg6ddSbnoC+k5eXT96ANTHpPw
	 WFs2ZM0qoUZui+jz7AlACArKK0AqKg0AcDGILQIexQ7ejPq0gGzMWhZw0rKUrpOaok
	 hPno6LKKwNfM0JCJ0jR3oqrcupQqSXu3/6hrKA7kmWhrvOgDjtw66tkPG7qVHwKP19
	 xlCCTeY3zo5yA==
Message-ID: <sashiko-outbox-234342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] perf stat: Refuse a group mixing tool and kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261125222725.2554455-1-takano32@gmail.com>
References: <20261125175450.2373258-1-takano32@gmail.com>
 <20261125222725.2554455-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 22:59:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A tool event has no kernel counterpart: user_time and system_time read
> /proc/stat, or /proc/<pid>/stat for a workload, and duration_time keeps
> its value in perf itself.  perf-list(1) says events from different PMUs
> cannot be grouped except for some software events, and the tool PMU counts
> as software, so a tool event stays in the group the user wrote.
>=20
> The parser splits it from another software PMU's event, such as cpu-clock,
> and evlist__check_cpu_maps() removes members whose CPUs do not match the
> leader under -a or -C.  What is left is a group that cannot be counted.
>=20
> Before this change, with user_time or system_time as the leader,
> get_group_fd() handed the procfs descriptor to the members and the kernel
> rejected each with EBADF.  With duration_time as the leader there was no
> descriptor, so the members got -2 and failed with EINVAL, "broken group
> leader" appearing only in the debug log.  A DEBUG=3D1 build asserted in t=
he
> [ ... ]
> Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
> Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
> Cc: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/all/20261123071913.653315-7-irogers@google.=
com/
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125222725.2554=
455-1-takano32@gmail.com?part=3D1
