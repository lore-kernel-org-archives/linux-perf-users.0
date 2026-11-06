Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941753;
	b=vLZijsxQWgiVmpZ7mpqUmH09dOwopbUX5KfbYGvFOO9VkLZAYGMWPR4wvnuVcfesf8dq
	 THh85y1Z+CWprVFnkZu1UnY8Usn5t0b1Gxv0Vik6zjKTjvMvaVmH/znB1UXntt7k9T3bV
	 L2wWbsk6a2P1do3vF7+kbPxruy4S+z1pKMkHVzut+zUa8vaZpdpohVZ6vgUYNNoECZRnW
	 lkAsNMZ4FcfLWwv540PBnz9DfBWJn7Nc2akJ7vgcfj5m43prOIUWg/ztBJUY3HwxMeOjG
	 Q5fCs3meYm6agxJbnOVVUGunsNdr9DMRDVEJlJh7fE/KiJnkNgjuGW+wro5LTq7wU9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5efzJkKUxdbIe4KMc7WNAZRDXCGNAAKvtmY2opAlExc=;
	b=lrqWpXKEBwfKNncZXLOoUq7oepUGFeU4k2+hnnHmVF6QjSvwcjXYAg8Rc0hTbBfzsYJe
	 eMmhMImGMvmXPRnOSGGEeSjq+pNN5BBJQZs3nBzh2McIguLCa1YG+vrNsT3cGO70JAU44
	 o4bL3GaQlCR4sg+U9psyr8exNod4pF1f10WZ+AFhm9bNW04inrTWH4aOyrIKwiZtnITLQ
	 6RmFWde1+Lwfmjy+xlJULmkIqFxf6oFKvZYUxYuYYOpzGh794PXFCLyO9VckIsQVmIftu
	 32exNfc0jhpr7GwfEPZvoFkVs/d7YBGt1PHWtwz14Tr0Ea/8I5hv7uOwJaxDntDJKwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh6e4sYp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD63606A332
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qh6e4sYp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465501F008A4;
	Fri,  6 Nov 2026 05:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941753;
	bh=5efzJkKUxdbIe4KMc7WNAZRDXCGNAAKvtmY2opAlExc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qh6e4sYpZVxlhVeMN2EY23kqYqv+7sjgOtnvTMLFClLWBqvr3swY/gzbhgCi3EHcj
	 5HvfxGtowHbj3F3S9lW3tZeBY2TYbixjQF9WPPz77iSEvGozOVwU9Ay/p2K+S0Ln7n
	 rhBlX8IjwvjFigD481TOwJ86/XiIGJhIQz3gYHCQ21ynbv1qAruOra6DugG8u6BoOl
	 uR5l6NEe8/NDduIXhzOi2wX24E6mVzaCJ6kW1ZPVtd+SB/rMl3ihoF/+b9RJ1AURfO
	 VVaZIGyWo00rVzTIvNmesoPHvT2P6XmYI0zuX6MDlZ7YgNN0NVd1oYsaqvTXj/9DYe
	 yNAdov08WHowQ==
Message-ID: <sashiko-outbox-200798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 14/20] perf/x86/amd: Refresh LBR stack in PMI only
 when LBR users are active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-15-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:09:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Refreshing the LBR stack in the PMI handler is unnecessary when no LBR
> users are active. This adds avoidable overhead and hurts performance.
>=20
> Limit the LBR stack refresh to the PMI path only when LBR users are
> present.
>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: "Sandipan Das <sandipan.das@amd.com>"
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D14

