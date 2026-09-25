Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627614C1505
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349411; cv=none; b=oJBAyCaltJ99UdJ34lRB5hNMG7eeUySd6oyZXVhtt5R0dY7s1QA4PBl6pdhyFSY7FfYFtfQNtBYvi1jD0vmr5LQ7rzQwbAc4+Elm34XtbidiQxQRClV/P0jiNQuvgRHSIir0CegCVrUI/SXugFv+O0wOVsOlABuzHqVrsfF8pTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349411; c=relaxed/simple;
	bh=cl0PqGoHEgd1GyY1Jz1mrnlxB8W+BeL9Ew2blumwgNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MAnUjQNy5QORPMRcWFnUMKr2dZmAau5H4U5aCJOirhE7dhV1lfX+RUZKvIcEhtYuA4NLc9/g1xvATFlwryNqZM6ir/HJNx5HC6Kk5UdY2c3ji8faU5gD6J8iV7WjEJfBid+XFl4nVeqZlmlz2dTg5in7aW7nrqnu3OWN9x/AYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGo+y64j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGo+y64j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEF31F000FF;
	Fri, 25 Sep 2026 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349400;
	bh=K9xcW6jP78ZyylarBweNaGXt813/ZDgrSZxxRzYgrrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGo+y64jVO+j0o6U7HfhFpJOgLm3WClbqNA0jaE4h3k1oqA0yTw3mjZfJAMTat+Ev
	 eHLQq+zqWWR0AThPpiq8WVgzHEai5k8qJBqUGtNxK3BzQve3ItoNRSMSbcY5DZm4+/
	 T2DfTF8OpHW4LxeULaiAiLNvElLfbBTwwe1QK9bsDJdU6yztVsi/yu2R+gWF/sJWAc
	 1+ksdQ8R1RfZB2YtnvYlt30jnrC8cMZ1G05qIK1DvQg68NyAmMgEIjI26gDFK4m4Jh
	 pUl1zgBTEkj1hSZ9yG0MpdCZqc57M60LM0YFSE/Ho6PmdsiW9YM8CLkRvgqKzhNccT
	 C6qck1GEQ5M7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] perf dwarf-aux: Add die_same_file() and
 die_get_type_die()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925150657.1826942-3-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:16:40 +0000
Message-Id: <20260925151640.8FEF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf dwarf-aux: truncation of u64 die_off in pr_debug on 32-bit pla=
tforms
--

commit c7e2660460f55978ed41b85fca70ec2e99b2a867
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dwarf-aux: Add die_same_file() and die_get_type_die()

This commit introduces die_same_file() to compare the debug files of two DI=
Es
and die_get_type_die() to resolve a type DIE offset in the correct debug fi=
le.
This ensures proper offset resolution for DWARF files and DWZ common files.

> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 2c135ebb1551f..54f8b5ec74a2f 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c

[ ... ]

> +Dwarf_Die *die_get_type_die(Dwarf *dbg, u64 die_off, int die_tag, bool f=
rom_alt,
> +			    Dwarf_Die *die_mem)
> +{
> +	Dwarf *target =3D dbg;
> +	Dwarf_Die die;
> +
> +	if (from_alt) {
> +		/* No fallback: an alt offset here parses whatever is at it. */
> +		target =3D dwarf_getalt(dbg);
> +		if (target =3D=3D NULL) {
> +			pr_debug("DWARF: no alt (dwz) debug file to resolve the type DIE at o=
ffset 0x%lx in\n",
> +				 (unsigned long)die_off);

[Severity: Low]
Could this truncate the DWARF file offset in tools/perf/util/dwarf-aux.c
within die_get_type_die() on 32-bit platforms if the offset exceeds 4GB?
The 64-bit integer die_off is cast to unsigned long when logging a failed
alt offset resolution, which is only 32 bits on 32-bit architectures,
causing debug messages to display an incorrect offset. Should this use
PRIx64 instead?

> +			return NULL;
> +		}
> +	}
> +
> +	if (dwarf_offdie(target, die_off, &die) && dwarf_tag(&die) =3D=3D die_t=
ag) {
> +		*die_mem =3D die;
> +		return die_mem;
> +	}
> +
> +	pr_debug("DWARF: no DIE with tag %d at offset 0x%lx in the %s debug fil=
e\n",
> +		 die_tag, (unsigned long)die_off, from_alt ? "alt" : "main");

[Severity: Low]
Similarly, when logging a missing DIE at the end of die_get_type_die(),
does casting the u64 die_off to unsigned long truncate the upper 32 bits
on 32-bit architectures? Consider formatting with PRIx64 to ensure the full
64-bit value is printed correctly.

> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925150657.1826=
942-1-acme@kernel.org?part=3D2
