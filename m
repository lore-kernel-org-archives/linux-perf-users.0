Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941610;
	b=bmKE/qywyMFlF517p661l5LVNGf7z5dy0W+t+ccbXFjiZqoHG8jvAKn2qcQV1rfFB5Ys
	 KYxDCNOcuGzL7JMcrLE2GbJwUz9MdREMKPFrzXxim9mZ+4BZy/2R4IaDmRGS3FvdKEhRK
	 JUb0BZ0/iT3Rq7uhLw2QP+3X6LtlztERxug/xVv4rSSslLKun5t/YKfZU5RJSqCtpL0AG
	 /Shn1Q1w93k7FWZo3UWuI7quLzNr5bgoG9AC7v9BO1ZAHRyz5P5piKUuIRWLSqT7i15E3
	 z1yaYh8T0i2SKiSZZgiSjnAnb80Z65UFPCmh7vxx6eOLRGPegSdR6owYuWTbX9hL0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941610;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JlBoRn/z1dhB3GkDjt4t38ZhySPvyBmUwIOXrTC8KZw=;
	b=X9f8cm3aQSGtX5uPQMjUL1zY3eXXOI0yK58KXyQLdsef8ERF2SEMTWMJ2ziamZhtdrqJ
	 ZKE2xVnUKajyksi8nspfxHX/3aM4+14kK45qB1CIKXdhOKLEsm4qVhXXE/dkp1rVjs3I5
	 6TFen3n1DC2QTK3hWUkMdNnAEB8no/CfulWVEWq0wAZxkQVANk5V9XXdNNbt8xeBaSkrs
	 zGkxBm8v4tZ2y1prchcGJIQLFYTM2Vz5HYEsxilD4ekpDENZRf8YCPHZdTt6dx6utbHM3
	 3gBwUW3oXHY4KlO+h/tZ/pVHx2rAFOWnxS3h0IIl3DB/4itrDfb3vjGWNBNFuJC4ngQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2U0c+Uz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F7606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2U0c+Uz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EB11F00929;
	Tue, 17 Nov 2026 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941609;
	bh=JlBoRn/z1dhB3GkDjt4t38ZhySPvyBmUwIOXrTC8KZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E2U0c+UzTTNu5+DCTzX2UhBkD1BN57P8isrZMJL0i1V+qdOmAv5lIX+42lf4RDu/F
	 17KkT7NUKppICXDFA+12KiQ53T/rbJ/akU16tzHCDqEdwC/JPdTRtZWREhFC4GYvmR
	 Q6bRFD1t7pa4K327in43IXZtwTkVXSA51KzfKu23XhGeKnlJpLl1wNqJOVRvL6mfR6
	 +ug1EvEq8M/aH1xfHLXAcchcU++0sd/i4nswmNmIx26KpFH4Y6SticqLFC5MT5DEJY
	 8QcO5t4aZhtixO36gtGSe8vPO6AXxjFfzUaBXANRnh9+fO6X+kBHXg8Nkjm3QB3Buz
	 ekVhD0WdGeHHA==
Message-ID: <sashiko-outbox-219402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/23] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-7-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:53:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D6

