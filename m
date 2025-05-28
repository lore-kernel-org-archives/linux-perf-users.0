Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7828E57E;
	Wed, 28 May 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452282; cv=none; b=ZiGEgxvHpCjKG9whf/02iOOs3BQucBkhrroziQrJF/Rb2wHgI/rKpbO8gP8etLNnQv2d1CGMW0zr2v/hg/IJTWlJkNKSYwBtQBD4UuQtA2vsLDh0d8Q7WKR78CPdxNGYIIULOIRegqgOfDbxqPRmQ8C1cZ5pmJtYfit/96DBMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452282; c=relaxed/simple;
	bh=68VnENCT5sJ2AEdFh4eOwOKX9EsCLWBTdHaZUNKLp/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsB0kaL/EJ1Ik8akbdML824CGGz1MVCPmTyl7ZhvRq03/X9zCjBgscSe0AeLa3HUFA78gk9d+sygAEyG1krKTKp7ct9CPnu4/qzQYqjwSmSER+0OI9RdG4v+YKBF9b4Wge7uKPS0VXuu42qZwf9ElLBg/zV4zAE+WxKaSgjhAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtwtvaCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtwtvaCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4416C4CEE3;
	Wed, 28 May 2025 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748452282;
	bh=68VnENCT5sJ2AEdFh4eOwOKX9EsCLWBTdHaZUNKLp/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtwtvaCFNrBnLSYT0HTL9oBd6k0psK3Lc+RyQIVJsBBZ8dXuFvPsSntbMmBTR710y
	 VhkR385AUwqHC5KlF4VlSkZ8AzqYo1Jg5OYTnX9xmH6qYyxTI3zSlMZx12h8Qys/ee
	 zmSUrMj1p26cOM3koYd+ePLbqDQb8tHO9GKuXbh6ydY37XN1oxzwuRo5X64fHhpsbv
	 xEGJqX9fK4ANUIEFK+iNDXA3Gka68u6O3LTsei0vgAsU/XqUkqAbVQuWjvbxt9SpmG
	 nVSY/q5HAM80Oxhur2gYc/upf0JW3Y0OGjNs8ZXiXvEjuKsQwKzp1Ri9vEJh/Wus/Q
	 N5IAn8dmxUz9w==
Date: Wed, 28 May 2025 14:11:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2] perf tools: Fix incorrect --user-regs comments
Message-ID: <aDdDt9O1O4gky_st@x1>
References: <20250403060810.196028-1-dapeng1.mi@linux.intel.com>
 <35efdc62-fc2b-40c7-9fbd-25fc6028fa6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35efdc62-fc2b-40c7-9fbd-25fc6028fa6b@linux.intel.com>

On Wed, May 28, 2025 at 03:03:13PM +0800, Mi, Dapeng wrote:
> Kindly ping... Thanks.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> On 4/3/2025 2:08 PM, Dapeng Mi wrote:
> > The comment of "--user-regs" option is not correct, fix it.
> >
> > "on interrupt," -> "in user space,"
> >
> > Fixes: 84c417422798 ("perf record: Support direct --user-regs arguments")
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ba20bf7c011d..d56273a0e241 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3480,7 +3480,7 @@ static struct option __record_options[] = {
> >  		    "sample selected machine registers on interrupt,"
> >  		    " use '-I?' to list register names", parse_intr_regs),
> >  	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
> > -		    "sample selected machine registers on interrupt,"
> > +		    "sample selected machine registers in user space,"
> >  		    " use '--user-regs=?' to list register names", parse_user_regs),
> >  	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
> >  		    "Record running/enabled time of read (:S) events"),
> >
> > base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
