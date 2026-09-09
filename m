Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9019569F16;
	Wed,  9 Sep 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966194; cv=none; b=E4tt3BWSR8m3+pMGtPUiCXjKXE5wfL2TwelS75V/iqrAwkCOcg0ZdOwnMCZvlwo7oeLrSWCXcW38Nhk7psWIOQ2WQ9UasZ+qPqvzRx8bMtQlbyFr0yYsk5syJzLtJrdK57Bo12pawgMryjtCwY953SmeV2dBtkX3sJO2OUbi5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966194; c=relaxed/simple;
	bh=NMutSb+iwDJQDQRxg5cP+VTbUgw3SkTxILY+H17fnK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9VFfbIfvthes1qzu7rPGNunMImegKMeGcWHOuNbFIMQi0TlRBOGEbwYEHJdFNZMlJ5/U5wtyr5d2WwMXLU5hm5y2N37bn+rAjQOsqgZgHkwHw8+XHMiEDOV59u/3nEsclFtD40j9rvW87zAcBgk+bxvui9xfgQL0F5t1MiYKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXPScXqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXPScXqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596311F00A3D;
	Wed,  9 Sep 2026 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966193;
	bh=ktgcUm+rCSbnlLVJ1OjKCjvpcn2qgXbLO5ZNOO8wOts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RXPScXqUxbTvQGmbvANMhPXNKqKEHHR2NuQD1qazMUE0tBmA+9mNG7o05mfoAEVIJ
	 GJwrrhjozIY2fbq9VHaAOArCai96wWNI6GENkBjYvexKprOaef739pnpewyt81nMjM
	 IppFyw1bUX0i7Q1Fa0H+KKC4GXtDTb4s9uVnyK07dRwsqws47xlHD7My1Oc4/eAxO9
	 4v6VwGokhbXoPvo2qOONlhUwx9f6RYCdGpxWgDnxHsKd7xB1R1oSgagcCDz0snBuNO
	 nvK3C5ma/6ufSgL2A42yPF44i1Ba16KNgN8VeFHXyBuuBT6UqOXUExiAD1L1iJmA8/
	 RHCvOOQl2qISw==
Date: Wed, 9 Sep 2026 11:03:11 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
Message-ID: <aqF1L7CC5nMMPGZu@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <61714d93cd55cd461d5c37146713ddb9e1d04743.1788872630.git.wutengda@huaweicloud.com>
 <20260908132152.08A131F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908132152.08A131F00AC4@smtp.kernel.org>

On Tue, Sep 08, 2026 at 01:21:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing 'lr' (link register) support in arm64 DWARF register programmatic lookup.
> --
> 
> commit 5d023c42589d9bd9061d9468194dc470f5cdc273
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
> 
> This commit replaces the static table lookup for arm64 DWARF registers with a
> programmatic parser in __get_dwarf_regnum_arm64(). This allows resolving
> arm64 register names directly into their corresponding DWARF register numbers
> for perf annotate.
> 
> > diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> > index 593ca7d4fccca..720c863d18696 100644
> > --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> > +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> 
> [ ... ]
> 
> > @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
> >  
> >  	return perf_regnum;
> >  }
> > +
> > +int __get_dwarf_regnum_arm64(const char *name)
> > +{
> > +	int reg;
> > +
> > +	if (!strcmp(name, "sp"))
> > +		return 31;
> > +
> > +	if (*name != 'x' && *name != 'w')
> > +		return -ENOENT;
> 
> [Severity: Medium]
> Does this code inadvertently drop support for the link register ('lr')?
> 
> If perf annotate processes an instruction containing 'lr' (e.g.,
> stp x29, lr, [sp, #-16]!), arch__dwarf_regnum() extracts "lr" and calls
> this programmatic logic. Since "lr" does not start with 'x' or 'w' and is not
> "sp", it will return -ENOENT. This seems like it will prevent data type
> tracking for the link register, which was previously supported when mapping
> to DWARF register 30.

I think we agreed to ignore 'lr' for now.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
> 
> > +
> > +	name++;
> > +	if (!isdigit(*name))
> > +		return -ENOENT;
> > +
> > +	reg = strtol(name, NULL, 10);
> > +
> > +	return reg >= 0 && reg <= 30 ? reg : -ENOENT;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1788872630.git.wutengda@huaweicloud.com?part=7
