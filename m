Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC43AA183;
	Tue, 20 Jan 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941011; cv=none; b=NhJgoOm8VwyFlBWMLYEj4PSKrQQZGN9kQu/kFWGJXkI4UFH7snHcl8AseVa/ro5L749u/IZQpywxcX0ukVKeT09j6z4Ipp6jCB/vC0U9be0/NvH0V8l1jvD3k8JETW+Ww2FfXQOpLISkdSE7CFDMZfFnlEkTw9V0AMuNROpaHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941011; c=relaxed/simple;
	bh=v10dL5M4XOZyFg5P34VvdCJ7I9741+7UypUpPryGbq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlxn6so8MBUCJ5oM0NWfvtUpoNIvj8mKwMHDcv/3OuD314t/PliVOevgxaUp8WAm6XD0hbMl6IIKeoO+HBtWoU8+NWYUY4k8iBLrINskDpSS14C/tvACzntW6AfYiyfkcE1NrDJeRz4kr8yrQ3hCNaTcjhn+MuCkbrGbHnjcddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re0uo1Hi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re0uo1Hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCA7C16AAE;
	Tue, 20 Jan 2026 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941011;
	bh=v10dL5M4XOZyFg5P34VvdCJ7I9741+7UypUpPryGbq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=re0uo1HiOExb64ED+8L8NaNxeZYI/hXpT3XOoNng41VkK76a/+ayPMjH/9ep7cu47
	 JVP1StMTFTCJWVD+xLQr4+4Ii7cls4LKaWuvPDMFuPM3wwuexTw+IU4tdHnQPp0Mlw
	 Lu7sHNVn4rkOzMFdR6qQ9IEPc7vaOCbQH9idU51pET2G/GwXCMNalrEd7/bJ2AONdy
	 tFJO4OZP3PX4luFpNzGzBQXsPrrXf23bqYYp1oYXjNowMwUyRZKqoOHDUAQpn27yQ2
	 sHhquoZkl1xyz30Ux8tTqi6UmucErtZt7lY6J8Ay8VvMIQz1NdFRJxL0Koj+qIEMII
	 Bo/N7ky4jHdVg==
Date: Tue, 20 Jan 2026 17:30:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests kallsyms: Fix missed map__put
Message-ID: <aW_lzwpy-nUCiu1B@x1>
References: <20251210190141.12725-1-irogers@google.com>
 <e0410f42-f70d-464e-82aa-7237d779ba6b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0410f42-f70d-464e-82aa-7237d779ba6b@linaro.org>

On Fri, Dec 12, 2025 at 05:19:47PM +0200, James Clark wrote:
> On 10/12/2025 21:01, Ian Rogers wrote:
> > Issue was caught by leak sanitizer and the test robot.

> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202512101502.f3819cd3-lkp@intel.com
> > Fixes: 34e271ae5538 ("perf test: Add kallsyms split test")
> > Signed-off-by: Ian Rogers <irogers@google.com>

> > +++ b/tools/perf/tests/kallsyms-split.c
> > @@ -148,6 +148,7 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
> >   	ret = TEST_OK;
> >   out:
> > +	map__put(map);
> >   	remove_proc_dir(0);
> >   	machine__exit(&m);
> >   	return ret;
 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
