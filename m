Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0752DFA48;
	Tue, 11 Nov 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887797; cv=none; b=KrZM08uGEHBpBRHmagrFk8x85WzUeRK4z94qJSjY8IZ8Z1Ip8oMY0fTV9ssWVxAauJX8I73i4nwaBlldw627I2ypYzOEL4HXkSXE4jPV2bjPykEVeC2tUiqWE2hZOj6nEWNEvz/ebl53X/Blh+NKx8fd7KyOVf9eRjgQbywda5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887797; c=relaxed/simple;
	bh=b6tcB8tkIAZ9MSkBm+lefzVztGFmfwkSOhggz/1BMQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohPXycwu6beZ5Mr8W4KZSUNusljlTi94W36HOS1laE/ZfAynUuG2n3ISEvOYn6u7+4FLHZGg/avcFkMpUpF1VJQNG3Xom8urHuCTHY6t+esvBqhCRy/XB4CI9ADWLFuHLzhypW8gK/hcP8pTozCTzZqSPxm3zYcfKsNAl+JK39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOusA4o9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOusA4o9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231FDC4CEF5;
	Tue, 11 Nov 2025 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762887797;
	bh=b6tcB8tkIAZ9MSkBm+lefzVztGFmfwkSOhggz/1BMQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOusA4o9O5L0zgC+yb+l+iyAtJCu0rROLhpRUDulgpGeVGT4Ti+5zs8qkilN7A245
	 dMc88E8vSmIVVK3Ex24K2YFT548bSBvO54Hsv4EUo8SuAyXHq3+G3FOSsuvrUzMY+J
	 NctlF1u3+j/sFvzcP6O1bTsFWHOrt/YUAE0wC8hco2PisbZk3wDDlCzQ2ewIt+6//0
	 owJDcmy0UN3FqRg63klOiBCbLNyBwCZ439mMRQnWHpcv9Gmig7wQshIfE7HLnthKNC
	 Q5fpoYFKjTToShyZJMo7WHEljjbvQ/mq4vvp8M0sPiyAf3zV0tAmaA+oX886VJTr2/
	 7stoNXEaYQYog==
Date: Tue, 11 Nov 2025 11:03:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 07/18] perf stat: Remove hard coded shadow metrics
Message-ID: <aROIcAVfNmNhS7_r@google.com>
References: <20251111040417.270945-1-irogers@google.com>
 <20251111040417.270945-8-irogers@google.com>
 <aRLfiZ4MCBZJGUlz@google.com>
 <CAP-5=fVJu=ke1415KQ2V_o7XpSwFwpGYRFrx=34D8Ze_vxKiVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJu=ke1415KQ2V_o7XpSwFwpGYRFrx=34D8Ze_vxKiVg@mail.gmail.com>

On Tue, Nov 11, 2025 at 09:23:47AM -0800, Ian Rogers wrote:
> On Mon, Nov 10, 2025 at 11:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Nov 10, 2025 at 08:04:06PM -0800, Ian Rogers wrote:
> > > Now that the metrics are encoded in common json the hard coded
> > > printing means the metrics are shown twice. Remove the hard coded
> > > version.
> > >
> > > This means that when specifying events, and those events correspond to
> > > a hard coded metric, the metric will no longer be displayed. The
> > > metric will be displayed if the metric is requested. Due to the adhoc
> > > printing in the previous approach it was often found frustrating, the
> > > new approach avoids this.
> > >
> > > The default perf stat output on an alderlake now looks like:
> > > ```
> > > $ perf stat -a -- sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >              7,932      context-switches                 #    281.7 cs/sec  cs_per_second
> > >              TopdownL1 (cpu_core)                 #     10.3 %  tma_bad_speculation
> > >                                                   #     17.3 %  tma_frontend_bound
> > >              TopdownL1 (cpu_core)                 #     37.3 %  tma_backend_bound
> > >                                                   #     35.2 %  tma_retiring
> > >              5,901      page-faults                      #    209.5 faults/sec  page_faults_per_second
> > >        418,955,116      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (49.77%)
> > >      1,113,933,476      cpu_core/cpu-cycles/             #      0.0 GHz  cycles_frequency
> > >                                                   #     14.6 %  tma_bad_speculation
> > >                                                   #      8.5 %  tma_retiring             (50.17%)
> > >                                                   #     41.8 %  tma_backend_bound
> > >                                                   #     35.1 %  tma_frontend_bound       (50.31%)
> >
> > I'd like to merge the alignment fix for this.
> >
> > https://lore.kernel.org/r/20251106072834.1750880-1-namhyung@kernel.org
> 
> I'm happy with that fix but if merges before these changes then I need
> to rewrite all my commit messages :-) Not a big deal, I'll add my tag.

I understand your concern.  I can merge the change after applying this
series.

Thanks,
Namhyung

