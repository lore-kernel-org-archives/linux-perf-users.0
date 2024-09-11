Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446F1A3041;
	Wed, 11 Sep 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065116; cv=none; b=RNIPy3uYfsEXsKU0JFnrF05qz6i8iS7vGJrcI38SJfzN7H72MMa8pYftPVp0Ru6pQjwT+PH3aV0BYj9lSds1xPF7DG+OxrhqDffRIVxlffoY7XB8jdLsi7ru9zlBoN2ICzgIM6qRjnlmLjinrLJWeTosQEF359Or5ifrNuowx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065116; c=relaxed/simple;
	bh=Mw1y4wLHHfBdKNO78tJQNdKZ1uzYVbptjk/O8odXsyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN3hn2EB4FNtceyJCNEL9/jxDUK90h3L/cLmMMjW90qWE+mLjjb2VdtcNM5PSukgMuWv9Wzao2wbtaoRlB5nuqW0Ekxj0svPFyES1Ui3MiUDQq0zfiwpCdloaxaKqC5bSrwyWiiPl6SEiFUhuntlC4gBSKHewvNgLweQglkKO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9x08tqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9x08tqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF7CC4CEC0;
	Wed, 11 Sep 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065115;
	bh=Mw1y4wLHHfBdKNO78tJQNdKZ1uzYVbptjk/O8odXsyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9x08tqxuk8uGTAQMURWwqXD937SsnBMX8ktRkA1fROJWNZL/r7jhq/v9RT9rRlsq
	 Pn/6SfPE1RjkGJz1JHDY0fblpuqlN43baJmsZdoOqVsUtP4w2s6vhl3C/Y2Qxxbebd
	 zWdBdykojgl7F4E1TjFtecuDOCyOwhfx5N61PsYvRARfG3Mu96Qub/iOG9LNAqEMBG
	 mBIdg3TO4mZ3Qx15aR32q888vlDdJzsY9+fCB7bJTwHao0rHsmYl9ufuW5gAnTz/4O
	 tH9A4Afrnc9PFFFtyNHKSMWyEypvwjbdV2Zp4W7M+IoVbgVhwsBuFLctmb3oCTDT1z
	 +0EOsSWg7EUAg==
Date: Wed, 11 Sep 2024 11:31:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 05/15] perf pmu: Allow hardcoded terms to be applied
 to attributes
Message-ID: <ZuGp2Mt-f-PQ6HIa@x1>
References: <20240907050830.6752-1-irogers@google.com>
 <20240907050830.6752-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240907050830.6752-6-irogers@google.com>

On Fri, Sep 06, 2024 at 10:08:20PM -0700, Ian Rogers wrote:
> Hard coded terms like "config=10" are skipped by perf_pmu__config
> assuming they were already applied to a perf_event_attr by parse
> event's config_attr function. When doing a reverse number to name
> lookup in perf_pmu__name_from_config, as the hardcoded terms aren't
> applied the config value is incorrect leading to misses or false
> matches. Fix this by adding a parameter to have perf_pmu__config apply
> hardcoded terms too (not just in parse event's config_term_common).

Stopped here:

  CC      /tmp/build/perf-tools-next/util/stat.o
util/pmu.c: In function ‘pmu_config_term’:
util/pmu.c:1397:17: error: switch missing default case [-Werror=switch-default]
 1397 |                 switch (term->type_term) {
      |                 ^~~~~~
  CC      /tmp/build/perf-tools-next/util/stat-shadow.o

