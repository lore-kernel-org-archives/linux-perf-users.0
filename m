Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274794;
	b=GNKScqmQA2fUM+u/qiTIGDpiSPqO38TgVfiZOuVqQnu/DvGALWTKdrjG1XvWeT91l28L
	 +Gz3Slwc6xssURqgOyrRYfxJg2igqHyntGgcuk/68wQW8xPXT0VbGkgv2P+oqJmp77L02
	 j55/Pr0q9UG5cQj7v3wJakLm9sIr3I02du6JtTWZo7jDyMzRt0hUHq1Nt1WcOa5DUnfSx
	 YUwL0cvVibB5JUIv0OeWeBclbYLrW6exOsGxXxjva+V9BWmaEDjOCrJHSmmkJ7AdkO5YL
	 idjW4gxp+XaMRQ0ER1tQ/cc36yKQBBbdIVeVSO0S58bmuIfMnBQwk8DrzZ4TB0m8Zzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q7ukDL6/fgORj24YLULVo1F9ZbCPn/nQD6raMhOBBpY=;
	b=LhXUOxRHak3hh2C3qwIkufcr7Zk7q6wfGed+bpaL00FC5i/4wOydDf6RWE/pr+S8v8w4
	 YUwSgQdgxveM+7D4nIyeDsIkLk3VWvaYyqTBZElWYVHUOA7mKO2MZ1CYi0D0rrQm3R56j
	 JX7Eitpa2XT6GwIsMIJnxtwIAgEBKWeMvSGroKc/4Bwljo1WD69AXyIAjqsYisKur+nKx
	 LdjjBYaec74pQqFTHHP6bAL3biHxM5Lnn/WVf7xoxMjgJDtr6ycb19T6Lv4MeYnNQaLZo
	 ZwnH3XgpTP6Z5OBk9E4tmeOswQVJVPLxLkqEo+t7cyQKDAYrWAOWgGrpqfTERpMwU5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTTTxAy3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FB606A32E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTTTxAy3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6125E1F031E5;
	Thu, 29 Oct 2026 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793274793;
	bh=Q7ukDL6/fgORj24YLULVo1F9ZbCPn/nQD6raMhOBBpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTTTxAy3/IBca9v/DrEe6ZHXwLwojgaQEh8BU/KCQWqPREGhrei++cZkgJQDMbHyh
	 sfgUmUvsmRUekpgVF+jahA1N8JHzqmzJBgqC1fSBPDY6+G7ZgsIAuK7Ledi5wT4kFV
	 3eLNrQoOGcq9mPqqs7DyN/o+UGzp0wOBIf/iXmSe5vfvcNXv9Z7TryxXKZXLZcdhaf
	 jLN+L0CXboCKRftaYoN+/Zs9pS8gQEdoWbu/FEHaduhNrxy6hmjWlKmcqwThngrNww
	 8tFv09FXPVWKQpnHEr3pL95/0SkB/HMXV/W/Uua03SL5f+abel/tkSxOKPe4NQEH/Z
	 WggyRwdVJqEDg==
Message-ID: <sashiko-outbox-189224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/11] riscv: add SBI SSE extension definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-2-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-2-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 11:53:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>=20
> Add definitions for the SBI Supervisor Software Events extension [1].
> This extension enables the SBI to inject events into supervisor software
> much like ARM SDEI.
>=20
> [1] https://lists.riscv.org/g/tech-prs/message/515
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D1

