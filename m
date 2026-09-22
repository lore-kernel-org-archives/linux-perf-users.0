Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E55437D8;
	Tue, 22 Sep 2026 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080861; cv=none; b=J+TbTD7U7iIxAF13k4ldlnZXL66d3WaCfd3sKY3LBDjyu0Uqi7+bKmC+hwJHE1KP/HPXpaVuo6VvxWX2iD0PWg9qSjMxRJ1Gi4zkRwFXEe/bAMCefMCna96jjY3DXIor962ob/Jl25Q47aNmggmJyxszg81LlQjUQscdUZJpGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080861; c=relaxed/simple;
	bh=Kglg6r0FvIlDidaJCbnpABroJUL7mUIia0GHlnxP7nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy20Ord8gcOFeT5ZHWL4zcCBdlTWbdZ4Am7wcXn6QBLiI/ByHP28mdyf9Iq9UG9JQSRplfOYgH5vlOfGtVeDnTfMAW8VARdABJSkumFV2MzM8hGAB5LNIjMqhdqWEtpfW27qzVGZ/duiJGy8ZFVRpmA+RfANGPx0iDDBMTfQ5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGPYbR1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGPYbR1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6971F00893;
	Tue, 22 Sep 2026 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080856;
	bh=8YTOgbanf2Su5SXwBgA++FQzBjCYeiKy0TeOj7FyDaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGPYbR1y6Vnm9Il/8qRsZ4gR8RMKDvXhG99ZFXEVZFrZhVXPC8m3oeuShmtjFN5sF
	 d4CotwkD2JrPTVBF7YQ6N6w6OxwB2CiVfHMazE91cDpNDiKl7UWd+f8DCl2FEh2qU6
	 d73b6MeTAGHrWOTuZbxwishN7Y7obl63FwhrRSNLEWX0scN/7uNDDsvg7h5p7FZjMG
	 cWcL+PV/Oz8zls2Nht0NmLb3qZnuq2Qw+jSwauf73OXY72DqCrmGxF8xBOAh0iD1yK
	 sKXnOKPPcoZ/FQ/ZZHIHBz8ZiNVn/cA0brLgqtSo5U+qcjFe+OL7NQMTIkkJgFJbCr
	 yd2dTnutpCnng==
Date: Tue, 22 Sep 2026 14:40:48 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chen Pei <cp0613@linux.alibaba.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	guoren@kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf riscv: Add perf_regs_load and enable the dwarf
 unwind test
Message-ID: <arJ3UM-td4trU4z5@x2>
References: <20260914124145.1257-1-cp0613@linux.alibaba.com>
 <20260914125814.C92251F000FF@smtp.kernel.org>
 <20260915015420.818-1-cp0613@linux.alibaba.com>
 <CAP-5=fWE7gjkpZdnHh_QAiVBKTF=1tsUE+ezDxW8SaCsaS-s5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWE7gjkpZdnHh_QAiVBKTF=1tsUE+ezDxW8SaCsaS-s5w@mail.gmail.com>

On Tue, Sep 15, 2026 at 12:09:13PM -0700, Ian Rogers wrote:
> On Mon, Sep 14, 2026 at 6:54 PM Chen Pei <cp0613@linux.alibaba.com> wrote:
> >
> > Both items checked. Neither needs a v2 of this patch.
> >
> > > Does this file need to explicitly include <stdlib.h>? Since musl libc
> > > enforces strict POSIX header inclusions, missing the declaration for
> > > malloc could lead to a build failure regression on musl libc systems.
> >
> > It is not missing. "perf_regs.h" three lines above resolves to
> > arch/riscv/include/perf_regs.h, which has #include <stdlib.h> and is
> > also where PERF_REGS_MAX comes from, so this file cannot be built
> > without it. arm64 relies on the same transitive include. Checked with
> > riscv64 gcc 15.3, where an implicit declaration is a hard error:
> > including only that header is enough to call malloc() and calloc().
> 
> Hi Pei,
> 
> Thanks for the patch! Please don't rely on transitive includes as a
> change in the other header file will break code here. Since this code
> only builds for RISC-V, we're likely to miss the problem if the other
> header changes. Other than this,
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
