Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265783;
	b=SQy071Es4fqkFRJjzDW7YSih1inOseCRN8MxbDvaziGukeWJWwnESqrlhYBySNcM6wQw
	 2SSQo4q5/02QK3b4L7aR88Dh5PU7uD1bQHy/iWoxnzuBBpBxaIlCCom1eh1zAQKNIRBbp
	 1oTSdnaEGS94fiqwDFparloWM/Jn8bznZUBYQtgdq6F0ahSwCdfwyzBRU1VbzPAAE8lQQ
	 0c0TQmPgnZo0Z38dJFW8IFIca7BDXHTlWX3mKXM/QVDCHb6DguMdetNwcg1sp9yTTlGX/
	 kg4Msaz5kpgdgZDNja7aHJSFvYblcs+3AGL0mc9hJqfo/AMMxYlVUzXnfk6nWvwpQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I3M/QfNS+WtdR3H1bWW0r/Jl1d/ccupOTL312IEbpU0=;
	b=OPduryAW33BeB6ZNOjCmr5F62w409lxQXg8bMoSaw1PXYuVPhi8UiHX1VFHk8h/jHxbD
	 sF6gcATTfXJn8yEHJ/kyXh3yd4Dq5Urv1tDv2i+igOQE8ebTg83VCfjjGuHyGV7IjDDwu
	 GLTplt6VcWKhWK1Mwz3lSu5W2RJMXh6eG3PzEjiwveUEe+JsgSqScqFT5EYuLnVK4RJnV
	 8eseJDHyAAyuwluGRTZ7+oKgv2xIQvuQYN95wAmmbu6Jy1cRRo2UdmZTTDoA9hJVZpvEc
	 t9DxbxX9ChWyjLXgOrTzMHvPg/GFoJQfsGDh3SSB85Z6M7NZg0hfl/88oRl67FgDn/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRmU96+b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C475606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRmU96+b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85301F01825;
	Thu, 29 Oct 2026 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265783;
	bh=I3M/QfNS+WtdR3H1bWW0r/Jl1d/ccupOTL312IEbpU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FRmU96+brUqwds9+CC3bH06snko76eanliDkH83Hg18ONxnwhFNpoaZqGecC5ApAH
	 /MQQOAqfKflIKPCTkNt1ey/rjkHg4sA9WPCtYPTckQmWBLwqXQIrXIK0cWy/tOqZxs
	 RvAR/ymTa02hB6AsZ2Fug+qM0jJTFm0Ewa0WP1ihaAPUHq201LaLuYt/0UtkP8FhO3
	 lp07dsh1pi1xr5/B5iVARwJ7YUO3fvYvnkeX/1xh5qNOgTFdKoaYRWZ0M7ZYmXDZGt
	 Uhf1jdG7fTSR3218xX1Ei6gLDxRFm/zAQmfDmRfyYr7g2XoNXG9i1xwJh10U/oL9Q4
	 pBponj3XorFUA==
Message-ID: <sashiko-outbox-189029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] include/linux/unaligned.h: remove deprecated
 __get_unaligned_cpuX() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Vetter" <julian@outer-limits.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029091736.28742-2-julian@outer-limits.org>
References: <20261029091736.28742-1-julian@outer-limits.org>
 <20261029091736.28742-2-julian@outer-limits.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:23:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The __get_unaligned_cpu16/32/64() and __put_unaligned_cpu16/32/64()
> helpers are deprecated and all users have been converted to the more
> generic get_unaligned() and put_unaligned(). So, remove
> linux/unaligned/packed_struct.h, and drop its inclusion from
> linux/unaligned.h.
>=20
> Signed-off-by: Julian Vetter <julian@outer-limits.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029091736.2874=
2-1-julian@outer-limits.org?part=3D1

