Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D2436BF7;
	Mon,  6 Jul 2026 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362187; cv=none; b=YMudaztaJqT8yxQk9RIcnFV8AWTt8lzo8eRA8rvajqL/Db+4Nb4XTlDQ7OaHCJTOFkN0YZtyT+wnnV4MJzu5enBSGYMVTY3+jUheZ2aykspgNSL7hdBD/6Hhoh66J7LnZtSmFeuIc5ecF8x4renT9eydB626CwqtwBFltBaIA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362187; c=relaxed/simple;
	bh=XIue6jTnF6HZduuzVpk88hDC0COqyR3aOscyTo4bBKc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qp7q9UKyVix2/+7WDCPuiIblTlnp0i4W+QcUb1SlMHLs9PprZs5+ouiw2rUyswrZ8lrfWTGEki4K2VQlTitl54U5j7KoX4nu2vPPVNBVpuKV2xZs8oP2svMr1lXpQdh76RZdyfACgSh374gAzdlThG8sk5N4CxWR3IWzAiWKmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=IIs2wqjQ; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="IIs2wqjQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To; bh=N60wPqK7OnmT4DTDxaO8QtCsu8PYodkEax0nw10BA5Q=; b=IIs2wqjQk4iAEvRo
	EhRnjsOJd9robykPRRw794CMshcYta0ef6eDDgBap4nW/mYzRxvD/o2/FHOJa9B0wSwajzzUGU3Fj
	U4fp+pHDRhVVyc8qf1oA7Y3eoPMFKdnR/Wdy6yBc8o6IZ4vsx8PsgS1y8HLQxcVG2hLgMOmgblc5+
	vuNU9z2Kplbcl7OiWKLst3Z4qMuMmi/q/vWUh7L/Bd6Upwe7BtOnC22CyZCSpW0OF2hyNA72G0hYm
	QvWEyTfwkRYwIxlEsxCWthPdW9ac8JFfFAzeB4Ck+9TCerGI5S7hyIKC9ZHVtXhKX4MAw9DLJvaLk
	52G2Qw2G+2ToZAxnHQ==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178] helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wgnxx-00GoWB-9V; Mon, 06 Jul 2026 19:22:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Jul 2026 19:22:49 +0100
From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] perf jevents: make events order more deterministic
In-Reply-To: <CAP-5=fWXhESb=4TMyt2X9oM64h5xwpNf7VGqXCs+NbPr8zeuGA@mail.gmail.com>
References: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
 <CAP-5=fWXhESb=4TMyt2X9oM64h5xwpNf7VGqXCs+NbPr8zeuGA@mail.gmail.com>
Message-ID: <9871da36895a05e0ca5646ba6edf4a52@codethink.co.uk>
X-Sender: nazar.kazakov@codethink.co.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: nazar.kazakov@codethink.co.uk

On 2026-07-06 19:04, Ian Rogers wrote:
> On Mon, Jul 6, 2026 at 10:57 AM Nazar Kazakov
> <nazar.kazakov@codethink.co.uk> wrote:
>> 
>> Some of the events have the same name, but differing descriptions. 
>> This
>> leads to a non-deterministic sorting order, so fix by adding the
>> description field to the order.
>> 
>> Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> 
> This shouldn't be an issue; can you give an example? I mean, with:
> $ perf stat -e event1,event1 true
> There's only one meaning for what event1 is. There is wildcard
> support, but that's not the same as having the same event more than
> once, differing only by description. Note, I deliberately use events
> with perf stat in the example because the metrics build on the regular
> event parsing code.

I meant sorting order during build time: 
tools/perf/pmu-events/pmu-events.c
changes between different builds, you can see an example of diffoscope
output here 
https://freedesktop-sdk.gitlab.io/-/freedesktop-sdk/-/jobs/15174060131/artifacts/result_folder/components/perf.bst/index.html

/* offset=5995059 */ 
"lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS, 
duration_time)\000\000L2 cache request for ownership (RFO) misses per 
second\000\0001misses/s\000\000\000\000000"
/* offset=5995210 */ 
"lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS, 
L2_RQSTS.RFO_HIT + L2_RQSTS.RFO_MISS)\000\000L2 cache request for 
ownership (RFO) misses\000\000100%\000\000\000\000000"

vs

/* offset=5995059 */ 
"lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS, 
L2_RQSTS.RFO_HIT + L2_RQSTS.RFO_MISS)\000\000L2 cache request for 
ownership (RFO) misses\000\000100%\000\000\000\000000"
/* offset=5995217 */ 
"lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS, 
duration_time)\000\000L2 cache request for ownership (RFO) misses per 
second\000\0001misses/s\000\000\000\000000"

That leads to non-reproducible binaries, even though the functionality
is probably the same.

Thanks,
Nazar Kazakov
