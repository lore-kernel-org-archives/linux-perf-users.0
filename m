Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750089;
	b=cPrbYytm41rG4wPnPPqVSzurwkvPYpqyAatTBAq4F4MYp06WWhEY2ZPLVxG2VqvByyPm
	 QWkMeB36O0jDrzoM82NingSuXZVp1eMRfn2bvqRR1TTpeUgWjg/Uw6Ax4vislvLf5t4rV
	 7xowxZ9GxomUXpaxSBUxNjRIwbs2wEss1FRU/zpFENB52I6RB2OqZyDnl8KOyav5mBiUs
	 9FyFKMxm4rerO4xPbwb9HN+vZoBJ9ogNbLxO8yBz9umJdnZsGt5U5xnpSb3yMpIclD0Js
	 VCgiTrtUC0oURZ3DiHzbpRsiUyPY8prD4VqYMRcZ4uk7Uhjv7fOVno59C8o3uhb86UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cyBpIMbvDPBSZgYxSZ6mKDfDGn9evRiBmyt+riePafU=;
	b=Cbifq4C1kVGfrPKFmKnx9NVuJnvDZvM+PveDhJs3vTRp3YC7Rt1Uw6FceW3T2Nrso6bg
	 hs35tTZe3K8krPpEclVUohqsXdFP8xh6f4xVDjWv8G7FmY+jbDhkgre/srEZ1WKBHSzqt
	 itiwL+skcY/0O1OaPMCAvVtypHdkzR/namj47vW0oJHJVYriQFzVQ/+nC7Qfi3SComKsn
	 mse62jQ8Y33MvuVt2y+uTvyGK8gZDO2SHHoeSd43SAwHHkdBWLLhWTPva0DsHrEh539iY
	 lPFO+4oaKiFsBKIttSgjTFbrMfdIEXLA87Vbo9xp6RNylueLLWD48MFzC6MQUWX2IZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/JX6QfI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62397606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/JX6QfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D761F000C4;
	Sun, 15 Nov 2026 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794750089;
	bh=cyBpIMbvDPBSZgYxSZ6mKDfDGn9evRiBmyt+riePafU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/JX6QfI3wp4YHTo9CSQAIel3IDJ3dSY6qYqmvLXwTwVr3gPVpdE6MBUkrtZP9vsC
	 KOOTm9Gh683j+42gbfgob1OlHJruLFMxJmaRNTWR4FFHM0GS/gJKDTCjR4oCWTo0da
	 ZDpP4OicsdhVCZvQF+D1Y/EYh/tfrMnu4jgMzmwT7zelzcwN7QA29LVBrYVOHo+jcG
	 iLH+qxUBYmnwSE5S+A9R9TQ31CcOHpKTAjDasUAKyikTMPnp6hOwWJBmPLXEdsdsn0
	 gWb+Wbd4PazWbMdlKy9AY0FUz3HKX2tjUU+CY7T+LRzh3aEjcTvq/sfzy/Csmp/Zfa
	 VquX/dAjLbFdA==
Message-ID: <sashiko-outbox-215543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf docs: Describe multi-record thread maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115-perf_fix_large_threads-v1-4-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
 <20261115-perf_fix_large_threads-v1-4-69c9b86b9ae5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 13:41:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Document the PERF_RECORD_THREAD_MAP layout using the structure names
> and flexible array declaration from the code.
>=20
> Describe the continuation flag and ordered assembly of split maps.
> Explain that readers must collect the complete map before allocating
> per-thread counters or processing statistics, and that split maps
> require updated readers.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-perf_fix_l=
arge_threads-v1-0-69c9b86b9ae5@arm.com?part=3D4

