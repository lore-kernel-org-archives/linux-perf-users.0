Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622782;
	b=ZyvGCDOqM5CU66NmTfPBbvmGovWTOfFzCSGqrH3fF4V9ORRPU/oadcH6xF9L/sIHiuiy
	 7qCW9Gcms/F9VpB5evHebrfsic0GCM4h0AprQ6suHa7FsxHMNkp1Z4Zi2gJ+dB5CFTG2c
	 vxKam9i4Q87ujmX37y7I6sIsE/7eRsEv90I9CMUav+pNoXdRpdoP+/8j+oMMYnHkDJ/RA
	 1sm7Lw9RV8BSNnkHzi4hZSBOECkfqNqXftJD9KAtnLeFBtY/YGYzx8lmt3RcXybJ4naa2
	 //382TBU7Sd65zqtQHlf1lSLPCnG/HhyyZ6qyXpRrqN1/R5oCLhKEms4iwlWd4uTtWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8cswT1w7AQ6ktVQzL81xyl+8CDf9q3yxW4CVoYo1fzk=;
	b=bWnMUAgn7F7fJAX8sDj8Cje2OY/xZpffVLGt7ppQO5z+OjsJh39Ee7xeb/cLltcvQm3z
	 AD8wxotDwF63TfBxu+EwWv57jfjvnH1l7pdkMCceSgV6HBjoybxq5msIbI1Wv7X1tojD7
	 h6Ur9DqQ0yyP7gP4ZWNEwX5kn6hS+x0259uFfxuuw8gmkhLhbNLAYfw14jNBHkW68A4XG
	 hcp6JwUOlBKfHg151WuXMZWD9pmTLS1UjEzuTKtKJTefonOijHsZdn5u+E5A/qBgDSdDS
	 8+n1AwRuYGFIpmusOZ1SVUU6YZ4/ehsr6EE1g/1nfnW6ZcYDjnzsxPxXMIbFXLGUyqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWdQRdUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1D606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWdQRdUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7903C1F000C5;
	Wed, 21 Oct 2026 22:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622781;
	bh=8cswT1w7AQ6ktVQzL81xyl+8CDf9q3yxW4CVoYo1fzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iWdQRdUiidS8brOeBqoV8XyECJ7jHH4sxdlXNtMPXlss5ZqnGVyF40xDzA0p6J6ck
	 A41W24b+uvtmjJRzoO7K3DUQsiQdGNZ5FuSg+5wFRqLHISb6g4k/5he5YeouEJY5k4
	 jEZXaLmTHrarMdzox9dEYCPorYyOZXzP2aqbtm6g4y/uOmBBRcKV+wUmikaGfUx890
	 1GYmXd1H0oi1EHsL+CXJ8TELUx6pFAbZKH2TVddoKAb6FyLeL3ZrX8NKRSNyIivOF5
	 TqZ3f6nu08uD78gILoapCZDoQfyYIZFgFmvXfsXVCmQ0Z4V78/kluz1i8qGbxRT5G2
	 cFvSjpslo0KnA==
Message-ID: <sashiko-outbox-180735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/17] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-4-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:46:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D3

