Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6285956;
	Sat, 10 Aug 2024 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723263358; cv=none; b=eZboFW18FvFcQ7jkhtQvxnJDb1QuQ1Czhwy8iY6DyuZV/HXbmRjR/vkr8NfdCewDw6WlBWIimS/OEDCikTFoddKEgF+CF4MwgqlmPNQkBsXSziXfiRZeEgYKzRLhR39z+igqygrKBnemsnG44v55eB19/i8WXUH8RMV6UCcF800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723263358; c=relaxed/simple;
	bh=08USEkIyAj5ynaXzgaq5Ha0UKjbS3cKMeCpfEozs9Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFsRpyzYsr/NmrWPdkuTx6wWlPrKbKHT4+tf71LnmG/Ish3hyJVBa/tDxnpghowSoHY7zv5nsZJrnUd6MipPJhaFF7tPyoDqqb3jyS0pHrsK4D2SIunvBz0O656tp7A8eLq+kkyLlUrpgi5l/GMi9WD3JZjxDWEXtqQ+Un4jXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFRLEfCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFRLEfCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EA8C4AF0D;
	Sat, 10 Aug 2024 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723263357;
	bh=08USEkIyAj5ynaXzgaq5Ha0UKjbS3cKMeCpfEozs9Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFRLEfCD2pZ1S8g/90rUbkjjRzms0TQrrL6kMK8FMT/gWh4VvDAec4m2ZQ28OKwjw
	 z1kpp8aO4MoGpZQj069lmmxad1zcIOU4+zFd4kAKJuIQMHss0K1kDhQnpWF7m191s3
	 pld3g/vhdzHFb9CE/dnQRF9LNSVE48tI0UuwBBxUu/YcFzCfsh+MikTMZmLK8fO5R4
	 hC1TSHNWssrCQ/luHf3TFmHfBIG1KBU5VHD6BdYvsKKD7E+aiFr+qE4p9HINl5aFi9
	 +UhAzIGpu4qBm3zAtVnyhJlROdnignY1ToutEgSLCoP2AGJHim6etEXKSk3eikpmKs
	 5SE4hYrk4+Nrw==
Date: Fri, 9 Aug 2024 21:15:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate-data: Support --skip-empty option
Message-ID: <Zrbpe8jeTXFnc041@google.com>
References: <20240807061713.1642924-1-namhyung@kernel.org>
 <ZraLFdiu04wjxyt0@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZraLFdiu04wjxyt0@x1>

On Fri, Aug 09, 2024 at 06:33:09PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 06, 2024 at 11:17:13PM -0700, Namhyung Kim wrote:
> > The --skip-empty option is to hide dummy events in a group.  Like other
> > output mode like perf report and perf annotate, the data-type profiling
> > output should support the option.
> 
> Thanks, tested and applied.

Thanks, but I found a bug when a member has multiple histogram entries.
Could you please fold this?  Or I can send a format patch if you want.

Thanks,
Namhyung


diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index c3db80a7589a..a937b55da736 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -46,11 +46,12 @@ static int get_member_overhead(struct annotated_data_type *adt,
 	struct annotated_member *member = entry->data;
 	int i, k;
 
-	for (i = 0, k = 0; i < member->size; i++) {
+	for (i = 0; i < member->size; i++) {
 		struct type_hist *h;
 		struct evsel *evsel;
 		int offset = member->offset + i;
 
+		k = 0;
 		for_each_group_evsel(evsel, leader) {
 			if (symbol_conf.skip_empty &&
 			    evsel__hists(evsel)->stats.nr_samples == 0)
