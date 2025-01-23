Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72408136E21;
	Thu, 23 Jan 2025 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620134; cv=none; b=B/6iiGNNk8zRG3b+n7qi2VHFJF4pWCrYf77TTVWj4hdsVXfds8QILxKW6+GKftFgTETVL98TFzLSUq27EUEK4smw/kvyZ4bMsUVbbjGjwKvnkzKyH+JaNCKSYV+DJLN9F95+KKJ2MqNr4FRycePUUT930gWu7B69g3goPDi7/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620134; c=relaxed/simple;
	bh=0AK7WmvDyjQlRYeM0Ly8UcgZD14ijCOLsfLs/Z7AfjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emdmWGlLHOpdOCSeMicPVWry0ePjsSehcm6xfAa8CTOwDe9HzBvrv7nQy7xGtW5nUnurzc6xJhWz3UVFg7vcSJNpfVh94ZdOVe7qefqpc/c88/41eb8XDr5MrsU2lArQmF0F+TQksrLWypUum4rz7hpr2rRKHW8Ukao9RMBmOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eOsh1CQa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eOsh1CQa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8DHZ4n2TBAlXWrin3ifIzIgZkldTo1uEfhcby08Z7EQ=; b=eOsh1CQaOf35FD+PbGE+DqB8bI
	HV76z+8mMC6mGPqa9rPydmMaHcPnfEOjWY3xReDeyyRQi7ioCXPSGBCmQz/v8dT/dVnudy0Jir150
	7XOnUlPSDj7NyZSb5kq6T/P3uSVtwar4FnaGz3QyxZRLcJ4w+FGM36WrQM0upncBNGtcKnRW/XvLP
	maaKDqpvs1WpwRtmrFFoZuBQVm5V7yo9NTn702zIHZ9IOhHclVlBwcHMw9MSfZLcZTmyZ8Zmegvbi
	vzSDabgEc4sg19xiO7hMpFOmH5ne7UqI4BfAOtgF/nsXtbZ2TKjSDHr3RlRzKRNK0htdhp81DkNeH
	UIk6svrQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tasN1-0000000Dks2-10ll;
	Thu, 23 Jan 2025 08:15:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D1FE03006E6; Thu, 23 Jan 2025 09:15:22 +0100 (CET)
Date: Thu, 23 Jan 2025 09:15:22 +0100
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
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <20250123081522.GB3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
 <20250122124228.GO7145@noisy.programming.kicks-ass.net>
 <20250122210339.i6sehdw4ddzqyy5h@jpoimboe>
 <20250122221430.jfnleewvjj3mcbif@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122221430.jfnleewvjj3mcbif@jpoimboe>

On Wed, Jan 22, 2025 at 02:14:30PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 01:03:42PM -0800, Josh Poimboeuf wrote:
> > The self-IPI is only needed when the NMI happened in user space, right?
> > Would it make sense to have an optimized version of that?
> 
> Actually, maybe not, that could be tricky if the NMI hits in the kernel
> after task work runs.

Right, I was going to say, lets keep this as simple as possible :-)
