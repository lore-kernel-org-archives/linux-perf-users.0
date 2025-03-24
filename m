Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E362E3383;
	Mon, 24 Mar 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801317; cv=none; b=Me5P8q1nJRnw42rqWtMqE6GhFLS4eEq4lvMTRsvktp1GAIZfG+ZZezTY4L7X/WvzI8teOI7zXu5vtuKK2SmPfq0gWY8vLzCerbmFPvtvqujgnUOk+9JI1T56ZTAd9+MdIqCAI5bmJwM+VvdtEFjURMkpkygtj1Wg0C8QyavUnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801317; c=relaxed/simple;
	bh=qvjg7nMYqzOBk4Rb6LYZs4P08P2ISAkK/8qUWcFYCis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ9IyjnZ0SYslI9jwe2FD+gOKGnnoGRqozvcArbR2HoIgPMIofmRAowerhVO15uKUePAUzOKa9Vcgs8WuPdsbS46D5S48VfqSPZ8Y799hBUbUs+LZDzFWc2fDR1fLbMLqRkE71NZsHblyY579hWIP67cmFxI7qrbpoq8LcoF33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXOWnZgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXOWnZgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0E7C4CEDD;
	Mon, 24 Mar 2025 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742801317;
	bh=qvjg7nMYqzOBk4Rb6LYZs4P08P2ISAkK/8qUWcFYCis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXOWnZgoo+0kAl9qy5ZgdSs+1OtDGQog9Gmuq//QQwd1z9g1PGctEpTaIxFYuJnHb
	 MNfO+m9yNB21bl1gdncarbsg/i+aL55rEGoMD5cJSajX2QlOVUNO3pxXi1bsNF8e9o
	 3hDd+inoZjxYgunAF6wO0KjioT+b+rHmliBAPgNTZG328bhKJY1iI2NLv6H7vGCTWg
	 XQpIK4tWtqiJlN8Hr1GpmA6rXuhD/ZNwFzQg2wCOUxazyMwQbr/5q5J419eH7NqxMd
	 f7yOE1R0K2p0CETBImc1lyKCDo/QrSe5v1Kwrf15OS6RAxil2WJlEQNTScGTJl3qG3
	 1TI7Aa06fyUCA==
Date: Mon, 24 Mar 2025 08:28:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/3] perf sort: Keep output fields in the same level
Message-ID: <Z-EJnye74la1triY@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9w_aFlzOkoCTSqK@google.com>


* Namhyung Kim <namhyung@kernel.org> wrote:

> > 3)
> > 
> > It would also be nice to be able to Ctrl-C out of a 'perf top' instance 
> > that freezes the output or so. Or prints a snapshot in ASCII. Anything 
> > but what it does currently: it just exits and clears the xterm screen 
> > of all useful information...
> > 
> > I have to use 'f' (how many people know about that feature?) and copy & 
> > paste anything interesting from the screen the hard way.
> 
> Actually I was not aware of 'f' key. :)  I think you can use 'P' to save
> the current screen to a file.

And I was not aware of the 'P' key. :-)

Would be nice if it also printed column and meta information, i.e. if 
it included these lines:

  Samples: 1M of event 'cycles:P', 4000 Hz, Event count (approx.): 758731362801 lost: 0/0 drop: 0/0
  Overhead  Shared Object            Symbol

or so?

BTW., the approximate 'event count' is a pretty uninformative value 
these days, right? Might as well not clutter the screen with it.

Thanks,

	Ingo
