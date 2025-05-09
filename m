Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B022F147;
	Fri,  9 May 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805550; cv=none; b=cl2jqhXpdV2uGiorX61cyXm3USGUTY86dXWxKGvN9IzaEG/LgJaWcX32/mKlnVhrlv0IvluxROJWWrUfxe08Zuu7TxwJScZDAX++wu89tc9u37HFHuXpKdSCrk3nFUoKN9q7rdJ+soKujVcXejH99G8SGXjnWZrhEYq6qAGsfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805550; c=relaxed/simple;
	bh=EiFOaPSKs0D9kCFjTr6DbCFxYlqjxLAR3rBU0u7Ioeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtTX1L/0VAUWC25wvzR4nDnE3CdH5Slt/qz1n015dp2ez3LoVGlq0YTIkReBWpylOAsIR+TavV7Ut5dHOWVXBeSkI0i7XYgvm7lYC5UGJNxj5QHyaEXXC0zaUuVkZDOJ1WnvsWRL5292hIo6KAWIFR0OMP9WTRLJFgpEDzqgjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXA0uTnj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXA0uTnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9EBC4CEE4;
	Fri,  9 May 2025 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805549;
	bh=EiFOaPSKs0D9kCFjTr6DbCFxYlqjxLAR3rBU0u7Ioeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXA0uTnjf2juDtNOz/sIFlBK6q06Pg2zqdh/KvXdeuiYV3o8yGoP8hC/4mRnj2RP6
	 twbQsDPqkqRexQKI9kAEUb4EriwWJcXrm3yJiCmC3NcKC4UL71LXrp95b3KT1OSUm2
	 9WNY5XJLF0QhANNzoRbtrbeGnF4KelEXHO8NlNrJDTyKAfrJ/TwKZTKjH+BqvzMr01
	 DBD5JrRgU4DvA2KLjeUd28fI/NhvOGokNpyGOq+jM46IeQDFkmWxdJrdE4eUpqy7mb
	 Tp3vOZPU7iUIQF5XQvq/Df4dweQlbWtBLwbP0DfSWhtNF1bXMUPQ1U3hkh1b0z8Z7j
	 C0fdX/oVBjUPQ==
Date: Fri, 9 May 2025 08:45:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <aB4jKjLsXCzcH4yd@google.com>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
 <20250508120321.20677bc6@gandalf.local.home>
 <89c62296-fbe4-4d9d-a2ec-19c4ca0c14b2@efficios.com>
 <20250508145439.4c6482b7@gandalf.local.home>
 <8889c16b-9c3d-4ab3-b353-e00146532174@efficios.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8889c16b-9c3d-4ab3-b353-e00146532174@efficios.com>

Hi Mathieu,

On Fri, May 09, 2025 at 08:23:49AM -0400, Mathieu Desnoyers wrote:
> On 2025-05-08 14:54, Steven Rostedt wrote:
> > On Thu, 8 May 2025 14:49:59 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > AFAIR, the cookie method generates the cookie by combining the cpu
> > > number with a per-cpu count.
> > > 
> > > This ensures that there are not two cookies emitted at the same time
> > > from two CPUs that have the same value by accident.
> > > 
> > > How would the timestamp method prevent this ?
> > 
> > Do we care? It only needs to be unique per pid doesn't it?
> 
> Is it possible to have many threads writing into the same
> ring buffer in that scenario ? Are all event records stamped
> with their associated PID ? As long as we have enough information
> to know which thread was associated with the timestamp cookie
> on both ends (request for callchain and saving the user callchain
> on return to userspace), we should be OK.

Yep, basically perf sets PERF_SAMPLE_TID (and sample_id_all) which makes
every records come with PID/TID.. 

Thanks,
Namhyung
