Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778655;
	b=qchORHAUyTZikWgmFuUatcWE5QYbPoIHUCiMx35/GwPJZRAkPzdQLCYyPDarkv115vtM
	 AsR/5QqQtUnqZfuleug6r2IzzLU9Tl4tZ8czAmV0wTQWKJfIwkpDANxEdF1qt7BwC9yuv
	 244KWDOh0eMCpgvyJElLLIYdjk4CIpnTD4nittel2+6M1Y0yvoGjRjcXnB5FqiyFjV5nJ
	 JSAxY1rZq+k3sfHhW2tUhcyy7FMlEKLEnQjcwPBomFWb4dbFQyQsabuYzyf3A/QC8mBF8
	 ILTA/bMEMYvpUoAXC4RR8nohq3KpbY55lxgRnKg7h/gHu1nlP5sjkyIKjNX5lUV1vVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778655;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=N5UuCC/Ms2hLZxT1jvIYIL2yeL6N/vJPxW5qz9SFjXQ=;
	b=JvUXAv4BLQvdUdftd/q6MSGvF65OMB2t7bbYVavGlbjStzKX66l6l6fc1RIC5I/w33Xh
	 Vr7/KHTvziCGtLwWWEMrnQjgf3UFUS0MqHGW3hzfmFE7LqSHNDG2C2ZJWCBESasfTT79a
	 YKut/pyh77/Se+/eP8D6CRQ2BlQQyyqTh4HC0GaafZDnGj4lrWZQpGUob90fuKxVGDR+u
	 4faKQweKrwJSJWRWr0EFpq0XgktDGWdLFLIFrT7EBGy22lVWsWM3h1tukImbWUZnfrmF+
	 oGoJOgTyDX2euVD2hST2H6rcF+LwtBJ41r9q9Rz30t+WEChvXz+ZqMcxXFGm5dSelqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceZAPvn1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98D606A31B;
	Wed,  4 Nov 2026 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceZAPvn1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD9F1F000C1;
	Wed,  4 Nov 2026 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778654;
	bh=N5UuCC/Ms2hLZxT1jvIYIL2yeL6N/vJPxW5qz9SFjXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ceZAPvn1eGF2M2UHVzcXgEmfg1foS3VLm/MiMc79yUZNuIzfo7SiwHsIVSVEKLOWo
	 W1F8UpxHNIfN7rmmrjbTA+UeGnuOH6IBrSDhS/aS5ZlZxla319nDL8pmmn4NFR6S1Z
	 GW8yFQBNuF+t6ynqhq8HdTCYjejDIk/u2mDxbzENumKB7XFXWQxMASDVoOGs1lU2FZ
	 PiLOS3mXbs2FKTGYR+Z7YUr55B9ftc0sLpgWxP0+ye6s5f+aBy8KSZeUdJSGPcDl+q
	 pp9J6BYonK/nC2PiM3OTK0sXki8qCQKKnW9sKwolQaYUOIGjH38GsoU5tOrzX51Bgy
	 mxHgw5CiCE4jg==
Date: Tue, 3 Nov 2026 23:50:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Yanbo Zhao <yzhao62@ncsu.edu>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/3] perf dwarf-aux: Add C++ vtable helpers
Message-ID: <aurj3WMsv2mwM971@z2>
References: <20261103155650.269973-1-yzhao62@ncsu.edu>
 <20261103155650.269973-3-yzhao62@ncsu.edu>
 <sashiko-outbox-195716@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-195716@kernel.org>

