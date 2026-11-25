Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635513;
	b=KuzcinvGgjN16ZDsIP/WMNpEf210Jy+JE4X+LIsdqfUuf9o4B6AB5JdUjPG0PWxR8TiE
	 DvPV4ov+w7EqVFKOBviiONONChqLDaB7PWZNfypXkAjT/kHIT6VFMrThg1lGrulbfc5rv
	 FUtKKzMspW8gQIKj0vf6w6We3z4cv3ja9dJxWUvY06/sCkRj9oT6myzv5gygg20uou/AR
	 NMpAgsglVkjxSjU0fZwoUq91F0F3dQxi2LwjCCcSkoTbCSLhvbvWLKEoszItFren7tmMu
	 gqdx60LGwYgVD/EZXP1bU8E4oA//Wfh66eFPOAzB+PexeTxiOyPavxt7lUOIhQMiTrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635513;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aJFiNwxIB67uSAcumjkkxrWHh2JFNkV1UeRYQx7r1jM=;
	b=M+AcG9o15zJI4lmvbO0ACFlDh7RKdXVwVJpoGl/zGkoAe/KWbXa04CGKmqP9SP36IQ9K
	 2RVm+gdI2W/ryhwFwb938Vm2hT5th/c74avZTtPbLsvtEDjefGIl8xTfkU5NyhpT29l/Y
	 8Zx4bWKIedtoRqqbCBetw2MNy99cM8quZY73RxLx3d8GaSIu7954hHWrZ8d97X05gYQEu
	 SsfwJO+/k7YRXw50sc5BxgtgjMJWsCD4lUrrCXwqo/V4jmh9OwZ9Swf4xuArB8ldX2boX
	 wBYx/ay0v33O9HVXf0VkRNUxGZxmt7dCH2HmH9ACgB7NkL8MAhO93JzenL6d8mbFWXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4u2ehvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC6606A327
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4u2ehvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9370D1F000C6;
	Wed, 25 Nov 2026 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795635512;
	bh=aJFiNwxIB67uSAcumjkkxrWHh2JFNkV1UeRYQx7r1jM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4u2ehvN05OtT50nzBx8LGLzsqeC+xIl3K1eMU859+RKo7Djv2cmlmwCwMOEYjdMc
	 XCj6mCVYXIkE/O/jUnth2hqrTCbAxjuQebFvfEhU7Ghr6FllgIZu5q7Po4qG4ln0cm
	 8OvWDzl3HbIXFdrHTOiIEZbVeKtCoUqCiM4CA0PHKf5jqTx7tYwQPFUZ6VwdWJWe8p
	 /o+8pVFf5T0VXvUu6sUfiIm5Bb/T22aPNs9zwMTX6qYJ+n976yBk64Wg1x1AAgR4cm
	 ROiUtKsVbTvn5SLuZBGNWQaP/tu7Slk1Yk0cKhjLSr6Az9iuQleZ72Mbl5wx92VkdY
	 hyiwzo33riJwg==
Message-ID: <sashiko-outbox-234079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 00/19] perf coverage: A harness for perf, and the
 fixes it found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 19:38:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 19-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125192312.3413=
4-1-acme@kernel.org
