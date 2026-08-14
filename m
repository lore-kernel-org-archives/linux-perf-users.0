Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9B26A1A4
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669415; cv=none; b=IyVJajaNFeuKj2dWNu5QPxs56xVpF2IMxSCYe3GejRNevFZ0qO0Lc1t58kRhwNxg/fAK6poIVu0IeZ1saZ7/Cdza+6M0HeAVL1TKchQ2MNyjI91S5H90rJbKD8nDz32umhRkAyqTQbx5arN5KkqAtm1zTpyM/e+U37gz8AoQQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669415; c=relaxed/simple;
	bh=10bS/UgvTNe5NnjNx4rluyLwkc6eMzeBjHT9/KpB/lc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJP8MkFixb87ioLuVqPS75XJHoiYEAOkW6yTBzePoHeTNDHyyC6k8H8FIjF8RqjLMRiCVUEQLfC8aqgN/s6ipFKWhPMI7/j7Mw/JEDWEpibdMvBkxzv+ab5ZjE3JpdDmeukQD6SzzuMRzapAhAZQxDARrS70Odp2dp9nqfZvBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWs09VNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWs09VNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A41C1F000E9;
	Fri, 14 Aug 2026 01:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669413;
	bh=10bS/UgvTNe5NnjNx4rluyLwkc6eMzeBjHT9/KpB/lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWs09VNxDwyzDCF7tiP81SM/wDqmHIIBgUknXpwzGO/9VPtiij4jMXb7Z3tb/VaP2
	 xyzfRkTHXrBvUtk6hQPA54OctDGGCNh/7Oi729EaDg6Y/cP4pJu38ESembb+yxbOXy
	 4hxlYjC53iVi0z47C+MpYx9awIq4VVxlk2C92g2fQYyL5uQlDM0AM3SzQ2XSTGfTy9
	 3OlbdqHSOxRZsQBt2Ug9BaTVekLbZOv/Gpbkx2uEZ6ZFnt7FpdjRPEZkN9nbbXkccU
	 snDcNkRWU8WAcfCE7cv15vLrETQCPwoSRc/5VRbp0Q1Nh9nBS8NsIpvNF82SJp7at6
	 HD/iSeQjFE6RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf tools record: Modernize -W man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813211109.240689-2-ak@linux.intel.com>
References: <20260813211109.240689-1-ak@linux.intel.com>
 <20260813211109.240689-2-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:03:27 +0000
Message-Id: <20260814010328.6A41C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Modernize the -W / --weight description in the manpage to cover more
> cases that are supported now.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813211109.2406=
89-1-ak@linux.intel.com?part=3D1

