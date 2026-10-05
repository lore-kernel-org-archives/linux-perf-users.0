Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9947AF57
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231449; cv=none; b=buehS28WJbH8/zwEQed2dodp+qBg6loy1U5iPeKzr31bhnkDgVzZd6dxsYXkYQT9cwQaXLCCqKYfGpp4PDBKTZXZJkZ50z77MoJlYUgASKB1/xwFV0g8kUFM7zs/fCCJK5LTqeR5uaKyq/zqfBUCmTGRmHYvim4x4rJbqzjgHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231449; c=relaxed/simple;
	bh=JTiYYbPmd1ASjTMxVGJt/yEGXHAPwO4DYpCIDkk1qME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJe4V1rfPrTdMP3JMutpOXHsd7PRzXa7eRNPXIKoVawVdrMOXRxhzZfyFU8pPWOIVXI9n4bVcPOpzjXbaMuiGhI0KZPjJMoI8nenbEyDO2SLz4Q4oxisM7FWfT2awioNkbj2xkd8ykYIzsSBumDnUA1JDJmqSSrMey2q8SNRWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq1hDKmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq1hDKmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34551F00898;
	Mon,  5 Oct 2026 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231448;
	bh=co3cOIQrMu7IIpSid9GTPIgWQk3zVQaqVfAgoigMZnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hq1hDKmorwbNwfh7i2UBwob7lwLXwHL3047CJxEWO664k9R17W53f/FdJQuVczASF
	 7WKVZu5BJuZ9uizfz5KWFHTaVJhAb08J2eB9rPsvM8JFeYp1qYEmkzJAe/iie/WNXh
	 nGxU4JzGYTr3mDExIRG/JlFvAhnM7ymPwvsk6GgdTC7mXJpXMH2vFJcmxFc329GxcK
	 W1ddkEGeLNrl9LzFOJTLxfmxeOw4/YNdLhNmv8669wY/Fyb1Kf+4A3O5UYrvh3BxPQ
	 m6SSyZSlhH1+G1Up5ZcEzG6b0m9cCHx4Vp4x+5CUwJKshvKRyr6g7loj3l2lSjjIN/
	 oxM53x8RDlCKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] perf dwarf-aux: Add C++ vtable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005201010.36493-3-yzhao62@ncsu.edu>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
 <20261005201010.36493-3-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:17:27 +0000
Message-Id: <20261005201727.F34551F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add DWARF helper functions needed to resolve C++ virtual function calls
> statically in the data type profiling:
>=20
> - die_get_vtable_index() returns the vtable slot index of a virtual
>   function DIE from DW_AT_vtable_elem_location.  DWARF defines the
>   attribute as a location description of the slot but GCC and Clang
>   both emit the slot index as a single DW_OP_constu, which is also how
>   debuggers interpret it.
>=20
> - die_find_virtual_func() finds the virtual function DIE at a given
>   vtable slot index of a class.  The (primary) vtable of a class starts
>   with the vtable of its primary base class, i.e. the first non-virtual
>   base class at offset 0 which has a vtable, and the slots for virtual
>   functions introduced by the class come after that.  So it looks at
>   the class first and then follows the primary base class chain.
> [ ... ]
> finds Base::set() through the primary base.  The vtable pointer at
> offset 16 belongs to the Other subobject, so it's looked up with Other
> where slot 0 finds Other::hi().
>=20
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005201010.3649=
3-1-yzhao62@ncsu.edu?part=3D2

