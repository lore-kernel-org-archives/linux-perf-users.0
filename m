Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526E36AB77
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231408; cv=none; b=qT7LPcIAm5eZxxXtOcRCRJBX8rICBu1jjSeuvF5lcTAkFeUgzAa9NtytBPmON0lQpUdYE/USyQnzlec0RhiGWecIxbvxW+wyjnGoaZpDnpr/TOYXEm/unvqiDHtTvoggpFHVUD0IF4T8ONGTr9tsroG2nEbX7v0D8mKMfd4BxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231408; c=relaxed/simple;
	bh=X8SVxDW2WKvEMEVWIPqb6OkKlkyusCER+HuzQQbnw34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFw6krOP07UrcEeCGfvtSt5J1PzymjpOy3tt1m+VmcpJF5zuZM08iNCvUFoQTgb4OXPGcFlku/hWtqWlF/hu1pOQRjYQBroSvKl6XVcZ9iIijvFxu0BXsw6xGkDOg5tApKOxZmedZata+67wCd/+FBoxJ5I4Een8GIIQNWH2bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAzg0amu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAzg0amu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FB51F0089B;
	Mon,  5 Oct 2026 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231407;
	bh=g885DyuNDlaO9uF96RmApC2zxfPkwLRWbukup9kL6CI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAzg0amuS+yR7KBhODlkLc22bLabaPHhIvWuVTF813zsrdz+WGbN0ggTmRRbe64Xx
	 p1F2CwthdVewZNhjJ1U3KL6pX/wdtZl0yL0TsGYmf9MnxyNXFQoybmJVFQ5tIBiBLP
	 2JLDubX1HOSM4wcckNQGGHWbMBZwpWm1l/Kli3ovKeg5GCnhEFQt3O4bT9jNVifVBR
	 b+g8GpVg0o2hAGcV2EvuuJ3tL2GQBhnduUQ7fEQ445jXSn5k538GdHCa+HsokoYijM
	 xwCPDKvZspWD3NS/sSpq/YrUsLk2drePzFr0eruGaeecV7FviS2cSvl3ezeHqUSW5w
	 rnwUc9nYm+oyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005201010.36493-2-yzhao62@ncsu.edu>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
 <20261005201010.36493-2-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:16:46 +0000
Message-Id: <20261005201647.36FB51F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Introduce the die_is_compound_type() helper which checks for
> DW_TAG_structure_type, DW_TAG_union_type, and DW_TAG_class_type, and
> convert the existing open-coded struct/union tag checks to use it:
> - die_get_member_type() in dwarf-aux.c.
> - is_compound_type() and set_stack_state() in annotate-data.c.
>=20
> The switch in __add_member_cb() also handles unions and the nesting
> limit, so DW_TAG_class_type is just added there as another case.
>=20
> Also accept DW_TAG_inheritance in the member lookup callbacks
> (__die_find_member_offset_cb() and __add_member_cb()) so that member
> lookup by offset descends into C++ base class subobjects.
>=20
> In DWARF, a base class subobject is described by a DW_TAG_inheritance
> child of the derived class DIE.  It sits next to the DW_TAG_member
> [ ... ]
> This extends the existing member type resolution and data type
> profiling state handling to C++ classes with inheritance without
> changing behavior for C struct/union types.
>=20
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005201010.3649=
3-1-yzhao62@ncsu.edu?part=3D1

