Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17042F260C;
	Tue,  1 Sep 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272876; cv=none; b=l2QwDHwO/rDabBiaTx7vhyXu+2gHNTBROoqfk4/1KiTT3lm/XIWqRFiFMPobFF2FlVztD58xF3oP9EQGdAmEzAET30IujnGD0vqU7W9fpdOuJ6ClMesS/9Xn96PSJnLrSSLCf0yppfNKjCTY5fuLGW+SIdGM7uAV7tx8u/fl3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272876; c=relaxed/simple;
	bh=nGkA13i0+e8g2PCLHkbip4P4orlBUfkBx8/GNpC6LGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EMeyhGW2RtbiTL5xcnIthNlwXf/EGMdo5310aewOS8juBf5GpCLR/R7dVV2bCr7XiqwT/RUgqtV1yoUUMKDh0OYW0LFby4QFLa5Uh9OK2N0wReWcA38gDOS8I5KU/gA0P5tfZyrqTghkcFjONDlKncJtrF8llHKE4Jo03gA8dh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIVSEQ0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIVSEQ0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A41F00A3D;
	Tue,  1 Sep 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272875;
	bh=nGkA13i0+e8g2PCLHkbip4P4orlBUfkBx8/GNpC6LGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIVSEQ0vFOMTELvQPqYrBNlVkSrTranATP6zSCDbF33I/7jST2mNmATdqxU37w6A1
	 6Qu3RVO2OIUuv7YRkF1qpapTFijeo9plqFpM/9fMxLCfv6S0yj1lPQ2b2RKuC14A3E
	 xn77cbWLasvbPKm+j1MUIy66lbsPKdpqA4EfmrOJGCsw03C2r6o3fCn/Gh/fsHdaaR
	 egyGfNq44FDyVg00rYrZsDyIqi/iEkVXom2cY48mb4GG9sPsI7MG36jkJQC7cJWF5b
	 52xkZEAfvz5VIVRS9ReiTQgLKt2nqsG2rojuy/IOw8IR6WaP12nvZX0zEn7xWzzbg+
	 8ztxIxTNiiDeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] tracing/probes: Fix anon_stack check for unnamed
 bitfields in btf_find_struct_member
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178827249775.123716.7813217688423513612.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
 <178827249775.123716.7813217688423513612.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:27:54 +0000
Message-Id: <20260901142755.1D6A41F00A3D@smtp.kernel.org>
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
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kern=
el.org/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178827248631.123716=
.2627172171811720261.stgit@devnote2?part=3D1

