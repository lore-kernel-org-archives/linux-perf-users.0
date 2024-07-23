Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65214C5B0;
	Tue, 23 Jul 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759643; cv=none; b=k3+AgwevnU1Tk0JYoTSK7AohDzuR7UUUxo/fiRdqg1ZzfncAZW3n1NV3BVqC/uw0Yvfy/MQ7T0NXina+YnLQjVq6FbdmJ19ZOXki+BJQJhZ9RDA9DS8zpSpPNlHfE7SQB7iz4NtlVzvqMlCwqRMSSvIwGX4gF3OHXo1b2N7k3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759643; c=relaxed/simple;
	bh=c3g2yi2iHSRtY9fZEZkTzGj+Ul17yjsvhsS/Ea0xXsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyEO5YRqrQvzr5kiG+mwbK1cNP5+d2lwY/xoPJKGtf6tsRQCo8Y9EPtVKdDo+m5zf+L6O+PfbC3yi3Zf/AE5btSXIIs3sGVj5xo6Y3GG8bCOGY3LbPB+GG5nrLfJ0xGEYVHrfTQfTSODNHFKoKOkXiSItSPySCyi/efSttkYFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih39rD7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih39rD7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203DEC4AF0A;
	Tue, 23 Jul 2024 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721759642;
	bh=c3g2yi2iHSRtY9fZEZkTzGj+Ul17yjsvhsS/Ea0xXsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih39rD7hiq3OsnH0p+4ej4v+qc6lqiK1pAJ/oFKuMh693D11lQt5UE2KH9j2OFK+u
	 NqdciXHzNCREQXBe+Zt82fmTnXYJm1rTZYOXi2wdUQuFKDsMRaPMRg3vINC3r54BHH
	 wHBgkXE6ftQgtHPT5IsBrBH19a3Y0+LxJjBTcHm1DC7hD4uAGmd6XJMnfRbAKRhqsw
	 ZnJNEMAso1Q0S+QmkR0Pm6YHDmUIFoz1w+lHveQ1MUgKYsxM472bhGxdAspAmgC8Ur
	 9keT1ijEJodl+h3Cp4QLUBQl61J0nbtNPcS1D655vtMGQPpHgruPFDxmmunt+QWRUx
	 VNox1yP8P4i4Q==
Date: Tue, 23 Jul 2024 15:33:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Avoid python leak sanitizer test failures
Message-ID: <Zp_3lQ1fZDn2Qxy2@x1>
References: <20240717165717.1315003-1-irogers@google.com>
 <6645190c-e66f-49db-a23d-e08f6308a422@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6645190c-e66f-49db-a23d-e08f6308a422@linux.ibm.com>

On Thu, Jul 18, 2024 at 02:17:58PM +0530, Aditya Gupta wrote:
> On 17/07/24 22:27, Ian Rogers wrote:
> > +# Disable lsan to avoid warnings about python memory leaks.
> > +export ASAN_OPTIONS=detect_leaks=0
> > +
> >   cleanup() {
> >     rm -f perf.data
> >     rm -f perf.data.old
 
> Looks good, and test passes with this patch:
 
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
> 
> Linux-ci build test results: https://github.com/adi-g15-ibm/linux-ci/actions?query=branch%3Atmp-test-branch-25073
