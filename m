Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702221;
	b=PC0qdlW/RiCsy8c8GeDE3FR3TfhtXnozf90wxHuqkhalpf3nl2/VgSACTj8hj85Kb7QE
	 wuV7vweX5w5oXVphg+9A/MQVXux5/bwLWxePanBgVElSI8+NtXHHnSWtiAPauVBUnHqyq
	 J7Jyu7vbcYedo5/g8MIsSyw6Lg7H1f0ssydwMhjHAI7CRbm9T6QKa1tO5AVwbeYSlDijw
	 EVKTS429Ans3/9am1c6KEOuTl33q3IZoodifB2jpAq9O2WhyncepMxX1Z03JQTgXa5JLF
	 KjaT7Ds2yGwN+gJNAHhxlwcBIIwZirzRNLPdbaIkUIzzTzIL3qSqS6GRDjOEzmIgbkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eTzZOjveUMfptxlYxZYeO/xxbwzFmEZcXxRkLULcLDE=;
	b=inYX7+VYgF3UPGSHTw79dbUk7ETBARvYBQUKsPLEEx2REHdZDSRQkvMmOnK7y3GPWHRp
	 Geo43kvGlWSVj8/O3M3uaOZxnY7JRhd2zqfiA5CgVjXiTdl9Awlw3OTVRvGkDekaYIrb9
	 fSo8CBfz/OvOiPJa6nBIc5ilOIJhWAkZ4ODnCUUwWNO1PCwr5mPHtrIRTPhdBbacrYzip
	 7mwCS3j9xbP9wS8cBTedGunPDBy80q03tqS1rv6C9UrZHilKggJ4le95Ik0KyXqdJieUC
	 XyYb9a042K1YXhmMUram5SRa2/gkmIr/xt+9fhZyCBW2xluP+TIX99TPRzzMXJyf8YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oU1ajRVa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1C6082BEA
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oU1ajRVa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72E1F000C1;
	Tue,  3 Nov 2026 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702221;
	bh=eTzZOjveUMfptxlYxZYeO/xxbwzFmEZcXxRkLULcLDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oU1ajRVazFNXoiUu3zqcvXQDsyshoyXoIp/+qveMata+DKnWwcX8dyZ2c1eF3QtYW
	 SSoRTJ3sEnBkAK6H7C4S/5fU5Uvf/5Wz0VZOHHQuR+uopjNM2HjN1RvpVWRZc/6oIC
	 d3RuQ+MPKw0Kbic3AUY2y/IAmMxi5Kmbj8DQ49YwAELUiW9pPBRRkCho/AjiVZp2nk
	 xVXLCSX/VVu7D4yzNv3CK5tkTC/PeQYSsP+9XlhP23iyjU/W3QlNocpSHELHEZtuMV
	 /ah9UdMoeJln+R5uaoL+nfRq2vGUbGpaTjZQC233dJcmtIhb7pJd6a+xmMaOB5HuLK
	 aBpVeLX44KnZg==
Message-ID: <sashiko-outbox-195059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] drivers/perf: apple_m1: Add Apple M3 Series
 Support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-6-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-6-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:37:00 +0000
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
> Add support for the CPU PMU in the M3 Series chips. These events are
> encoded with 16 bits, and similar events have different codes when
> compared to the M1.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D6

