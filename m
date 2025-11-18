Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162952D5436;
	Tue, 18 Nov 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488849; cv=none; b=q9ZPIb6540llJAYb3rXysJUZDRxFYFqj+kzf2gEFRYG5aHd5zcWKbnbM3f5I40hpHJweyIFZs+G/2NLvsW6EKoiERdcx+FBL3vyRflnQHpSAPb1pGWmxN2DFlBzNH1g6A/Nsq6WTEfV787oDXLLwAEBR8tjQTz3h7Li8VuDWCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488849; c=relaxed/simple;
	bh=AxMhfxquKo0s9tMPXG++Jk0NzsllscdC1w2VRDYFCOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JreJcDwmUBh1GsJRihoVRGVzDBlvrsFcPXv46p2TTPcT0700jqvtfpypKGFIwTxigderzAqJy/mV3iqwzYjE0IYXzE4u3rsg79rB8w5mxorNc5bkOYBM4wcrp0N3Kl3USooUoHmg0sbycS2rYmxl/a2o/DvpbitCaI8QFOKVGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOqMUkh2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOqMUkh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C34C4CEF5;
	Tue, 18 Nov 2025 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763488847;
	bh=AxMhfxquKo0s9tMPXG++Jk0NzsllscdC1w2VRDYFCOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOqMUkh2rY97DiM8Mon6CAYuomlriAvxjEFUWD9adrUuu+1oc1E/9VHOXZYqZIERg
	 eP0R0Svu8fvtn8FQGpdQhBz4H8P4HYJ/nhXHZ9pZzGq5y7cfkmAGVSSUANzgw/4EUj
	 SGAgxO/XRUFMzHrdoBArs7EFZ/uP6uXoC1NuQyYLSSuvnF1SEvcU1GKeDa3/J9V8XB
	 NDKaM2K/+PHnoVPAh/FT2t0Y3F6KKP5mXayOSSqtwlPHj54bvq1WvQaF9y1/sc8msU
	 /BFKgfFhjkMi8AMmUPPv2rxVDUT1iqHZ1dd0G4q8QMbiV1uqnm+vvsEhLF3cyRrEa1
	 Yo6hH2mGUBsPA==
Date: Tue, 18 Nov 2025 10:00:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 00/10] perf stat fixes and improvements
Message-ID: <aRy0SVVuZaTfY3xU@google.com>
References: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113180517.44096-1-irogers@google.com>

On Thu, Nov 13, 2025 at 10:05:06AM -0800, Ian Rogers wrote:
> A collection of fixes aiming to stabilize and make more reasonable
> measurements/metrics such as memory bandwidth.
> 
> Tool events are changed from getting a PMU cpu map of all online CPUs
> to either CPU 0 or all online CPUs. This avoids iterating over useless
> CPUs for events in particular `duration_time`. Fix a bug where
> duration_time didn't correctly use the previous raw counts and would
> skip values in interval mode.
> 
> Change how json metrics handle tool events. Use the counter value
> rather than using shared state with perf stat. A later patch changes
> it so that tool events are read last, so that if reading say memory
> bandwidth counters you don't divide by an earlier read time and exceed
> the theoretical maximum memory bandwidth.

[...]

Applied the first 7 patches to perf-tools-next, thanks!

Best regards,
Namhyung

