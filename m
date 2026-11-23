Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421546;
	b=NbXIWwsu0BoNoHIR+X535REUCzPKAODkTg63aUwqeUYFAMwsfE60d5d3Qom1AlsXrFYK
	 RSMWJNFMGmoZ7kEvFD3T+AQfcr3+8G9GzuBF6tbbta6gvqRqGzLYJ3CWjpsTAGcweyThH
	 I6vL2oYry20FiGcWZu6BMRpvJv67sTEPOFZG3uITJDumpuEwxPRpeo4pBJXXW3BekvzpB
	 lzLq3xJdtN7gQR6YpQvf/DTJaILDpinMocyAZdFlgeijidxvr7jEMfQ8bXoRacRYZNsPN
	 prU61/Okg8WG7uYtw6GiFMaghP7PBwsd7cbsQ086vvqOhZ1IBnljWSiy4Km+WUvbTVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421546;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SG6UG9Tn05dTLUPGOQ6HwaG2qpN4C+RLcs8OK2mHh5E=;
	b=faY8ausGXYVcUXz3Sy5Oi0TqM2aIYkRP4oAm42ZDWliIqwtuuPFvYvsSU87CddYLU7PU
	 /PQOS7NnfMJd0Bli1a6Na9QxK3awHvNliHfWHjCjX5Kr1AXPTeiUXCyPtKNrGL6PdRNvz
	 6LyS4nVeW5oRUJR/zjKYSHJUAM64ZRbNtlj+q26HfxqbJRaKJqsTXq5pKSxKSJGPdYHtM
	 hoGKFN4DuPNQArjlFwt8HY0q1rwXZyQxU6sFN77c4Eoe0WcN3y+lmqLktGTIogHOmHbf+
	 WIfCcXVjtW3qv5Ax9shwLKasp7mQc+kSn6PBKIV+9U/Fmpi6hl/HhoM6Wdk7P1JL1mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVowZEgk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC837606A31A;
	Mon, 23 Nov 2026 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVowZEgk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33571F000CA;
	Mon, 23 Nov 2026 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421546;
	bh=SG6UG9Tn05dTLUPGOQ6HwaG2qpN4C+RLcs8OK2mHh5E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hVowZEgkdhgq+bG4dvIo+BgMqnK5mXDAxMnapIxNISHNDuPW+TwM4z3PATSX0KBCK
	 vsu9bHAmXR5b1DPbYkVuFNd11JN06OhbUQPevr28K0j3NVQr9eU2A7CtHnbxHDocCB
	 L7LJnEIhAP4/BYOmpQKhQtjCGrhWLm6fyfre5qRoBv2dYLKUrGf9QZ6xjdubcev2uJ
	 7VBTmUNQGZFSnbrhDbgMWzSYFtdkpCsQnZZTHXayX2oBCf94CibuItheDMRqMxAGT1
	 H0LGyyZKvHt6M/Y8b9DJqVp18ffwwarOPZJrYXNCqM0wfafzDjdG/eq9as134/Wu8h
	 7tAXOdGCpmb0A==
Message-ID: <sashiko-outbox-228887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] msr: replace rdmsr()/wrmsr() in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, linux-perf-users@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20261123080822.3426355-1-jgross@suse.com>
References: <20261123080822.3426355-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:12:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace all mentioning of rdmsr() and wrmsr() in comments with
> rdmsrq() and wrmsrq(), as the former functions are no longer
> existing.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123080822.3426=
355-1-jgross@suse.com?part=3D1
