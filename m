Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65653AFD05
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522684; cv=none; b=HTTw16bPIpI0x0KUyqh80bBdoweOUPk70UYVQULeyd9FpXH9pOUGX8lrBCbDnWQtJm+cEjIq/T09tak6U9jN17ngeFbBlKMbEg/djZIHcDDbcCRr/aSxH/bxdhx+LUhBBkWQYmqtzW2IkROwoB/yKRXGUGQnC3jT9BhwwzkGdYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522684; c=relaxed/simple;
	bh=TOfwnBOtPd71RgjBZPj/AVp+ApU6Npl6JvrZhWnd4U4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pE/IBFhUQJq9qNN64xRNX8IF7yLsEZyE1TtuI6yMcFswTEWDfx5oIUS5Zq+yMX7g765JHp8++iRo0PenUwqUGLs0vNS/vLHD9N6Iw2S+vHjGUja1jGXV5jWautQCDfB6gET4vqSiY0lN/4PCxRMkc1dW+THmTmlIHu/z452rjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mekW7lsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mekW7lsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50D31F000FF;
	Wed, 16 Sep 2026 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522675;
	bh=CulgQvMhhcelr9RfSLEvTznaMGTNQGkdjaJZlLnJhkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mekW7lsZtP7WLSY+J4F5YNfRRMnwvCLVXlqvjbA1ctv0G6Olcf5LQH6SQe98RWHO+
	 4wbrhmgLqGvD8Ml8pyCIApxcIKWf0nntE9C6vrUS0It5tShKa4pkGeWeNGwG4KWDMV
	 4LEpd4H9yAQ63/8YvFn2LEPk/p+v+Sd1M1//y+4dcro9KgCosVS26sKcQb9pgVDb3X
	 UBGynnhqnmeaWROdIQynv1TLkfamIwTm5gaasTMmxdD2yPrWhe2kM8ZWR1ByQhN1+h
	 eU3ILawVrxDI+1B2MIxYMj4sIE8qldftgSkLrVKZ0rz52tXyImLPpDd29SkZc1Ypdz
	 xjtYkfdoE4Exw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/26] perf capstone: Symbolize address operands to
 match objdump on arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6055eabaa63f43fffb67e7e5ca6f70d997a3faa9.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <6055eabaa63f43fffb67e7e5ca6f70d997a3faa9.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:37:55 +0000
Message-Id: <20260916013755.B50D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Capstone currently outputs address-bearing instructions with a raw hex
> value prefixed by '#', without symbolic resolution. This differs from
> objdump output and leads to parse failures in jump__parse() and
> arm64_mov__parse() on arm64.
>=20
> Example of the mismatch:
>   Current: b #0xffff8000800114c8
>   Objdump: b ffff8000800114c8 <el0t_64_sync+0x108>
>=20
>   Current: adrp x18, #0xffff800081f5f000
>   Objdump: adrp x18, ffff800081f5f000 <this_cpu_vector>
>=20
> Fix this by extending symbol__disassemble_capstone() to:
> - Enable CS_OPT_DETAIL for arm64 to access instruction group info.
> - Detect instructions with address operands requiring symbolization
>   (jump/call/branch/adr/adrp) via opcode or Capstone group ID.
> - Resolve target addresses to symbols via find_symbol_from_addr().
> - Format output to match objdump's style (strip '#' prefix, add
>   symbol and offset).
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D1

