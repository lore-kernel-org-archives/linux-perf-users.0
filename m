Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435542;
	b=jrqv0ofmDMMgT1aekt2PxMHL9Xo5GLoxQyyAU+Rmqsx7yP9xShghERIgYVPjxT/nsnhL
	 8uWDI2otmEWcYg4owGU7eJlWm+ul8TC2ZGc3+tLs0hNSSvTX5yaCZUDzYsNQOMtR/9Wr6
	 sDNrYm5wR2/7lEZdpb5VnkyeFbiJvT9kY/9RF/i53tzlMgxqbGeDHBl/wj9woe0vrM00J
	 nUUaZog0cLD2npiz6TumgwvZNeNMYKvTPysXfcTsDAd8QVqGMXQNddowmnI+xt22ifkCg
	 iglM6dgYJMrWtXiyR0WCVg3SfnpH4IFkm6QlRkfbZHUWzEaqw8wq/1qSqdUvbyyltIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435542;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=imkExJEfnTtYQk0sm5yTDzBU5TLRZtJFfxOOrK/w7IQ=;
	b=jSnRoGxZDrukkF9pEWQQB2CDT55n/FL+cpNb1qB+cVvpjMFhFTyuZdLlcV/r0y4Ei5TV
	 ZiGHcUOqubkk+vJMNm24jg9dBko44+wbWHaGSkaAycrGef1/uv1YZmogHTkMKE2Agpsmc
	 Y/FDUNiyWbVDTKcmbuK0smJxttIPTDPUCaK/ounxs1NudJs8lWEuszecOmZmDFPZc/cLm
	 XwLJ0YmHRu9Bv1igkjOIV3ZqbqguSIxGIMYE2ZQ/iVdaolXHqXtYQh61V4RWzkzMRs98V
	 /u0cj9LW0PGycMGn0OaWfS2E7rSNPRSIpW8sjqcy0a8wz6rjLd8X43692FMrIKNRVqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5ykWG9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE36606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5ykWG9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F408A1F000D4;
	Mon, 23 Nov 2026 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435542;
	bh=imkExJEfnTtYQk0sm5yTDzBU5TLRZtJFfxOOrK/w7IQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5ykWG9z0twL7APaeeffiZbWC9NAET4U0YGk1ewr3o60gwv/a6ZKpo7LJi6aDdJ4T
	 RRZcMILwXGBqNlx/yyLNef7yk3ial4/7dOtAIrAPM0XIFr+ADFWffvO34QT7xXnrMy
	 SgPxcrv3YUCqr3ZaB7aAq1JCE9Ctn0MfUZJqQprnTiECRAGfEmp3sRgSv2Echpvfc8
	 LTaia9cuYhn3MBeGIRLgbfClYYvh0I9AEqm2nMCKkmdlTlBW8RvmDncKIrA/GoynU0
	 lYWvm5HYXANCpCH4YQtaxrpGEGWj0VWRsmMHGnFASHa2nrZxAWXbcIQGo/55w4L5Ck
	 gnqht/Oibzgow==
Message-ID: <sashiko-outbox-229183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 0/6] perf: add PMU driver for the MIPS Coherence
 Manager 3 performance counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
References: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:05:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 6-patch series:

- Patches 1-5: no issues found.
- Patch 6: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-i6500-cm3-=
pmu-v4-0-5a9f5351688f@mobileye.com
