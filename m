Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903503;
	b=Yxuhx/03RUVFEJojpAAUNS7SV9RfjOxP6pigOwUSlhHLp4wtfHTYEC4z93C3+V7A7wnq
	 T13qpSRgniOBGMNkIBFNlPwgkobHE8Yo269k0cZy4RgzAEkAuevF8OyXamZlCOiZu3Buo
	 23X1rHJIF3Ad3A9V2+UokKCo2w9jzLHPVaYqrsRs1DHxchxMX8T61B3eRuC2FFWgxjgqo
	 JDNJX26PIaEDR2PtMb2e7/xiICcJCC+OR8MN+7g2IX7eBnm8Yqs+8y32hNPoH5ijtISXU
	 tl/CidjFLK2/YDELvNNzk7DfDOlZVMZ8jUIucVRJJGRdlwcN8Xo7k/4MY8wi2l3CoGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903503;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ua/+aPiNUKpr/iU7x5GlHiVbXs3HQwbzJrZx65tmogw=;
	b=uboxVeQuQaMsrDpPbLwIiAyMO6TOWayYBbxB9wcLBxVhqopB6XK53gwQG0IRTWl9kM0z
	 mKX+gSZGP3TwQ6brxzqO1NXziSsZLZw0wQauLlD7ItjJjEzR3awfzmvad4bAdg2owdclM
	 IEM6B1jXXi8+TRCWiuaZ6wwK6bpAC5CB7Eo4C/kOUbmnEO/WQfGfCkJRcAPtPrAuA6FFn
	 x7LOKK7hyg7tpChliiXnISSKa3ibCinOIr69SVETXDF1qvkAC1kbN5JNXuo8PfcmXpuAb
	 4L38PMkGCfV1XybiFRLrWGgEjjuGFQyFldG/SV2I5EAHddUOO2PerRMDcWdMBqD9Qmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSbAk6zr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEBA606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSbAk6zr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3C51F00A16;
	Thu,  5 Nov 2026 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903502;
	bh=Ua/+aPiNUKpr/iU7x5GlHiVbXs3HQwbzJrZx65tmogw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSbAk6zr5xBG9MDgUYpMGbpX0KpqcBPqZ7kTPcDa6yXRK0CCyVEIDPUHfgY+QuAEp
	 8sIGsdKZDt1DQLLPNgPi7ZhDZfL6dlzKJeyVLzbwIoxIPAKi4Lprg7KRNDvog2XszT
	 +WVDLiePZ7+1UtnlRLi5JmzF8so5EHdPNpkBvRdIsJuEDA9G1oHWQJQoWYe4TRKWAe
	 FAPpCNxSHgyriJYdBZShxu6+n1zIQY7zl5oIA61jGOejK/GZZ/T5wu4wzAwQFj8NAv
	 04kn0OyOu+48XUIBxjSyzyRuMsJPRBHsm659vgCSZ4kbLyAvFxrc1udwmXRkqlEH8N
	 TYO5SnDNqStAg==
Message-ID: <sashiko-outbox-199773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105181949.43198-2-yzhao62@ncsu.edu>
References: <20261105181949.43198-1-yzhao62@ncsu.edu>
 <20261105181949.43198-2-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:31:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105181949.4319=
8-1-yzhao62@ncsu.edu?part=3D1

