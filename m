Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981319DF61;
	Thu,  6 Jun 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683101; cv=none; b=a+ryMLTumd1L5pE6wiMrPTi4b80SJdhBYcNi9/hg42eHgY9yrY42NflBZs/uGJV95gRSKRlwOsWapzlQ3YNkyDTvu30xG8ARmGaD9O9yef7HS8Deuzasv2XGKw5Bzj9OuRokDp5nE9lpDeXso6/zDyZvWarI44VHSukh4+QJvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683101; c=relaxed/simple;
	bh=415HSXxW8PVvjc6k6Tqy0srTS1+R/TG4X7z7xilDD7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoyQKNjgMwrk1eV3vV2yve6Ci9QzUXEKGWTqgOlV7opSVxxEnN8luvU9oVI7YpASZAMXkI9dCgceTc1o7DW/U7pvupvJYhvnzmPp8NoAQLSh7PHN2HvIeMpZgakUOdejPu42bZvorv5wMnH0o9IpQh2+VTJ37hX2RI8HyEjl1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8CTIgRg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8CTIgRg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8A7C32781;
	Thu,  6 Jun 2024 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717683101;
	bh=415HSXxW8PVvjc6k6Tqy0srTS1+R/TG4X7z7xilDD7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8CTIgRgtpdgUm9LcWuC9QNpdFuHZ9TZLbjaD3LbQuehiIuT+Ra0+Rt0qqkvlGT7q
	 6g1pgHHRu2SjoY/kV9R5CHI+gfma5i73Cj8oIgby6h/i4ut1sNeHAqBYPvkM7uYc9j
	 x0JnV3eBqpXlyCNrEswgIaYHxcuEqPm09cwHvdcMnrJVjaifWD1BDBI7gwzmx2ZFq/
	 QI1UIwv5GOnaEt+H8DjH72AnEYhcOMuBhbFwKH+UYPEHIb/413l6V86noaObV+OIwv
	 hn1ld0+/3VkEeZW81pZfLhfrLmFhG9NuHlLIN5oUdgndkVxkt0ldtId3/x29AdCR3P
	 ohRBGZmzWD5sQ==
Date: Thu, 6 Jun 2024 11:11:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the
 default
Message-ID: <ZmHDmrLCoYPUCv3n@x1>
References: <20240516222159.3710131-1-irogers@google.com>
 <86136e0d-45e9-4bf4-826b-359e4993488f@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86136e0d-45e9-4bf4-826b-359e4993488f@amd.com>

On Thu, Jun 06, 2024 at 10:15:00AM +0530, Ravi Bangoria wrote:
> On 5/17/2024 3:51 AM, Ian Rogers wrote:
> > Instead of decaying histograms over time change it so that they are
> > zero-ed on each perf top refresh. Previously the option '-z', or
> > pressing 'z' in tui mode, would enable this behavior. Decaying samples
> > is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> > the default and rename the command line options from 'z' to 'Z' and
> > 'zero' to 'decay'.

> I've also felt `perf top` decay as non-intuitive. Esp. when system becomes
> idle after some heavy workload, even decayed samples are far more compared
> to samples from currently running processes and thus `perf top` keeps
> showing already finished processes at the top, which is kind of confusing.
> fwiw:
 
> Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks for voicing your opinion, that is really helpful.

Changing tool behaviour can have unintended consequences even when done
with the best intentions and analysis, that is why I'm wary of doing it.

The --children case generated complaints when we made it the default, so
we ended up with a ~/.perfconfig option to disable it:

root@number:~# perf config top.children=false
root@number:~# perf top -g

Or enable explicitely:

root@number:~# perf config top.children=true
root@number:~# perf top -g

Same thing with the build id cache, where one can disable it using 'perf
config', etc.

So I'd do this initially with a 'perf config top.refresh=zero' instead
of changing something so few people complained as not being intuitive
after all those years of having that default.

- Arnaldo
