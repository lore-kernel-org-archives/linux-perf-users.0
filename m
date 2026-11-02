Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622448;
	b=D6WhaEit2n+HegIzg31+R2OP8vWfB6O4UnMYMjXza3FC6RQLB1uRbM7WN3sFNP2cUjIM
	 68rn5YRxZ39ydqF5iHlnWO7v8LnvIrfOadnHIKJn89Tr1N1fHncoGiNl/+nJr0AXZxhl8
	 LpuGC/NfTHP6/doT88i0Kd2EAQiYAWzBz/pKUR41Pt93yn4Ozz4Fb4Tsw+aEg7ggiZ6Mx
	 41N0sqYYaf4HrclqQsfxhXP5SZ6dXBQGZJPXm/YE3TZkmGkRU790fvfXeU7vhDgaWUZC8
	 fy5TBGJk4CuMprEGEMnWtae0Bh0s8OBrSCM1LjkT3qEgvMTt8+xbnF5B6jcgIvbqAkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vMvg1LKxuTs4gRCYmDmsFqXQJ/wncWzBOK9gwq2Yv40=;
	b=Hqa3rlo4GSq2if05thUU/S8UcJ/FKDUEExHfQgvqnRhTwAMpm6VOFnJVJ9CDKNkVZbWi
	 PdFrrEdvfsMUK9u2w8lLcmrMaoTc5AQQNFGHtY6J0MI2/yHa9v/C1ugrIOkhV+GZV2XmA
	 aC7zro0FB/epw2gaTWXp8JMWAgh4w+dWQY0T6ak+3BWiI0OOoTk+bx28lgD01VBxLdn3g
	 hbxb/o8QSyX+h7C8by7gqCNPJgxI14NNAlIlr41WgaGm6iKTUH86lmE2BFIZJg2SSIi14
	 wjT1emcPsXcnbnqsO3vyG6UUiriS/1UPx/OuBDN80YLZvnBFOW1CUUWNFFhZXAm3uyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgwEBm3a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07659606A33F
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgwEBm3a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CED1F00A1C;
	Mon,  2 Nov 2026 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622447;
	bh=vMvg1LKxuTs4gRCYmDmsFqXQJ/wncWzBOK9gwq2Yv40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XgwEBm3ay8bU+68sWvABxjTGXbh9KanJC1hs60hRyTtwjzxdVnX51VuPzD6LQGFy1
	 fz95zjjS0uDwLyxA+mxPvCpOfbBh5EBed+k87JSmse2lmuvObi0nZIuhshtQsSLM1L
	 a3deK/TI2X3eXMjLFImMBhGvnk9EPOXBx5GltqnaNlooadJxdl7a714ePqTjx67E38
	 U+Uifne14Euir3Dt9XWK7QljLWA05BVqeHHFTFaKiM0aABoDP7o8mLFa/DtazHi942
	 Nlt9oR5BP6mTQZUGN0cWlI5ZSAH61DFqe5kCmBwHAh8daSvt1D9KigqzFYMMJyV2Me
	 2WPEHhKfcVVyA==
Message-ID: <sashiko-outbox-193403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/18] perf test: Allow infinite named_thread loops
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-16-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-16-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:27:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The following test will want this to run forever, so add support by
> treating 0 loops as infinite.
>=20
> Convert i and named_threads_work to be unsigned to avoid undefined
> signed overflow behavior in infinite loop mode.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D16

