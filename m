Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE791DA108;
	Wed,  4 Sep 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457660; cv=none; b=RmRD+ds/0I1CvMr/zgtIJGU4b9I1HJWa3OjkIe54fbPvpF/JjafuMPI5rGaYRx0wFoNsi3YsffjfnfhhkyIQ5UfzyTV7LN5aI0/dbEHYyol4Z7+NgthWkuI5SjDsCRChDPYS2McVaDVAI/6ZOHZNn9ryMRVVZqT3MIZRPZ8hEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457660; c=relaxed/simple;
	bh=iHascUt8rpDx40DApnoHRvvn2WHctSgMy1P2tqab250=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIjZ+l49F9tUA7pVj//SMRD3ppjb5TRj+ZMhTAtJ2FKVjuFK7j8Flo1IaMzq0AF6rszgzvEnmxPVzGoKjyIS2kzvG6fILITqfsU53pe7A+6CWvzF1zBs8Ei9qAsHwRH1INW2saEuo1LlVK+s+wvkj+g54wsiWPgp68nAxXjar5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrlWIr3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrlWIr3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C3C4CEC2;
	Wed,  4 Sep 2024 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457660;
	bh=iHascUt8rpDx40DApnoHRvvn2WHctSgMy1P2tqab250=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrlWIr3csucfL5KhOJuxx9QRLf9jHNAZ68X6tr3TR4hXNLcuDQdKE7Gi/dxcmtHiC
	 K+FvxaEN8D5d00Xoo+dSdSxbRfe0jh2nbSBK5+Wq3/Ygj50gfaPU501ohAcT3iWi/+
	 42WwveJy/f+94e0+kgjSas7mLs2OBoM1uTE7NPHfE2OXQ6cWlgAjJVwWb4TdqhWUkA
	 348j7lDJ7q1JWZynCtKam5c/elLcIuVQcFMVE5KFraeutoVJFdauv8ixWKbrLEXSxF
	 LGf7K/OaoZPOFkj9l1/lK5u3IRVrMOBbB7RmESv+qkl50T/xLyZ2a0DJnHrfA4Yo4z
	 8HxfXJjVcDIsg==
Date: Wed, 4 Sep 2024 10:47:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf jevents: Add cpuid to model lookup command
Message-ID: <Zthk895rlxYbUbMl@x1>
References: <20240904044351.712080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904044351.712080-1-irogers@google.com>

On Tue, Sep 03, 2024 at 09:43:51PM -0700, Ian Rogers wrote:
> When restricting jevents generated json lookup code with JEVENTS_MODEL
> a list of models must be provided. Some builds don't know model names
> but know cpuids. Add a command that can convert a cpuid to a model
> using mapfile.csv files. This can be used with JEVENTS_MODEL like:
> 
> ```
> $ make JEVENTS_MODEL=`./pmu-events/models.py x86 'GenuineIntel-6-8D-1,AuthenticAMD-26-1' pmu-events/arch/`
> ```

thanks, applied, added:

  Committer testing:
  
    $ tools/perf/pmu-events/models.py x86 'GenuineIntel-6-8D-1,AuthenticAMD-26-1' tools/perf/pmu-events/arch/
    tigerlake,amdzen5
    $ perf stat -v sleep 1 |& head -1
    Using CPUID GenuineIntel-6-B7-1
    $ tools/perf/pmu-events/models.py x86 'GenuineIntel-6-B7-1' tools/perf/pmu-events/arch/
    alderlake
    $
  
  Signed-off-by: Ian Rogers <irogers@google.com>
  Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
