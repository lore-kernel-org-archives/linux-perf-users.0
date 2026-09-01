Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5E30E85B;
	Tue,  1 Sep 2026 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223982; cv=none; b=kYZ0QmdNZcZrsnJQNr07bn2iK0DSyi+1XWKNBYBYsSqhsfKb9A1TYo3IqF8HSDqlg/cPc+2Bg4zBRmrIsMJbLxYJiVP/r4lwKfGngq3TQYYHUNF79WDU5gVzfyKenuJh7MvO54IGKK0SKAOG8qAAoZ23ydqSZC6iF9WECzCe4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223982; c=relaxed/simple;
	bh=gHQd+xaEOQoz5G0XkN4wCLVfBbXXPqDSjKhYdAvUZhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QkdbUJODe4oeHs4ks2VfoHIMh2wLvEBct5zcyOUetu4pv/ANoF/ZfNLcMTb1jcnnwamciHTcCOttYkdbnDWw7Oe9CQ6rKCvkR39qvf7950rz6LmOPjX/ahuTcCZlyZHu7Xhkw7QOPvSWOQFkdGEC+/iearIGAtsAETEePLBGC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB50lWU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB50lWU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D001F000E9;
	Tue,  1 Sep 2026 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223980;
	bh=gHQd+xaEOQoz5G0XkN4wCLVfBbXXPqDSjKhYdAvUZhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IB50lWU2vwbrSvhDG6L7b8GooveX2JsMEU8TW8S2Es+RkobBnXHN2KPkhJ9at5+pc
	 GDK2Y/lka5wOTDvIj6rBRSEscqdyAsNMcPi95tRovr5p9zEvK3g1AXWmvHIBdZ65Y1
	 uCKcemB+1biYMFmnP6/mR3dTq1Mb2c33kj6606axfhltrpbozYadzM6q/r8eDTMg9g
	 tiHb+K2BJh2RVdWY0aaGPdH+NbkJoSR8cpikeFbUvSMZDpstnvkjz+kADNfzGKWHPR
	 yP7UHlDDZ1IpwF3auVHsH4SPv7Pr9JZEwiq25XSZha8TQnoqVZWwOpdjAWotekZyOP
	 T8q/9/Tc1vLOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] tracing/probes: Fix BTF kflag check for
 anonymous struct member access
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178822363712.115597.2744784023996949800.stgit@devnote2>
References: <178822361441.115597.11442662641658772793.stgit@devnote2>
 <178822363712.115597.2744784023996949800.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:52:59 +0000
Message-Id: <20260901005300.69D001F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178822361441.115597=
.11442662641658772793.stgit@devnote2?part=3D2

