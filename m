Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2827FB18
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836853; cv=none; b=OF4x+duezvHEECBEBmCIhWlqTBZO3AwAC52OXPTYJEfC26u1GlpnW+BmCsgCYhIm61jeXFY+Nv1uxuYBnX+YXS/SRn1f6RrPNUx9ApTdmqnjM81k9kAKRSMT23qIJ0Z4UwQXPqS80Q4v+FiKNLqVBlrwHcAeeuViC3ro27ramC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836853; c=relaxed/simple;
	bh=/nErJv/jUQCqBSBcaZjVJZYU+btd3l4YBQRgvJbA/QI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ThZM+sqb092ifAlDdqA2TmGcCwXQJwLx8+/0mzG8Vs2HEHJWAiHmcCENG3UrqoD2l+KfgQbwi78Y9ejA6w+9EKX9NfA15wRunDWYdN0lA4X3CRV4Mg8iJ7Q54qunYPQTV1usKtA9BGQF1DygKjbVDeKELuVc30uO0iFXKfVrYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsWMODSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsWMODSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8301F00A3A;
	Tue,  8 Sep 2026 03:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788836851;
	bh=/nErJv/jUQCqBSBcaZjVJZYU+btd3l4YBQRgvJbA/QI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsWMODSvtOPVZ6/QWQFBL+iXj68gYCSzRtAXvOgTvLRKFgFfONNQCmz/tdVCjZoHm
	 tPgEFQKcJOPSdBlzzTLsuq7xEdd1bdMpqQe/mFxd7taKk75hn6XVTsJqDfUczX348N
	 KvmMI6Rf7vOwvSms1qssVWF2RStO1FE+lxTcASP3oLlDydcYI1sPIoQwD8Vr38qf34
	 2DHc5fJBcTkcL4LcFAawI7RZm6CIHQLLWT4mkXFHV0NJJu4N8I3DE3hXfOiBLvLnRX
	 erUX8oOvVl5h4/LNVOWlgVU4/Mruw1/txA3LLvHS4U+Oaj/bI/kVyOTqInBAgnWpJ4
	 LOCrPXR79Z2iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/14] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907-remove-pg_private-v3-2-6ae22f9d9272@nvidia.com>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-2-6ae22f9d9272@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:07:31 +0000
Message-Id: <20260908030731.CB8301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A high-order AUX page sets PG_private on its first page and stores the
> order in first_page->private. Stop using PG_private and check
> first_page->private for AUX page order only in the ring buffer and its
> users. This is fine because page->private is 0 for order-0 AUX pages,
> matching the page order.
>=20
> It prepares for a future commit that remove PG_private.
>=20
> No functional change intended.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> [ ... ]
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-remove-pg_=
private-v3-0-6ae22f9d9272@nvidia.com?part=3D2

