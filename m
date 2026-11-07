Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048929;
	b=CprfZdUIXa7IRt94ifqx0cx3AtELZVkRIV/q5C6V6hWi5CviYNQn6Z12I+oB/5mLz549
	 TO9o45VGFgTtW3Yp4bKqZkZQYM96dztp6G7NSBNTrSZTMcBQtRRRsmzFQevAuLD7PouLv
	 Q10H+CHrGrZ73dO75/CfbUkOG4uz+d4eZhCPGvtZZBkSxZLrVrgpVQt7CYnxMjK34u+9z
	 LDlQ/t9+o7PYawImRzt3JVITow8IzWKeV+pDxD4Wk7CVhs6DFEQ+lEPWYS+/ZyMjW6aRZ
	 IagswcS4AkURrbtH6xlZ24fam+Q+jpUI0jbN+8c8cF2FLbJ3ql+EAzHIsEdoZPwbkeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p6jwC9fKQHDo/glAYHY9UqDq1Nq/bmtO1Hb8SCE3dLk=;
	b=wvm0ss3zHte9ZNzdnM69h72etqELOQvQXVk/HG3U2GlSZQRqDjFu8r4nCLzj4MMauEiW
	 5Q5OOZ1q0Eg+mzePmg3mMBfCRrolUsr8oorjCNyPVZQSRvQeJ0/xWsRuO5RS8ByLg4Sp2
	 rI+xl0arPAM1MT5AE4SD9WQmQM3+h8zMIaHH9hoFbLz3zIk5h/sCNZ5hynGy1Mzb+yJmc
	 fQ5sAnqrMjRxAynpcrkuHJDzY+YS2YGGzbbabPuwlK5M4xIzjRvPBdUB9vB/nlDqJf8JU
	 Jm8l831VLSXz/pLFyzOVf9apq8dnVQshskDrJVuQRtvp2kwWQ8IYXf9COrTJ9Ji/7JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akWqQoEk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F3606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akWqQoEk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E63D1F008A1;
	Sat,  7 Nov 2026 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048929;
	bh=p6jwC9fKQHDo/glAYHY9UqDq1Nq/bmtO1Hb8SCE3dLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akWqQoEkOIWq7Hf7KZjzdeRFAC/s0/jm07AhlscK/51OpPClLsc1JBmRtGagNc8cx
	 +tE1v2OZ/7U9ARtCxkHay1WYIO4F7kMW5ZVU5ziBe/7kfA9XFbqi1sg6u3P9y8vy7X
	 mQVR5mrVgC8Gtqrzp85+DLUYpDG80r7Oz5W1OyvemAZHzrNBYQKEem7ptXUJ7lzgZX
	 Fv3zWdLdj8DcdVjFxCf0Tlm3ZXsFnrGGfxg1uyTu7T2uOisqsoKNhH5I4nNnJ9EXgR
	 VLor/RXSon3cOucCXXR5OHI/OA1zZHmXenkfbKW16TdIE6qPl5teGxWtmP1eq2Hckp
	 QzjqiZ9uHt4Bw==
Message-ID: <sashiko-outbox-202834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/15] arm64: dts: apple: t8140: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-15-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-15-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:55:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Adds the PMU nodes to all t8140 devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D15

