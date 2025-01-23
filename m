Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA62F3B;
	Thu, 23 Jan 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657939; cv=none; b=lxgXaRmjvnCVhtGpRapis7p+qfYZKVGxMVk965SWsr6L/ICvFDwGYbNx8I4pyVwRbJSMO8nZ4hb6LWDlhYPM4aUfgU52r3aVwg979pWDa2o2A4BfNoWJUe8OODC4OFIWURLpUDIZpAWQtwosNOiwP6NBBs9eyiIW/SApKlTjGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657939; c=relaxed/simple;
	bh=/hzZPwGynrYSsJ+Bya58z3KDQHJTOwtaPmGbJDf7sDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT2NxcyV8AumU5CTxksi+MzOG7saHdLdXpfDm1w3BZe9vaH0/dYjJ8tiljlqJLqjEcdBbvTe3vQRaED0U9eTRPDJ5eb9SCueR5lcFMMrwa6TyQeloQyHxlsmU9xG+DAmeLq1899UyNz85D6EUfDPP0GNZ9rJc80kR9jx1bkGkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+1SPXdB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+1SPXdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E935FC4CEDF;
	Thu, 23 Jan 2025 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657938;
	bh=/hzZPwGynrYSsJ+Bya58z3KDQHJTOwtaPmGbJDf7sDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+1SPXdBSZuJAljXTJCMFDISzXCpnse7SDSnYEyVOQlZ5X3Tj0sDby58uuSN0U3Az
	 CfEWZE/0jlajncdVQlqWBKFr2H/NBssNIk7cfNCuSnARH7VzMsRw2rfbLgn6cRNyf2
	 OnJBWFhIFVDM/PmqJ+Q7dzk0bQIh1/ygAyD7yh6bwG58Lm/O5Gr8pFuvDbuYy3TbOe
	 BoVwMz6ppe1mHP2f9N3iQC9edZ8BgJfnRKn6FR/UfDOdk+edL3MEv+PixIgV5ipfp5
	 a4z4VifQtY79NBszPBvqF4cpp/MoeMcMQidHD7mVz4gPIUJzX7brufBcXS9WM3qLIx
	 YMUgSHSbIGFEg==
Date: Thu, 23 Jan 2025 10:45:35 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v4 29/39] unwind_user/deferred: Add unwind cache
Message-ID: <20250123184535.hymskoka5e73ufwv@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <51855c0902486060cd6e1ccc6b22fd092a2e676d.1737511963.git.jpoimboe@kernel.org>
 <20250122135700.GS7145@noisy.programming.kicks-ass.net>
 <20250122223625.aibbrh43pjkzve6c@jpoimboe>
 <20250123083131.GE3808@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123083131.GE3808@noisy.programming.kicks-ass.net>

On Thu, Jan 23, 2025 at 09:31:31AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 02:36:25PM -0800, Josh Poimboeuf wrote:
> > On Wed, Jan 22, 2025 at 02:57:00PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 21, 2025 at 06:31:21PM -0800, Josh Poimboeuf wrote:
> > But if the NMI happens late in the exit-to-user path, with IRQs
> > disabled, right before nr_entries gets cleared, the cache won't get
> > used in the task work.
> > 
> > However I think we can clear it on entry-from-user.
> 
> Return to user runs with interrupts disabled, if an NMI hits that, it
> will have to set TIF_NOTIFY_RESUME again and queue the IRQ work thing.
> That self-IPI will hit the moment we do IRET (which is what re-enables
> interrupts) and we're going back into the kernel.
> 
> Anyway, I suppose that is a long way of saying that you should be able
> to do this on return to user.

Indeed, I knew that but somehow overlooked the fact that the IRQ would
clear the cookie so the cache wouldn't be usable anyway.

-- 
Josh
