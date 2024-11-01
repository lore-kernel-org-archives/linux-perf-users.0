Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C801AC884;
	Fri,  1 Nov 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482882; cv=none; b=bilkf/mUZAn/YubGClnw6huci0KKfRuRU709tggfi/LomYcJc1hfqp4p5sAo2erqyATefjEqLRxUAQTXZ4CGQq6IR+tqrwh+r4VDTxbnLezqiHp+GH8m6Gsaz3OrI8fkEHk7oSNdb5S1cxEohAJXiZ9SX8bNseZJKtT+Ibg9nJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482882; c=relaxed/simple;
	bh=XeLsmqqTc3tYnHi81CpCxpoUam3VFymyrAfk9PaJZ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWiMapD3HXO4C/+lUn8lFm3AKYJiVGRm2nktl+YpYr5ayGPcs4eQHH2B3tHlqTritOokzmNRb090xKp5F8MOoDs0H6g7Z44cw0mY8fOmnDBE7t/G5lLFOUnHCzZmZgoz+DkTvAAf8BUdFLUJUZ8S226awA/akc7YAfuIuc10C5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYHzKctO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYHzKctO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CE6C4CECD;
	Fri,  1 Nov 2024 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730482881;
	bh=XeLsmqqTc3tYnHi81CpCxpoUam3VFymyrAfk9PaJZ6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYHzKctOz0p2FFBtqGmfIcnL9+kIiQCHrpWgnI+ZuYHgzh0AsZfKZQBvrRdO1fhPU
	 7aWYTGS6o6S6d5WhiCoWVAV5SqSeYx4wXc3cl72CE2adtfQR0oNg44OVdl8m9FXls0
	 t/ttz/EvkhjSixLVn6DBcPdfUDOpzLFjDj3kqvaGCTLCw1mphQJKrcU6qr2xBGP+p/
	 DQjq8SBTmrJPpR7Bb5rf4LoQldszghd3IaDeX//74fKA6bfHriJtyPPXjYg1wnXBeB
	 HpgmjH3Kk3fk5Mj1k/MIgQijxZp40pRx8lOEUB0gL023ZuBR+XEGB8ZVPGZbFGZ+BQ
	 urAfK3N03bSXA==
Date: Fri, 1 Nov 2024 10:41:19 -0700
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
Message-ID: <20241101174119.qso5fdln2chdflav@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>
 <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net>
 <CAEf4BzYd5OT9COBS4va435jqMzkjvvAHbe55AR6giv8pitUvAg@mail.gmail.com>
 <20241031231320.h2hwns367e5byvyy@jpoimboe>
 <CAEf4BzZksT=GTs268KBiCsYxUcvWz5KUghjKQQR8OxGdoBt=6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZksT=GTs268KBiCsYxUcvWz5KUghjKQQR8OxGdoBt=6A@mail.gmail.com>

On Thu, Oct 31, 2024 at 04:28:08PM -0700, Andrii Nakryiko wrote:
> So all task_structs on the system using 104 bytes more, *permanently*

Either way it's permanent, we don't know when to free it until the task
struct is freed...

> and *unconditionally*, is not a concern

Of course it's a concern, that's why we're looking for something
better...

> but lazy GFP_ATOMIC allocation when you actually need it is?

We don't want to dip into the GFP_ATOMIC emergency reserves, those are
kept for more important things.

Actually, I think I can just use GFP_NOWAIT here.

-- 
Josh
