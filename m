Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA51917FB;
	Wed,  3 Sep 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937127; cv=none; b=t/vncAlJ5S8aXu0804TGLx/6cP9F3IRk3hLrS6xt3B5d4skePmSXWvfAw5PON4EdB/AXzO3FkJ8JV52y9S5eTSrbGH3DlVRi/piVI3DeMclGctgxhZcyO7nogE69kLR+s6z0MnXmFr6eMGM9WQaRWYvpecyoKAZjjJD24B0QxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937127; c=relaxed/simple;
	bh=S41McUg1GFAepvjvdzi9iRrNDfEtYbm9E7tlVxwsJPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOdE8Qq0/0xCjhbPwxi/88yzV43mkYfddiylSW6sGoHQwNAf95GjSs99ebxPmBF49YheGwX9PpeHMYJT+2CfVtPBKzDu2y3iBkUTRh9XNV/eaNu9NzchCpDvLw1Exibpv9hm5NpxTtute4OLQ4Q5uG3VuKEUsiAAxMU7IEMbZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfQc6slY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfQc6slY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E1C4CEE7;
	Wed,  3 Sep 2025 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756937126;
	bh=S41McUg1GFAepvjvdzi9iRrNDfEtYbm9E7tlVxwsJPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfQc6slYfQMBnPCDJerK0cu0D0UtYR7zMy3L5n/6lWOD+Sm1nlPHteuz8rAkigjaF
	 comQPogIFriNuqp28SylY2PCnNnIy76jfl06/XxXAFLwpMC9qs4I3OyNOcBHC4Snkj
	 cNFu9m5ZloMwvN9aNNGWxFEZGhOLJl+9LIRBctf+PwcpTlzoIGY7e3cqH4sil+bIpi
	 90ZOix9N0R0/IUpwDqZCxmv0boz1gKZQl84RpNT/VdGZk6oNZZHW0grkiKtowmbwxd
	 mqeB8gJXLmRJG2FfpGwQIfU52mmFVfcc1wYU/opVJMhecFVQSx2jtoTW3fnuC1/cTO
	 YL4QdfOsMj5aw==
Date: Wed, 3 Sep 2025 19:05:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <aLi7o0hB23v7wpJ9@x1>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-2-zecheng@google.com>
 <aK_8kt5Yf9MDoPdu@google.com>
 <aLhjnex4_SXpV_8N@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhjnex4_SXpV_8N@x1>

On Wed, Sep 03, 2025 at 12:49:49PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 27, 2025 at 11:52:02PM -0700, Namhyung Kim wrote:
> > On Mon, Aug 25, 2025 at 07:54:03PM +0000, Zecheng Li wrote:
> > > match_var_offset compares address offsets to determine if an access
> > > falls within a variable's bounds. The offsets involved for those
> > > relative to base registers from DW_OP_breg can be negative.
 
> > > The current implementation uses unsigned types (u64) for these offsets,
> > > which rejects almost all negative values.
  
> > Right, I thought it cannot get negative offsets except for stack access
> > (e.g. fbreg).  But it turns out that container_of() trick can generate
> > them with optimizing compilers.
  
> > > Change the signature of match_var_offset to use signed types (s64). This
> > > ensures correct behavior when addr_offset or addr_type are negative.
 
> > > Signed-off-by: Zecheng Li <zecheng@google.com>
  
> > I've confirmed it produced slightly better results on my test sets.
  
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
 
> Cherry picked this first patch to make a bit of progress in the
> perf-tools-next front.

It is in perf-tools-next/perf-tools-next now (this first reviewed one):

https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

- Arnaldo
