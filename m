Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F351C32ED2A;
	Tue, 10 Feb 2026 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756869; cv=none; b=J6lj9XfPT1rNYMfxRM7XK8HFxgXM/93g5jxnaKFhVtiOKHEzfakRxX6MOuYmXrsScEOMCaOMu98MNRa740iJaRJVx/FttiSS8K9nOICsWjonZegMrLczvDVk2MOeDL9813VLSPdCAfLcvRh5LwJE1fadRSuT3HTjgvc7Y/wpBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756869; c=relaxed/simple;
	bh=cZGYzYiX5yAx8IYvzjug2a4f+UhquAJMTud2WCa/g/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLKAu5yiJFotC/qyrANXylhA1p8JJcWdmXWPcIEYbLRpi7aMaTBIngwLG3YrqbMpYgwAoL/KSMoDpcD1ls9OJelO/igCZ3TCPbyipSX4+Ny54mzVuOfTpvQsv/deae2LQgqFLmWAPxVRWqtkACFPy4CFWlgs7EtznSCVhJer1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3xIF5v8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3xIF5v8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A1CC116C6;
	Tue, 10 Feb 2026 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770756868;
	bh=cZGYzYiX5yAx8IYvzjug2a4f+UhquAJMTud2WCa/g/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3xIF5v8bFFHhlBFb2UP4QRAHUK/T66XQ2hyRhO/OMkD9r+5/8PLJhFiv/ZA4GFR5
	 QZGQN1UAgkblB5xvTk5GDNPZPzYO/o3fHATir3eMdRmtvoZ5bhaD2nkYxdVt3e/+3+
	 zmCW3OeqIdRDM/oMDaV4jqbwIZrQWAowNHR7KWOvWYpQyN2MKURsHtmMPkMos3qbBS
	 4r0SN51ylUjLU9qX5teDpHD7B7XZNNFmbJ7NP42f09+vkGxxKWzR8kznwhRQwmfqJr
	 05lgKL9S0lPCofKCIEu8XQ1BR+dxh6Eyv/tHT0wyK31AjUNy78oKJrznsm2ibNrHS5
	 M2/bpya11GRWg==
Date: Tue, 10 Feb 2026 17:54:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <aYubAAZ10CfYsmZx@x1>
References: <aYoZD1onJLsnlrV3@x1>
 <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>
 <aYsj7vV2Lh8wV-ZR@x1>
 <hox364wgs57bv7hvscvvtbkl5yerur55iz7un3gsu3ozpbnba5@haqvngx6jy4n>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hox364wgs57bv7hvscvvtbkl5yerur55iz7un3gsu3ozpbnba5@haqvngx6jy4n>

On Tue, Feb 10, 2026 at 09:16:18PM +0100, Dmitry Dolgov wrote:
> > On Tue, Feb 10, 2026 at 09:26:22AM -0300, Arnaldo Carvalho de Melo wrote:
> > I tried here building it with rust installed, it detected, ok, then I
> > removed and tried to rebuild, it still thinks rust is there:

> > [...]

> > I.e. it doesn't rebuild perf and thus doesn't notice that it doesn't
> > have what is needed, if I touch some other file and thus it triggers a
> > rebuild, it still manages to build it...

> Yeah, looks like the problem is due to rust not adding any actual depedencies
> into the dep-info file, when compiling the feature test file:

> 	/perf/feature/test-rust.d: test-rust.rs

> 	/perf/feature/test-rust.bin: test-rust.rs

> 	test-rust.rs:

> To fix that I've tried to add an extra dependency on the rust binary on top of
> that after the compilation is finished. While hacky, it worked just fine, and
> perf catched it when rust was removed. Haven't faced any issues after few
> rounds of installing/removing rust either. If this approach sound fine, I can
> post the patch tomorrow.

Looks hacky, can't we just try to run:

⬢ [acme@toolbx linux]$ HAVE_RUST=$(rustc --version > /dev/null ; echo $?)
⬢ [acme@toolbx linux]$ echo $HAVE_RUST
0
⬢ [acme@toolbx linux]$ HAVE_RUST=$(arustc --version > /dev/null ; echo $?)
bash: arustc: command not found
⬢ [acme@toolbx linux]$ echo $HAVE_RUST
127
⬢ [acme@toolbx linux]$

How would your dep on the rust binary work? where would you expect it to
be? It may be installed on some different path, etc.

Perhaps there is precedent with some other component...

- Arnaldo
