Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382957;
	b=nhgIL8iuU08CJMAe8YhO8P7VIWF9O+9GPEyBAPOxGIc+UuMnUZC5NQ3w035rc8KdJGyv
	 /neZjxSIzVQCHhPTFFcOt4Iha/w/QsKjNyJoupAuL2gFxRblhgGzVmY/2ZBR6/Ko9GVjM
	 0SlUoUY+vC7OTve1w+L5WjTi/fq0eQ0sWdNdj2dXJECwNma7woOU+GQsqcvMaDUo1X+4A
	 /6uM5ix+isSISD+HCMEjjp3gf3Z6/lUTdRbuiu0X3B03it4STGIgM9KYLfDmYbA6AsUq1
	 3eft5dGsQGgpMmHSl9vpFDQoCDShj0T9SlMbZU7C3IUpBR8ew5iRu3yDud+DiiVYjfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3z9hzlPCsnV6YqTLeBND8HVdOXjCabaIelrDd/tUZCI=;
	b=nLhBWZisGRuygfNPfQLDtX0RihXL9SNsOVg4lIx1F5Y/UM/ypPGhZWs87XH53hyjdtON
	 yT9H46OHkMofT1x/kASA+GkiZvwFaa45GqJICYbBz2jGTwcm9aIkMBhxIol1md7Zvuxq6
	 nWJOVIPAQzaKG06Bgm6ZiIg+uaZKnZ+6J+mvaDqw+ciaQQUVNYziNlcAz5UcWvZK0cc+B
	 UtBd9ttnVswHDVDD2u7gcXXypTWJDCxqvGxG/4adqa2WDq8pKKmCK/+iua66EQPHLrQ8c
	 vLxKidgxXbpqBtEUkqjXrVWCWuTiZ7sINrXVSSgmLVjDWpKSyiG047Sm1o6qdBZQg3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVWDoik2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BCC606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVWDoik2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A23C1F000C1;
	Fri, 30 Oct 2026 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382957;
	bh=3z9hzlPCsnV6YqTLeBND8HVdOXjCabaIelrDd/tUZCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVWDoik2nIK/rxk2p6f0ikVEYn4ciZiEsb1dIXvfVp46Fj7xjs02li2qxKPp4kQgR
	 UYpDxr/3wjRrLzcdGK7u8ZK1fVhhICwF3I43aCazQHA4oNIeSdWOv/53ZP+f3+xnZR
	 Dwbi60jL3Bu7NFm3IjowUiCY8fBd4kh3UJqmjl0qt0+U0r9iylW4DvbZ08amDUwbZh
	 ffsq5/2mWfWB/wgE5tsbBj+H5pRJm4pI9knkrwRWAxaemuQpEnuvIoRD9OMCj9F5/V
	 v3GJvMNHHEB0AYHURnq53ZEtw1/6NnOT2nbgiVSgjgvNVVCQ+IVcPzEUCZtosyawEm
	 u6d2n/MsYZB1g==
Message-ID: <sashiko-outbox-191376@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] perf jevents: Add support for NVIDIA Tegra410
 CPU Memory Latency PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-5-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-5-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:55:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 CPU Memory Latency PMU events.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D4

