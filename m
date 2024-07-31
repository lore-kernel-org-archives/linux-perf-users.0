Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9D1EB3E;
	Wed, 31 Jul 2024 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451757; cv=none; b=j0jJZvXxBNofM2YkLPHnDFtIAHq84aOvq7zitI9WjxxPf58pRkUUCV4busAgs1c4rWwUThqyTihtgFfwqjO7cvxpC48haWbhARozg9KWv2/q5hsfkseZnVAzgKIUTJsc/pqKGTwKW73I1jkNquPQBXlV25QeEWlNB+6Ja0FqK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451757; c=relaxed/simple;
	bh=uzxjQ56bzKqnAIMD8U1i8Zj5u3MmtLCgXeuq7UhCFVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY/ULOXMPHhHAgNbyx2N45eIYsmR5l2DtF39sVG0ThQ6TJ4zmxOZpDqE0p6jX8Ze5aINoDBdxRqaXLNIs7esC/7OKBt9wxp/f7+UMc/3aSR3I6kFfhqe9F/k2jVrwJbDXlwDohPaLevSyu+/LCN0iN7HPUT4EKorglWNYyqwcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlDjXXQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlDjXXQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6FBC116B1;
	Wed, 31 Jul 2024 18:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722451756;
	bh=uzxjQ56bzKqnAIMD8U1i8Zj5u3MmtLCgXeuq7UhCFVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlDjXXQZTARa4ABc60MCHroAXU2WILUd436SKu4FkbXeZRIt1J8N/5778c0AHOCwN
	 QbukXjoUvuTlvR8rypMc/3NS9UllwCwVcTc9GwGvFjl7edjEqJ50cKigQYirTNojbr
	 ktszU2R7f1oMqndm9io3VP112hgBZjGrSOCV1ae2y8IzEcPTHYQp6UB+FC0VtC5MNj
	 7YgrLWR6TCO9DsWjaAyELDLQAqKCEfqEEYYie9a5J3qnAghROk12rwmkCkCw4FdAnZ
	 2aPvw5KYP5OgHqX3THqsSEkMJAhOO9dbRM/3rL4El4seR99U3dK8guM18f+aK+kDPC
	 3lC++RaFEQPjg==
Date: Wed, 31 Jul 2024 15:49:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Song Liu <song@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
Message-ID: <ZqqHKWPcW3TvSQoQ@x1>
References: <ZqpUSKPxMwaQKORr@x1>
 <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
 <CAP-5=fXX5RUgoXR2v4YPYQWJi=A1LejJ-MfhKqe+es+SR3WyyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXX5RUgoXR2v4YPYQWJi=A1LejJ-MfhKqe+es+SR3WyyQ@mail.gmail.com>

On Wed, Jul 31, 2024 at 10:35:12AM -0700, Ian Rogers wrote:
> On Wed, Jul 31, 2024 at 10:08 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jul 31, 2024 at 8:12 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> [snip]
> > > +perf-util-y += disasm_bpf.o
> >
> > I think this can be gated by LIBBFD and LIBBPF config, but not sure
> > it can express the both requirements easily.
> 
> Should we gate things on libbfd? Given we can't distribute a binary
> linked against it, I support deleting all libbfd support. Fixes like
> this show the pain in carrying it.

I thought about it, but the problem at hand was that library A clashed
with library B for a namespace, so I fixed just that problem.

I agree that as soon as we reimplement the features that now are only
available with libbfd we should remove that code, now it is even more
isolated.

- Arnaldo
