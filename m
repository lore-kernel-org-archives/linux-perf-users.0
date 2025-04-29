Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706A21C19F;
	Tue, 29 Apr 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938945; cv=none; b=lTGUoGXyf39zIdL5WoOhQThCczgpptOeX5XFu9YFTMOwft08Xqw1Yw7UpJk0PwCCCmzqGE77SbnvlrBeUh7ktFJnnYzts8og9MhIJYH1MIUhHcZFWu1jYugYSJy3itxQIOuT70Fc3lbpaNGn1qQyamyv79rTkQkMf1EjqyhYPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938945; c=relaxed/simple;
	bh=aUl3rcsG/8z0/NS/eNGxVItw66jXfL3nPszPiTNdHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+zbrrKSPK1rSxuV5ZueA3kusyIGx4HFtvzDrt2aXoi8y01YIHzooows+5qOwmRRlfQ1Wa4Lwz7YynGmyF1X2Lz1RPP+bh8NT1SSupxZN/MgfJe1xla9EuLJsbgUjxIZdWUziTwE/JEKcY0Dzo96FCeFyvmHWdI5eSLp/T8pqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4rRxEN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4rRxEN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83039C4CEE9;
	Tue, 29 Apr 2025 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938945;
	bh=aUl3rcsG/8z0/NS/eNGxVItw66jXfL3nPszPiTNdHeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4rRxEN7TRovLBU5VyEyt6ayZgpAnH0OlZRpx/1mTnItGK/A7um+DboOmu9SETnSF
	 mIhjyt4ertWEkeMqQ1w/Dcez6ZlZnbiRHoeKet8jNnDMUoRnmAPOVPFq4n2ojCoPi2
	 zSy8jTIlc4dGLDQepxNvCTpapE2ftyycrXO2N+u34m+NLXo2Lrw1Iw9xpolXaDYYi3
	 +mcc/KaGoqE3w75S5qKBG9IhVRn9lHseGxJCshUhLKwKuVjIK7y9aPdDHAxBcltmI2
	 aAXLvd0StaQdPYZVF+hbB3l2rmVrWD+iO3/Qq+iNj9alS7TeYtNd6lbwnzdNM5dacm
	 S/WU/iWAwIUEw==
Date: Tue, 29 Apr 2025 12:02:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jakub Brnak <jbrnak@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	mpetlan@redhat.com, tglozar@redhat.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] perf test probe_vfs_getname: Skip if no suitable line
 detected
Message-ID: <aBDp9fU5qJJeP9z3@x1>
References: <20250324144523.597557-1-jbrnak@redhat.com>
 <Z_fWa093x33Wcwrw@jbrnak-thinkpadx1carbongen9.tpbc.csb>
 <Z_gw-xw97c_IWdXw@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_gw-xw97c_IWdXw@google.com>

On Thu, Apr 10, 2025 at 01:58:35PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Apr 10, 2025 at 04:32:11PM +0200, Jakub Brnak wrote:
> > On Mon, Mar 24, 2025 at 03:45:23PM +0100, Jakub Brnak wrote:
> > > In some cases when calling function add_probe_vfs_getname, line number
> > > can't be detected by perf probe -L getname_flags:
> > > 
> > >   78         atomic_set(&result->refcnt, 1);
> > > 
> > > 	     // one of the following lines should have line number
> > > 	     // but sometimes it does not because of optimization
> > > 	     result->uptr = filename;
> > >              result->aname = NULL;
> > > 
> > >   81         audit_getname(result);
> > > 
> > > To prevent false failures, skip the affected tests
> > > if no suitable line numbers can be detected.
> > > 
> > > Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> 
> Sorry for the long delay.  It looks ok to me.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
