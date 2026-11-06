Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949183;
	b=UdcaFCf2RoZAwtIOawBSmlmlGEU78x5Y2vLLQghPIJ/Q1AHiR216riqNVJ8i5ovupwn5
	 vSY8u18H9671An3CFJUMrpvskBHs/80R/0nmma2UurQYOmt+aRJx7W5g7/ECFurWT5UnV
	 LBDY8vL10H6fpPANBwGa86iPO0Gt6zDcnZr9v5LCgvJviscGEcaX2WlCEsPOziL4YaaVM
	 JyLMThUbTS9ylgWCjLeiKhvnp2cLHUtpGv7gCORh0HZSxY+wwRX8JnrfrAXdIyWU3mqaZ
	 LpFfKU5F2tHjCcDauRWWLXoc4gAg6sDg50rt86tBsDlyPWyTzCde5BDivFl4/oLxO8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H3SRB8FWQTIDpCRyxrVWiF5KnroqMrO7wFBtupxmT5w=;
	b=FbYJ6K1YYs9Kf6wC4Jj1UsLUleNw8m5x8H8c7PSBGGVwgG9FMi0Crx2rbT0fSZ22cCeK
	 hbWWx9W1c6yYpIXThiO8/i1Gfm4XCct4k7m/paUW17A0sulniCLWMFxC8yWPF1LzAezHK
	 ywBpY/Je2lqfpT1id7JXdUtv6C4e96HAf7RnePJ/PtP/6uaqJ/q76qH5fJqiRMPtQwwzL
	 d3sMsPHmVYiSwfLAuw03hZbEsQjGHAddAQ4MxGBSoxBTBadpJ2iV4BZOzKJ/KQHxkV42Z
	 G860+tCD+Y17J/QzpcOQm8/0BPJQXKECNqY3N+9XjVO6fM0y9k5iDgm1QrCY0lUIMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOO8XcYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE18606A32E
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOO8XcYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43AF1F008A5;
	Fri,  6 Nov 2026 07:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949183;
	bh=H3SRB8FWQTIDpCRyxrVWiF5KnroqMrO7wFBtupxmT5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOO8XcYfxNX/oJcqhNqzdiXl2uQ1nb4pZZyN3+OZM9DemYe9sHcS5JKAD4vV1WutV
	 X5imzQz+0XRIXD0KRooXepMq3Okg/RSjshNA7BxRHBhV/fYZrirt+1gTevVg1KwBcg
	 uoOWSKnaljm943wC1BoPmLynRcNm15rToUgUir5792JKkIWD/uLq9ENuPSAqlcDoPo
	 hVxRqvdHIdRf6zIhRvn5jUYk4PU+IDw/SQze8p7SQCTSm2OXiycvsjX3VdYLeovCU8
	 4unp3a5aIll9uBtyFzKUhxH11xBRAmWcRc0SJAC1FZIJcDRU3g7ofUGmA19XNn6pwP
	 qf+v7KcMEgIjw==
Message-ID: <sashiko-outbox-200975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/20] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-6-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:13:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D5

