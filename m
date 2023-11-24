Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504828E17
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Nov 2023 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz4lq766"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AECC433C7;
	Fri, 24 Nov 2023 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700833878;
	bh=zL6LSOUpyol3f/TTZLpJE1N///sAY2bgqyQEwH2vTkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dz4lq766LPUPsGNg13Wj3cUhzgX7roA48usWCBEOUNwh2o5eEZS9ZMdO8vg2yUmE2
	 JR9gEIts5UayGvhIHpm2f+lE9m2v/Ab3dt0dvePqK1ng7yQQRky5nkfYBAK1Szb1ab
	 6et34VwqAaO3gt0YqEqF0TnRL4oZf2PKvmudFR4pbiHmKR7JKzdz/edbjvX4Q8Ufh5
	 jTdjfAz1x6jpD/537bcMyUHGT7caB7uzh2agTQkLVYoveMobi/i2sok+78lOhRPgDy
	 aVP/beH/uYvILfCOyTRA4+ogGJeb1TQKfR4KQEKUK8/zNooxIQTYGgZlREISYAN0Zd
	 Ezlg2D3cRMmww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0245440094; Fri, 24 Nov 2023 10:51:15 -0300 (-03)
Date: Fri, 24 Nov 2023 10:51:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Hector Martin <marcan@marcan.st>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf parse-events: Make legacy events lower
 priority than sysfs/json
Message-ID: <ZWCqUwZHUAWarXZY@kernel.org>
References: <20231123042922.834425-1-irogers@google.com>
 <86cyw0zeiu.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cyw0zeiu.wl-maz@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 23, 2023 at 03:16:09PM +0000, Marc Zyngier escreveu:
> Now, in the interest of moving forward: this patch seems to address
> the basic problems I was seeing on both M1/M2 (running any kernel
> version) and Juno (running an older kernel), so:
 
> Tested-by: Marc Zyngier <maz@kernel.org>

Thanks, added to the cset.

- Arnaldo
