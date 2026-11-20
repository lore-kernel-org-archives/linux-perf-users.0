Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201409;
	b=Ey7PPb14GpRr+nzSJ295v9awZJiJEuyrBwEXhnNjN/AaZLT1PSu4q8i8fcXa80B+U5fz
	 RE1MZ54ACweeuDO2kqeJxptO/6tTCugYJYzUoaCGVU2qk5cnuskjZLQJAsGEy9Rj0U7Gz
	 rRF/nzFDvGJ0cQWxrQt2YzniZIeYTAQC7N5oan7oC6v5K9lSAa2fhVFExwHJHDg+pcK3k
	 OLtnML86Lhui5VUks+aqskmeaOnDGy2QZnEVqTSH9EtIWXRoPkhR7vhPNF6DfR2im8k0m
	 cRXrnLirN2Z8KgvH0zl0k4OkJAq6ipF3LKzS+Cu45dco7OJtDr0LC95j3V6589akGRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SLqAE0R2SWBvo7f7ywYNvLU8V9X9pPRp0Lq/0PU0DzM=;
	b=mQizGpMCBNTBGtgetUV0pdaRPfGmD+E5Nug7fue47O360HmS5z+hLcPvCWOBS82vM3SZ
	 sSOvzmO998ENaDPGJIN4pRWgBx5VKNEho//UkBLlkleSvn8dbkK+tD35JSMx5LRbhQlp+
	 15rR1XxbJk1IRiZ1pdJDirhiseDPng3bnHn0zhqVzc64MV2vi6mKlkf8lClTQFoX+g6jl
	 wqhxaCrSwuizGW6Zo6T8HIQ//b6tP575CRp07tTJtg3Ha+E0yqKqLOXtAASiK1fDlq3XB
	 ZvH6Ah0FwZzfdaahzPwet3a+S4N1LQskaL+bT70zrlbIyMLxaqvyzYqmtrrTG1SFEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnLahg5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07F606A33E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnLahg5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5001F000D0;
	Fri, 20 Nov 2026 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795201408;
	bh=SLqAE0R2SWBvo7f7ywYNvLU8V9X9pPRp0Lq/0PU0DzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AnLahg5iKT+hxnK9fYQ0l3JKJxqQdqmAUM3xhbh11/QOTIqqBAaerOTuRjTZOxTGz
	 eq4bG6+YccHxnT3jiAN2Rv8ZYAVhE+MDFb/bVrlbabpf+3Y00fsEL5vNWwpPg8wznA
	 c2ZMBJfkg49SjGyVDk/CoJONwF970OvLdCm16evfqFYRUEWJI5IOJy1SxtQQg7KOuh
	 Gw8anoWQic1/PfeM5bbzTYZgo6QURm/9cIyU/6HioXxM3QcCB0x38QYNvb1hsF2Kxb
	 A91allJJS7iwIG9xZ0OSMFf+cMAW5xfoPdPKJ/0MhgloDMhJVfQ7seIe2KL587vKWw
	 AlnAflqUiReRw==
Message-ID: <sashiko-outbox-225883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] coresight: etm4x: Fix event count decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7dbbb1306371bed56e3af4dabf88d3c18f471dd8.1795196854.git.aaupov@fb.com>
References: <cover.1795196854.git.aaupov@fb.com>
 <7dbbb1306371bed56e3af4dabf88d3c18f471dd8.1795196854.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:03:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Leo Yan <leo.yan@arm.com>
>=20
> TRCIDR0.NUMEVENT normally encodes the number of events minus one.
> From ETMv4.3 onwards, including ETE, a zero TRCIDR4.NUMRSPAIR instead
> means that no events are implemented and NUMEVENT is zero. The sysfs
> event controls currently interpret this combination as one event and
> allow writes to unsupported event fields.
>=20
> Decode NUMEVENT after NUMRSPAIR and store the actual number of events
> in nr_event. Use the decoded resource count so that older ETM versions,
> where a zero NUMRSPAIR represents one resource pair, still report at
> least one event. Update both sysfs event controls to use the actual
> count and clear their event fields when no events are implemented.
>=20
> Also correct the instruction event enable mask for the single-event
> case to use INSTEN[0]. The existing mask uses INSTEN[1], preventing
> event 0 from being enabled.
>=20
> This change depends on the recent driver refactoring. With no reported
> failures, it is not intended for stable backporting.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795196854.gi=
t.aaupov@fb.com?part=3D1

