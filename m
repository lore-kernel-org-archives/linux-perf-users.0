Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF1489880;
	Fri, 31 Jul 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533829; cv=none; b=lWeFe64WUWhqqXvcaY4pDtCFxl59znnNfSRoWlAOTevMsAyzyr4gs/fi8N/6kC5y8Z+ns6qhLM/A/mD+Ftba7zC7pA9ZhBLSWOzN7+GqQnVbpOppEEbTjpBM96NQ8C9CfUl8OUw6WjTOglNVvyz3kdwEv6Wsl8yNAVu6Jdaq/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533829; c=relaxed/simple;
	bh=2D3WGVaatyIhqQJGUgKu+IuSgLqmh2EieCTUSrkb2iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAOy7ATnolWdcDM+67bJjvrwOmWTULiv6t21Q4y2iZfVZFo2x3l50mb1mPOZAh2zPwXS2rPTa2GdyqI7rI6HNj0/YKegtyfifF8iwi3Bf2UM+hbHC72KpgxcNh0w59aJ8l3BiOvf/5Fo+EDiodlgCUft3Ppk6Yncsw3XkNTZppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah02780e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah02780e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53A91F00AC4;
	Fri, 31 Jul 2026 21:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533828;
	bh=Ek8XHZE4EmB/vc6T4UyCyoBNL7M6eI/UpaQAOvfeZuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ah02780emoIOp3lfE1qerXj5RuTtVWLkA64/+qM6OZZ4fBAuTyjxMHGb+rXhwv/M5
	 sCT3eqYYFBR0rbnlMhBEKdt0i3JrRvN1kD/Xa0XXG4sfzSbd2H381Cu0oj+qAnDX2T
	 wxJoSGkg3lVBaQi8HUCnyfezg9r/8gt9th7AoZNrm3jCvZli2N7nXtPlDBSbvnRHZi
	 gtyXZnFUnUdpTCkPt3xCTIAiLTFYFBWaLClQUivq8eS3auyA6GjxCZtDgpoc/YitWR
	 FjCsIgxAsq7qqSgjrG/Eo8blhghLP4lJ+OVwmEUKbCby1YlkWNc+/iufF69oUgSDK/
	 +3JK3uW9a3Dgw==
Date: Fri, 31 Jul 2026 14:37:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2 2/6] perf mem: Add support for printing
 PERF_MEM_LVLNUM_L0
Message-ID: <am0Vgnayr0WVdeOH@google.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-3-thomas.falcon@intel.com>
 <amjjSlWIQRA64qSy@google.com>
 <8829286c-c05c-456d-82ad-6e75ab864f1d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8829286c-c05c-456d-82ad-6e75ab864f1d@linux.intel.com>

On Thu, Jul 30, 2026 at 01:46:27PM +0800, Mi, Dapeng wrote:
> 
> On 7/29/2026 1:13 AM, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Jul 13, 2026 at 07:43:55PM -0500, Thomas Falcon wrote:
> >> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>
> >> Add support for printing PERF_MEM_LVLNUM_L0 in perf mem report.
> > What's the L0, by the way?
> 
> Per my understanding, the L0 cache is newly added a small piece of cache
> which is the closest, lowest-latency memory cache tied directly to the
> execution pipeline. 
> 
> The table "Table 9-4. Data Source Field Encodings for Panther Cove and
> Coyote Cove Microarchitectures" in the ISE doc chapter "9.2.1 Panther Cove
> and Coyote Cove Microarchitectures Memory Auxiliary Field Layout" indicates
> the code "01H" means the "L0 Hit - Minimal latency core cache hit. This
> request was satisfied by the L0 data cache."
> 
> https://www.intel.com/content/www/us/en/content-details/922690/intel-architecture-instruction-set-extensions-programming-reference.html 

Interesting, thanks for the explanation!

Thanks,
Namhyung

