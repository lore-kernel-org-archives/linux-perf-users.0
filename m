Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789032;
	b=2F585BfJVoaDOQi38Q/Q6JmX92aCZYvJAUbZ9520KCUd2bX1bbo2mrd3aaeY88bXoRZc
	 oL/739821VsEdQgVeWC0KutiAckSAtfEBEcz/QxDiTrqwqYhsMrKIcgGfLRQ0xBxCuYOC
	 oZZiJbvwLxR8yKbKmLOB3I7MyWMvL+h7+u26Iw46EQ8FV97UnUTkeJuzdZKyMHDQMGlmf
	 akGpEy/vM3cauw2sG0BYunT+nNEOmliqqWDCo1jTlO5redAhZExVnXbJvHGtL/GLhrTGL
	 Pthqx1VAburxkomhxW/87zewuvwOMzLn9e3wHocbWnozbW/pNrC6ih6Lak8haVpLNJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wC9i+X+A2S6j73x+I2d53S/0u7ZyQZrTLYiw07x1HFI=;
	b=0NYVxL46qLNsBtV3dCQni/aYLEwI85XRuTeHxuoUvSAUgJN49Zet+r7vKkHCJfuhs9zM
	 4mVzzdtvKRV08dFrtwvClO4gEBFGOE66SH4aP+xPwTI2eXAIsV8vmBMT/yX9oqphLZws0
	 /AciMDPIE0Sm6RbrcQ83Tymzm+r5Pw7IBb35vSZPVgxkMCggOrjTqTH8BkLN20HVDL7e8
	 UhMg7FIT6YTuXxZKNNbBcLMdEYgBilcGLG1lA45YAArXd3AZGU7aRRUs1QwUYHKBzZIDH
	 nOklc8bZ5pNZAuK2J2RQuR3/rXoV6Qmbr3wxyBcJ1FsnudkxCs+PrdWFUgDJu321AgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDUkJt2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E9606A336
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDUkJt2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CA51F000C1;
	Wed,  4 Nov 2026 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789032;
	bh=wC9i+X+A2S6j73x+I2d53S/0u7ZyQZrTLYiw07x1HFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDUkJt2YuBVF9kpI8XzWXfFVC0GvYco5K3l6AoYkbHBKJlNglqt8DAH6b9LecqaGm
	 AIl698j4AZrvFfXkXjWZd8xkjEcyWS+3v5t9vZegK0lY4X1k8D/v3mYMIVRCUXKVKZ
	 g+kH6O9Bekh1VqTD/RMcibuJMp8tLFFUPk5AQLwj+o/eYqLOCg41k+QInzMsrt/mV/
	 IMhjANuc/Cvv7fHRVc02cxPBW8BabfovyumIjlZWP3QKE4x8210Qw4+MLsRlGPjC7C
	 YSVJXXGmzRBg7zLuiiAic5o489HvtTXR3Cn6zmGYZ0XnpuBadUd9ABhLxP8T0EJ81K
	 7Rak2PUxPEl7A==
Message-ID: <sashiko-outbox-197115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf evsel: fix buffer offset when building the EPERM
 error string
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104103607.1903-1-gubin@cmss.chinamobile.com>
References: <20261104103607.1903-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:43:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When building the EPERM error string, the scnprintf() that emits "No
> permission to enable %s event" uses (msg, size) instead of (msg +
> printed, size - printed) like every other line in this case, overwriting
> the "Access to performance monitoring..." preamble and truncating the
> following hint. The message shown to the user for a failed open with
> EPERM is therefore garbled: the preamble is lost and stale bytes from
> the overwritten content remain in the buffer.
>=20
> Use the correct offset and remaining size.
>=20
> Fixes: c1034eb06920 ("perf tool: Make perf tool aware of SELinux access c=
ontrol")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104103607.1903=
-1-gubin@cmss.chinamobile.com?part=3D1

