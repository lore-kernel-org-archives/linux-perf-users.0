Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0333B961;
	Thu, 30 Oct 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815360; cv=none; b=Fim05cyUCIc/BmPoW7MGXWo5IrGZ+4oMBm/3K5A/ZbqOViZVjKdLhdTSPJyq1N0M/UmEwgMySbtMsH5NkoNjcNIGY3U2aQV5gaVbi35K8vGFOk6GAYL09AU4dtcYXHY36pY0eX59KGiiXnXPO21/cpABtXPmu4gPEVT6qYFyDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815360; c=relaxed/simple;
	bh=mvf1imlMzjmlPqLM7MATPvQDTa7Xp5Eb92w0I9oD1Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsnzGXHgCyN0mjcDHdHd+kFpHFyEdQ77QCzSgncDEmYY4NY5V7dBaU6Ly8oUpXqnt0fbskhfwHfvv1WpA/PgGqlnZZ/Bqsjwc1k/ECtqE5q0ybAodCQFEVFq4xVzarvvDG7u6XGrkMHBSrSNoSq6BV5LuBS8BhgZU9g1ZvA7nlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1/eKes6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1/eKes6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82741C4CEF1;
	Thu, 30 Oct 2025 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761815359;
	bh=mvf1imlMzjmlPqLM7MATPvQDTa7Xp5Eb92w0I9oD1Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1/eKes6tGKBGDR/slEUxunAeBiQQI+EVCeXtjMtWtyXpU/q1+KThUPJCC5+gu9lG
	 YH7Z5cjUKZg9M+AT4NN3g0wA9RnWFv0PIXR2GTnNgHd/B45Ss/eU3E8LfhxjdK92QY
	 nJ6oAT1DQEPLXTB0bfLjT9f2G3FSDS8Fo5PhktwDcWL+rvqipwsYZ7Y9CeWQXioBqP
	 6YGX3/gNmISuOb0UsJtDObx8mZLZhTGpJozVF4B9ZPD6OlSZqsW8Eb5+y1o/8cHHix
	 9iOwmN+lH4kEsWmYJ+KI/C1/bPrJrz41a8fy5bi0FDRoJsHQp7EFSQi+upb8T5hdvh
	 03031Wsw0booQ==
Date: Thu, 30 Oct 2025 10:09:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>
Subject: Re: [PATCH RESEND 1/3] perf/x86/intel/cstate: Add Clearwater Forest
 support
Message-ID: <aQMrONyVjGsCFXe2@gmail.com>
References: <20251023223754.1743928-1-zide.chen@intel.com>
 <20251023223754.1743928-2-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023223754.1743928-2-zide.chen@intel.com>


* Zide Chen <zide.chen@intel.com> wrote:

> Clearwater Forest is based on the Darkmont Atom microarchitecture.
> From the perspective of C-state residency profiling, it supports the
> same residency counters as Sierra Forest: CC1/CC6, PC2/PC6, and MC6.
> 
> Please note that the C1E residency counter can only be read via PMT,
> not MSR. Therefore, tools relying on the perf_event framework cannot
> access the C1E residency.
> 
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

So, this is not a valid SOB chain: primary author should be the first 
SOB, or if it was co-developed, it should have the proper 
Co-developed-by tags.

Here I can see two possibilities:

(1) if Zhenyu Wang was the primary author, and Zide Chen reviewed, 
    tested and submitted it upstream, then:


  | From: Zide Chen <zide.chen@intel.com>
  | Subject: [PATCH 1/3] perf/x86/intel/cstate: Add Clearwater Forest support

    From: Zhenyu Wang <zhenyuw.linux@gmail.com>
    ...

    Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
    Signed-off-by: Zide Chen <zide.chen@intel.com>

(I.e. add the extra From line as the first line of the changelog.)

(2) if it was co-developed, with Zhenyu Wang and Zide Chen having each 
    written unique lines of code of their own that finally resulted in 
    this submission, then:

  | From: Zide Chen <zide.chen@intel.com>
  | Subject: [PATCH 1/3] perf/x86/intel/cstate: Add Clearwater Forest support

    ...

    Co-developed-by: Zide Chen <zide.chen@intel.com>
    Signed-off-by: Zide Chen <zide.chen@intel.com>
    Co-developed-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
    Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>

Which one was it? :-)

Thanks,

	Ingo
