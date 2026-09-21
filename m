Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98E4E0B72
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009826; cv=none; b=E6P7twBhJyC3ojaew9bgrNi1b0Gv4SGW7DrSd+v6rmuk7QYRQ6psPfWzOyWPWHLXHy/5fdNyrprwqRVvl4zYL3aQyixKRaa/Mp9GlfAeQis44keY/LwIrp+FNjHWx8g3vkpEV2ckqCnnpzXk3ZRR/5Mdtt7Ui9TXcQlSTftaCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009826; c=relaxed/simple;
	bh=BCff0Owgn+l/SkKpDkywKq7/K3DQYPFLP0DJbgMDJ/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovqqHzTwVCwZdTcm7btXxltpKJVMXuHXOu3cDPgZUzuordEugZcQ2H8BfmE0UvwDRTKL87Bejl5B424+krshXMxVuEMojZJyfOCiTZ/0wUvfszGasXfaNVBabCPFhmvbOmOc1Nh+oIU12T6xhg4Y/2kOBQAEM19P0i6PFGi2lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lydewa/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lydewa/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DBD1F000FF;
	Mon, 21 Sep 2026 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009824;
	bh=raknFsnNr0GmPVthY1Twv9xNEyoLt4HEHpdacmXst8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lydewa/f/fK1h83JDiFPJfzeQ5UarpCRq4kL/jH7RZstr26duJaxJC/XMVMZMuNoX
	 wnfE1MnOX4JzF8gdIJE1Mz04zqdcbxtRZ8xUosswEGJ7Lwu90vh2ViKyY8jSxgfEQ6
	 XjSJMLtMrZnSnpf1LLOVrglZbKUO5f9al34ssxe8eFHDOCd1IeYCfL6jO1nUYMWHtZ
	 7PrqyMbvnG4nc8RHtL21RfcKovlOvStPNcLbc/hOywwiAjO+IYWEuhtrDCdwf/J4HU
	 TzJ4Ev2AgG37VmQU9GheWTlfWPdC/dPyD3xqdRdxcW3+qfdw1Wgh8//qrBlxkf63zW
	 XPpApZbrIpJdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] perf annotate-data: Bound the member nesting
 recursion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-5-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:57:03 +0000
Message-Id: <20260921165704.38DBD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: primitive fields incorrectly marked as truncated at max de=
pth
--

commit 53c26f5303c3adc8952e84e580aba93503743c50
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate-data: Bound the member nesting recursion

This commit introduces a recursion depth limit of 32 when adding members
from DWARF debug information. It prevents infinite recursion caused by
broken DIEs that point back to their own ancestors by marking deep members
as truncated and stopping further parsing.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 2ad6d012e069c..f44fb333bc674 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -289,10 +300,19 @@ static int __add_member_cb(Dwarf_Die *die, void *ar=
g)
>  	}
>  	member->size =3D size;
>  	member->offset =3D loc + parent->offset;
> +	member->depth =3D parent->depth + 1;
>  	INIT_LIST_HEAD(&member->children);
>  	list_add_tail(&member->node, &parent->children);
> =20
>  	tag =3D dwarf_tag(&die_mem);
> +	if (member->depth >=3D MAX_MEMBER_DEPTH) {
> +		/* Reported by the JSON exporter so consumers can tell a truncated tre=
e. */
> +		member->truncated =3D true;
> +		pr_debug_dtp("member nesting limit reached at %s\n",
> +			     member->type_name ?: "(unknown type)");
> +		return DIE_FIND_CB_SIBLING;
> +	}
> +

[Severity: Medium]
Will this depth check incorrectly flag primitive fields as truncated?

Because this check happens before evaluating the member's DWARF tag, when a
structure at depth 31 is processed, all of its fields reach depth 32.

If one of those fields is a primitive type (like an int) that inherently has
no children, it seems it will still be marked with member->truncated =3D tr=
ue
and trigger the pr_debug_dtp() log.

Should this depth limit evaluation happen after confirming the member is an
aggregate type (like a structure or union) that actually has children to
expand?

>  	switch (tag) {
>  	case DW_TAG_structure_type:
>  	case DW_TAG_union_type:
>  		die_find_child(&die_mem, __add_member_cb, member, &die_mem);
>  		break;
>  	default:
>  		break;
>  	}
>  	return DIE_FIND_CB_SIBLING;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D4
