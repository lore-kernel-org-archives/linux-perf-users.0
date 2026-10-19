Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2944C64B;
	Mon, 19 Oct 2026 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388314; cv=none; b=qlj0r0zyYL3bzayxzzYEMEqd6HCUfs53pxYiTqqMlKy92DHbeOIqBZKXBVbQcKZFS7sHahXxnj7ebSwDZsihSHvw6ZHUCl1hzrljKqWqSTQqinXws6zD2I0tLO/Jix6ZI81Sr3lpmWZNE1u5vyrOf2162vyz+Q262wP22NhofcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388314; c=relaxed/simple;
	bh=2AHC1LCrnIejm9IbO8ghkZDmss6eRXzoL1vPVbk7/uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+kMC1DRBK6icijmtZAhAFK4cki8lXYQuNGl7vrzyKzGqc1EIhizEiCs2N+/dac9pIxAbCcT55SyMb+hVnVb2CS5fojo3LFfAsvcRq+3N0Mz95VN07Uf2xsDrbE0NqsfnK1c+Y379fLpGhqs5gW9vvJXOhnI/l7GZraXfBXgy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZJHFkfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZJHFkfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E5A1F000C5;
	Mon, 19 Oct 2026 05:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792388312;
	bh=OdicA64Gb+yy1LVueolJ9Qt8I2uMT6PXP+0m3ZmCWrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gZJHFkfOTAXHcy9Cb0RJSzLkeVxxygmNAM2Crx3P9ULg14InlR1SOuY2RGMYpIxWx
	 edxQ8WPOYcf83jEFeFIw1q13kUIQScxnecQecqUDcLMih5xVBNurkjnZiGIf58YPWG
	 RI+tXuyih6K1mP2TrxhJb9jZmGAqaYLv40Yp0sRMODtgkp1ZCPw3JMhiakfH60hDXY
	 mOOEXuT+8lcVM3FfVX64aZHpVW9HDQo5gUeJEbPsQ4zihhjRT88q5jpg/t9jolTWkm
	 01SokNRglWa69EPgdNfxDDwdLPrmhQhXTFx8lpa8k3bTqdixiTwtphkuGM8FHVn+tg
	 j9soaBb4t7Y7Q==
Date: Sun, 18 Oct 2026 22:38:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 5/5] perf symbol: Ensure dso__set_is_64_bit() for
 libbfd
Message-ID: <atWs1maCdPluFX0o@z2>
References: <20261018163741.850434-1-namhyung@kernel.org>
 <20261018163741.850434-5-namhyung@kernel.org>
 <sashiko-outbox-176289@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-176289@kernel.org>

On Sun, Oct 18, 2026 at 04:44:26PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf symbol: bfd_get_arch_size() always returns -1 in dso__load_bfd_symbols()
> --
> 
> commit 6d3220ac244766831d73c524c0b8f5184af28a7b
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf symbol: Ensure dso__set_is_64_bit() for libbfd
> 
> This commit calls dso__set_is_64_bit() using bfd_get_arch_size() when
> loading symbols via libbfd in dso__load_bfd_symbols().
> 
> > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > index a4dcb406c79e9..9cc6216ce3adb 100644
> > --- a/tools/perf/util/libbfd.c
> > +++ b/tools/perf/util/libbfd.c
> > @@ -462,6 +462,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
> >  	symbols__fixup_end(dso__symbols(dso), false);
> >  	symbols__fixup_duplicate(dso__symbols(dso));
> >  	dso__set_adjust_symbols(dso, true);
> > +	dso__set_is_64_bit(dso, bfd_get_arch_size(abfd) == 64);
> 
> [Severity: Medium]
> Will bfd_get_arch_size(abfd) always return -1 here?
> 
> Earlier in tools/perf/util/libbfd.c:dso__load_bfd_symbols(), ELF binaries
> are rejected before reaching this point:
> 
> 	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
> 		goto out_close;
> 
> In GNU binutils libbfd, bfd_get_arch_size() only checks ELF targets and
> returns -1 for any other BFD flavour:
> 
> 	if (abfd->xvec->flavour == bfd_target_elf_flavour)
> 		return get_elf_backend_data (abfd)->s->arch_size;
> 	return -1;
> 
> Because abfd is guaranteed to be non-ELF here (such as a 64-bit PE/COFF
> binary), bfd_get_arch_size(abfd) == 64 always evaluates to false and
> unconditionally sets dso->is_64_bit to false.
> 
> Should this use bfd_arch_bits_per_address(abfd) == 64 instead so that the
> address size is queried across all BFD flavours?

Looks good, will fix.

Thanks,
Namhyung

> 
> >  
> >  	err = dso__has_symbols(dso);
> >  out_free:
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261018163741.850434-1-namhyung@kernel.org?part=5
