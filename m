Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F073B83E1
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960181; cv=none; b=ck5xpLR7yZbLcLtG6OGJUZ2IxblCxVH9ylVUbm3JUTerJc/wujN9QDLUw5/bX8ORELPSUhm97ghK83ZJ0+r+xaO5/lbMJ/wIntBJNujfonZkfHBECv8RW+WaijZ7Y3jEV3YPHY4dD+bahIl9MdnGskY8/4RTkXYrdGqFg9kFeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960181; c=relaxed/simple;
	bh=FsYmXvIqag4VQU0mEeWshoLZ+4t/hbeRkjf7QTU3Ly8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fLTxJyoRn3ciIHMZbtu4PHBvmGijdrDot+zzX0TpeK2d+r7D3LZlh8ViOaTWQtWOObGiDJuf1j+8H3qvX1Kct0CDnKSiH/MC9Q00770uvClOV1k0TezPIgxz1gVCSOjvAUxfELKoUsojHKCPOYARVV+DfsKM/8GMf/1g6nQkdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8VXbBff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8VXbBff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A123C1F000E9;
	Mon, 17 Aug 2026 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960179;
	bh=FsYmXvIqag4VQU0mEeWshoLZ+4t/hbeRkjf7QTU3Ly8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8VXbBffFxka7yI5syIb4sbQANgEwBrFYJH8tzB4SDkU78+Xh4GwWWyUufysYhzuO
	 nD/xw6sFZEWP8zDNiaszgO9lutIBDqt7JIiAHH/13Enpuf8SnoSNOus/u7KwWSX3gk
	 gtbMrOP6enXMSg5z8Y7SgQh/utAIfTCyAj8gcL56wnW9QB6oVLadosK7x3CpWjEEhH
	 gGTI1LpQP3QpmT6QDmf5Gzl5NRAT7OYACFuoeC4IF1YZb5/Npil00mFnMXDgQFxygt
	 ARSNQaMjUHZEDuccqT4egotWttjXRTKsQnI/z9vSHAZhf7cGCgalqi4GECc5m+yqma
	 PDeCLrLXTaYeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/9] perf c2c: add column rendering for function view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-4-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-4-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:49:39 +0000
Message-Id: <20260817094939.A123C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add renderers for the function view's Cycles %, Store count, and
> hierarchy identity columns. The identity column renders the read-side
> function, contending writer, or cacheline, with indentation for the
> hierarchy level. Also add width and header helpers, estimated-cycle
> calculation, comparators, and the dimension table that ties them together.
>=20
> Clamp the identity renderer's returned length to its local buffer before
> using it for pointer and padding calculations. This handles snprintf-style
> would-have-been lengths without changing normal output.
>=20
> The next patch connects these dimensions to the view's HPP lists, so the
> symbols used only there are temporarily marked __maybe_unused.
>=20
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D3

