Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4047A76
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8c2nWFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD9C433CB;
	Thu, 30 Nov 2023 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701351525;
	bh=X4W1JMvTu97EnahxXjQRJ3hmHYLmI6U10XmxNRUbL34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8c2nWFBLxRIr+g7iek0n5/Q7jwvyCLLXdZbyS2Gq5XAx0i788SuAdbpyMAAGwBQF
	 cx+VKdidV+9o3Qb+z76eUC6SdJOaXJFQsoMnaWMer8pl1M3GU12xn8i3kwJqOPO2Jk
	 HotoTagX6NhsXugAKXNl66GgFPfNvwVZiINfpcCjTD2yS92ptudh/8Sh+oMCFli9hj
	 ta031Lnsk6oiZ2IDFy/+7gd498174o2N4lGShDfNT62h9kIA1d8wFbhqmdzqzJ2JE6
	 W6indg9NjPzxj9/WV67SMQl10EUZs6CCjvFp5dksg/dq+Djileq7iXifOvS5I+xcBM
	 AStAy48UnyzAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8781A40094; Thu, 30 Nov 2023 10:38:42 -0300 (-03)
Date: Thu, 30 Nov 2023 10:38:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Nick Forrington <nick.forrington@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] tools/perf: Fix man page formatting for perf lock
Message-ID: <ZWiQYvoxkOHy5mT8@kernel.org>
References: <20231102161117.49533-1-nick.forrington@arm.com>
 <e1e6641a-fec1-0b94-f57f-10ddec5b079c@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e6641a-fec1-0b94-f57f-10ddec5b079c@arm.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 28, 2023 at 11:08:54AM +0000, James Clark escreveu:
> 
> 
> On 02/11/2023 16:11, Nick Forrington wrote:
> > This makes "CONTENTION" a top level section (rather than a subsection of
> > "INFO").
> > 
> > Fixes: 79079f21f50a ("perf lock: Add -k and -F options to 'contention' subcommand")
> > Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> > ---
> >  tools/perf/Documentation/perf-lock.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> > index 503abcba1438..f5938d616d75 100644
> > --- a/tools/perf/Documentation/perf-lock.txt
> > +++ b/tools/perf/Documentation/perf-lock.txt
> > @@ -119,7 +119,7 @@ INFO OPTIONS
> >  
> >  
> >  CONTENTION OPTIONS
> > ---------------
> > +------------------
> >  
> >  -k::
> >  --key=<value>::
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools-next.

- Arnaldo

