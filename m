Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281482DCBF7;
	Fri, 23 May 2025 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747966667; cv=none; b=dm6yy2fxzU5W8D5xKYpdT9XMQxmbSDvaTFvE1Olvj87O3ft7OCjkZPEk3R0T5zWSZAbA+49M+WWIwWMBOW79fovXMh8gzAeAFpGpQ/uFyMFaqKSkZLNT9FbUs2ZKH0kfCE15GSkuJzWpQBlOqCh3Xiz6TRjcKvbey/4i9C8PtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747966667; c=relaxed/simple;
	bh=E5xK1wgNw3hRwupucK5i8lrn4o/OaAyHp44mQtDWSCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0OcSPss2G175/qIn/nl7aBx7dFAOVeNqwhgEWnwKa34MUIThpT2LjFBacV+hv0rYLna9wieqfgOxhC3VROD9I8540Hc7QYhYrFeAXFftSvIm/cOvVqDq4Lt2q/swZ7TLI7n8kW/o/3/aPuubv1NT2+y/bAbd+KvVhYgjg8rBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F77sQt+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F77sQt+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E44DC4CEE4;
	Fri, 23 May 2025 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747966666;
	bh=E5xK1wgNw3hRwupucK5i8lrn4o/OaAyHp44mQtDWSCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F77sQt+srF5UdZrFzjzIKG/sFultf/WwZi61MSDE6X3KCGAXRC9cU4G25pE0F9i2C
	 KSaxrUJ4TL/03yRAEOwAuk5kDPaFua4jZEHjlb9aMOSD9grDH8yPPAzrXzJpY0qFdD
	 xtzgW0kcSD7I7JgQqTOT/3shtGvJUZAWSq8/Uz44OH5+XscriTiv9CP/xhzs25ZBMS
	 ST9Js8bc5W1irEzXZXt7KQcHgNWHGufhlKnFaB8wdA8Li50IU3gDvSbJsrEy80VtXE
	 //KrzKHD5w7Ymr4Yx69240sQotYluQNaq/KrDL5J4/MdhMoo3pWdqJw8lakon3K4t6
	 7CkH/Itdxqpeg==
Date: Thu, 22 May 2025 23:17:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
Message-ID: <aC_axwJjoYIsRjer@x1>
References: <20250515181417.491401-1-irogers@google.com>
 <96c8fae8-b8f9-4094-b03a-9dba3ca234c2@linux.intel.com>
 <CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com>
 <aCoUMOVRjCr_t0ae@google.com>
 <CAP-5=fXnvRLiGmV7rr2H8A2Hj7HDE9m+B6Qn0areRXBhz-tK+Q@mail.gmail.com>
 <aCviJJpEYKt8wYEk@google.com>
 <1fcdbfa7-5d99-4337-a473-eb711f27b8a3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fcdbfa7-5d99-4337-a473-eb711f27b8a3@linux.intel.com>

On Tue, May 20, 2025 at 12:45:24PM -0400, Liang, Kan wrote:
> On 2025-05-19 10:00 p.m., Namhyung Kim wrote:
> > On Sun, May 18, 2025 at 10:45:52AM -0700, Ian Rogers wrote:
> >> On Sun, May 18, 2025 at 10:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >> I think we're agreeing. I wonder that the intent of the aggregation
> >> number is to make it so that you can work out an average from the
> >> aggregated count. So for core PMUs you divide the count by the
> >> aggregation number and get the average count per core (CPU?). If we're
> >> getting an aggregated count of say uncore memory controller events
> >> then it would make sense to me that we show the aggregated total and
> >> the aggregation count is the number of memory controller PMUs, so we
> >> can have an average per memory controller. This should line up with
> >> using the number of file descriptors.

> > Sounds right.

> >> I think this isn't the current behavior, on perf v6.12:
> >> ```
> >> $ sudo perf stat --per-socket -e data_read -a sleep 1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >> S0        1           2,484.96 MiB  data_read
> >>
> >>        1.001365319 seconds time elapsed
> >>
> >> $ sudo perf stat -A -e data_read -a sleep 1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >> CPU0             1,336.48 MiB  data_read [uncore_imc_free_running_0]
> >> CPU0             1,337.06 MiB  data_read [uncore_imc_free_running_1]
> >>
> >>        1.001049096 seconds time elapsed
> >> ```
> >> so the aggregation number shows 1 but 2 events were aggregated together.
> > 
> > Ugh.. right.  Merging uncore PMU instances can add more confusion. :(
> > 
> >>
> >> I think computing the aggregation number in the stat code is probably
> >> wrong. The value should be constant for an evsel and aggr_cpu_id, it's
> >> just computing it for an aggr_cpu_id is a pain due to needing topology
> >> and/or PMU information. The code is ripe for refactoring. I'd prefer
> >> not to do it as part of this change though which is altering a
> >> particular Intel Granite Rapids issue.
> > 
> > That's ok.  Just one more TODO items..
 
> Sounds good to me as well.
 
> For this patch, I've verified it with SNC-2. The rest looks good to me.
 
Thanks, applied to perf-tools-next, will go public tomorrow, after I
redo tests, off to bed now...

- Arnaldo
