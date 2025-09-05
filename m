Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88194248176;
	Fri,  5 Sep 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101832; cv=none; b=GYCDcpZGSnkVlVRdlHCBHgGnrPoGCsLJK4oqo46/lhdKUiJxVTjs+gHytkWaJPUCm0GB3wPes9WD4evYAKHwwioNdLyi1Stc6Z8CeXUgaO+/KEfQCYQdoTumalTTh16o8hEmbZCawqnQylwHwD7xrSyy7NuPbtSp/PnkwP9xly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101832; c=relaxed/simple;
	bh=EY9a/qJowNnGiBZRmmgNcKTqSiUenKGV9TjPNYFySFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXGUWQV6h1yRG8Uam2emxobJtBOwc55F71vkAMySvYFiOPQk8QcWJZn96vsq1qT1jba3O6eT8zW/vOUvC8UBBpv16Pi4KWcpqRkzfQvIScxSmfGOe4GqWFnDTciLxd4hiW0ZI4fQOByc0XzZE/E72OduMKgrdgNufsL+rMDatpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSJuEUj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSJuEUj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924B2C4CEF1;
	Fri,  5 Sep 2025 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101832;
	bh=EY9a/qJowNnGiBZRmmgNcKTqSiUenKGV9TjPNYFySFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSJuEUj50C4lXsNFIagLrB9IqmozQ+JzO9v5HaAbxoFl55kh8DwztNseiEncuTYn2
	 7VRmk7Eagnwb5KH2BpuYLsaamNPsIEEPQS1JiRu/GpCwFbGmGGKgKhwo/5miG3uCtV
	 f9SbV0dbbRcyQq2VncWkzKGpAN1+O/l8cSOXo7J8wPFHaHqC4B2SfcXKMihYR2Pj6w
	 uN0qXuj94YcuA0MWssNhiVJe1z2FRlPFxng0/axd1dbcU4AtU2g7jQiGTYUDNvGbtQ
	 u4+Jvbzji9/ux2/rWuzwnpozxE5qHaa38nScP/6RJHJkIaWfqYsj+F+6ECjd4m//bs
	 fLNX1guYV15bg==
Date: Fri, 5 Sep 2025 12:50:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Zecheng Li <zecheng@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] perf dwarf-aux: Use signed variable types in
 match_var_offset
Message-ID: <aLs_BuzNJZt6Wl2g@google.com>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-2-zecheng@google.com>
 <aK_8kt5Yf9MDoPdu@google.com>
 <aLhjnex4_SXpV_8N@x1>
 <aLi7o0hB23v7wpJ9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLi7o0hB23v7wpJ9@x1>

On Wed, Sep 03, 2025 at 07:05:23PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 03, 2025 at 12:49:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 27, 2025 at 11:52:02PM -0700, Namhyung Kim wrote:
> > > On Mon, Aug 25, 2025 at 07:54:03PM +0000, Zecheng Li wrote:
> > > > match_var_offset compares address offsets to determine if an access
> > > > falls within a variable's bounds. The offsets involved for those
> > > > relative to base registers from DW_OP_breg can be negative.
>  
> > > > The current implementation uses unsigned types (u64) for these offsets,
> > > > which rejects almost all negative values.
>   
> > > Right, I thought it cannot get negative offsets except for stack access
> > > (e.g. fbreg).  But it turns out that container_of() trick can generate
> > > them with optimizing compilers.
>   
> > > > Change the signature of match_var_offset to use signed types (s64). This
> > > > ensures correct behavior when addr_offset or addr_type are negative.
>  
> > > > Signed-off-by: Zecheng Li <zecheng@google.com>
>   
> > > I've confirmed it produced slightly better results on my test sets.
>   
> > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>  
> > Cherry picked this first patch to make a bit of progress in the
> > perf-tools-next front.
> 
> It is in perf-tools-next/perf-tools-next now (this first reviewed one):
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

Thanks for doing that.  Please pick up the patch 2 and 3 as well.
Namhyung

