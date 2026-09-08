Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C43CF02D;
	Tue,  8 Sep 2026 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901126; cv=none; b=hkBrdU2D5JhOZ3zUwaSNIsD05AWHDxy8TYm4jST1uPM4ZJmL2h0SW13CsYTYEcCpDSTEWNGgC37GsPbEaJMAMfoRPylElMG8LzA6kyywfW6Cg9GQDmD7Yz59Fb5BuuWGQHQanAn/sgFQ+R4DcYAiUnFNC6TRPH7w6FfaiS6g5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901126; c=relaxed/simple;
	bh=jhAaYCdk4O2hshJRAEykd548fryClgj3pmy2xDkovCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDpUOI4aceXi4eCAmN1TBpprcMUwN7mQxQb6POL9wLgzM/A+Ret1l+rG/tWCr/f7WeN2tJmZsqPH6mElkprbJvSHkPbYCsIVMs6ASJjqEmzPAwah0al52aDtkLYBQxNIplwkYsWgzEr7IHOYRfhPLaJBbVOKOCCkkuDKMjclBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBllKCJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBllKCJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1291F00A3A;
	Tue,  8 Sep 2026 20:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901124;
	bh=JkCoDOO6f+i5wpHddyeREAJnLw+KDi+4N1NoSSymZEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HBllKCJhSgf3+kBQw6PkQ9fntVmxxDdlSeTrPwshJPevCOsV0pcn7FSRh17B9oQLz
	 BxTVVb2j0CZywbwQlNnGD3YDhn2orpWaCDcZuakvtcIIGHq6uNSfZAjONYTv8dW62U
	 PSQKFooeGe6z+4k1d0LgISPw21odnDFjKWRl31yj9Br+2ipMeGfkixO1K11Lbsel2P
	 +5FmGATpmAPjoMlbXZMRaptr5lQ6AJICW6caOwnjIoV3hrCHo87iDMPUzHRN/aBsK2
	 oTqdg6mUHiYGj3fltkLeloE6CXYWL3Z6zeYxnneHXwulj3Juv+wQzuQIQ5TklFr4w+
	 KHf5Ao+C4ZcbQ==
Date: Tue, 8 Sep 2026 17:58:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: liujing <liujing@cmss.chinamobile.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix undefined shift in intel_pt_bip()
Message-ID: <aqB3AOHLJ-n5gjfj@x2>
References: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
 <20260903082128.4972-2-liujing@cmss.chinamobile.com>
 <20260903083110.C416F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903083110.C416F1F000E9@smtp.kernel.org>

On Thu, Sep 03, 2026 at 08:31:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch introduces a build failure by placing a variable declaration after a statement block, which violates the C90 compilation rules enforced in the perf tools build system.
> --

Please address this and consider the other pre-existing issues, not a
requirement to process your series tho.

- Arnaldo
 
> commit 8a68d39b58963034d86457f673e830e359365de8
> Author: Liu Jing <liujing@cmss.chinamobile.com>
> 
> perf intel-pt: Fix undefined shift in intel_pt_bip()
> 
> This commit aims to fix an undefined shift behavior in intel_pt_bip() by
> moving the bounds check before the shift and using an unsigned shift operation.
> 
> > diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> > index e733f6b1f7ac5..9abadd0d1c108 100644
> > --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> > +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> > @@ -2060,7 +2060,6 @@ static void intel_pt_bbp(struct intel_pt_decoder *decoder)
> >  static void intel_pt_bip(struct intel_pt_decoder *decoder)
> >  {
> >  	uint32_t id = decoder->packet.count;
> > -	uint32_t bit = 1 << id;
> >  	int pos = decoder->blk_type_pos;
> >  
> >  	if (pos < 0 || id >= INTEL_PT_BLK_ITEM_ID_CNT) {
> > @@ -2068,6 +2067,7 @@ static void intel_pt_bip(struct intel_pt_decoder *decoder)
> >  			     id, decoder->blk_type);
> >  		return;
> >  	}
> > +	uint32_t bit = 1U << id;
> 
> [Severity: Low]
> Will this cause a build failure? It looks like the declaration of the bit
> variable is now placed after an if statement block within intel_pt_bip().
> 
> The perf tools build system enables -Wdeclaration-after-statement and promotes
> it to an error. Could this be fixed by separating the declaration and
> initialization, like declaring uint32_t bit; at the top of the function and
> then assigning it after the bounds check?
> 
> >  
> >  	if (decoder->state.items.mask[pos] & bit) {
> >  		intel_pt_log("WARNING: Duplicate block item %u type %d\n",
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260903082128.4972-2-liujing@cmss.chinamobile.com?part=1
