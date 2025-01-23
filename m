Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB2C1CEEB6;
	Thu, 23 Jan 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670755; cv=none; b=A2wIcF3okJ65NDk+Rn2ixAOKssmRaPnhg+kEpHUzP9f4uJEZJdaMG/MBlAcsdGsiHhN4kfROVFtn4tRV6Nenu+sGSw25+sFfy1L4z8tJcQNLg5Kiqt1th/PemEqKM3Pd1G7tFTzjUxPKHl1nFJKE8rqCGsSURFXu+znAcH6P9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670755; c=relaxed/simple;
	bh=B7gk++jCMY/BtalIYCw/H6LHVHDOviKcwWkkwl2PrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxCKws2dlncNAe7b5f+E2z4Y8heyPaGk1THlpbylUKtf06ScizgAWfrh+P5VeZTzvdWZQu2Dqj9PZq5wbuQH49RT668N1oVLXREn9KewYnHPq/CSfpCG4+WtTAYwNdHSP5N5vqTXtD0J145oA5c+ka/Jq8upbk/aE/WVrkcH5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LDOmfgsl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LDOmfgsl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LvA5ehYZhYft0tnAhYfdtI5coJkJeA/0CGC1dXTtsX0=; b=LDOmfgslOIOyKVSdtPxTzIEon8
	fA+IADLs4h7UOW3ns61cBbHMKYErAD4zDeKp/GCLrMBWbEGh208rKI1ud0WLRlTV1/GxdWkQ9lKC6
	vKZD0M4ABH9NNdT3mByRmP5329KohKocDYBxc/FoJYkSki67oxTXPNirW3J/tohLm/rMYhVzN8l1f
	sQSQZeH4cuhC6m8mpTM4jLxmuPHkMNg3wJ76vsLr00wVm0RWv55GCHI4l7RZ8Vmu4EbzUr7R/vJR8
	k1ZBsIjXB9i1aaDAkQqM+P06bPs2shRzXAKOcyaHcpn1mS+c300QAarerZlgtT4qbLj/oy8Ix1dr0
	ywzljHrw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5XT-0000000BBGv-3Sgh;
	Thu, 23 Jan 2025 22:19:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35EE5300717; Thu, 23 Jan 2025 23:19:03 +0100 (CET)
Date: Thu, 23 Jan 2025 23:19:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Message-ID: <20250123221903.GF969@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
 <20250122122821.GN7145@noisy.programming.kicks-ass.net>
 <20250122204720.t42a4em5endxox3y@jpoimboe>
 <20250123081403.GA3808@noisy.programming.kicks-ass.net>
 <20250123171509.3xmrbrbmu3tsll7w@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123171509.3xmrbrbmu3tsll7w@jpoimboe>

On Thu, Jan 23, 2025 at 09:15:09AM -0800, Josh Poimboeuf wrote:
> On Thu, Jan 23, 2025 at 09:14:03AM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 22, 2025 at 12:47:20PM -0800, Josh Poimboeuf wrote:
> > > What exactly do you mean by "NMI like"?  Is it because a #DB might be
> > > basically running in NMI context, if the NMI hit a breakpoint?
> > 
> > No, #DB, #BP and such are considered NMI (and will have in_nmi() true)
> > because they can trigger anywhere, including sections where IRQs are
> > disabled.
> 
> So:
> 
>   - while exceptions are technically not NMI, they're "NMI" because they
>     can occur in NMI or IRQ-disabled regions
> 
>   - such "NMI" exceptions can be preempted by NMIs and "NMIs"
> 
>   - NMIs can be preempted by "NMIs" but not NMIs (except in entry code!)
> 
> ... did I get all that right?  Not subtle at all!

Yeah, sounds about right :-)
