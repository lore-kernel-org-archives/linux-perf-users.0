Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157485;
	b=NWFBVrYKvXWXKFvh+vM968CLKtce/k3HBjQC1oM0Rt/sjJxVdnS8bWp61uC2IOFYdWMJ
	 l761EM69dLIdwkZYttXow8wxtBkF+oLjThQhJ0H0wds7mh7JOPP6ol6UbMH5EBzZt62Jh
	 aaa8zpb9n6Y6gTGFDMB6l1Lm7Lbq6JmpiOOCRlmrFQBxVQhdfdtB99W4QQ1GCxYFm/eo0
	 QhhhOrwEjM6AsHKKjtDAQuozmeVOmKKYWegD3DOsv/UlqBtwebwCJVFRpsUDrviGD8ccP
	 wFuqQso7L7aAuwETcYEpdainU9yfWMeOBv+W/MYVgOtxcr4bwdbGF2Sj2nlfaFc34BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xMPVgvHutwpNLNKnLhWU76QNUs2jHJt45FQpsb87O5Q=;
	b=cnyvKMOwc67Ji7TuW3E6eLaMuWG0kwmwyCMJ4+8oJzJhyZQFp7OMTrUK5D97BXCMDlB3
	 Bx/ivTUSxoL4jgB26d0tvIZ+d+FdGX3HNU9Mhjx27l/NFE0oI8DfN/a8jxsjWLh8QCGPZ
	 KF8VIXRYVB3fblvbvO0HHnYIGXDv0uGMMP06XJLvvHKhptaiHeFuoC9eU1DOg8OOL8J67
	 2FZ6VcAHRkLq6Fyuf3EfF3buGCAH83M5ztzHyts0frs2IYN24yoZvuscTJrnOj/wVNeJf
	 Xlvxw94oInOw6zcE8+h+TYzZON9rSCk2s/azUL+Z9epRJ2JW3Al1I3QmOv8BnJTm1LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8OlGj5C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AC606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8OlGj5C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DF81F01828;
	Wed, 28 Oct 2026 03:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157484;
	bh=xMPVgvHutwpNLNKnLhWU76QNUs2jHJt45FQpsb87O5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m8OlGj5CjfL2Kqgzhrdh9MJe8lA4n3HyttaYQg65D2h+lZN9frY8EJBljh0evVXEv
	 iHg1UahsvV2Gop6ipVhzlQzAyvNrE5jJuQ4wGoYiRN60KX9pBdgV3dzIur/mA5oJpr
	 8THFz5QOfRynX12iIE+I4ffNtfswwdoQf+UiFYnDV0s2IdyP3DF5WI8EGpI10ZVQ63
	 n0p5Dkwv6+nT7Vv74wiP6XCxIacV6DFQDdUIorvKN36hFUrhT8UWPMLCaZ+lZf6Hfb
	 ZyBdRq8XSV+KAmJFI9t2nRw+lSwTZCTF1sFLaSJ9F5HIDUvNt7v6gy9ASrj3ehutU5
	 zeH+mxtTWCTDQ==
Message-ID: <sashiko-outbox-187410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drivers/perf: riscv: Fix racy hw.idx use in user access
 paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jinyue" <jinyue.li@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261028031119.1485928-1-jinyue.li@linux.alibaba.com>
References: <20261028031119.1485928-1-jinyue.li@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:18:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> riscv_pmu_event_idx() and arch_perf_update_userpage() are called from
> perf_mmap() through perf_event_update_userpage(), and
> pmu_sbi_set_scounteren()/pmu_sbi_reset_scounteren() run on every CPU in
> mm_cpumask() through IPIs sent by pmu_sbi_event_mapped() and
> pmu_sbi_event_unmapped(). None of them hold the event context lock, so
> the event can be scheduled in or out on another CPU at the same time,
> and riscv_pmu_add()/riscv_pmu_del() change hw.idx underneath them.
>=20
> Taking the context lock is not an option: perf_event_update_userpage()
> is also called from riscv_pmu_add() and riscv_pmu_del(), which already
> hold it.
>=20
> Commit 3fec323339a4 ("drivers: perf: Fix panic in riscv SBI mmap
> support") added hw.idx !=3D -1 checks to the scounteren helpers and to
> riscv_perf_user_access(), but hw.idx is loaded again afterwards to
> [ ... ]
> stores in riscv_pmu_add() and riscv_pmu_del().
>=20
> Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in=
 the SBI backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028031119.1485=
928-1-jinyue.li@linux.alibaba.com?part=3D1

