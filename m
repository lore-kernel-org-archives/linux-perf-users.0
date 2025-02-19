Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43D2566F8;
	Wed, 19 Feb 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999748; cv=none; b=CTyW6gnA4MsLzvE/87DwCwODwlmowbRZkDDv5lTyUeBnxCwkGvVMZs+2kNpMoNIl1lcl5Rzaw5HAQRXGbGyxyGhIpV/FilQS0/hh6YlkR0+KKUhoZ0kkH3aOfgdpZb6BZLQaUt+3JMst85mqRq465UUwdeXHIgRpsylUSKPyGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999748; c=relaxed/simple;
	bh=4MWGaUGndZEvN2swOVMHgXHMQYqR0wPMzXWRDv1AKSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTmD2keTFOOYthF5ywQCG+CjcUT5O15+pgmjMdnTO+/qMwSbMhiKFXbJNHAOEnzyU2GFDYXaeFT/ldF/XmSuis+/Ol42Apiiv1wNxVZ8h/XM2a5TfcRLNgGec7sVokdILDO+CAD4tep1cJS42GLx1QDW4M30cOlw39FVVcfLdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD3zBl5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD3zBl5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FBEC4CED1;
	Wed, 19 Feb 2025 21:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999747;
	bh=4MWGaUGndZEvN2swOVMHgXHMQYqR0wPMzXWRDv1AKSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oD3zBl5CD7+4IBQeyehw+DWr7mUbD9rs04ZOLNCk4Bj0gQPDRfokTMdevrCuCeOoG
	 GLMTCTC87vvX89+cxY/EZ9BZyNeJyCan5Yb7GTY4aSbZy+ezrqIzPV5aYCj8AENdWm
	 LQrxwcF7wkeIPRy1ZC9ciOKgDG0W/v6CuSipzzSPNFVK1FysjxPzf5dCwLTv+UuHFI
	 k0WxxDyr4ml6YYd20WasQM2UUZyzNkDSAEbeD1PVdQLwRiJCgS8G/hpPLZnAZ5jsDI
	 C99ah9Z3pfbVkBAmsvlS9bRjltN9Nu9Sp0dR8Jm+y0CxznODHAB70vRGyR3z0F5YRk
	 Gx45DqShhoP2g==
Date: Wed, 19 Feb 2025 13:15:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1] tools: perf: support .gnu_debugdata for symbols
Message-ID: <Z7ZKAYutejOOoBbQ@google.com>
References: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
 <20250213190542.3249050-2-stephen.s.brennan@oracle.com>
 <871pw0gw8d.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pw0gw8d.fsf@linux.intel.com>

Hello,

On Fri, Feb 14, 2025 at 11:30:26AM -0800, Andi Kleen wrote:
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> >  	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 66fd1249660a3..e578b7d406a69 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -6,6 +6,7 @@
> >  #include <string.h>
> >  #include <unistd.h>
> >  #include <inttypes.h>
> > +#include <lzma.h>
> 
> This needs some ifdefs in case lzma.h is not available?

Right, should be guarded by HAVE_LZMA_SUPPORT.

Thanks,
Namhyung

