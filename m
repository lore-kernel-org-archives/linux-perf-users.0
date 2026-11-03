Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724047;
	b=RE53puNR5d8OdEOGCIBZywlM+qDUP8mFfTmyeMAwpgBNR+m4vknpgneObPpoi7BQs02m
	 E0LEftYDFdRhRuaNWVMJ2ztTdHOarLJVQrKmUCivIDSMC/e4YTlE1K12WjF4DZ11aQyZd
	 kUNibabXSc49rn1p7Jr5419q5oGg2s0lPOJ6CFxuu37rgUK5s+nLcBjHYDpi1Z3CMT/J3
	 uXy3cf9cQUlJfY7u+kSaZRExv+xGmDzPaabe7LgoclYiNTibCGbDhK57V9MB5owxSOs9/
	 pq1QbMi9qnAqPUfw2sHjVilEcNbCGhlPe835kUpc7ywfTO+sWaxJhnWJk0ewehgSfiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ahar+PZSezd13EEuRp3JvII5/SAvoTWZ1sBRnuol6Gw=;
	b=rYxn30OVLlGtLX67gMoOh+Dho+uHCIFMgUJN1+un59kOmHMurt6aC0+RQCirrHlqm/RO
	 9nP6BynBK/m0px+FK0WWpNfEUq1W9KXGDRN46gd/9gy45aPdDhSNWj99W1gFxFhzG9u43
	 JS6uG0O9cDlZ9eZD0ATzOaUf3njlTAlERl2P9oTpv5AhB7C/u2x15kA/F3AutCFTkQZYf
	 5sw4kA5DhY4vxroXnqfc8PO0WqNmGj5mu5+ls2fvXcZAjXCJKVTXcinH8AApt4MvdCCcE
	 XdTD8Ax24Zw7gMxd1q63RDwOV3aGm72owTqLAreqffGWGyU8Vz6znevA6z38JPaNkHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxYJ1q83;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7112606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxYJ1q83
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439611F0093A;
	Tue,  3 Nov 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724046;
	bh=Ahar+PZSezd13EEuRp3JvII5/SAvoTWZ1sBRnuol6Gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fxYJ1q83GEBxJbnBCAxpazw6s2NrLAepWA8UZPwgJNTnch8XE0yjpMeUDBCiUcT2h
	 gDLM1P95V3XT+1d7EXoWu3QGMVIcXvrFls92b67X6Ich8ha9bTmJ7IzbdLvy6UhZkw
	 ixKpXUplN4qgw9WZByaGGB0XKlUN+Nt7UN/36pcYlyvfYYr/z+7XiN7C0QC6aKRBiq
	 CGItO6xLFayRsEI4yoqsT2QW5ctawd9jlQ0pQySMg+szXYiBkxIcPNyRZBVEYCWM+M
	 Gh6F9Q4ifuWfK6y3hS5vWpCkExtAiXmBKbC7HaBLIujAEANvCw1Rwr/8iGmNqchMcl
	 0SpDuVC7DU2/Q==
Message-ID: <sashiko-outbox-195734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf annotate: Resolve C++ virtual function
 calls in x86 insn tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103155650.269973-4-yzhao62@ncsu.edu>
References: <20261103155650.269973-1-yzhao62@ncsu.edu>
 <20261103155650.269973-4-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:40:45 +0000
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

commit e681ce13b22214a8ffd9b0e9b51a57f0b2937bb7
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf annotate: Resolve C++ virtual function calls in x86 insn tracking

This commit resolves C++ virtual function calls during x86 instruction
state tracking by tracking vtable pointer loads and virtual function
pointer calls using DWARF vtable helpers.

> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/ut=
il/annotate-arch/annotate-x86.c
> index 3a6ea7e978e0a..e38a4e7a54d55 100644
> --- a/tools/perf/util/annotate-arch/annotate-x86.c
> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> @@ -207,6 +207,29 @@ static int x86__cpuid_parse(struct arch *arch, const=
 char *cpuid)
