Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CE28F514;
	Fri,  9 May 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806142; cv=none; b=ZwBfP2LhFjKf7MU5hauF8dAIgQFwSDePWMzzh/ce1QesNK4yaJDa/7aAR/vSXMRS3hF6IqTTf3yasH715YsThpAPOy6FI45TodKGyWwMaTCdAnNtbnpJdgHBGhko0KBeB6zBjf9We5kbphDiby0SrQ8WMIwvv0TYAUH5XyHP+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806142; c=relaxed/simple;
	bh=K/Wpb6iCN/OvB3MXINIGgaih96m/6TtnVEPRz5NxA94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd+rps40lU5CDXqUXh8BFjSJw2DZA2zlBd7TjhE8ItS6XPDrxoPIWK5iqUIGzW0VVBEGVT6HC/azqwYCnTBQ84Qk7oTnzQaq6YOvb+qna2L964YDCjDC+snwV/kbg5NU+/gnCxiz3mqD7RCqrzIiCdhC1Cls8LWrbfTmi/LPrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D0EC4CEE4;
	Fri,  9 May 2025 15:55:38 +0000 (UTC)
Date: Fri, 9 May 2025 11:55:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250509115553.0811747e@gandalf.local.home>
In-Reply-To: <aB4jKjLsXCzcH4yd@google.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
	<20250508120321.20677bc6@gandalf.local.home>
	<89c62296-fbe4-4d9d-a2ec-19c4ca0c14b2@efficios.com>
	<20250508145439.4c6482b7@gandalf.local.home>
	<8889c16b-9c3d-4ab3-b353-e00146532174@efficios.com>
	<aB4jKjLsXCzcH4yd@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 08:45:46 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > Is it possible to have many threads writing into the same
> > ring buffer in that scenario ? Are all event records stamped
> > with their associated PID ? As long as we have enough information
> > to know which thread was associated with the timestamp cookie
> > on both ends (request for callchain and saving the user callchain
> > on return to userspace), we should be OK.  
> 
> Yep, basically perf sets PERF_SAMPLE_TID (and sample_id_all) which makes
> every records come with PID/TID.. 

If LTTng is fine with this too, then we should be OK as perf and ftrace
both record TID in the events. I'm assuming that BPF would be OK too.

-- Steve
