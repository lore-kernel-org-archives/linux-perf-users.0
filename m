Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737EE245021;
	Fri, 14 Feb 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532773; cv=none; b=oce6z/rVsRdEgavcSa9FchwabMh8fRtSBrBb3k2adjYk7VArxwn3MvY+8nBIJi1m8QIgopJ05RS7+5qSg7ClY40HK7l6jt4MAqabdvJxYa1hUzQ85FpYI9+WVzCzAIuVw1tC6M2B79YH+KhOC9h5vdseYPLXKhWJYGt01qPqWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532773; c=relaxed/simple;
	bh=ZxRqtA2Pr+vwIr05ZbDmWmG2gKvCO/nFce1NT3ml670=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCzoXRFgzxvNUGM7PKclJ1P6A3B9pyjXJQdyZS/HcsRw1tb9go+9EbMUYNsfpx7xu4y/H+0VERkTtvauNrs3EqbeLMauV0uYST1gHxsTIsPvkIO4OF6AmWTr60KvHZtbniYfx2oab+ZQ5Sa9HsFQz8xWAIaSc2ju+Xu1eW0NF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C77C113E;
	Fri, 14 Feb 2025 03:33:12 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1363F6A8;
	Fri, 14 Feb 2025 03:32:51 -0800 (PST)
Date: Fri, 14 Feb 2025 11:32:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Subject: Re: [PATCH v1 00/11] perf script: Refactor branch flags for Arm SPE
Message-ID: <20250214113249.GA6174@e132581.arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
 <CAP-5=fUH6X2F5S5eH+iU+-hT0vNvMKPTqbGt=E9W06sG=MzxEg@mail.gmail.com>
 <20250212085439.GA235556@e132581.arm.com>
 <CAP-5=fX6veqJYbTRfOiOqtpg8Dq+m3nZJRd4zEBCZeNiwB5Xpw@mail.gmail.com>
 <Z62DOPuDJ-PrcHQw@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62DOPuDJ-PrcHQw@google.com>

Hi Ian, Namhyung,

On Wed, Feb 12, 2025 at 09:29:28PM -0800, Namhyung Kim wrote:

[...]

> > > > Built and tested (on x86). A little strange patch 5 adds a new bit not
> > > > at the end, but "Sample parsing" test wasn't broken so looks like it
> > > > is good. I was surprised the use of value in the union:
> > > > ```
> > > > struct branch_flags {
> > > > union {
> > > > u64 value;
> > > > struct {
> > > > u64 mispred:1;
> > > > u64 predicted:1;
> > > > ...
> > > > ```
> > > > didn't get broken. Perhaps there's an opportunity for additional tests.
> 
> Probably because it just checks the value as a whole u64, not each
> bitfield.  But it seems to test if the value of the input sample data
> and synthesized-and-parsed output sample data is same.  So it may not be
> important what value it has.
> 
> Anyway it'd be nice if any ARM folks can review this series.

After discussed with James, I concluded that it has risk to break
other arches (e.g., x86 LBR).  So I have sent out patch set v2 [1]
to keep the existed bitfield layout in patch 05, and added Ian's
review tags.

I expect James will give a review the new series.

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/20250214111936.15168-1-leo.yan@arm.com/T/#t
