Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCAE38F93B;
	Mon, 13 Apr 2026 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776111715; cv=none; b=fLW/WszscK8wdyI78alnei6GcgaDOxugCzonGQq1l59L0J+LvGlVE+DS8xzupmTKTdTyypTkAfDRaHmimoEhFcHJqdJdDLEhEzckl6wpTbc9aIthIMXcSaTAVvEnsf3X5UvVBhjxgHiK7t6WvZ0Oac7lCIFv9D1MRvsFLfk0yF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776111715; c=relaxed/simple;
	bh=fzQiXakGjGluf6D/pcF8Snn3bTVL/S7FErtfSveTYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja4HWHvtJMOmTwV9Ad7L+NiEgnjNDgD5+748uxZWy9OHJUbnsKYPc9fLO0y4L5ON4ixqbXapvSJIG9o7vnQtyhcYfb9eUA4d/uY/rBhqu5r5Zep7ia909HM03Lqv02tu7Mwh5R112cONKTqfdRZp/tswE1vRpSDPgLft4cV4Seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAEAimsv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAEAimsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DC0C2BCAF;
	Mon, 13 Apr 2026 20:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776111715;
	bh=fzQiXakGjGluf6D/pcF8Snn3bTVL/S7FErtfSveTYhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAEAimsvOx6jRnzQH5eXIzLFw4NhKNoouIJ6GKurU6JidRn0aR8ZfKfai7kjkccug
	 YkIi7vwsbKfC5KjR3sNvf5xG/n8mu6F9RL9qQupX0mQ0Vpf8x5l7WdQwaE2D7v4Q0O
	 YrdcegEJ0jNIrfHOz9dDzMHvVCgnBc/dpIuf6EOaqRz6nHvxZ/j2FE072wzt56+WBT
	 tdje5j8gQaHIvVCgRKB0N+LnE5AzlPpGjCVUd0hoEurMLRAhYshy3nM1FNl1eTMMW6
	 OtGEYeV+/7DAlZY/2KBF5tJ6YCQalMSItOgEUL3mZRR4NlNPjjfwkU1H4wHY9qrkYi
	 Bk5+a/PdJi6TQ==
Date: Mon, 13 Apr 2026 13:21:52 -0700
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
Subject: Re: [PATCH v10 22/29] perf s390-sample-raw: Don't pass evsel or its
 PMU with sample
Message-ID: <ad1QYOR7DYgjVKKM@google.com>
References: <20260411191710.524998-1-irogers@google.com>
 <20260412020833.641177-1-irogers@google.com>
 <20260412020833.641177-23-irogers@google.com>
 <ad0cxk1PJ4EcZi_H@google.com>
 <CAP-5=fUjXQgQWYZGQthYAcABn-rXtSGC4U2=OkaYMgjLif2x6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUjXQgQWYZGQthYAcABn-rXtSGC4U2=OkaYMgjLif2x6g@mail.gmail.com>

On Mon, Apr 13, 2026 at 09:59:56AM -0700, Ian Rogers wrote:
> On Mon, Apr 13, 2026 at 9:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Apr 11, 2026 at 07:08:25PM -0700, Ian Rogers wrote:
> > > The sample contains the evsel and its PMU so it is unnecessary to pass
> > > the evsel as well.
> >
> > This patch is changed to minimize the diff.
> 
> I'm not sure what this means as the patch already attempted to
> minimize the diff. I'm worried that not sending changes to my patches
> via the list introduces errors because they don't go through Sashiko.

Please take a look at the tmp.perf-tools-next branch.  I kept the local
evsel variable.

Thanks,
Namhyung

