Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D75386C2A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289152; cv=none; b=CMDGZzG7gyYyB4wkOkpOdBrgW5a5/0e2JbindYBQUriv9MyXblkNOGqTHpeCj4iHLtqECK8NRb66BXHhVeHzRk6xFffB6wrskwhO6fu+TOog8WWZABwoKdmMDXwAq7fhmaJerioqST8OEwnc9RWNVd+oDqqOBc4THZ2fLhjg7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289152; c=relaxed/simple;
	bh=pgTCElLHkSkZkmInvsVCy/RkLAUdGLQUfDzbjnGJQq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K1FJhE/jNd5lZzwQ+VffcuIjLzenIehbBVZebAkAYHbbkQL5r1owTTDoa41s7qsH7PbeblHDq92/sAM4/d52ZCxj3b7riy4HKa9ImkPpNpbX8OXcI/7kjVHAplpbDOF3o6cdeARhq5JYhCfZZYWVXj403EXeqntmQSvHQ0hsSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5mzfDRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5mzfDRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F45C1F000E9;
	Fri, 21 Aug 2026 05:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787289150;
	bh=lK8CL5CH/AHqzzUc+34dQlVulSibmgK7Ri0gPYjI7Pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5mzfDRdW8TNLCqulcc/Zo5Bobu1wFSuYPJSAoDSWXgLKbIrZJ8zNffgcaeMeJfny
	 L+EMQMaaIPoZ0XiMnN8tSIGHY3/HRU1wOqApecj7MJGqz7SGYsV8Mpg8XmxB+Pg4pd
	 W58hqXZ37aWJJJ2M2b2iLDWaCz1RkV1duuawU4Vqfgm0/kYRShrb3CH3O4ZbGCgMFG
	 SYd0x6YutrXhPzI9ia/UIEMzIUJX9h2i8kui+ke8baRv9T1cQ7EjXB8j73fEnmmsBI
	 7CHBpS9FPk1yyzEfN5NDyMxWyHIJW5XowbOfQCbzgd2CeLr5zAhhjk+5vL6yU+uiTV
	 7h4tCLiaSOgMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf dwarf-aux: Add C++ class, inheritance and
 vtable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821050207.4517-3-yzhao62@ncsu.edu>
References: <20260821050207.4517-1-yzhao62@ncsu.edu>
 <20260821050207.4517-3-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:12:29 +0000
Message-Id: <20260821051230.5F45C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `die_find_virtual_func` returns a `DW_TAG_inheritance` DIE instead=
 of a `DW_TAG_subprogram` DIE when resolving inherited virtual functions.
- [High] `die_get_vtable_index` inconsistently returns a byte offset instea=
d of an array index on pre-DWARF 5 binaries.
- [Medium] `die_get_base_class` bypasses DWARF expression handling for `DW_=
AT_data_member_location`, causing incorrect offsets on older DWARF formats.
--

--- Patch [2]: [PATCH 2/3] perf dwarf-aux: Add C++ class, inheritance and v=
table helpers ---
commit 11247af931b847d92f3746e9aef5b7921e7db0a0
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf dwarf-aux: Add C++ class, inheritance and vtable helpers

This patch adds several DWARF helper functions to support C++ virtual funct=
ion
inspection. It includes utilities for detecting source language, retrieving
base classes, inspecting virtual tables, and locating class members. The
helpers fall back to older DWARF constructs when DWARF 5 constants are
unavailable.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 88ba0ec23a686..e991eed963a8a 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c

> [ ... ]

> @@ -68,6 +112,90 @@ bool die_is_compound_type(Dwarf_Die *type_die)

> [ ... ]

> +Dwarf_Die *die_get_base_class(Dwarf_Die *class_die, Dwarf_Die *base_die,=
 int *offset)
> +{
> +	Dwarf_Die inherit_die;
> +	Dwarf_Attribute attr;
> +	Dwarf_Word loc;
> +
> +	if (die_find_child(class_die, __die_find_inheritance_cb,
> +			   &inherit_die, &inherit_die) =3D=3D NULL)
> +		return NULL;
> +
> +	if (__die_get_real_type(&inherit_die, base_die) =3D=3D NULL)
> +		return NULL;
> +
> +	if (dwarf_attr_integrate(&inherit_die, DW_AT_data_member_location, &att=
r) &&
> +	    dwarf_formudata(&attr, &loc) =3D=3D 0) {
> +		*offset =3D loc;
> +	} else {
> +		*offset =3D 0;
> +	}

[Severity: Medium]
On older DWARF binaries, DW_AT_data_member_location is emitted as a location
block (e.g., DW_OP_plus_uconst) rather than a simple udata constant.=20

Since dwarf_formudata() fails on blocks, does this silently fall back to
setting the offset to 0, yielding the wrong base class offset?

Could this use the existing die_get_data_member_location() utility which
already handles both dwarf_formudata() and location expressions?

> +
> +	return base_die;
> +}
> +
> +int die_get_vtable_index(Dwarf_Die *func_die, int *index)
> +{

> [ ... ]

> +	/* Fallback to DW_AT_vtable_elem_location (older DWARF) */
> +	if (dwarf_attr(func_die, DW_AT_vtable_elem_location, &attr)) {
> +		Dwarf_Op *expr;
> +		size_t expr_len;
> +
> +		/* Compile often emits it as a simple constant expression or block */
> +		if (dwarf_getlocation(&attr, &expr, &expr_len) =3D=3D 0 && expr_len > =
0) {
> +			if (expr[0].atom =3D=3D DW_OP_constu) {
> +				*index =3D expr[0].number;

[Severity: High]
Does this fallback logic return a byte offset instead of an array index on
pre-DWARF 5 binaries?

If a binary uses DWARF 4, DW_AT_vtable_elem_location yields the byte offset
in the vtable. Should this byte offset be divided by the pointer size before
being assigned to the index to ensure it behaves consistently with DWARF 5?

> +				return 0;
> +			}

> [ ... ]

> @@ -2164,6 +2292,70 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die=
, int offset,

> [ ... ]

> +static int __die_find_virtual_func_cb(Dwarf_Die *die_mem, void *arg)
> +{

> [ ... ]

> +	if (tag =3D=3D DW_TAG_inheritance) {
> +		Dwarf_Die base_type;
> +
> +		if (__die_get_real_type(die_mem, &base_type)) {
> +			if (die_find_child(&base_type,
> +					   __die_find_virtual_func_cb,
> +					   ad, &ad->func_die))
> +				return DIE_FIND_CB_END;
> +		}
> +	}
> +
> +	return DIE_FIND_CB_SIBLING;
> +}
> +
> +Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index, Dwarf_=
Die *die_mem)
> +{
> +	struct find_virtual_func_data ad =3D {
> +		.index =3D index,
> +		.found =3D false,
> +	};
> +
> +	if (die_find_child(class_die, __die_find_virtual_func_cb, &ad, die_mem))
> +		return die_mem;

[Severity: High]
When resolving a virtual function implemented in a base class, does this lo=
gic
return a DW_TAG_inheritance DIE instead of the actual DW_TAG_subprogram DIE?

If the nested search in __die_find_virtual_func_cb() successfully finds the
subprogram, it populates ad->func_die and returns DIE_FIND_CB_END. However,
the outer die_find_child() loop in die_find_virtual_func() terminates and
returns its current iteration pointer, die_mem.

Since die_mem points to the DW_TAG_inheritance DIE at that moment, does this
ignore the populated ad.func_die and return the inheritance DIE to the call=
er?

> +
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821050207.4517=
-1-yzhao62@ncsu.edu?part=3D2
