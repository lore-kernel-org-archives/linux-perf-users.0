Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450637166
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F58oEApu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCCDC433C8;
	Wed,  8 Nov 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699474222;
	bh=J25KUy86NfApZ0qWpYlZcp82HfO5i4wtIPpaV2apC5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F58oEApuCiR9Ul+qxxkzzzJLijYO6ROIj5DIlTxjrW8VkenFlFJItHBB6X5KvtNr5
	 Aozn8mM8MTBp0fOn4WkgO2b0WUea/dP7sLK1IAl+ZH2J2vc7/IIOOuh2kXng3UaZF/
	 +EH3+aRjz+IuPSgEmEi3ujOFjWArpRX5pTtIwn1PJtNZzQwnO5mW1yOapZ7Upw2KAR
	 /nDvpEk1OMayjfw+90UWMr5iRZMSlL6VoExiDR6tLISBssJyivC26SjtilJl0BELOK
	 057c405lKiBPXglVrsL0KhoY5XPsibymUMp1TeB/sZ+hl86FJp1SpExosY1uNqDZXr
	 /Tw+KkejaLDkw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1298C4035D; Wed,  8 Nov 2023 17:10:18 -0300 (-03)
Date: Wed, 8 Nov 2023 17:10:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2] perf test: Simplify object code reading test
Message-ID: <ZUvrKT0TjGeSi98K@kernel.org>
References: <20231103195541.67788-1-namhyung@kernel.org>
 <c1aedc2e-e51b-4b17-a05e-cd347f56d83b@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1aedc2e-e51b-4b17-a05e-cd347f56d83b@intel.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 06, 2023 at 10:15:07AM +0200, Adrian Hunter escreveu:
> On 3/11/23 21:55, Namhyung Kim wrote:
> > It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
> > open.  But other arch on a VM can fail with the hardware event and need
> > to fallback to the software event in the same way.
> > 
> > So let's get rid of the cpuid check and use generic fallback mechanism
> > using an array of event candidates.  Now event in the odd index excludes
> > the kernel so use that for the return value.
> > 
> > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > Tested-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next.

- Arnaldo

