Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154613635E;
	Sat, 31 May 2025 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748678031; cv=none; b=HeUREBT9nghamEE1Ykwd7qa8VKULfa6BwcdFtXXJzuHPy1CCBm2WTT5tvgkhSkXA95nLyXXQ09nN6h1m0g2CM7/OU9NuV7rFNlVLSWxJ12nog0aWhDJHs41WDbq6vt6ELqNMxgFPIEaxLhoR/sLyKkSOhfjjHaaDdY478O+R0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748678031; c=relaxed/simple;
	bh=moi2gTk6n8ONkexxuDUEiaKnmWxJpznirQYCn6g3ixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcp9jjGM5Aaziar4FJBluOOrwT1B/N6lHuc7FkDPxaesBJ9VJzXcheiEoJN7v+pmLtwDb8TqpanUQnYcZ01M7mxkpC9QJ3wd8EuM7UJ8T9O4669a/ogvM1pUbGSw8UkPRC/1RCezKcdAp4TVSbmUWBiw/QrPXv82vs/3A5ZLs+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VExZfzv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VExZfzv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A063C4CEE3;
	Sat, 31 May 2025 07:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748678031;
	bh=moi2gTk6n8ONkexxuDUEiaKnmWxJpznirQYCn6g3ixE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VExZfzv9y9vwuJOLnsWWMuL/nCW8gjlCrKg6ObmHmaI9pg0M/R1LmWEKIbtsqg3q/
	 aQqP7JkFFIlGQVlk6aHu+XjiQgvnWVpveIo/9tbt40u5b2PH5Smujcr/GE7v8pL6p0
	 IT5XZE8ITfY10XJ0CJQ+g06T2RIOHIz25PS/VfmzvikdV665mfl7amHi0EnkB4ErOz
	 BDnQWwfN5yptg7mZFGxjrU4TghjaCWmSqieVyRzioCB+Sw0FBbr2xRT7UOaBWT0daa
	 LeihNzWFhVhWHKkhk3KH5IIwAGv7ooNBSooYsgvqTrdhLbZeWKXLPOrvVil9V7xjtC
	 dnKeY2xyIsupA==
Date: Sat, 31 May 2025 09:53:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Joe Mario <jmario@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 1/4] perf/amd/ibs: Add load/store SW filters to IBS OP PMU
Message-ID: <aDq1iG3P9_BBnx7C@gmail.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
 <20250529123456.1801-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529123456.1801-2-ravi.bangoria@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> Since current IBS OP PMU does not have the capability to tag only load/
> stores instructions, tools like perf mem/c2c ends up recording lots of
> unwanted samples. So, introduce a load/store software filter in the IBS
> OP PMU:
> 
>   ibs_op/swfilt=1,ldop=1/         --> Only load samples
>   ibs_op/swfilt=1,stop=1/         --> Only store samples
>   ibs_op/swfilt=1,ldop=1,stop=1/  --> Load OR store samples
> 
> Other HW or SW filters in combination with this ldst filter are logical
> AND. For ex:
> 
>   ibs_op/swfilt=1,ldop=1,stop=1/u is
>   "privilege == userspace && (ldop == 1 || stop == 1)"
> 
>   ibs_op/swfilt=1,ldop=1,stop=1,l3missonly=1/ is
>   "l3missonly == 1 && (ldop == 1 || stop == 1)"

No objections, but:

> An alternate approach is mem_op BPF filter:
> 
>   perf record --filter "mem_op == load || mem_op == store" ...
> 
> However, there are few issues with it:
> o BPF filter is called after preparing entire perf sample. If the sample
>   does not satisfy the filtering criteria, all the efforts of preparing
>   perf sample gets wasted.

Could we add an 'early' BPF callback point as well, to fast-discard 
samples?

> o BPF filter requires root privilege.

Could we add 'built-in', 'safe' BPF scripts that are specifically 
prepared for perf events filtering purposes, that can be toggled by 
non-root users as well? These could be toggled by tooling via sysfs or 
so, or even via the perf syscall if that turns out to be the better 
approach.

It would give us the flexibility and extensibility of BPF, combining it 
with the safety & compatibility of the filtering functionality being 
provided by the kernel.

It could be provided in the form of a BPF program crypto signature 
registry of upstream-approved BPF scripts for perf BPF callback(s),
or so. (While root could load any BPF script.)

Thanks,

	Ingo
