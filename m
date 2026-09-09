Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA24492E2A;
	Wed,  9 Sep 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966035; cv=none; b=rMNlYQlxIn8wvTRgfVAad/bCfYZeLI1TAYkCvxUyA9lTdQgil7j63XO0f4EssCWI5VGL6FWcWCpBKG7c7EsvMcDzXueT6lvxWXHFe5zqbuyMHi+f+sRbz0L1hRDQYANNz+GVqiruMSmxAisIwfq8qsJdtTOypi5752+oswVp2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966035; c=relaxed/simple;
	bh=t+R7Uy585677nF3IPeAGd1/uim1KC/QB49F7RDrEc2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2G9GRC8BUqs6uomm2xxSMMhUgGZzCCHXyxCk45n/froj+Zg7Pr63nJWz+Ai7rtyYX+MrcSFe3g8sx12L/Osy71Smm6jXB4gcQkNpPN3tVeXiiVOlzF8Dhj8L5RY0/Hhj1qIY02IGi+gRlaioZBENFkDC21SrPBKHeeb/Cfxc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHhCXPxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHhCXPxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743271F00A3A;
	Wed,  9 Sep 2026 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966033;
	bh=AmM8N99F70jl9iWYm3PjrvWLcN+zgfro5Jg4YjUE0Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eHhCXPxbPBQ6zX7jB4F1zXRb2+26vfW95cKEmyksecfoMKKigRuGFUCORoPcW/lOV
	 NC+eRwGG/t2G+mkwoKyB0LcJMZMPpqyueEYclBNaLZ4daKd+AdcsmqNBFkz8ZDTWUB
	 JYhZhZ1bzDGvZ/lOjeA2Zcm+3QSdpfFEaJZBKY8UczB2MbsOP1H5/9Wsqx7IX4DN5s
	 VRUUjuwqvLoDvp/OQY5oEl50J015Jjb5ABSB0C3LNj3uwyMOe1e0IoXJ3F5MiGUnyS
	 eKpWQU/a8oWX8w1l/W7F2UCG3Hv4Cjq7hw8Cpe+SRxp3fwYIOloCIY2e02o2iqHa2M
	 puCRnma4GzFiw==
Date: Wed, 9 Sep 2026 11:00:31 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tengda Wu <wutengda@huaweicloud.com>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 05/26] perf annotate: Normalize arch__dwarf_regnum()
 error return values
Message-ID: <aqF0j8swBpYtOL5a@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <07d3cce3cb8561c07d7c77deac81eb9ab0540ccb.1788872630.git.wutengda@huaweicloud.com>
 <CAP-5=fWj19r_NcMS8DPeD7SQ7-Ak9_rRn=EOaBLUmxvPyHTSPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWj19r_NcMS8DPeD7SQ7-Ak9_rRn=EOaBLUmxvPyHTSPg@mail.gmail.com>

On Tue, Sep 08, 2026 at 10:57:11AM -0700, Ian Rogers wrote:
> On Tue, Sep 8, 2026 at 6:05 AM Tengda Wu <wutengda@huaweicloud.com> wrote:
> >
> > arch__dwarf_regnum() returns inconsistent error values: early path
> > returns -1 while the main lookup returns -ENOENT/-EINVAL from
> > get_dwarf_regnum(). Callers only check for -1, so genuine failures
> > can slip through.
> >
> > Normalize all failures to -1 to match the callers' expectation.
> 
> This sounds like a bug in the callers but this function is local to
> annotate.c and is just a convenience so:

Agreed.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

