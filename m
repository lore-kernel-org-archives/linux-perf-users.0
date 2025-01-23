Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5814831C;
	Thu, 23 Jan 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652513; cv=none; b=qHJ1q1hdX44/ymm/AhWD5yW5/iRMz7X5m4vlbSz47WsUfuByg1Oxbu7OxVCyPf8N2djbnWMp1Ds3h+XbvZj3JbsjOsrGLnwN4qKH5sGRHb29K0u0LqBLr2gPUIUdGBBZs/iJKLnE/hUKKUAzEU4v4sT5GssBju5FuGG4j1ZJkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652513; c=relaxed/simple;
	bh=nu69aD+91RPxf0w6srnLP3MSuMQn0rt5CBqU9EAgxAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDlyPINPnwASjN4CDCdaJyBNCkwxb/iWPkiPVJidyHsepeoSvRBExm2I9mWYf9DfaCFQpQaeIO6q1tMf3XnQCXSMOyJ+ZShaMiMugK51nijt6+OAgI3cUBtyW3UIXBo9tz5c0rxwBpsFqG28aaOPo0x91wgGuGmy5otgIpcH7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N54iZ65m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N54iZ65m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6455BC4CEE0;
	Thu, 23 Jan 2025 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737652512;
	bh=nu69aD+91RPxf0w6srnLP3MSuMQn0rt5CBqU9EAgxAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N54iZ65mtW8O7/RdKqepmL7ZjqSLNc11Sn3rDIn036WpL9vbWkbHW7SNOerTAwEBi
	 8TWEvOo0aG+m/ZjyeLToNm52ylh9Bjpb7s1m1ln0bt8jzEnzGqIOw+ywhCJuWHMQnk
	 wL8dAOWk68YOAATv8loCVqEnKnXlyUTGJ6TZaDYZ3aVbHzjgxmz+oKCYy5LI9T3Bqj
	 k9c71sP953nrvp7NdbbZQ48PGHxefmwpIYoPfan10l7wvyS56E/yM63eJ9FU2I/glV
	 t0kX7be4SGnNuQGZ0LuvoxvDl9e2oZmlLrm97Hd5fy0dw/ly/diIotCa8CyzV9ZBU7
	 Dqed7KpWsMIig==
Date: Thu, 23 Jan 2025 09:15:09 -0800
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
Subject: Re: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Message-ID: <20250123171509.3xmrbrbmu3tsll7w@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
 <20250122122821.GN7145@noisy.programming.kicks-ass.net>
 <20250122204720.t42a4em5endxox3y@jpoimboe>
 <20250123081403.GA3808@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123081403.GA3808@noisy.programming.kicks-ass.net>

On Thu, Jan 23, 2025 at 09:14:03AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 12:47:20PM -0800, Josh Poimboeuf wrote:
> > What exactly do you mean by "NMI like"?  Is it because a #DB might be
> > basically running in NMI context, if the NMI hit a breakpoint?
> 
> No, #DB, #BP and such are considered NMI (and will have in_nmi() true)
> because they can trigger anywhere, including sections where IRQs are
> disabled.

So:

  - while exceptions are technically not NMI, they're "NMI" because they
    can occur in NMI or IRQ-disabled regions

  - such "NMI" exceptions can be preempted by NMIs and "NMIs"

  - NMIs can be preempted by "NMIs" but not NMIs (except in entry code!)

... did I get all that right?  Not subtle at all!

I feel like in_nmi() needs a comment explaining all that nonobviousness.

-- 
Josh
