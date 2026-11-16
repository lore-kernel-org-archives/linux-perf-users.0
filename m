Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873361;
	b=vFlRF/0vdclDdT7RQnvkbxeHSKbtqa6k2NxzXAa07giczD7AmUBkavoEhMlBKAfO/rB2
	 vXCBLfukc1a6elDfyxo2N31DmI5OkRN9ImPSeD4z5MBun1wNj19XuFEZhi6V26vOGmoUa
	 mteviWkBNFLtvMX9xlj3Yhp6rZfVliwdxtM95rIExlnYRM7iElYSYTkr3b1PMx3yCJp7/
	 MKK/jvGhCqXSNK6sLIEChgWbT7q+irtdYPu2t/XnOoG3W8Jusgo9Ulm255+gGQ3aYBIyt
	 oe6xBC/4n/6K7iicaBNBHpuT/04FfNyMZV3UEQxSf/06VKK65mgnQ+fTpxvDAfK9zZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fgYQXs5g0QScYD2kl4hidkLHM33WiIInQnVbezDSIEc=;
	b=088zydiVgoZdawXRi6zO/YJp2xZ07OOUJyQ5JQfBJI/+DnyQD0k+fdKoaQ0HkgGeIa+G
	 7zLypUm0D9bu5+Q8wpVv+CzBIk0VGCxuoIAK0bxSD0HQ7N/0aaoPd0qTCL6scCxYwEaTZ
	 BL9hofkAShAe3BlWSGZNTuxWrw7/BwdCKILCDrxckzzaJW+EzQIzEvW/Yh+OEDf0qUZuy
	 5gO5gDAH8HU788OOsXuMjLUv9HFIgDd34+WY9qYcTMBVT9rS9pjq38V7NBgK4LjOFz2Fw
	 Bn+ga8SJyS8rflamDi1UdbGz9NxfNLdy4tkPWr1/Kyp6eK5EKzBBi/lRS3Md/i8Y1Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QSy/xzRQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4FB606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSy/xzRQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399541F000C4;
	Mon, 16 Nov 2026 23:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873361;
	bh=fgYQXs5g0QScYD2kl4hidkLHM33WiIInQnVbezDSIEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSy/xzRQT6IOZX0aWxK3aJCwwWw6hnBVO1XKm8iphCTAQ4x5c9LihI7J4haHhwFRr
	 ZUPRyhdXTq4CTTk2najci+nhrWOKr+ezI39QLffTZxCG2th/+vMLJhcoe4CQlhEJEa
	 SKDEUDuyh4PvewtmfKEv/6InXQVkgBrLKLK44bIa/Lecm1bHcgNbOH6dCEVIMGvlfj
	 NUhtN+MXBwtUccsRFeujA0PQgzetR/txxpNPEM1RoIOio3hxDhUMU3MYMduy09cZNZ
	 5CO4gt5BtW0/EB/IaBmTKvkCfEixU+p7ErRnLmqFQIH3ahlATGmddjweeelgXGHM+K
	 o7EucPwpiVocQ==
Message-ID: <sashiko-outbox-217943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-5-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:56:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member.  The test skips
> on 32-bit PIE builds, which load globals through the GOT.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D4

