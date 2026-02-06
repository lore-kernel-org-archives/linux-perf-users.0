Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338526D4CD;
	Fri,  6 Feb 2026 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770415194; cv=none; b=UHIpD8ERoyWd6ROTnHxEk3QqRe8f75wLa0XP6EbYSmgmMJVoKyoyzuQ4SxtqF8O4PmYJSLx3LAu0E8/j2dqCAqVbM+t4LzbUmwINxclLGL1SCYCrI6SfI0b10H6crNBegJkkSnnFUeYnmXIs+Kd+CRvtSKqrM2bO5YjtSPqJChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770415194; c=relaxed/simple;
	bh=W0rS3XNNF77VuqmBvw9H4zfSkqrcl2AcjYA6thzt2K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyDKAyKSs2lxKKTjO/iZkCtqiMDFf6coFT1r3bUXJ6FQkDbaQRfuKinATRthVaP3SV0u6fFswsEhquC41B5LhcncR2ZUW9BouQwcHQ4HIb+PwJkUSo6MNrIKrCsKGbKIxXXvlYpz30Wk53IeGJO+rGbmtWhoJ8WHXqFcOFJovjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnpxcHkD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnpxcHkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B82C116C6;
	Fri,  6 Feb 2026 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770415193;
	bh=W0rS3XNNF77VuqmBvw9H4zfSkqrcl2AcjYA6thzt2K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnpxcHkDyi0/Ny07ic1NhZBAB1yzlK5Y0pxShU7z8udYIBr9U3q+t3P7X0vphBgL8
	 uCModrlnc+/r7nBYsu5V0zBNvKQsbD8TaF0px3pt7pCrzVhtuENKmqcSpR0ozOsyV7
	 S2pEoTP5/NdWHq0Gnek4AlxGqZWzExYxPVdKDOTD9zB3LlG0G6rnaCgom1KMv86or1
	 eulcJCGJYiDfQS2vrWo8yELi0lTK3Spp2R+ttbKImp2ZKVyqg3A/ttcsBuOQvA6YqO
	 ettjFXbLd7cBaNWlvuUpTDR9zxCxT34vftyTfULC7Gal7CBPYzuRY8dgFrecYcGbst
	 cO7AWuz1CwswQ==
Date: Fri, 6 Feb 2026 18:59:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tycho Andersen <tycho@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] perf: fix segfault in `lock contention -b`
Message-ID: <aYZkVQn_pUzn1CeD@x1>
References: <20260205163250.1980640-1-tycho@kernel.org>
 <aYUzLjODMw2NqEzq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYUzLjODMw2NqEzq@google.com>

On Thu, Feb 05, 2026 at 04:17:50PM -0800, Namhyung Kim wrote:
> On Thu, Feb 05, 2026 at 09:32:50AM -0700, Tycho Andersen wrote:
> > Check if btf loading failed, and don't do anything with it in
> > init_numa_data(). This leads to the following error message, instead of
> > just a crash:
> >     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> >     libbpf: failed to find valid kernel BTF
> >     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> >     libbpf: failed to find valid kernel BTF
> >     libbpf: Error loading vmlinux BTF: -ESRCH
> >     libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
> >     Failed to load lock-contention BPF skeleton
> >     lock contention BPF setup failed

> > Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
