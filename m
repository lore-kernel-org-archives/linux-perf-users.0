Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB473ACA7F
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005949; cv=none; b=Ts5t717SvfM7aYAWgb7ZbC4lzBwVahYdegosQuEHpuMT4nCbor3e+UoujxCLKX+m4/gOeQtCJ+nmw6t5qZo27SNW/ZjQe/E0OTwfV9jxpciisK6l5C68+1FfpdveeHI4mzl90KGCb09nDp+FuBmfIiioXykX2T/tAkJBB3eRAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005949; c=relaxed/simple;
	bh=FWkaj2u2ibOXqp7vZGxN6exTF9yHm48ur+3zkg/eE/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dBwzEeG++Klrlqpav3sq5jMjDWAgtvMOsNX5iNH2bHj2AsS2mLn7LHfoP7GxPUQielLQNVZ5Qdt/T/DrR5xuqSJ/9EkeJYjcbfK7Joazpg6MvxU/R1Lt0Yz6I0UyIa/HeuswrWEas77y1tccKU3EcSRHAjrC3ikhb0QJZjOC7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlvon1j1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlvon1j1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE65A1F000E9;
	Mon, 17 Aug 2026 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005948;
	bh=FWkaj2u2ibOXqp7vZGxN6exTF9yHm48ur+3zkg/eE/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qlvon1j1+aUeY3lA/866g5QdCD22rqlF75EAq5yQWxof4LpJvdZo/w7jsKsVtH89M
	 ocIG42KIfWH6FJgKvhE4ydK3q7wI8TJkr0z5pBdwDeKbTICNmKxTw+Ec5hQvfl8vIF
	 7VQ5T+2rryItcoWlAkHAn1PlcriT3BSMg5URyg5dxo9grktaH5QBQcX6g5b0Mtk0qx
	 xFaXeSOmCBv5a16Vz/CVrgTLVS6ow+K3R8cffrgWZu2R3PxjHebceHUkEA0CMdmWKh
	 Mtzl8hZuMhPRDqZ7PSuwukmkenfqldtu68ML+tE9QuUkYgtlOdm98cCtrLmV7MJxTN
	 xHY7bE+k0CDXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] perf dlfilter: Add non-empty branch stack filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <58f96797f94467859fec160320a7b9426be8cce7.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
 <58f96797f94467859fec160320a7b9426be8cce7.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 22:32:27 +0000
Message-Id: <20260817223227.CE65A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> --itrace=3DL adds decoded branch history to existing samples, but a sample
> that was recorded while the decoder had no trace for that thread keeps an
> empty branch stack. Consumers of the resulting perf script output, such
> as profile generators for context-sensitive PGO, have no use for those
> samples.
>=20
> Add an opt-in dlfilter that drops samples whose parsed branch stack is
> empty, so users can exclude them without changing default sample
> semantics. Build and install it alongside perf's existing dlfilters.
>=20
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787005265.gi=
t.aaupov@fb.com?part=3D1

