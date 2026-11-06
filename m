Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931910;
	b=arhIpxB5H2AG1I3GlNXTaQG4mhbFsmmYRQfQ4t85GIzYoVMII7i4n4sLemDedTRJNoet
	 gaOPd9YEu7fa2bYErV5YC3dENM4Np7hTleY4tvAgUluVP9ddqKrRFtnGhvVa59sf/BKFE
	 4PsVaycMK0pk7q6m0wEgSL2SIwPZ04WLOQgSDKuG+mGPnDHiHYCKtaJjoBxhutCXZtiIK
	 11NnQsUg2E3k8ECoKwoaCmGcdqcIz0qBVr4Pf7DEOSRgt4/K2IndyEFamWBp4IRg9skC6
	 0DdMdP5ebgWTawIXOMVz05A696AtHRlFnyQZpv4V3TqvnAZXUn7qsp99dTCABY/1jaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wcaSiDUuBKKSSTryj0u+Zqg1aKKh+PZ0hg95Dbsr1R8=;
	b=CqMHRuyzYL9HqH/uorjh9pitoqc+I69cTCFkwL/c25lMfvG9dQvCRWryMh/K9sO/UMj3
	 8XR/spS5l2VrCtdZE2F8Jt3BVdY4gECj6tM+vmRcn+Be+0md6bdIDkRwhQDtoGm15IkmI
	 eKvbR0JfZ+T4DAjbfKZOcK9XnGO6ZIUCkrzkn0uWTs+Dg4Fzrk6p6U9yFbG7p4r9xhFow
	 DiZpKaCqfJL7tb6AeNDOFQ4Vw8lcJZsCy1kcCKQZnkJnBpzD8zU7NxCXQjiKbfBiTQIOU
	 YwC+a5qcfcVRtjtJwwRdemNDMAxPw+w+d9r5PBe/t0QikgHQiAh3+g/DOJKrvTtx4YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2w3JQvo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25915606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 02:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2w3JQvo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BE21F0089F;
	Fri,  6 Nov 2026 02:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931909;
	bh=wcaSiDUuBKKSSTryj0u+Zqg1aKKh+PZ0hg95Dbsr1R8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z2w3JQvoc5oa7QV32Fw2a+Bk1DURFSEPiB5XekMj72117iOWGw0pUp//SyLFMwLgT
	 wPZxbYGoAPuSiI2nVcjOSPDvHSQyNqFD/j3iNYTTacaCCAZCHGijIX9m+Rqg/o/yun
	 DLcERzBqyx99ALsXJEcSpMrDY23/ANtskPMnj/0noc9TtF0sCniuTJT4RwpNy9hCPw
	 YeVmwqJBCafyL8xZk4icMs+215eZJQKCFEpBmS3pVBZvDBsjW5uIcJb8DbDofxv3tf
	 q/hA0ZkcboGFjoPi7l7xavYO7qmz9rozih5K42yNq+ZNMtlqFO7EviIy/I3Z7+OMI3
	 wxerrmZeo8c1w==
Message-ID: <sashiko-outbox-200591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf iostat: Reject incomplete and out-of-range port
 strings
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261106022027.2413-1-lirongqing@baidu.com>
References: <20261106022027.2413-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:25:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> The root port regular expression accepts trailing characters and an
> unbounded domain field. A nine-digit domain matches it but makes the
> subsequent width-limited sscanf() stop before the bus. The parser still
> returns success, allowing the filter to use an uninitialized or stale
> bus value. A three-digit bus is silently truncated as well.
>=20
> Match the complete notation within the documented domain and bus widths.
> Check regular expression compilation and propagate conversion failures
> instead of treating a warning as successful parsing.
>=20
> Fixes: f9ed693e8bc0 ("perf stat: Enable iostat mode for x86 platforms")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106022027.2413=
-1-lirongqing@baidu.com?part=3D1