>  }
> =20
>  #ifdef HAVE_LIBDW_SUPPORT
> +/*
> + * Get the return type of the C++ virtual function at the @offset in the
> + * vtable of @class_die.  Returns false if it's not found or the function
> + * returns void.
> + */
> +static bool vtable_get_rettype(Dwarf_Die *class_die, int offset,
> +			       Dwarf_Die *type_die)
> +{
> +	Dwarf_Die func_die;
> +	int index;
> +
> +	if (offset < 0)
> +		return false;
> +
> +	/* TODO: arch-dependent pointer size */
> +	index =3D offset / sizeof(void *);
> +
> +	if (die_find_virtual_func(class_die, index, &func_die) =3D=3D NULL)
> +		return false;
> +
> +	return die_get_real_type(&func_die, type_die) !=3D NULL;
> +}

[ ... ]

> @@ -615,13 +662,39 @@ static void update_insn_state_x86(struct type_state=
 *state,

[ ... ]

>  		/* And then dereference the pointer if it has one */
>  		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
>  			 state->regs[sreg].kind =3D=3D TSR_KIND_TYPE &&
>  			 die_deref_ptr_type(&state->regs[sreg].type,
>  					    src->offset + state->regs[sreg].offset, &type_die)) {
> +			/*
> +			 * The vtable pointer of a C++ object needs the class
> +			 * to resolve virtual calls through it.
> +			 */
> +			if (!src->multi_regs && die_is_vtbl_ptr_type(&type_die) &&
> +			    die_deref_vptr_class(&state->regs[sreg].type,
> +						 src->offset + state->regs[sreg].offset,
> +						 &type_die))

[Severity: Medium]
Can malformed DWARF debug info with cyclic DW_TAG_inheritance entries trigg=
er
unbounded recursion and overflow the stack when resolving C++ virtual calls
here?

In tools/perf/util/annotate-arch/annotate-x86.c, update_insn_state_x86() and
vtable_get_rettype() wire in the first calls to die_deref_vptr_class() and
die_find_virtual_func(), both of which reach die_get_vptr_class() in
tools/perf/util/dwarf-aux.c:

  update_insn_state_x86()
    -> die_deref_vptr_class()
      -> die_get_vptr_class()

  vtable_get_rettype()
    -> die_find_virtual_func()
      -> __die_find_primary_base_cb()
        -> die_get_vptr_class()

Even if die_deref_ptr_type() succeeds first because a class's _vptr
DW_TAG_member precedes an offset-0 DW_TAG_inheritance entry,
vtable_get_rettype() -> die_find_virtual_func() subsequently walks all
offset-0 DW_TAG_inheritance children via __die_find_primary_base_cb() and
calls die_get_vptr_class(&base_die, 0, &vptr_die).

Although die_find_virtual_func() and die_get_vptr_class() check
++chase > MAX_TYPE_CHASE in their outer loops to guard against cyclic
inheritance, the first iteration of die_get_vptr_class() invokes
__die_find_member_offset_cb():

  tools/perf/util/dwarf-aux.c:die_get_vptr_class() {
      ...
		if (++chase > MAX_TYPE_CHASE) {
			pr_debug("DWARF: base class chase limit reached at DIE 0x%lx\n",
				 (unsigned long)dwarf_dieoffset(type_die));
			return NULL;
		}

		if (die_find_child(&class_die, __die_find_member_offset_cb,
				   (void *)(long)offset, &member_die) =3D=3D NULL)
			return NULL;
      ...
  }

Inside __die_find_member_offset_cb(), any DW_TAG_inheritance child with
offset >=3D loc recursively invokes die_find_child() with
__die_find_member_offset_cb() again without a recursion depth bound:

  tools/perf/util/dwarf-aux.c:__die_find_member_offset_cb() {
      ...
	if (tag =3D=3D DW_TAG_inheritance) {
		if (offset < loc)
			return DIE_FIND_CB_SIBLING;

		if (die_get_real_type(die_mem, &base_die) =3D=3D NULL)
			return DIE_FIND_CB_SIBLING;

		if (die_find_child(&base_die, __die_find_member_offset_cb,
				   (void *)(long)(offset - loc), &member_die))
			return DIE_FIND_CB_END;
      ...
  }

Does this recursion in __die_find_member_offset_cb() bypass the
MAX_TYPE_CHASE check in die_get_vptr_class() on cyclic DW_TAG_inheritance
graphs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155650.2699=
73-1-yzhao62@ncsu.edu?part=3D3
