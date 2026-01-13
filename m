Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FF2FB0B3;
	Tue, 13 Jan 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335680; cv=none; b=QjWHUgaHGynGK+BOYefCFjzB2MVxZvnaxfgI5j0tz1Mp+IT0rNIMPEu4hShOclZ+hX4HvgBVCvmRfoO6c6qoHJcR6KynQlrr9q2A+/NYSfLE6y60mwXLvtuSi6P+8EP9Cc8ZMFw2MgvRnN4TLT7/1Z2owLpsOEQMncq07QGBosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335680; c=relaxed/simple;
	bh=0eug7L5Oo4daX3SQM8scaIph0aOL/b1RcK3Ba2oHqRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF8y6wTBiI4m1JsGzeH5n1GQ5DKUxN+RBWhP5Npev4APFr677zSjh5TPh31i0/0mqWPz/iErtba1QumEGqdNS4B+MClZRrEH5AqmBltUOQ2zrc1o4h/loClfCP+qtYk/wiLTqtNh2Ymh/7T6TnGiyttIfitZ4dhabVQGMcTWWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcE3dQNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcE3dQNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B51EC116C6;
	Tue, 13 Jan 2026 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768335679;
	bh=0eug7L5Oo4daX3SQM8scaIph0aOL/b1RcK3Ba2oHqRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcE3dQNpejvckUkL8pyeSwN/r8IMy4jvbpyqn3rDN0YQX4eqMiMs47FbbcHMS7vqm
	 izswuyDD5uoUcbGCJQcHYYLUy/3G0Mi8NDGCIB34gGjAmU5Zt/11z1xrLObGB3Jy2+
	 iBrAaVPduX9+22XqFjkqNijzTH5wpjI4jP4dZ/umFfQEt9GG3f2B4Hfn0eQjjsgmfw
	 HCpmUGgkkyI6+Q7eQsScrr05k13Fker+Sq5pySCe+y62N34NWZEqLCXP8/iq+L2iKC
	 KgTPbQGEUJPEsFLo1uDwgu8SE4ucO6REjx/mZj8eSrjhQTb00Bb/XtpGF6hGCyRJSl
	 m7xIjlterONzA==
Date: Tue, 13 Jan 2026 17:21:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf test: Skip dlfilter test for build failures
Message-ID: <aWapPIv5MI72R7Rm@x1>
References: <20251219011820.2505506-1-namhyung@kernel.org>
 <aWBEr-PCJS4UEvtI@google.com>
 <CAP-5=fXp+jQFykEenXo4u9S6TstZ-xZ4ZHGOmn3HRBWHzc5agA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXp+jQFykEenXo4u9S6TstZ-xZ4ZHGOmn3HRBWHzc5agA@mail.gmail.com>

On Fri, Jan 09, 2026 at 03:16:50PM -0800, Ian Rogers wrote:
> On Thu, Jan 8, 2026 at 3:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Ping (for the whole series)!
> >
> > Thanks,
> > Namhyung
> >
> >
> > On Thu, Dec 18, 2025 at 05:18:17PM -0800, Namhyung Kim wrote:
> > > For some reason, it may fail to build the dlfilter.  Let's skip the test
> > > as it's not an error in the perf.  This can happen when you run the perf
> > > test without source code or in a different directory.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
