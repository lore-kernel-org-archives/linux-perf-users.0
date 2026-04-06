Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CB334C17;
	Mon,  6 Apr 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499179; cv=none; b=oOglWh2uAoKnfT4dt5EJGzRa1WFT+WetBV5K63cYYmXfEZ7NOrh7oIyHYsLlDpK1jftSpZmEU5H4q36lDKL4ZNNsZ79wk7YEWQO99SyZGTorBEKzecDM5oqst/23E/hoN06Y3Mcz/+IDFBFloSTbVZxWfxJ02g0lXcGiCv6Lqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499179; c=relaxed/simple;
	bh=rJ8WXWiBUXOozfot03zzydoOcizP8lcGmvYyRXUHqxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiwCRGHHsqQZuK+SGB9wYiYyZB0t/DAAqRgoVe1rckkpFg5EsjijHUtijno/03vprXW2Zg2oUgs2LurdKnkhqcMr5YFyRTW1MdV1AsKb4e1w4WZVWxk+wlFRVuBfi4rksfQfQDyht8lVY+YUfLoPJo+kysHsHVK9B3cxlrUOe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnQlHyBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnQlHyBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E8C19421;
	Mon,  6 Apr 2026 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775499179;
	bh=rJ8WXWiBUXOozfot03zzydoOcizP8lcGmvYyRXUHqxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnQlHyBbQ9m8HDttnirWVL3G/jtxcKXJtl0yBahgArdQ9woeG9fQWasogQ4nyhJxU
	 zPjKnT1eyNDwWNPbiBmNGgjsyoBn3Dy70PaxRDwdgSIvyMj9QLyKXCY29rh3WyESuh
	 s3acDHS1oNOPVqEEpU1lGIxUwdtZBb3hOOhG4i6r0nGg0wtU7OPbAyeN/8wVvsVUIn
	 96+WglmhRtp8BMJ6Zjj46PDAcHm/Hfr4V+F19A4eJPASHEFX2p/xodP+1DSfsAKrhb
	 bHyAnv9OPqcYD2o1mrI1LZm42X9CqgxM/mu9CSH3inGSYmFQgDF/RFtVMWnbeMLbJM
	 bG/o1B36HSiSA==
Date: Mon, 6 Apr 2026 11:12:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v6 06/25] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
Message-ID: <adP3qGXvdkNKDJ9v@google.com>
References: <20260403204017.2919994-1-irogers@google.com>
 <20260404034325.3172592-1-irogers@google.com>
 <20260404034325.3172592-7-irogers@google.com>
 <adNNa1lkyMXSyhuD@google.com>
 <CAP-5=fWC7WtUk7iT4pVLZC8aJYe-FwAhA03LH0rn5AFyL-jeKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWC7WtUk7iT4pVLZC8aJYe-FwAhA03LH0rn5AFyL-jeKg@mail.gmail.com>

On Mon, Apr 06, 2026 at 08:24:31AM -0700, Ian Rogers wrote:
> On Sun, Apr 5, 2026 at 11:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Apr 03, 2026 at 08:43:06PM -0700, Ian Rogers wrote:
> > > The evsel argument to evsel__intval, evsel__rawptr, and similar
> > > functions, is unnecessary as it can be read from the sample. Remove
> > > the evsel and rename the function to match that the data is coming
> > > from the sample.
> > >
> > > Add bounds checks to a number read values from review feedback. Make
> > > perf_sample__strval avoid returning NULL pointers, return an empty
> > > string instead. Fix the function type to reflect this, catching a bug
> > > in kwork where the string wasn't being duplicated.
> >
> > I'm not sure if it's a bug... the string was never freed and duplicating
> > it would create a lot of memory leaks.
> >
> > Also it seems you still check the return value of perf_sample__strval()
> > if it's NULL.
> 
> Yeah, this is one of the areas where working with Sashiko is
> difficult. The kwork code has memory handling issues, and each patch
> series has revealed new warnings. I believe the issues are fixed in
> v6, but as you point out, I haven't addressed the pre-existing memory
> leaks. I don't think we need to overcomplicate fixing the evsel in
> perf_sample issue this series is addressing.

I thought this patch introduced memory leaks by adding strdup() and no
free().  It looks like there is a pre-existing memory issue in kwork,
then you can leave it and just convert the function not to pass evsel.

> 
> Specifically the current code will assign to struct perf_kwork name
> both a value within a sample:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-kwork.c?h=perf-tools-next#n1021
> ```
> work->name = evsel__strval(evsel, sample, "name");
> ```
> 
> Or a strdup-ed value:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-kwork.c?h=perf-tools-next#n1152
> ```
> work->name = evsel__softirq_name(evsel, num);
> ```
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-kwork.c?h=perf-tools-next#n1125
> ```
> static char *evsel__softirq_name(struct evsel *evsel, u64 num)
> ...
> name = strdup(sym->str);
> ...
> return name;
> ```
> 
> The name's lifetime must match that of a sample, which seems
> ridiculous given the ring buffer... will be overwritten. So in this
> change, based on the Sashiko feedback, I've strdup-ed the names to
> avoid the name pointing to memory within a sample that will change
> when the typically stack allocated value disappears. Sashiko
> originally complained about a lack of bounds checking, but then
> complained about strdups of NULL, etc. At some point I have to stop
> addressing every issue within the codebase that Sashiko raises, and
> kwork seems to generate more of those than elsewhere.

Agreed, you don't need to fix all the pre-existing bugs.

> 
> I think it is pretty obvious the kwork memory handling at least needs
> a free function for struct perf_kwork, this can then also free the
> name, but refactoring and fixing kwork wasn't the point of this patch
> series. We've just merged the tests I sent out to provide minimal
> kwork coverage.

Right, let's not make it worse and leave it fixed separately.

Thanks,
Namhyung

