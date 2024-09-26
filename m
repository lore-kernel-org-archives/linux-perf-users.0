Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC71171C;
	Thu, 26 Sep 2024 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328947; cv=none; b=h20DiivRXvmUvU7XfTcQwJ6Fi5NLlrvfelfKjs+TwioHF04KRtq1KMLuTkmR3BeLMss67cztruxqSfR4Gv18IrmRM29aOmV45zJRQM7YjeRASLT5GIndDNSU1mODkRg8aCl/XtkL+Q4MAwDyG4OufYffJpJMZ1TCCm6k1Xmcmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328947; c=relaxed/simple;
	bh=TzrPpScamIQIi5oyPDJQMQjV/sG+yfPS0hLCZagtCzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUTpkmezOzt5nYYARWIOUIpdWb9rcV74jKpQ85Fi4IZf6jTsN33DTTxTD4Jqi1ELFaVFFrvRJG8WtRRJop0esQ3VvroJkKp3T66NL+9ob7YpzsWN0eNxLwt4CCLXPTkPYO/p8n2QJH6nFQ/EzO5vBzyudSBFcPcItFrADJOyZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNsO25ec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNsO25ec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D74DC4CEC5;
	Thu, 26 Sep 2024 05:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727328946;
	bh=TzrPpScamIQIi5oyPDJQMQjV/sG+yfPS0hLCZagtCzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNsO25ecqCyPe9twcE/ubl7gBVq69x9ucHDhsRncG67U2M9ZQEPGgDghXJ7xcTlkJ
	 ppXdo3SwA+Trz+9j8mhvqcFTGTS3sqzvNvnahusaL0XqW5+2GLGM9GCErAWgNWgVIr
	 T8thn4jLwQaKpAiXLGZ1OJY6YGhWp5hnk0Xr7W/3H4KrH//LkenWt+3KNPcvtQrUbt
	 zmcRyX9yr09bUfltCziwH2MVLuSor7RRuRXArE/2/AzKYRJeivwIaFNeALCK0M8arm
	 PV/9aeUzjfRMm9OGl14pLK/MTkEQFB37MVJX0bKaJyNsql8DQDQWh9P9Zh1PoGXCDv
	 7UQR3H7qFrA8A==
Date: Wed, 25 Sep 2024 22:35:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Silence perf check subcommand when not
 supported
Message-ID: <ZvTysPPKxYKjUMTA@google.com>
References: <20240911122850.926303-1-tmricht@linux.ibm.com>
 <f74e73b6-fa0a-4533-a9de-3c5dbc4399f3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f74e73b6-fa0a-4533-a9de-3c5dbc4399f3@linaro.org>

On Wed, Sep 11, 2024 at 02:34:27PM +0100, James Clark wrote:
> 
> 
> On 11/09/2024 13:28, Thomas Richter wrote:
> > Perf subcommand check might not be supported and prints an
> > error message when used:
> 
> Only in verbose mode though. Personally I don't like all the piping to
> /dev/null in the tests because I have to go and remove them every time a
> test fails, rather than just doing "-v". But as it's pretty much the pattern
> used I suppose we should continue.
> 
> > 
> >   # perf check feature -q libtraceevent
> >   perf: 'check' is not a perf-command. See 'perf --help'.
> > 
> >   Did you mean one of these?
> >          c2c
> >          sched

I think perf test is supposed to run the latest build so perf check
command should be available.  Do you see this in the test result or just
in the command line?

Thanks,
Namhyung


> >   #
> > 
> > Drop this error message, the return code is sufficient.
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >   tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > index 5c33ec7a5a63..697fbe296a62 100644
> > --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> > @@ -32,7 +32,7 @@ skip_if_no_debuginfo() {
> >   # check if perf is compiled with libtraceevent support
> >   skip_no_probe_record_support() {
> >   	if [ $had_vfs_getname -eq 1 ] ; then
> > -		perf check feature -q libtraceevent && return 1
> > +		perf check feature -q libtraceevent >/dev/null 2>&1 && return 1
> 
> There's another of the same in tools/perf/tests/shell/test_task_analyzer.sh
> 
> With that:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
