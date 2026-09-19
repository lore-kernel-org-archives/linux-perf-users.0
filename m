Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219838DC45
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779911; cv=none; b=Csx0omyMzh7e/5jlzy+y6UTB+/aF9FKZKOK6zC+s4xQmLKDp0XeStjCuQh7lTRbOe6Mjw+HrdUIhWusQ7LBoLX5CNj3ADSkRqcb/yXPMebgh6C8pZFhq//0DDYrOLkFdN/nTD682HoGe6Tr9vCCLt+KVUAeyGeC9OBVSqGNQ43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779911; c=relaxed/simple;
	bh=hZzfsM/uZ7OneJBZYD2Oui02OLuDNQBLvrYub7qZ950=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AkAcsM+1+KustYsVgnyo6cE2SOLAyfJnjvHueHI8OBNohgMLnLE18KoJNQ3RP+B+rvC9ZsQUtI1QKYWBcdmcBVgXLQP2b8Yq1yTTEGfjuqSRYl1ZCgRiup1/DBLOvBTYlVSLenLx4xIpGA+lPvR5+m6EisoN2InhqOudILdUx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAKkJ2LC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAKkJ2LC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9C91F000FF;
	Sat, 19 Sep 2026 01:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779897;
	bh=hZzfsM/uZ7OneJBZYD2Oui02OLuDNQBLvrYub7qZ950=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAKkJ2LC/BTlx2r/rc/Vwr9NBmBc9KzwGzMQ8eQ9QDGq+Abgn5IDW2gGoISEzoGOr
	 IeCvvMU9nT1hhSIq2vUip6cNsdLe1gKo0If0QAFZlx3SVuKBpmcesMZnBb8vR97YSH
	 Rf3cniuZ0LJclB/49/Q3COpqiyTte2cPcBv3zsEKvDRdGa4W34Ti938ztktXe2U148
	 kknXSJuqEGW1UqKPwmZVkriWQhfsLoKywdhBqfpRsDpQTZhPVR9zXBU0lWkrtT3+zF
	 FQKQ3CW2s2VR0iyXXy8FoosQapeCnV6/qDkPunhgplgbNVT6nn3c9R+RLXu5yX5ecN
	 vbL7/xctmqvxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 7/7] perf trace beauty: Validate
 payload size in augmented perf_event_open beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-8-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-8-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:04:56 +0000
Message-Id: <20260919010457.2E9C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When pretty-printing augmented perf_event_attr arguments via
> syscall_arg__scnprintf_augmented_perf_event_attr(),
> arg->augmented.args->value is cast to struct perf_event_attr and read
> without verifying that the captured payload is large enough to contain
> at least PERF_ATTR_SIZE_VER0 bytes.
>=20
> If a malformed or truncated perf.data record provides an augmented
> payload smaller than PERF_ATTR_SIZE_VER0, accessing attr->size or
> executing memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0) reads memory
> past the end of the available buffer. Furthermore, when attr->size is
> specified, accessing fields up to attr->size without verifying that
> the captured payload contains at least that many bytes risks out-of-bounds
> reads.
>=20
> Validate that arg->augmented.size is at least
> sizeof(struct augmented_arg) + PERF_ATTR_SIZE_VER0. If attr->size is
> non-zero, verify that it is at least PERF_ATTR_SIZE_VER0 and that the
> captured payload contains sufficient bytes before proceeding with
> pretty-printing. If validation fails, fall back to printing the raw
> pointer value.
>=20
> Fixes: a9cd6c676685 ("perf trace: Add BPF augmenter to perf_event_open()'=
s 'struct perf_event_attr' arg")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D7