On Tue, Nov 03, 2026 at 04:22:30PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf dwarf-aux: unbounded recursion in __die_find_member_offset_cb()
> --
> 
> commit 3556b432528cd90397fc56862bef26cf9afde995
> Author: Yanbo Zhao <yzhao62@ncsu.edu>
> 
> perf dwarf-aux: Add C++ vtable helpers
> 
> This commit adds DWARF helper functions (die_get_vtable_index(),
> die_find_virtual_func(), die_is_vtbl_ptr_type(), die_get_vptr_class(), and
> die_deref_vptr_class()) to support static resolution of C++ virtual function
> calls during data type profiling.
> 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index eb4b8f3475df1..10079f47a6c38 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -2293,6 +2293,239 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
> 
> [ ... ]
> 
> > +static int __die_find_primary_base_cb(Dwarf_Die *die_mem, void *arg __maybe_unused)
> > +{
> > +	Dwarf_Attribute attr;
> > +	Dwarf_Die base_die, vptr_die;
> > +	Dwarf_Word loc, virtuality;
> > +
> > +	if (dwarf_tag(die_mem) != DW_TAG_inheritance)
> > +		return DIE_FIND_CB_SIBLING;
> > +
> > +	/* The attribute can be present with DW_VIRTUALITY_none */
> > +	if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr) &&
> > +	    dwarf_formudata(&attr, &virtuality) == 0 &&
> > +	    virtuality != DW_VIRTUALITY_none)
> > +		return DIE_FIND_CB_SIBLING;
> > +
> > +	if (die_get_data_member_location(die_mem, &loc) < 0 || loc != 0)
> > +		return DIE_FIND_CB_SIBLING;
> > +
> > +	if (die_get_real_type(die_mem, &base_die) == NULL)
> > +		return DIE_FIND_CB_SIBLING;
> > +
> > +	/* It should have the vtable pointer at offset 0 */
> > +	if (die_get_vptr_class(&base_die, 0, &vptr_die) == NULL)
> > +		return DIE_FIND_CB_SIBLING;
> > +
> > +	return DIE_FIND_CB_END;
> > +}
> 
> [ ... ]
> 
> > +Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
> > +			      Dwarf_Die *die_mem)
> > +{
> > +	Dwarf_Die class_die = *type_die;
> > +	Dwarf_Die vptr_class = *type_die;
> > +	Dwarf_Die member_die, mb_type;
> > +	Dwarf_Word loc;
> > +	int chase = 0;
> > +
> > +	while (die_is_compound_type(&class_die)) {
> > +		if (++chase > MAX_TYPE_CHASE) {
> > +			pr_debug("DWARF: base class chase limit reached at DIE 0x%lx\n",
> > +				 (unsigned long)dwarf_dieoffset(type_die));
> > +			return NULL;
> > +		}
> > +
> > +		if (die_find_child(&class_die, __die_find_member_offset_cb,
> > +				   (void *)(long)offset, &member_die) == NULL)
> > +			return NULL;
> 
> [Severity: Medium]
> As reported by Namhyung Kim on v2 [1], broken DWARF debug info with cyclic
> inheritance requires recursion depth limits when chasing base classes.

Can you please address this?

Thanks,
Namhyung

> 
> While die_get_vptr_class() and die_find_virtual_func() add a MAX_TYPE_CHASE
> check on their outer loops, die_get_vptr_class() (which is also invoked by
> die_find_virtual_func() -> __die_find_primary_base_cb() ->
> die_get_vptr_class()) calls die_find_child() with
> __die_find_member_offset_cb() on its first iteration (chase == 1).
> 
> Inside __die_find_member_offset_cb(), when encountering a DW_TAG_inheritance
> child with offset >= loc, it recurses into base_die without a depth limit:
> 
> tools/perf/util/dwarf-aux.c:__die_find_member_offset_cb() {
> 	...
> 	if (tag == DW_TAG_inheritance) {
> 		Dwarf_Die base_die, member_die;
> 		...
> 		if (offset < loc)
> 			return DIE_FIND_CB_SIBLING;
> 
> 		if (die_get_real_type(die_mem, &base_die) == NULL)
> 			return DIE_FIND_CB_SIBLING;
> 
> 		if (die_find_child(&base_die, __die_find_member_offset_cb,
> 				   (void *)(long)(offset - loc), &member_die))
> 			return DIE_FIND_CB_END;
> 
> 		return DIE_FIND_CB_SIBLING;
> 	}
> 	...
> }
> 
> If a binary has malformed DWARF with cyclic DW_TAG_inheritance (for example,
> at offset 0), won't __die_find_member_offset_cb() recurse until stack
> exhaustion on the first iteration before returning to the outer MAX_TYPE_CHASE
> loop in die_get_vptr_class() or die_find_virtual_func()?
> 
> [1] https://lore.kernel.org/r/asA1u7LBRp2gqbWI@google.com
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261103155650.269973-1-yzhao62@ncsu.edu?part=2
