Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D12D77F5
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788119624; cv=none; b=eJX9k6+l3u99Kv4ISAzISDaiBPZloqoe5KbTRL5/ehmtozf/BzRBNMRGjELg2LhH8/lP886sdssXRfQYuDF0jXaD/w/xl5V3+yoADxKM23u0r/XPcv3y9sQUqAammkcx/Q0Q0ZgM+f0zckH/9AdXGQzM8uA122HsdrWV87Spors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788119624; c=relaxed/simple;
	bh=2jIBJIdH+d4KGZmxkrcwOckdjlU2BbIG19Q5V12UtJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WgAjsoKWw/kWs8apgHZHe5V5kNZ+9uu9zowzs5dWkvvhlZseoClIOyOitr9HnJ7RUGSzt0wUUZMCLWui+g6lnYs3KGz0bctO3DMIeio2LzPTFRk2fTOEVkSu8GehUJUSERXrRxVi6EAJdIAVT67Z5HLhQTCt6pgR9O2Enrv7k4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IINg2M1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IINg2M1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038D91F000E9;
	Sun, 30 Aug 2026 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788119623;
	bh=2jIBJIdH+d4KGZmxkrcwOckdjlU2BbIG19Q5V12UtJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IINg2M1YJUKk1p+tl4SUm7I7sMRnvwLhpkn4TVw1q/jXV3TsLu1iu4mGr8dS4OKv9
	 L0AJNI/E/qu3vC96IwxYa4bdu7LxxZiTit0F41z/HGj52kbJvgMuAbstN3uMf1xEXz
	 OdRKd5ehdb2SyzJ3JutUQ7NUlwcoo34axJBHy3cZCbw3N8SsVBTEEoEn0uzC+zS/Bs
	 A4RdfO/rM1ZHhniDf/W6oR5RGodOHFH045bpgXaTnx/xoeKEH6ejwuxdsMDYPmvmOO
	 s6ZRhjpsh0OaHAzNKMFghtmBFuKyURcOfB10HbT/Q1Lj34r1FmSAP9a0f7jUXIgAtv
	 SB2Qc3wMoIjDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] perf tools: Add support for displaying weights
 in annotate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260830193459.2840519-4-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
 <20260830193459.2840519-4-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:53:42 +0000
Message-Id: <20260830195343.038D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for showing all the three possible per IP weights in
> annotate. The weights are shown by defaults if any are non zero. This
> is useful, especially with the new insn lat statistics, but also
> for all the existing weights.
>=20
> Add a hotkey to the interactive browser to turn them off (w), as well
> as a perf annotate command line option.
>=20
> The weights are stored unconditionally in the sym_hist_entry, which
> will increase memory consumption somewhat.
>=20
> Assisted-by: omp:GPT-5.6-Luna
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193459.2840=
519-1-ak@linux.intel.com?part=3D3

