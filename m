Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABA279907;
	Tue, 16 Dec 2025 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909698; cv=none; b=Klq5Lq6+7r9U/NSUTjLj99swMldnL2ge24/lEzwGfvBu6tVe++1jde34HU8FjNo6OWWMH1GBBXhrXoRiLwYgI/NDxDBShClkH33x2ap/w3hp7bm+tieCYhkGZapSVmk8KdOeth6fV8qIVGqjFCgNtgPWd3a1U3d+apGhfE1BcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909698; c=relaxed/simple;
	bh=/OZls7ZYBSvAdFq0YdPFyREKHs6MtoPv9otOSQzWjMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/zi+IyVy9egd61X68sbKac6GmBTZWC4YAFfrBZ/jKSEgWUlrj5wZmSSkXhdqIQ6QkXLIbWV//nXS3ojczUJlUrJwGqAq31gwOEOQi8cx9BDO2hMTDUb75qXKR8sgI+arBrZJCcvWd7u3C+lkwz1VgaV9xzij+6XfwXICkK3Zhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtPDcUh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtPDcUh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F86AC4CEF1;
	Tue, 16 Dec 2025 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765909697;
	bh=/OZls7ZYBSvAdFq0YdPFyREKHs6MtoPv9otOSQzWjMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtPDcUh9m5DPtZSZKhQ05944xEERA+AjRd3jxlSvVy3s8+zMi4rgaQCtD4/Cp3ryf
	 ool4eBISC1fjkwOI07b/nxrG1KXg5JcDlaLPCNqdpuqbax7tZSlGD1NdeB+CNnyhfd
	 vRSWwihLC8ifRT0fQ2gFSfG6IJzesImX/fimBgmB7YBYe37mGGp8/NulrDCVA9+Yap
	 b76NJ2MRbl+JyV3hlpiPJvYy6YKTXZEFJin20Iagk6Ts1238bXFBnm+50JFNvVHMck
	 mXQcvrK8MpCnfhVnVyKwTC4e74giNEYZXv/E55pXfPp+zGy4/AAYHyltJl5d2YcW3K
	 VoPtNrjj0yXZQ==
Date: Tue, 16 Dec 2025 15:28:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB
 to MiB
Message-ID: <aUGkvNzhls6cE39T@x1>
References: <20251031162637.1456191-1-irogers@google.com>
 <a980f102-b468-4d55-abd6-885f02dc01e9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a980f102-b468-4d55-abd6-885f02dc01e9@linux.ibm.com>

On Wed, Dec 10, 2025 at 11:09:40AM +0530, Madhavan Srinivasan wrote:
> 
> On 10/31/25 9:56 PM, Ian Rogers wrote:
> > 6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
> > 2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
> > rather than MB (megabytes) where the values are powers of 10. This
> > patch corrects the unit for uniformity and because such units may be
> > pattern matched against.
> 
> 
> Changes looks fine to me.
> 
> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> b/w  power10 metrics file could also have this fix I guess.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > index 7a5d1bf543f8..8d028a7c2777 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > @@ -29,25 +29,25 @@
> >   	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
> >   	"MetricName" : "mcs01-read",
> >   	"MetricGroup" : "memory-bandwidth",
> > -	"ScaleUnit": "6.1e-5MB"
> > +	"ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >   	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
> >   	"MetricName" : "mcs23-read",
> >   	"MetricGroup" : "memory-bandwidth",
> > -	"ScaleUnit": "6.1e-5MB"
> > +	"ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >   	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
> >   	"MetricName" : "mcs01-write",
> >   	"MetricGroup" : "memory-bandwidth",
> > -	"ScaleUnit": "6.1e-5MB"
> > +	"ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >   	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
> >   	"MetricName" : "mcs23-write",
> >   	"MetricGroup" : "memory-bandwidth",
> > -	"ScaleUnit": "6.1e-5MB"
> > +	"ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >   	"MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
