Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF70369D66;
	Sat, 19 Sep 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840597; cv=none; b=m8mMM15zbt1k8dYdmLcrgchRnTIXFQs5juBOJ0uqpXXJnrQQ13DJQxQjbg/BVloakzXlXqvomu6JRIEDnZByb3Q0MvnkqFbBveseQ3hmfSSOREwSyMssemxrVG/uNzTxduGjq00RkaZaAsHYuRPE35/PP2YEhG63E0einxonySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840597; c=relaxed/simple;
	bh=DMIEPAt5eOC5dwEi3Ho5pwdaUdehVtkjPRiYLRdEk7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djSnwSFZpkjG/wEqcqe4WtQtAWbApmgbQNeBXt9hVd5ti4kAsjdhE8smpdRFOw50gBALqPHEaIgx1q3xl0nwmc0+X5EefXkcQ2oidE95ZnB3k5qWqJqU2DU2H98Qy0vlz4/80tdMtvKUnkpcTt1fOWuSjth0V21wU3WNo9FkW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnRxNjWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnRxNjWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270991F000FF;
	Sat, 19 Sep 2026 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789840592;
	bh=eLXADnUaztTfvh4+xBPZKmE+zTftl10pApNl7PyU/lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RnRxNjWBhqW/w/9YZGgq2hKuLXIX3jwOSc6gy7SdynNzolge1EJUVvXy8odbDjoIP
	 0i5Ibuuky+qcZhcNT2jM7qRQsmjPFBA7zPK9ACBH4sFXGVx+Za5gcjXMcW+LKoWO/B
	 qpjyT2cDDM3jTjcqicJXPUZhK4EfYLaO8AD7l3Lq9ESB+tuGcb+PK9MQ+tYlcqy1l2
	 jICgkqiWqAv/1axrw9TNPtwQG5PpHy4FDGV7sBAyvs7X4UipcriLtQ3aHMEKctK3MP
	 gqeOGT37huMYFaTSyIXqb1u7sgElzd/DfZmmk+23t/pUYoW4g2EezI6C7TBI+l5qiV
	 ETu4VAJvrI/eA==
Date: Sat, 19 Sep 2026 10:56:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>, Tengda Wu <wutengda@huaweicloud.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 0/4] perf annotate-data: Support flexible array types
Message-ID: <aq7MzpfPwQkv-oML@z2>
References: <20260919063745.48444-1-namhyung@kernel.org>
 <CAP-5=fUt43_08GcNV3bz-SFmRjBN+NoNZ7zEJyBDa+tZiN0vdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUt43_08GcNV3bz-SFmRjBN+NoNZ7zEJyBDa+tZiN0vdA@mail.gmail.com>

On Sat, Sep 19, 2026 at 09:18:55AM -0700, Ian Rogers wrote:
> On Fri, Sep 18, 2026 at 11:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > The flexible arrays are dynamically allocated with different size.  So checking
> > with the original type size won't match and cannot find the type if the offset
> > is bigger than the size.  This patch series detects those flex-arrays and allows
> > accesses beyong the original size.
> >
> > I'm not sure what's the best way to add test codes for data type profiling as it
> > seems we need to add a lot more workloads for different cases.  Probably we may
> > want to split the workloads as separate binaries.
> 
> We have tools/perf/tests/shell/data_type_profiling.sh, I wonder can we
> not just have some workload with a:
> ```
> struct flex_array {
>    int len;
>    int vals[];
> };
> ```
> then create a randomly sized flex array and access  it in a loop something like:
> ```
> struct flex_array *a = calloc(sizeof(*a) + random_number * sizeof(int));
> a->len = random_number;
> while (!done) { /* done is set by an alarm like with noploop */
>    for (int i = 0; i < a->len; i++) {
>        a[i]++; /* Expect blame on struct flex_array here */
>    }
> }
> ```
> ensuring the type profile blames the struct flex_array?

Sure, I can add that.

But I was afraid it'd need many small workloads to check data type
profiling behavior for different aspects.  Maybe we can think about it
later when we need more. :)

Thanks,
Namhyung

