Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAB20C494;
	Tue,  4 Feb 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689130; cv=none; b=YSkHld5BuUOa5SJSSYN3ulJ1XUQEOq1HgzmoFC2sAxxWp7stTZMyi71WdMkrgQxNm1DhLKZgWpG4a9zLfgR9+YsSi+KYR8qUSXFmbvFg9jQ9XjmY64B3QRFC7JZ25MrVEsxcPQjHsPSUvB9tXDrPigU4vhVMNTnYJmXeyXIc/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689130; c=relaxed/simple;
	bh=yNJVGDNkyLK6lOVSRR5EsvFcIsTNRYoR9X3o1HljH2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmOxYBdLUJT9vl5dzMCBoZEZMWbgnULti4PSCBjgfjTCWUAsWpObVkpkjGgxN7DCT9UedbW+6470CShULydsnbzgah4RI0ns0jcYSb8rWG1+GSt43wjMibzc6hWoggGRY9wxHmUw24Kgg2QaNwF2UFTWMnNVtOzOszVW+VM2qJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYPTYucN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYPTYucN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC4AC4CEDF;
	Tue,  4 Feb 2025 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738689130;
	bh=yNJVGDNkyLK6lOVSRR5EsvFcIsTNRYoR9X3o1HljH2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYPTYucNU13/7E1+heWjaa+BF29s/cOh2rZeO/wdC5Ez2TDv4Ww4a537I1kiW0QUQ
	 fn/118Vh8b1DVUBYFju9KnxLxjW7/MyImsAf2ZG6F6AmkRsacNURYly/t2J7g1jY2N
	 F9teiOddJjnVZBsriiPW2SxP1cF0k27zpG4cydyc=
Date: Tue, 4 Feb 2025 18:12:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020447-gyration-wireless-f7da@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh>
 <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>

On Tue, Feb 04, 2025 at 11:41:38AM -0500, Vince Weaver wrote:
> On Tue, 4 Feb 2025, Greg Kroah-Hartman wrote:
> 
> > 
> > It seems that the majority of the perf code IS looking in the correct
> > place, just mem-events.c seemed wrong.
> 
> I hate to tell you, but other places in userspace are depending on the 
> current setup.  libpfm4, used by PAPI, is looking directly in /sys/devices 
> for pmus and will break with the changes you are planning.

Then that too needs to be fixed, sorry.  Again, devices can, and will,
move around in /sys/devices/ you can never hard-code any paths there.
Any userspace code must ALWAYS be able to handle that, that's a sysfs
requirement.

And do you have a link to the source for that code?  Good news is that
if the code is fixed in userspace, it will work for any kernel (old or
new).

thanks,

greg k-h
