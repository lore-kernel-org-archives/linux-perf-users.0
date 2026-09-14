Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE1304BDF
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350943; cv=none; b=StbwBx5OcNSqU8DdPv3DkEYVp9R9UH8JBXEh2p9a1CtFq3mkQMOs5EXb75lN2vX8pliBEAXX2aQeC26/9VCpuQf9SaH6rw4zcgdJ7LUbcGWKsPoYlt3d7+zMLbsgS8H8a7dAZUvnhAmg+Eb0kYiVwPgo8xs6HJpZEhnw2KBuQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350943; c=relaxed/simple;
	bh=hW7+wFr7yPv4JBxebkfAJ3MdyanHAEifuVGEIrBqOlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fl2mPK15YXb+IIBmW0wOc1OUQZ5CwbALsIpYRn8sI8jRktslekAPXtfGQz7L2BWrP5By9gaHyJ8R2+K8Xe2rJKnPEWqPByyCKGJB1I5qMNuvrsuUgrwCLLmY05cJZrPf59OP9hJigUFJ6iq/cjdyjeSWbwntrorMSa+85ratqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9di2Yad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9di2Yad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5861F000FF;
	Mon, 14 Sep 2026 01:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350942;
	bh=hW7+wFr7yPv4JBxebkfAJ3MdyanHAEifuVGEIrBqOlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R9di2YadGf40K+mAIpcDgrjDCTE761p9RxYldFce+9+fCO+3KSxGEw3nieLx85jvO
	 NP7Zfi1z36l4QttE61DhJ3umj31oJQsUruQ4V5/xpqeygeYkkhh46VBQsxckic1/gM
	 KTdG6eS/XpVqgWyCXUrwBeGehDWN8MWlXeWmKbHaAjR2pHE8q3yo/SjqNSkQVRerub
	 g9oOe+BNw1CouK2FX9qtphf6OCkyhIkEOyKCTF+eIMbs//rlLluIl0N5gv5EhsQPYf
	 xD/mJYkR0yfa7xrjv0QyWKW0YQL+Vbyw7Vdi8PnzPblrf+yffumbGcsRiuUmi+x0aL
	 dFa9X/AolCZhg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 01/10] perf dwarf-regs: Fix DWARF register index
 bounds check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-2-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:55:41 +0000
Message-Id: <20260914015542.3D5861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Tighten bounds validation in __get_dwarf_regnum_for_perf_regnum_xxx()
> helpers by changing perf_regnum > ARRAY_SIZE() to
> perf_regnum >=3D ARRAY_SIZE().
>=20
> This fixes an off-by-one condition where perf_regnum =3D=3D ARRAY_SIZE()
> could pass validation and cause out-of-bounds access for
> dwarf_xxx_regnums[].
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D1

