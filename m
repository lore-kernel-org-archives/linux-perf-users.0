Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF64E01FF;
	Thu,  1 Oct 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846400; cv=none; b=jM8WRk927gwc/8cG6XlJr3T09zMpkg9F5/8MUPUPUIqSMK6ZvgOUWBsvEL5/w4ZEnvaCPHvnN/b7ri4jtXMuYXA0U7l8JcX1CBkDZbUCZDLH1HumBuXjwAn9JVf4FaZOSEMjl993GiG1j6zDWXB9wZGe3GDp5k32WYMrypJkwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846400; c=relaxed/simple;
	bh=MO0KjfqcjKPbUIWDQ+E2zMkQFC0kIlqwf2vXSjWrlaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENmPcU+lnYk4UvDZO0waCZd61Oak13vMwg7SCKOX4yIJVhK4N3l9B9V4uM347PKxwUx+JXWpyGraiqw17w0ezch+bAvv87ZB6mhqAfh1gp5n4VlSniO4TJOxY6XfGLc7PFINSutKkjMDLVdC+Nc6mlOpHFY5cr3HYp6G4sUxLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edOUlZwB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edOUlZwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0727A1F000FF;
	Thu,  1 Oct 2026 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846398;
	bh=QAxbLNT2m/6vIBJzR9bz5RmvNEM+lKzY8iFrNJs4/fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=edOUlZwBRPtFj49mTD9UppDhVFcd/bQQYBA+4+jFPmoqKN4g8s7IJoyECpl3+R3MM
	 ThZ7j8ThsTY+JboGGeswHqiPKaomAGAfs95me1IEmEoKoJVmv4PzAte5DijUlV8mWq
	 F9KFBv/AacGC9m+jEHOEDuVLbeAxmRPivzaeRN28vYTkbf2gm7m4GKoQRm40/IBKjQ
	 Z51dsHEpLOAr7MJdBfCsxDW/cemL0ApKt8e9dWjwgl3WZO87vvAv5jJKgtEi7uh69Q
	 rQUgnNKS4dWKmlI3UNC4JfI50d1lmkYjzN3xHyZ3O3ZYNnahsvCqP3AtlLKqAXNSCr
	 ikTbuMfQk5l4w==
Date: Thu, 1 Oct 2026 11:19:55 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 1/5] perf config: Move perf_config__set_variable() to
 util/config.c
Message-ID: <ar4luypLigWoOOQT@x2>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-2-acme@kernel.org>
 <ar4JX79-r_4gCNfG@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4JX79-r_4gCNfG@z2>

On Thu, Oct 01, 2026 at 12:18:55AM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 11:37:12PM +0200, Arnaldo Carvalho de Melo wrote:
> > perf_etc_perfconfig() caches what system_path() returns, and that
> > allocates, so on failure every caller dereferenced NULL, the
> > pre-existing ones in perf_config_from_file() and in the daemon
> > included.  Pre-existing, not introduced here, but this rewrites the
> > accessor anyway, so make it total: the unresolved path is the same
> > string for the usual absolute ETC_PERFCONFIG.
> 
> I think this patch does many things.  Can we split them? 

Sure, will split it into three patches.

- Arnaldo
