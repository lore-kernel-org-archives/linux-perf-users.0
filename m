Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA4259487;
	Wed, 11 Dec 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944622; cv=none; b=l6ggWLBG3Dy1BAhk+dXbAhwtqwROrEXKbZV+8FNLau1FwqkBfk0sUHWaWzBr0uadVnyVbVruCKtbct2ER+tbO9Nl/KFd4Cfvfr8dolU0KuZfBoLuQYK2k5W4AvvgyX6+FGDnEPcmdWIQum/d5k/X40JOve4TeFY0i5V/PEY947Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944622; c=relaxed/simple;
	bh=JYtE/PzAOPqP/g9sqizspw7MFjU0tdkKLj4+8sLFF4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3Gbi7IdfEtuTvWcSuFt8lB+sPsYqP/0y/I0R5S3rdKqufmzemFG8rpxEWeKaMk3/WZH8oRfQfmsZ72lpMRxqP1FdmXgO2fvvOo8pPiuQJX7YaKHAc7s2XOieT2tsHQzM6F2h0NWGz0AMmjeLUCafqutiYSiXuGqFZ4Ncz10dJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBaTy5aq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBaTy5aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF22C4CED2;
	Wed, 11 Dec 2024 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944622;
	bh=JYtE/PzAOPqP/g9sqizspw7MFjU0tdkKLj4+8sLFF4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBaTy5aq36nH1Xxi7n47Yx9pPGGdhACrjS4YuC1UxYhmxrMztqr8DYIuiu/wspEES
	 hG0xUtK+XSAViDRh302aaRhzfLsS4yEoFvDD9RP3H58GDqMPxbkDV/ox9YPN/TRopB
	 M4ujBNnYB0TSVpdfmTHFYYFiBIvCVp1DYPMTREu9USZ2kG5Z8fC5S96mFZ1FgFVOAA
	 NlBPSYAWljJJGeOJLkkA0zpp87NALsXPOSRP2yVHr6TBohesu2QIYY/LvXDr48a/1D
	 A0zkKY0IjFMflg9Z29SLpL6oZkbo+xleTVyhQxoHzIFZONR6gCnnMhgaqRe5Rot1F8
	 8jGUDmA8Iz6AQ==
Date: Wed, 11 Dec 2024 11:17:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.ibm.com
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
Message-ID: <Z1nlLM0JJqEwxRFx@google.com>
References: <20241205022305.158202-1-irogers@google.com>
 <Z1iUmVRzN0V3vMpG@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1iUmVRzN0V3vMpG@x1>

On Tue, Dec 10, 2024 at 04:20:57PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> > The refactoring of tool PMU events to have a PMU then adding the expr
> > literals to the tool PMU made it so that the literal system_tsc_freq
> > was only supported on x86. Update the test expectations to match -
> > namely the parsing is x86 specific and only yields a non-zero value on
> > Intel.
> 
> Namhyung,
> 
> 	Since you see no more problems and Athira tested it, I think
> this should go via perf-tools, right?

Yep, will do.

Thanks,
Namhyung

