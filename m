Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B902F1FC9;
	Wed,  4 Feb 2026 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240396; cv=none; b=ilCvyJ6s0BMSnnffaoJH4J+m/5bxS+JTTsI5Cs12g02iQxIg1zFMYPzX5LK0PscT1Jf0Rkb7CnqVInydf8CxEMD/IaV60mxgoYSmRGcAJqKs1eYu9dGuD6AZVJSGhkDvb7LO8hL8jrlSqTsMUFNf3j+YPWu5Q4kE3TMAe/3ztXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240396; c=relaxed/simple;
	bh=9DiQADzjW4i7BEwNdcaYSOR4tcKdv7eUWpWKlnRXvBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwcersBPZ+7vedoddREcF8Dpjgiqhex7XhV2oHIifp4F/zJH5tWM1O+12I7k2sgI94rDdbrYStY+NlBUUExaRnk8cwekvo1w3wr010J0EJClB0WBx3mcPahLylY5bCtmLTif6lsOhG3X9jXxAeT74G+35siF3br42JutWxuPJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgb6kDYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgb6kDYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C2C16AAE;
	Wed,  4 Feb 2026 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770240395;
	bh=9DiQADzjW4i7BEwNdcaYSOR4tcKdv7eUWpWKlnRXvBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mgb6kDYR7uM4T5PL6wUCEZWabmvO81u5gskUWXSdcIKSsv1CRxcP4vKnNh2x1wsgH
	 tHxHroxsBl0Uin4ZsKnApZDzXXAtLqu3D0q9a7pFdRKhsK4zFvR3dcO9peocPhbQ1g
	 HqVVz8zgRF+CqD0GmfnXhmluGuMLM9H3GLqSD33Ek1XzL9RTSeAeUoUlNDXUAw3i2L
	 pp7kzleJv4i8Hepzvlzr9hi3pH7ZlUoeRitMF6Pbx1exAA2oWWEzwOx7z4FvME8BaD
	 oRrxvyRlZoKMF5I7sDNqO9UfggM0MJLeQzCa5M5lp0Oss/ETyCoz3c7qKHWgadrFZ8
	 9ueneLp8EES2A==
Date: Wed, 4 Feb 2026 13:26:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Tycho Andersen <tycho@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH] perf: fix segfault in `lock contention -b`
Message-ID: <aYO5iCWb3P_9YIVr@google.com>
References: <20260109164417.396138-1-tycho@kernel.org>
 <aWGh_XNyt-hmSamy@google.com>
 <aWUeOQbFOZ2CVBG2@tycho.pizza>
 <aWa2vDy_0QGh_a20@google.com>
 <aYNjwvYkvk0Ul2Jl@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYNjwvYkvk0Ul2Jl@tycho.pizza>

Hello,

On Wed, Feb 04, 2026 at 08:20:34AM -0700, Tycho Andersen wrote:
> On Tue, Jan 13, 2026 at 01:18:52PM -0800, Namhyung Kim wrote:
> > On Mon, Jan 12, 2026 at 09:15:53AM -0700, Tycho Andersen wrote:
> > > On Fri, Jan 09, 2026 at 04:49:01PM -0800, Namhyung Kim wrote:
> > > > That said, can you add a NULL check in the init_numa_data() instead
> > > > and see how far it can go?
> > > 
> > > Looks like not much further, it fails in lock_contention_bpf__load():
> > > 
> > > ./perf lock contention -b
> > > libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> > > libbpf: failed to find valid kernel BTF
> > > libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> > > libbpf: failed to find valid kernel BTF
> > > libbpf: Error loading vmlinux BTF: -ESRCH
> > > libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
> > > Failed to load lock-contention BPF skeleton
> > > lock contention BPF setup failed
> > 
> > Thanks for checking this.  I think it's ok to fail like this when BTF is
> > not enabled.  Let me see if I can make some changes to run without it
> > later.
> 
> Gentle ping, I was just reminded of this crash again this morning.

Sorry for the delay.  Please send a fix with the NULL check in the
init_numa_data().  I think it'd be simpler and easier to improve.

Thanks,
Namhyung

