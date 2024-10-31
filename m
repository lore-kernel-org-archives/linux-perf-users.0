Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08C19F430;
	Thu, 31 Oct 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416405; cv=none; b=ayLAuNlIgUAzbQ97jJfmfMq2IHyc5IVZZXXlX6BDOIlytCWxHLfJlKi9v/JrztHJ8xw2G3XbQNWdnJ4p6XdnS1RGs/ZCl8I0+pFhsacjpN+bq8noidDRHzLyGVcDthe04gKwaI1oTHh2t2mVyJViAWIryxr9H5CVnvXWZEMG9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416405; c=relaxed/simple;
	bh=mEmnzC1xd/KNq1I/xUPwImaQnTcCICieDIqR5sZlge0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSZ9ZgL8SI4PzD2D6IeAaIlZeE5wWJ/7uLsp/0SkFOGb5H1J+cH3mvp5r4yNKW8BRSzQWDmsCum80VXThJDFnzCI8MngVjxYLwBe/luN93aBPojWgmQg1dfRnrUskY53V6eorb7iasgqNP4+S9jMUD6g/Qtbnr8EF1E4Pl9uSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbbPtvAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbbPtvAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A756C4CEC3;
	Thu, 31 Oct 2024 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730416405;
	bh=mEmnzC1xd/KNq1I/xUPwImaQnTcCICieDIqR5sZlge0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbbPtvAadCEec6g5GZf7sJSw3tl4vL8IN6rFF8ukYp3L1h6X6jzJ0INLRS+k4/bZF
	 N0mQbSswrOqLejTR4tccjDEh2LoevQeO0lxpygKlR1BvKlFAKgZHCAp9BDCY7+T1fU
	 IEAH9MTIyScXl3wEnEmq5pe0yUve+PQsqeKgueK+yz6hSyJyu2p5s2ltc/xIEfsugk
	 bPLSwWjfNwLgiTuLko6ZYwz8Nci0Wsfm9RfB14Le4t1fnOslEIVet1EAYalYqBNR01
	 96rcMRYo3LYsXaMtNMY15C/hJEt2EEaczO1vD8/ZFOXeFN8wHXZx7susoOaIijcso/
	 x9yAUaqcBMznw==
Date: Thu, 31 Oct 2024 16:13:20 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241031231320.h2hwns367e5byvyy@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>
 <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net>
 <CAEf4BzYd5OT9COBS4va435jqMzkjvvAHbe55AR6giv8pitUvAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYd5OT9COBS4va435jqMzkjvvAHbe55AR6giv8pitUvAg@mail.gmail.com>

On Thu, Oct 31, 2024 at 02:22:48PM -0700, Andrii Nakryiko wrote:
> > Problem is, the unwinder doesn't know in advance which tasks will be
> > unwound.
> >
> > Its first clue is unwind_user_register(), would it make sense for the
> > caller to clarify whether all tasks need to be unwound or only a
> > specific subset?
> >
> > Its second clue is unwind_user_deferred(), which is called for the task
> > itself.  But by then it's too late because it needs to access the
> > per-task data from (potentially) irq context so it can't do a lazy
> > allocation.
> >
> > I'm definitely open to ideas...
> 
> The laziest thing would be to perform GFP_ATOMIC allocation, and if
> that fails, oops, too bad, no stack trace for you (but, generally
> speaking, no big deal). Advantages are clear, though, right? Single
> pointer in task_struct, which most of the time will be NULL, so no
> unnecessary overheads.

GFP_ATOMIC is limited, I don't think we want the unwinder to trigger
OOM.

> It's the last point that's important to make usability so much
> simpler, avoiding unnecessary custom timeouts and stuff like that.
> Regardless whether stack trace capture is success or not, user is
> guaranteed to get a "notification" about the outcome.
> 
> Hope this helps.
> 
> But basically, if I I called unwind_user_deferred(), I expect to get
> some callback, guaranteed, with the result or failure. The only thing
> that's not guaranteed (and which makes timeouts bad) is *when* this
> will happen. Because stack trace capture can be arbitrarily delayed
> and stuff. That's fine, but that also shows why timeout is tricky and
> necessarily fragile.

That sounds reasonable.  In the OOM error case I can just pass a small
(stack allocated) one-entry trace with only regs->ip.

-- 
Josh
