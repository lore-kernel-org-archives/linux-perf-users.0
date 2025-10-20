Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751152C2368;
	Mon, 20 Oct 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986042; cv=none; b=OGd2sqJOyrWzPUFmwT5qB1J989T6VbyaZRumW+uwm+zDN6Z78CaL5rZiNPm4CzRFrtE82eyQmm/FiQSvpNUg+e53OnJJVGruQOC6RPCC1fbj3c5aD3AKzAVC9cZw5+a9i3kgMbE2CfJ/VtZroiaJhKFxqdjn02M+VjsuAHHJ4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986042; c=relaxed/simple;
	bh=GseQrDC+hgXaA3u5o1V86eCA9a9iaRLuWbK9V9imRq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuEEKfKSZPPiFyM0pqKYaXnkTyM7m2hpsgPkcpcEVfsi58ea6Cfa/VF7kSyPyetLBKI+Laz2H7ioAfYeZOMvSi4AKlxYUQ0tKIbJSzhqlDFfx9VcofXQdFmmzghwCqX2x+M4DlJLtiZ3mvOqhspJUgT3sJVR8XT2GO2pnnDVjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DE37E86065;
	Mon, 20 Oct 2025 18:47:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id BD97D80009;
	Mon, 20 Oct 2025 18:47:12 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:47:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>, Takaya Saeki
 <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 12/13] tracing: Check for printable characters when
 printing field dyn strings
Message-ID: <20251020144732.308326bb@gandalf.local.home>
In-Reply-To: <8d15e5a6-e80a-4707-a43a-4cbb6d810222@arm.com>
References: <20251015173214.760495866@kernel.org>
	<20251015173550.062240695@kernel.org>
	<8d15e5a6-e80a-4707-a43a-4cbb6d810222@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BD97D80009
X-Stat-Signature: sbjaw5o7kk6o76brmheyatft4xe4ot9g
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PUk132oYyzOAbICIfWGFSdVhhBgPwPhk=
X-HE-Tag: 1760986032-109600
X-HE-Meta: U2FsdGVkX1/m4n2fxNMsNlQWzyyVqHwVelvAwc6in/iT58zHlFRObzHBfGG1u2E44NjuJ97tXfUkhWrOweptcVdBB2L7wbM1FvSsmnONqh+5S+f5jUoicPAg5dFfl/MQpdcIvgUmXPJu8gMfUqx+QMS2GYerDsyiopeARI1K7MS1t1QyP8IDJ7c3oW5XaoPxAkIyylBq42na8RmxCGJ+M+8tM7crFzms3ZD9+ca4oD5CJMm7L7hs7pcVozXSN6x63SLYVsu2NZGKaVOWCZoubHeQiRS2u8uUHDgkbpBxDA/pL6fPJowOdYR4wJJdqBAAKYyUfWh5tfyjk2l+EeBCKCyAJhoPMJgH1qybs3NHTlcwKJ18/QvPj6Mnbn9o7T2D7/Ah77rYR8/+8+8hP0cY4abq4/CeLIvWHixWqdKdl23WDgmG9bXlQlvNQs02qI8L

On Mon, 20 Oct 2025 13:19:46 +0100
Douglas Raillard <douglas.raillard@arm.com> wrote:

> Hi Steve,
> 
> On 15-10-2025 18:32, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > When the "fields" option is enabled, it prints each trace event field
> > based on its type. But a dynamic array and a dynamic string can both have
> > a "char *" type. Printing it as a string can cause escape characters to be
> > printed and mess up the output of the trace.  
> 
> We faced the same issue when converting trace.dat to other formats that distinguish
> between a byte buffer and an actual string. The current solution we have is to
> reserve "char []" for actual string and use "u8 []"/"uint8_t []" for byte buffers.
> 
> Obviously it does not solve the problem for existing events but that could be worth
> establishing a convention like that for new code and support it in trace_output.c ?
> Most uses of trace data beyond direct printing would require knowing the data schema
> from the header info, so value-based criteria are typically not suitable for that.

Well, what the types are is not quite controlled by me, but by whoever
writes a trace event. Thus, it's not going to be something I can control in trace_output.c

-- Steve
