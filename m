Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA704D4869;
	Fri, 25 Sep 2026 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351326; cv=none; b=eHMFJVvW1WjjrNSZoIeTJXEMUkbZo0xIEe2KyytSUvGlaEfRioI+w1+bXQzXUsU5cPHxFPhCKLhgYAUFUwZ8zj4tsKPUEYPGjYBgRyUO01QgwCP96tt59QKTSxxiGF1jWC+xN5iotFr79+HmBQ5Q8bjICywe1ch7G2FaswyNDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351326; c=relaxed/simple;
	bh=Oj62K+LDoAanoxmiJ3SgEdVsIbe/FYcTxQHC5xVkDZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFDSg+yRqh38V6EiyJ6QGkjI38Q74Gm5srd3qUYg/3u9KmKwD8xOKXMrAadMTVVZErOYkaq01mqRaTluyipiOMz5osBV2LfvcVMeYcIZZdVIL1qCOO5fwPMjCLPXXhyydflNzdd9tYzFNmkw58bh0ymRTomisNm7bwNHrZ1WGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChXbqUDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChXbqUDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D31A1F000FF;
	Fri, 25 Sep 2026 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790351321;
	bh=6CH/QBKQKUhpI0vIFIzSBarGJcOIWbB0njVIaOc4Fqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChXbqUDwd2V5nxpd2y0DIeJvwTUJDGuaiu19L6Th5Vh4rAcDRoK7jHnNBCURk/XQr
	 BHZjdX8PoaJZdvtItmh1k1IEEDRvjQr+3tMahYZE/qQLUJ9KmTpgVJzqyq2J+S87bR
	 DltNnjq4cZG+ST3IUh0l96JgvmWtWovTMJAwBaEpdFleviW1JE1+kevlcBldlRHQE5
	 J7QT7jqA/YrOg+8jlmZeIbNFuyLNyZnbwF17OnD6NZeBTTpXuLROGCV3J3CxVbqYpi
	 VohvprvrdOTnc5K9Rfan5gAZPEdyZTIVktTr3wX0O2gDTg5P5Wkv/ugHRqakR8uxO8
	 tHkK3OO0vA3/A==
Date: Fri, 25 Sep 2026 17:48:38 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5 0/6] perf annotate-data: Fix hangs on broken debug
 info, AMD mem record
Message-ID: <araX1vz6-Vo9v1I1@x2>
References: <20260925150657.1826942-1-acme@kernel.org>
 <araXPQChZ9HHNFzY@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <araXPQChZ9HHNFzY@z2>

On Fri, Sep 25, 2026 at 08:46:05AM -0700, Namhyung Kim wrote:
> On Fri, Sep 25, 2026 at 05:06:51PM +0200, Arnaldo Carvalho de Melo wrote:
> > Hi,
> > 
> > This originated in another patch series, 'perf tools: Annotate fixes,
> > stdio progress indication, debuginfo-client in more places', and is
> > being split off so that these fixes can be reviewed right away; the
> > debuginfod download feature work from it will come later, separately,
> > based on this series.
> > 
> >   - 'perf report -s type' spins forever on the dwz compressed debug info of
> >     zlib-ng (libz.so.1): die_collect_vars() saves a type DIE offset that is
> >     relative to the file the DIE lives in, the dwz alt file for types shared
> >     by several CUs, and resolving it in the main file parses whatever is at
> >     that offset, here a typedef whose DW_AT_type refers to itself, making the
> >     typedef/qualifier chase spin (patch 3), with the chases bounded so that
> >     other kinds of broken debug info don't hang perf either (patches 1, 2
> >     and 4);
> > 
> >   - 'perf mem record' requests PERF_SAMPLE_CPU (patch 5) and uses the IBS
> >     swfilt filter when the kernel exposes it (patch 6), with the tables
> >     carrying the term kept in the arch/x86 code, where the knowledge that
> >     IBS needs it stays, as Ravi Bangoria suggested reviewing Namhyung
> >     Kim's v6 review remark on this patch
> >     (<4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com>, replying to
> >     <aqsRVABj23jaaiSq@google.com>).
> > 
> > About PATCH 5, answering Namhyung Kim's v6 review question
> > (<aqsPKGVUkWk6wvYA@google.com>) about the --sample-cpu default: the
> > data source field is about the memory hierarchy level of the access,
> > it has no record of which CPU issued it, and while the TID is in
> > every sample and in the CTF stream, a thread time-sliced on one CPU
> > or moved between SMT siblings is not told apart by it from cross-core
> > contention, so it is the CPU id that keys it, and it is what the
> > false-sharing detector in pahole needs.  The TID is recorded as well.
> > 
> > Requires elfutils 0.160 for dwarf_cu_getdwarf(), so the libdw feature test
> > probes for it and Makefile.config says 0.160: older versions now disable
> > dwarf support with that message instead of failing to link.
> 
> I have a nitpick on the patch 4, but otherwise looks good to me.
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

I'm fixing that one, thanks for reviewing!

- Arnaldo
