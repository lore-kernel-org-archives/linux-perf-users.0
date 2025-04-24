Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87120F070;
	Thu, 24 Apr 2025 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522867; cv=none; b=rj+xXg1sLzdWTCljEgJCk2oTYXCZYDTYDjvFsp+a/ulPjEWbygUhfujkIkgnq0yWK3EMsqN92WF0IBPaA2Z74sQTCAwsDPFaNrscoCpg/qoCwjZjbY/tNs5UYUzFfVJWOvjDwLZzOdeaY3rh6mbwM72d//+YVMiqq8yrZJ+etb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522867; c=relaxed/simple;
	bh=N1XG3jyOjkQ6x7wHNsp8O2x06iBDYxKQu0BlC/Fi6lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYii9/1A8m1mCl0hUJ84FNsN+RmzEjgdIlbySlfC3zCumiCTvdi6YPtvsm4Ckgdskgn7YiXaqavOsQ+waJ8DPz5Zxe3HT6v10v3vXAjUueZQPDUYZ3DQ8/X/uppjF8CzjJj4izkoZ+MA6yAmsDVQ4wfPp9AXbUXwMxNmKq1QDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89601C4CEE3;
	Thu, 24 Apr 2025 19:27:42 +0000 (UTC)
Date: Thu, 24 Apr 2025 15:29:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v5 0/9] tracing: Deferred unwinding of user space stack
 traces
Message-ID: <20250424152938.0922463b@gandalf.local.home>
In-Reply-To: <20250424192456.851953422@goodmis.org>
References: <20250424192456.851953422@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 15:24:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This series focuses on implementing the deferred unwinding for ftrace
> (and LTTng could use it).

I forgot to say that this is based on top of this series, and does not yet
include sframe support.

  https://lore.kernel.org/all/20250424162529.686762589@goodmis.org/

-- Steve
