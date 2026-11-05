Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880059;
	b=qfEuH6D9VaWqnMpfJK0qrtXRwxayG3mZw7AK3K69vaZ/Ml3S5hXB8fN/b6KS6W4QGER4
	 48R1oNrUqYWMBRb2MyFZJ1N6U6PssQVCjE92MPRPd0djMTGzUsyXpgtCshdgQe3PtdzU+
	 KKVa2ssvmz5BzVRoAGckWFXxQcio5mDUGe6nkd4zTt/gzsG+LqbHQsqLoZhcUFKrjWEEP
	 V0m74rVxjg2Jic7unltbzRfPTqZLCj5EEuZbMvFya5pV8WMG9X9Pja8C+2EZiAgbXBnhw
	 nq5z98B6FumpU9bCMyuiTy2MtazF6iLmYuezyJJbwEsCSqhvJvI4XffA8PcwgiQ/7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880059;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7igIsH72x0F828QY4DPwOKmD+bbx2OMmOR2auTO0JnY=;
	b=R4IKiPE++s/6WeqXmHtd7tYzA7fLoB9G7/0u7Hg9TZzcguMsMPW5gp/aKZxEMGI1aoPf
	 7EWAPMVU6MxE719RZSdRvnzrQVhjFtyqOi1YZJsXIO76Nho69Oz86H/5SyPE4BXuyWvjG
	 4lOWYK84VrFyOu5lJ4fKqqD6b4HpyWJvlA33Oav1QsRIbpfwfrsA2qt3RI4seNnl+EFp/
	 kqK+sKhu/EBgg2+3xUTGmjZ0GhmA2QCANCoEU04yyykNUtws+RW1i+rzJ8XDyaMLQez4h
	 205gcpNEvzA8H6dekXs4ih41/trKJlgMFb71ddd4Wrqr996u3MXgZk1XgYCVDa4PeLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baeDJKMQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47328606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baeDJKMQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F091F00A02;
	Thu,  5 Nov 2026 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880058;
	bh=7igIsH72x0F828QY4DPwOKmD+bbx2OMmOR2auTO0JnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baeDJKMQKSpyufz40m+nLFWuK0Kz6ixHI8Qqwg3DTfwTwDrXwqChuC78umiBQuvTM
	 os5MZj/HfopehuAL9GHJDh5eJ+U3RIWan/lJXQa2gM/SrKo8tgBiGDrCxIw4+8fOuS
	 /Zx3aWzc6ocDsdArjTGwRPTGCzNXD3wrYndzyh8V7u7J7UfbvpPQ07BG2CgTxARgHy
	 Fm3s69jI/aeNgqlsMHQ4Y3FXf0txiFrljGrdpwctz6naJIVI+NGNtZw3SL0BAsh0sC
	 K8MsyMlFrjnhHIKFi7/9WtjB/IQi+v1P5U63LlhfqrF54NF+7Nj7W5kjMbznklviL+
	 I1sCsQtx5fk1A==
Message-ID: <sashiko-outbox-198980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/19] perf cs-etm: Fix nVHE per-thread decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-1-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-1-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:00:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> pid_fmt is unset in per-thread mode because we don't need PIDs, so we
> can't use it as a hint to determine which EL the host is running at.
> That results in falling though to the next part where EL1 is treated as
> guest, which is wrong for nVHE.
>=20
> Fix it by only returning a guest machine when run from perf kvm where a
> guest image would be provided, which matches existing behavior in other
> parts of Perf. The exception is when pid_fmt shows that the host is
> running at EL2 (VHE). Then EL1 is always a guest, so keep using the guest
> machine rather than decoding guest trace with the host kernel maps.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D1

