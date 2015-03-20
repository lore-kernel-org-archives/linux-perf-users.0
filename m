From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 20 Mar 2015 18:45:42 -0300
Message-ID: <20150320214542.GS16485@kernel.org>
References: <20150319225858.GA16485@kernel.org>
 <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
 <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
 <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
 <20150320203922.GO16485@kernel.org>
 <20150320210709.GQ16485@kernel.org>
 <CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
 <20150320213429.GR16485@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42408 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCTVpr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Mar 2015 17:45:47 -0400
Content-Disposition: inline
In-Reply-To: <20150320213429.GR16485@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>

Em Fri, Mar 20, 2015 at 06:34:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> Strange, are you pressing 'V' on the main 'perf record' view, i.e. before
> getting to the annotation browser, to see the DSO just after the symbol?
> 
> Trying with a deeper callchain in pow-me-harder.c...

I'm not being able to reproduce this, out of ideas, back to processing
some other patches, please let me know about any news on your side :-\

- Arnaldo
