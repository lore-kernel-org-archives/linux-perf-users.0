Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622264;
	b=BNONEuOpcQdJWbpUDI9tE6uzjYqwWZzo9Kp4lZTks88Jw9Ns28nUCmsMtD5zNj8IxBGt
	 lr3W8i4+nUY/M2K0Px2nt3eYU+jfPbHgmB1qLuEyItM/f5QudKWuUjcFnU/UjaXuQDCPb
	 lvAOvupsPHjLGJGrr6RonXlAJ6FxpGeYEUyjqtVPZdGuyOqWFOw85JkrqjZTWWCPLTH86
	 8Rsq868xEDaEz8JSf9294O+X0mlw6ikY5wh41aB4OHzqXmfCQKFEZarwTntV7aeT87j5m
	 RZr2msEBsVNin3tc8LjeW4/5CcGBE1Gr6XQ+pw/iNB+cpuN+iGKyWPKywlb6hh4tMJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YvxryozxiKSFuAkV1guKy//J+brTN0Uij8OM17+tuQs=;
	b=J7p7OsrCLYn8VKfXtXMsYAlCYDJaBmGDgXn6O04LHaTFSug93+q9w1MEldn/cTidkRJh
	 msWdqqbsR7xntUzmkE/4YCRJh61AaohLJmRALQV2eo1NO7kUyOZfbVOLjLHM9+44e55Wz
	 ciUbsC9Gh4OhPzUHNJoOfInLHVjWFJNHxdjYdnU2GjiTtfjv4G21YFM5OT4+2VROAYN4p
	 bHEsyY/DjrqA5u9s6VUqW/x1gHDYpSgm4gZ24CuEouiVYOlvGthsjwGPuTTPy7jVa7yzE
	 xybg1UzcArUxlJ5PKk1rHP/OHk+fiPGxbkdinEOtY+kc7o86OoXkQ+nsOMg0NhRL+rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoTymIKm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DF606AA2A
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoTymIKm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAEA1F00A16;
	Mon,  2 Nov 2026 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622263;
	bh=YvxryozxiKSFuAkV1guKy//J+brTN0Uij8OM17+tuQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoTymIKm5QvTiDAoU3XVF+NcA4Dw4X8H3PD+M2u5A0H/NUCMQ7PJLpAzDlDYNRals
	 LC/T1NfkzD4UkzmX21HghumOsT28ZkdVAF9UWmeULLrJDjN2m310+IowCZSiy1BJIo
	 soViP/sGUGYN2AtGPvI2eiDFOQoGmR4eIn6YVDkApInRpwgF7FFGI/fnSvk5b4Nedo
	 jyGxahdhjv9S2QBRy97TMULMcT39dLEeZ6QDlWCDfn+QfVf5TqtDoo/yAYiJqCndFh
	 TBKqcjA6V1ONtqKs+MZXVaVvSY/ra82GXTQZSx4T8ClA8PSkludlTs55qfgQI8r24f
	 voCOd3gAJIJLg==
Message-ID: <sashiko-outbox-193396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/18] perf cs-etm: Warn for invalid timestamp option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-2-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-2-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:24:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Instead of silently returning an error, print a useful warning.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D2

