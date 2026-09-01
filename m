Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB336E46C;
	Tue,  1 Sep 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272822; cv=none; b=YPsoUA1YmI3sUpc7ML62Qd0eO2wfR5P5+0M82BOLX3HslDlNq5Du3OfpC4tFVAfuDrKFVhQXTamzH049joli4g4FDlSCf0bAQgmynv/g9f4HX9d0g1l2VqIuIjpGJUrfgmgwCkViH/Ym4qcm7TCxKwrHLzyRpGyir0WICvKFdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272822; c=relaxed/simple;
	bh=7vqtrdeO9w3AfT1WStijzZlJbB0vxMN8XYyoi77WZjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jOiTaXKeCIZEsjq9F40r0WXHDVrVMVr5bGZho8TBHRzTUzHX+b3JdRZz2No2+ckafvRc0i1uBEOkT6uhGWUoEWs/VjUNAnaOOj4GJdhy4altVO6Ymu64zYVFiYonIk2yQaT/6ZnRsfwiDrOW9KEEonu6udtqdY6+AkJLYmv5HgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oybbI2kb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oybbI2kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451151F000E9;
	Tue,  1 Sep 2026 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272819;
	bh=7vqtrdeO9w3AfT1WStijzZlJbB0vxMN8XYyoi77WZjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oybbI2kbCTs202Tajzsut18EtyGv2LUX4HlaCz3bGWsEw28kDiCbRDAgwtBUe/pEb
	 V7RscN0P7EQo0gQNVkrpXi+fIS9f1Yc5YsIsEDOu8BKBHIe3GN7h0uaU+bU3Z6dZ1y
	 BZCRUjhJiAec8svXtKUcG58z8XQejQpo7clplMhkthtREBRXw6RdE9qYnIDB/w8hAz
	 D5yxD9cgOGbh3/zYzRU0tHrf2P9OjxLIEbi7QCffRpN3FGPQTD6CJP+aH7jar+UOJQ
	 /iiBIrXXDOhZ0YLQg0yrnKVuaSJgbQA7iYbM5qPYuw2Rk2Q00pTVQtVzzwa/W1JZrr
	 dalMkbnYgqAnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178827250904.123716.17452648791331881284.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
 <178827250904.123716.17452648791331881284.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:26:58 +0000
Message-Id: <20260901142659.451151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> btf_find_struct_member() traverses into nested anonymous structures and
> unions to find a struct member. However, get_bitoffset_of_field() in
> trace_probe.c checked btf_type_kflag(type) using the outer parent type
> instead of the actual anonymous structure/union that directly contains
> the found member.
>=20
> If the parent structure and anonymous structure have mismatched kflags
> (e.g., the parent has kflag=3D0 while the anonymous structure has kflag=
=3D1
> because it contains bitfields), the bitfield size encoded in the upper
> 8 bits of member->offset is erroneously treated as part of the byte/bit
> offset, corrupting the resolved offset and failing to set last_bitsize.
> Similarly, btf_find_struct_member() pushed anonymous member offsets
> onto anon_stack without masking BTF_MEMBER_BIT_OFFSET() when kflag is set.
>=20
> To fix this problem, update btf_find_struct_member() to return actual
> containing structure/union type via member_type, use appropriate
> __btf_member_bit_offset() to get bit offset, and use member_type for
> btf_type_kflag() in get_bitoffset_of_field().
>=20
> Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure fi=
eld access")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kern=
el.org/
> Assisted-by: Antigravity:gemini-3.7-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178827248631.123716=
.2627172171811720261.stgit@devnote2?part=3D2

