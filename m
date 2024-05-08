Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1726622;
	Wed,  8 May 2024 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128930; cv=none; b=nsSQU6LfwwXhhh1wOQmH27ATjES8yXeDIFuL8tppzxBIsKIQE/kWWDlF1fMWxsrAxvjG8j92xSrmP+EvKTT3wNC9/f32WKoDpadHut6w8MvDNQNQi1t2Xs/28POMcisnxtdUEYlZCxizdaWSfB6Q8wcq1vKGpje+B3/HsBpJDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128930; c=relaxed/simple;
	bh=cMPB8JByBguRKhjILcllAZIhhWQ03/cNqUNHlW3lq94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIk0Xnnu7P0/VAnFd5QyBQqo1Zhq6byjpuYJLO+ZxY/8uf+gcHs7yhnot+Y3kji/i37spothmpZN1m9aE+ymDeY1fBKVoYJjHRpW3qsJUCaDAqd3YW/yPXSkaV8OZiK7D3hUJaWrWEN6mZ27DfcuaTSJ9v+WerAQzsIIDxYXl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw9IWcnN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw9IWcnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D8BC2BBFC;
	Wed,  8 May 2024 00:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128930;
	bh=cMPB8JByBguRKhjILcllAZIhhWQ03/cNqUNHlW3lq94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nw9IWcnNlap8METO3z95eEE2YZAe7sPhbR9PipjrOv2OUJ+uKJv1boDUsbk9YKnSt
	 ENJ4jjTak2SL69VS2CbgJ7dVXwm2XvUqvyfiLboUom6gSslclPXRpZrP/oSZ3qSxF/
	 AM2KwkFOnwuavhHjggcmF6tUujY1xlSUO1Mrn6vxXek0NiDperyr65PShErUEcdwTu
	 LTqEoSBmChbboIJlzqoSuTFFTx0FOOmxieOO9d0ABsZUeZKb8sCbMOsudvX7W/cBmz
	 oUScLyNldpkGbpQtRgCRRHSdWP+l8wQqkEqEv43Ao+H5fNSzLbKBB01v/+PIKIF25h
	 hmyDmSNJOeMBA==
Date: Tue, 7 May 2024 21:42:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf dwarf-aux: Print array type name with "[]"
Message-ID: <ZjrKXuIE2RWntStf@x1>
References: <20240507041338.2081775-1-namhyung@kernel.org>
 <20240508085751.a1a5dbd31e1fa7d4e80cdd85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508085751.a1a5dbd31e1fa7d4e80cdd85@kernel.org>

On Wed, May 08, 2024 at 08:57:51AM +0900, Masami Hiramatsu wrote:
> On Mon,  6 May 2024 21:13:38 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > It's confusing both pointers and arrays are printed as *.  Let's print
> > array types with [] so that we can identify them easily.  Although it's
> > interchangable, sometimes it can cause confusion with size like in the
> > below example.
> > 
> > Note that it is not the same with C syntax where it goes to the variable
> > names, but we want to have it in the type names (like in Go language).
> > 
> > Before:
> >   mov [20] 0x68(reg5) -> reg0 type='struct page**' size=0x80 (die:0x4e61d32)
> > 
> > After:
> >   mov [20] 0x68(reg5) -> reg0 type='struct page*[]' size=0x80 (die:0x4e61d32)
> > 
> 
> Good improvement!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Indeed,

Thanks, applied to perf-tools-next,

- Arnaldo
