Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722951;
	b=wPRbg1nmaraSG3qD+Oq7T7QzC0U9TRHyux8E+t23xGAZnMKQhM9a77yP5WM4VLzfYr/x
	 m5DgsN0Ea+S4NgoLWQ37m0cqCnIYqZBy33l1p413uaB+jrjNAtc5HDi/6EaJT7V5Wk502
	 bBkqdcTGYSrVGM1QOBTO2chdmhKMegIuTltDNIjB4nquoJdbYwGig2gS1TKkZHYkLCuNh
	 C5jpPwmm8cnlHsFEfFw0AzuYUhfhN4FNUqWIl8VXlLklHH52td+T9t0IcDAoMT3X6ahKi
	 JSONDbJDoSNcsBI9levjlJK/VvFe3nc+Pu5urbO3B1vMtfGFflM4Q9tQPp4y31H+cSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P3FtUDxJQwIK77wjxLQdmDWGOk3fmBL64O8rIMXaEvo=;
	b=VUo5PQA1I56kaMdme9HWZUfa6eb9izkTqEq1eyFFnHD0wP3t5rNrMRNg0VDh4hUQ1+Tf
	 233yZ63erPACbr4GoX9inmo1S7Tl/d2AEc5ktdWzzct5eSdpSchTs6qGJqAlp9rmkKnJd
	 B1l1jtIp5k3YowRh6thrF69KCoy62QtfYc7EtjwJwwSfXR3O+GhGIs2DZ4S94wfN6Q68R
	 V7kdTQ2PKKgcBqe52WLu7vObdGmsYKIK8rpvTyifXlsCYReqaYa7QNN/rhCs69vXsqEI7
	 FAVoJpA2eeTq+XaB/q7nF2Ojqgi1KwuWzd2SvaUR+g4y9b98IkQeUB5Ct0G/YRg8/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYHRMOgr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C7606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYHRMOgr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A7B1F000C1;
	Tue,  3 Nov 2026 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722951;
	bh=P3FtUDxJQwIK77wjxLQdmDWGOk3fmBL64O8rIMXaEvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYHRMOgrNoXZCNntZvMccuNIeWe9hsBl4BYDqzDQYBTqJU7kMLMkxpuiuB2ssihac
	 9zEBOvLpThA/hWpNQs+86gwk8wUSlFMQDqJUnk1rLuzjaJEzom7q6OFpyMHlzosWK0
	 CdlTDkYYRGXmT/l1f3erIFFx3ZNkjnZWzl2ss4c3JDOxA2nJSUn1MzvPkhPa2iUzLN
	 E/tyxWOU9QelAzxvIN9aXpkOciOmr3lhQ3ajFp4wjhIRf9qYmV8CQrepu7o0yBA40S
	 8bnNYH1s/ytMwWHVi6ggqAvL/G8QsmlOTpitXPC2QExXRCZz5CzoGXdsP2ubd5drpx
	 leNAa97MfzsuA==
Message-ID: <sashiko-outbox-195716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf dwarf-aux: Add C++ vtable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103155650.269973-3-yzhao62@ncsu.edu>
References: <20261103155650.269973-1-yzhao62@ncsu.edu>
 <20261103155650.269973-3-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:22:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf dwarf-aux: unbounded recursion in __die_find_member_offset_=
cb()
--

commit 3556b432528cd90397fc56862bef26cf9afde995
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf dwarf-aux: Add C++ vtable helpers

This commit adds DWARF helper functions (die_get_vtable_index(),
die_find_virtual_func(), die_is_vtbl_ptr_type(), die_get_vptr_class(), and
die_deref_vptr_class()) to support static resolution of C++ virtual function
calls during data type profiling.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index eb4b8f3475df1..10079f47a6c38 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -2293,6 +2293,239 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_di=
e, int offset,

[ ... ]

> +static int __die_find_primary_base_cb(Dwarf_Die *die_mem, void *arg __ma=
ybe_unused)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die base_die, vptr_die;
> +	Dwarf_Word loc, virtuality;
> +
> +	if (dwarf_tag(die_mem) !=3D DW_TAG_inheritance)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	/* The attribute can be present with DW_VIRTUALITY_none */
> +	if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr) &&
> +	    dwarf_formudata(&attr, &virtuality) =3D=3D 0 &&
> +	    virtuality !=3D DW_VIRTUALITY_none)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (die_get_data_member_location(die_mem, &loc) < 0 || loc !=3D 0)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (die_get_real_type(die_mem, &base_die) =3D=3D NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	/* It should have the vtable pointer at offset 0 */
> +	if (die_get_vptr_class(&base_die, 0, &vptr_die) =3D=3D NULL)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	return DIE_FIND_CB_END;
> +}

[ ... ]

> +Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
> +			      Dwarf_Die *die_mem)
> +{
> +	Dwarf_Die class_die =3D *type_die;
> +	Dwarf_Die vptr_class =3D *type_die;
> +	Dwarf_Die member_die, mb_type;
> +	Dwarf_Word loc;
> +	int chase =3D 0;
> +
> +	while (die_is_compound_type(&class_die)) {
> +		if (++chase > MAX_TYPE_CHASE) {
> +			pr_debug("DWARF: base class chase limit reached at DIE 0x%lx\n",
> +				 (unsigned long)dwarf_dieoffset(type_die));
> +			return NULL;
> +		}
> +
> +		if (die_find_child(&class_die, __die_find_member_offset_cb,
> +				   (void *)(long)offset, &member_die) =3D=3D NULL)
> +			return NULL;

[Severity: Medium]
As reported by Namhyung Kim on v2 [1], broken DWARF debug info with cyclic
inheritance requires recursion depth limits when chasing base classes.

While die_get_vptr_class() and die_find_virtual_func() add a MAX_TYPE_CHASE
check on their outer loops, die_get_vptr_class() (which is also invoked by
die_find_virtual_func() -> __die_find_primary_base_cb() ->
die_get_vptr_class()) calls die_find_child() with
__die_find_member_offset_cb() on its first iteration (chase =3D=3D 1).

Inside __die_find_member_offset_cb(), when encountering a DW_TAG_inheritance
child with offset >=3D loc, it recurses into base_die without a depth limit:

tools/perf/util/dwarf-aux.c:__die_find_member_offset_cb() {
	...
	if (tag =3D=3D DW_TAG_inheritance) {
		Dwarf_Die base_die, member_die;
		...
		if (offset < loc)
			return DIE_FIND_CB_SIBLING;

		if (die_get_real_type(die_mem, &base_die) =3D=3D NULL)
			return DIE_FIND_CB_SIBLING;

		if (die_find_child(&base_die, __die_find_member_offset_cb,
				   (void *)(long)(offset - loc), &member_die))
			return DIE_FIND_CB_END;

		return DIE_FIND_CB_SIBLING;
	}
	...
}

If a binary has malformed DWARF with cyclic DW_TAG_inheritance (for example,
at offset 0), won't __die_find_member_offset_cb() recurse until stack
exhaustion on the first iteration before returning to the outer MAX_TYPE_CH=
ASE
loop in die_get_vptr_class() or die_find_virtual_func()?

[1] https://lore.kernel.org/r/asA1u7LBRp2gqbWI@google.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155650.2699=
73-1-yzhao62@ncsu.edu?part=3D2
