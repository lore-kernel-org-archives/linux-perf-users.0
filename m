Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FD4570C5;
	Mon, 31 Aug 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199888; cv=none; b=imcZ0ULzr996q6aaxQfeuM3K69sOdhfjytBjgDctW/K1o6QbAZp2ifR4ogOPNxas/R8VfLbDj3ThFYScnq96tmV64tFnKbPEbSH50bxS4zHNLcEOeLXlUAOfBH4j0N6anTMK00ZHcREn3+ivrtVVBol0iJUanobWQQTjpnSgoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199888; c=relaxed/simple;
	bh=c1YMrZePH04FzCNXiWhfaQHsLulNFvfsK+TNQ7/6Qa0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OaKrRjzmohVuVBB/Nf641JE6OwQdIihEy2F+CK8chJ3ZUO5n0xEqJB4hatM3inXufb7gqqnjzPs61d61fqRCUYbriGgFHb9XEPVuK3/0CTdK5L7NrK7h0/ovjJfOIz/4rvCDggWgOPqwqCsHRD9/S9yxqyyM8ku+NYv1J2AW4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Ghplue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Ghplue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEFE1F00A3E;
	Mon, 31 Aug 2026 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199886;
	bh=c1YMrZePH04FzCNXiWhfaQHsLulNFvfsK+TNQ7/6Qa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1GhplueAY3VfW93fo54H+ThUGxQ8lvIae4hSg13cXTxQO2ZoVR3qPTWM9kqQ/e3Y
	 GwQT2EwiIdux9TL3pSP/0W7xtzUyTtSB9o5ouWshYrcjwYXkKhhdijjd6G4l5hWeEv
	 sA78FMA00tN5OSAYD2iBDKoNR2JhvD9nGBGEWsyoMfH/tR81lZ75VvbcYPt3o8X31p
	 YCqOkj6tedi398Ghr7SS4Z9XoBy/50aAQNyscCXkVOEc1I84KijURCLLj8jQoXDNYf
	 UeBZ8/w8mpgJZd6izr5vR/gvL/fc2I9mEBtZa1ocSAAjXlL6y+mqS98rCikA9vVNdC
	 6Kw3yRsFqb5NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tracing/probes: Fix anon_stack check for unnamed
 bitfields in btf_find_struct_member
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178818876548.104360.13229872396750615226.stgit@devnote2>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
 <178818876548.104360.13229872396750615226.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:11:26 +0000
Message-Id: <20260831181126.8FEFE1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> btf_find_struct_member() traverses into nested anonymous structures
> and unions by pushing members with !member->name_off onto anon_stack.
> However, it does not consider the unnamed bitfields (e.g. `int : 5`
> or `unsigned int : 0`) which also have member->name_off =3D=3D 0.
>=20
> If such an unnamed bitfield is pushed to anon_stack, the
> btf_find_struct_member() return an error even if there are other
> valid entries in anon_stack.
>=20
> To fix this, only push unnamed struct/union members to anon_stack.
> Also move the btf_type_is_struct() check to the entry of this function
> because now it is sure only struct/union are pushed to anon_stack.
>=20
> Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member o=
f a struct/union")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178818875393.104360=
.1469039168635349344.stgit@devnote2?part=3D1

