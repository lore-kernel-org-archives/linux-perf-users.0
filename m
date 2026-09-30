Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35A42CAE7
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802658; cv=none; b=kzpIqiN0paDVgEpoLB4Jspm661ilmXyczk1m/w/JiEoTJeNS0HNKCy3eqUZhr42qm9dIns8uUUYEPFKD+03wQW9sfAzaXg06DOCHgQDEsEvSHXP6CL4pA1Kpcns6ymG6EObyC03THcC7B+eAFikwe64jkZkSLWBkxJaiTPhyz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802658; c=relaxed/simple;
	bh=st7/cWPZXTMfahEePY4wjQ4MO0qZsd5tOlUTskkEcBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJa93+wD0BadRTzXNVah8ixjVzu99NFHYZ4/D6C+Zpvu/L66eKRNBh9QGbdW4fDaI3A+HIdhF98eMykNdxJivzHfvb9IEQln1f6eVePC9YoQOegJxaZ6TmpWYaJRH+Q9Mt+kO2BTn52aAwcR+97ccgVPceflXEzhouh6hl/3ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKoHJ/tO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKoHJ/tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1641F000FF;
	Wed, 30 Sep 2026 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802657;
	bh=Lyfz5CARg519hLgbHk26vz7GOnYejQDx6kmUqLMpsnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKoHJ/tOKd65Ree1mu8Lnsph1novDlMH0XB8URrGZg1zUCypcA1XcJcTNNMe3okjb
	 tCIWjR2GeEiTtP7vpM1xQs/FZhPcV9c1bnlBx/PKm9Rm1uIeL75rxDa9UwpVijBqeu
	 A8m2hexAGHFgjTshrvJz6jHshEBtLmwbHtycOnqu19C4m41rkpyJpD/CWp5n2F3JgZ
	 r8WCRjt1t4itpiH++LKmQwLY7hFazvt+XDWJjCr2rJVONmpQL58Fb6LyBsOzogcFio
	 IG7PDknGS9xIQubQ6FF41hdt9FmE33zb5YTSYaT5JiCc1QmZA+4hTln9l7n4S+VJOZ
	 cLTPlO9qV84Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf dwarf-aux: Add C++ vtable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930210038.196928-3-yzhao62@ncsu.edu>
References: <20260930210038.196928-1-yzhao62@ncsu.edu>
 <20260930210038.196928-3-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:10:56 +0000
Message-Id: <20260930211057.2E1641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf dwarf-aux: DW_AT_virtuality presence check incorrectly skip=
s non-virtual bases
- [Medium] perf dwarf-aux: infinite loop in C++ inheritance traversal on ma=
lformed DWARF
--

commit e1f1b87424c8d58d923a8c3fbc1408fa0ae0c3b9
Author: Yanbo Zhao <yzhao62@ncsu.edu>

perf dwarf-aux: Add C++ vtable helpers
   =20
Add DWARF helper functions needed to resolve C++ virtual function calls
statically in the data type profiling.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index eb4b8f3475df1..b1f3dca057abb 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -2293,6 +2293,222 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_di=
e, int offset,
> [ ... ]
> +static int __die_find_primary_base_cb(Dwarf_Die *die_mem, void *arg __ma=
ybe_unused)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die base_die, vptr_die;
> +	Dwarf_Word loc;
> +
> +	if (dwarf_tag(die_mem) !=3D DW_TAG_inheritance)
> +		return DIE_FIND_CB_SIBLING;
> +
> +	if (dwarf_attr_integrate(die_mem, DW_AT_virtuality, &attr))
> +		return DIE_FIND_CB_SIBLING;

[Severity: Medium]
Does this code incorrectly skip valid primary base classes when parsing DWA=
RF 5?

DWARF 5 allows DW_AT_virtuality to be present with the default value
DW_VIRTUALITY_none (0x00).

If a compiler explicitly emits this default value, will the presence check
evaluate to true and falsely identify the non-virtual base as virtual,
skipping it?

> +
> +	if (die_get_data_member_location(die_mem, &loc) < 0 || loc !=3D 0)
> [ ... ]
> +Dwarf_Die *die_find_virtual_func(Dwarf_Die *class_die, int index,
> +				 Dwarf_Die *die_mem)
> +{
> +	Dwarf_Die cur_die =3D *class_die;
> +	Dwarf_Die base_die;
> +
> +	while (die_is_compound_type(&cur_die)) {

[Severity: Medium]
Can this loop hang indefinitely when processing malformed DWARF?

If a maliciously crafted or malformed DWARF file contains cyclic inheritanc=
e,
die_get_real_type() resolves the type back to the current class.

Since the loop does not maintain a depth counter or cycle detection, does it
spin infinitely as it re-evaluates the same class type?

> +		if (die_find_child(&cur_die, __die_find_virtual_func_cb,
> +				   (void *)(long)index, die_mem))
> +			return die_mem;
> [ ... ]
> +Dwarf_Die *die_get_vptr_class(Dwarf_Die *type_die, int offset,
> +			      Dwarf_Die *die_mem)
> +{
> +	Dwarf_Die class_die =3D *type_die;
> +	Dwarf_Die vptr_class =3D *type_die;
> +	Dwarf_Die member_die, mb_type;
> +	Dwarf_Word loc;
> +
> +	while (die_is_compound_type(&class_die)) {

[Severity: Medium]
Similarly, does this loop also lack a depth limit or cycle detection when
traversing base class subobjects dynamically, risking infinite cycles on
malformed DWARF?

> +		if (die_find_child(&class_die, __die_find_member_offset_cb,
> +				   (void *)(long)offset, &member_die) =3D=3D NULL)
> +			return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210038.1969=
28-1-yzhao62@ncsu.edu?part=3D2
