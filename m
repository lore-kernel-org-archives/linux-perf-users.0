Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA114A1E12;
	Mon, 31 Aug 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200355; cv=none; b=S8e4OVWA3IZM05M/4PpGBvqbp7S8PE0yFNHdTvsPTp593KzayNuNhYS5abVCFolGDyES8y6Cl2DjKX1tgFCDaP9rkBw0sngtys+mi0EDKMd6daBjIMIxP/QMObJ+qmdn46IISYmP1NXgl2b7xRzJM1yhTgPd6VbWoZkj8IAnkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200355; c=relaxed/simple;
	bh=ean0lIQfC0jeDOw02xQW0l41OJYoMqCFBzQ8txS+vqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r3zpJRkCWl5/jPVlfBrZUXpu7Ap7DwowuLGcikrZby5FvwnzQCkPyIaFjxheFUa6FQDepmxGSTfMwJLfoqFXAFgVJ1RgU/IoZcx3F0HgGrSIzjdXHy2u+AC3aXotg+ZXtWJxTytIylpKihP2nsl2l7L0AY2p8Fivlce50WJLfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORqzuLGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORqzuLGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D3B1F000E9;
	Mon, 31 Aug 2026 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200353;
	bh=ean0lIQfC0jeDOw02xQW0l41OJYoMqCFBzQ8txS+vqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORqzuLGPn5S6ceKcJh+Yiyz6XUDRpO4Z/U0aWyg4dslc234w2/yK1IaL4jHYlxSQD
	 h67Tt/R9HqtZuN+DLmSX0kFDbmOWPl50xXHD48fTaDSmIwZTCnlWZxv/Oi5RLR+atY
	 Hnb9T0xCHnm+6gJr14bcaMBHLfu8bAkNGI19j5qkAh5GDzrvJ+BzU9fs5KWfFT3hnI
	 dUvszR0XybzbEWJVR7CatUQLcEsfo7pCmtclnMVYiGB7O1okPMs5RCz1/Pc/1eQh62
	 X15yp2sVQUKebXU81VMMamXcy9Uno16k93xNI5EYDk2OzFQQ9zRWaqz5iWHcZTveNh
	 TkXBekKhm4xjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tracing/probes: Fix BTF kflag check for anonymous
 struct member access
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178818877624.104360.10938474138218043559.stgit@devnote2>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
 <178818877624.104360.10938474138218043559.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:19:13 +0000
Message-Id: <20260831181913.74D3B1F000E9@smtp.kernel.org>
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
> Assisted-by: Antigravity:gemini-3.7-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178818875393.104360=
.1469039168635349344.stgit@devnote2?part=3D2

