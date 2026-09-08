Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D555D89D
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874016; cv=none; b=XqWieLtSMns8N5MxQ7KGqbZM17YWn6S29+HDdUW1MxAX2E/PAqKdQlpJlSe00eEEDHclap4/6WlNulB9i0k3QVy0WQ2WUs/VeQe1+0Rr9CYjeJfrVctauHZBH32Hck7o8oe/xoMPkU129xRQn+a3FIhWrrQthS5432GKS2N+m2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874016; c=relaxed/simple;
	bh=HhP94pQF5cLjyC3WkBa0n6oDCnnUU+4X7/Viu5MPhtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E0tva5VdV+UQgSH3FKEglA2YHNl+ZMBDb/vAPKEJ9saRmg5B5bcOyhfRGyRAU19mQBCz1QWbDJEgKwc42i5S1k3hxiJvJ9C1lJlHzLVWqRjjF6o90zDAVPccZzFhX37wWx644ODWdwpt5T+8sYQRk0wev6jj/ZiFC1ViXGFtSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/poYLTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/poYLTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4531F00A3E;
	Tue,  8 Sep 2026 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873990;
	bh=TznTlnly9+QcSvBIZ8OCOQq6FLsVviowfV4n7J0FIq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/poYLTguzqE2RJ1nxOPStTbXe07CzbU/RpXiPqJKkbVUVAKOzCM31+ZnKZgQ7iWy
	 3RYcKBb0D+OsqEc5g0f9wAwOhGr9oUzKw2/XNQYGCK5hD4lUc868gkW9Sw4UjPLHHs
	 jcpn+Q2BnLB0NiJtSwVB0A3DhUR5FL/MGAOdyjUuKvY7rD4mnV2wI/j4YilvnodaDK
	 DrkbMMkKXcKAuUVYp35gfBo+MgkPPw/oR6eguN9AwR+jjlJ/PEQ1b0eRagavdqc8sN
	 nCPX8fZYHuhKTyHc9fsVS5Jfj+MiTRZoyDNkXJsT4oFZFo3D11fbp4Xjve3vT76Skv
	 OR/44NBv3cJbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/26] perf annotate-arm64: Support 'adrp'
 instruction to track global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c9dae8385eb67cc4a05c4ad1bbaafec164ab0043.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <c9dae8385eb67cc4a05c4ad1bbaafec164ab0043.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:26:30 +0000
Message-Id: <20260908132630.8D4531F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to track global variable types
> calculated via page-relative addressing.
>=20
> On arm64, global variables are typically accessed by first calculating
> the page address using 'adrp', followed by an 'add' or 'ldr' to get the
> specific symbol address. Without tracking 'adrp', the instruction
> tracker loses the base address, making it impossible to resolve
> global symbols and their associated DWARF types.
>=20
> Introduce TSR_KIND_GLOBAL_ADDR to represent a partial global address
> state. When encountering 'adrp', store the page-aligned target address
> in the register's type state. Upon a subsequent 'add' or 'ldr'
> instruction that references a TSR_KIND_GLOBAL_ADDR register, combine
> the page address with the immediate offset.
>=20
> [ ... ]
>   chk [70] reg24 offset=3D0 ok=3D1 kind=3D7 global addr : Good!
>   final result: type=3D'struct folio*'
>=20
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D24

