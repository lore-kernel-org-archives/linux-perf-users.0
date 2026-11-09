Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223235;
	b=Q2+alNaGYZMcYvZ/6ZP9fUTbWmjbZ211RmUQGX6PE/uLMVdv9OpbbAH34aHXFmleCdEt
	 YjqWmR4qYXGdTZSHFzzt2WsfdIX++PRgD7aqyGj9dnP/TQWfFiqvaZ4JrpE5o1sGhHOnQ
	 c+OoV7ReqUqMIObZyrGlpz3Barsmiu4nM/uMc0GTwuGMtxPumOhdXkFCeD+cLgkLQ8p8L
	 gef4E55oBanNngTASfzoC8CCsOuJ90Bexrh25J24LFBvq9ajpKCx/ZXfmPtTe3G6+B2E/
	 udI5SFhR1b/4l4s2vYIrj+TcA50Cr1YT2T+6l+BMm9xc3jqyEmnM394aAC6cxwnZMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nyRXxW2eiJ32kgQfctkndScWADHtl1UgbgSGOSasXRU=;
	b=mQmwKQ99VH4qn8cm9fOD8z9IMAPdDoctVfy0Pu7FwoHD+LFgSGleu8l9RIv8WnoRr8NT
	 eB7QsngD7pqElxijktD0pI+cyYyAgldGYMqf+HsXUBwhWI0v7IhJw4KVMC0mFpmO1FCxm
	 a0XlxQNhMpsmDxdjY1MnoWe47Z7ST9ZONRPoHHkpxeHxsdRtBk6EPLbS1ayqU0d09rKUg
	 4Bs2uXUUKpDrClsAAE8bSkhgWN8AXT3d4rYHQ7Bnuknl+xBT9uh148on8dgMBXNK1dAO0
	 QPHP1RnAOfIIHkEe09mj7AH4LnAS4hC50aK8974TBYZFIq1RYYRTqjB2D+yFtxTlD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4wDWiR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC25606A322
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4wDWiR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A21F008A7;
	Mon,  9 Nov 2026 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223235;
	bh=nyRXxW2eiJ32kgQfctkndScWADHtl1UgbgSGOSasXRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4wDWiR1OFsIbUcwVBzDTRev0nD6zj6yQYFfEXeADYP1k+6nEZcRsZdgxNucRPjtB
	 JEBcyaJngQEQQiVBadOYDM33fAxC+b99Nn79cfzCOaqX7OS3SeZIruOpi14lY0qenR
	 lN6xOPH18Yx80yybvzp4WckfQpuHUAC8djWfeQhtIz0wYVY24DP6ggob+3E/W2qibP
	 x7EyUufnd7uXUg5xXTNytlHd22jsKqmcIM5LSFmjWRGnJM4mseuZS3EDqkdciId3ta
	 RgJCi6RDH4jVywVD7qQv2tZCwaSMyXB6WsPFdXpCL30R+bVOA7YRPsCrZoFWYiiS5t
	 bOEidpFEzuxdw==
Message-ID: <sashiko-outbox-204864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86: Reject pair-counter groups with no GP budget
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109110356.27709-1-zhaogongyi@bytedance.com>
References: <20261109110356.27709-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:20:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> AMD large-increment events reserve an extra GP counter. A syzkaller
> reproducer opens a perf event group until the adjusted GP budget is
> exhausted. x86_schedule_events() then WARNs on the unschedulable group.
>=20
> Treat an exhausted budget as a scheduling failure and return -EINVAL
> through the existing cleanup path.
>=20
> Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per C=
ycle Events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109110356.2770=
9-1-zhaogongyi@bytedance.com?part=3D1

