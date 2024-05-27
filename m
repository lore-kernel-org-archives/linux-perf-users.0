Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2426AFA
	for <linux-perf-users@vger.kernel.org>; Mon, 27 May 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807535; cv=none; b=R5/CZXnuH0xNw7YooCgVLRSlNRCwh32db6pA/RG93tW7jR7Rwr1XZaU1RV+LPVVecgWZiYGffgdmFDFycDONK/I/8VEEluD8Xir83HZQHzl8maLUa1yVEzXui3NFqOtnNZY+RRNmu6pz7P2mHooYPXCPKhOj6srhlPLywuNTQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807535; c=relaxed/simple;
	bh=BggQ6WeR/VvO8wb95FnHBFaVo5F7rauqoxYgDuiL6do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj/9LDRaKtAEZQVjlVozuXx9UbRTZ/OYlnbkEejZQJ/DvBeNtg9Gj640SEy9sRS9r5wl5s81hRq3gAtW1UqnDAbdRnYtGU0O25Ig/7XKyCrfLTdr/rAYxhhF73fAwaiPvZOSGYVkyNNeBb5AEA6estinRjJQjl1E1yFLVf2y7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CjhKL17R; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CjhKL17R"
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716807531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCSt2lfO79zGQqXQ6GqTg/xKbnT2Dp8Ua6SwahVXIwQ=;
	b=CjhKL17RlnwOw4OY2MkDLrsOc8LFenEpy6DV44i4imM+m3HwKgceHGw+ekqqA9yzSEsf8d
	a1YtFHeXUMJzqgB7IhnSznfWjUpnHdMX2GWk9/xQes5lzVrFwSLAnQPO2B8NmOcd+sxJ8R
	4vxJTJkM0kPCqw3gKY2P5VLw/JvShVA=
X-Envelope-To: irogers@google.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: mingo@redhat.com
X-Envelope-To: acme@kernel.org
X-Envelope-To: namhyung@kernel.org
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: alexander.shishkin@linux.intel.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: adrian.hunter@intel.com
X-Envelope-To: kan.liang@linux.intel.com
X-Envelope-To: james.clark@arm.com
X-Envelope-To: asmadeus@codewreck.org
X-Envelope-To: linux-perf-users@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 27 May 2024 18:58:42 +0800
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
Message-ID: <20240527105842.GB33806@debian-dev>
References: <20240525152927.665498-1-irogers@google.com>
 <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
> On Sat, 25 May 2024 at 09:43, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This makes 'perf record' work for me again.
> 
> Oh, wait, no it doesn't.
> 
> It makes just the plain "perf record" without any arguments work,
> which was what I was testing because I was lazy.
> 
> So now
> 
>     $ perf record sleep 1
> 
> works fine. But
> 
>     $ perf record -e cycles:pp sleep 1
> 
> is still completely broken (with or without ":p" and ":pp").

Seems to me that this patch fails to check if a PMU is a core-attached
PMU that can support common hardware events. Therefore, we should
consider adding the following check.

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 30f958069076..bc1822c2f3e3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
        while ((pmu = perf_pmus__scan(pmu)) != NULL) {
                bool auto_merge_stats;
 
+               if (hw_config != PERF_COUNT_HW_MAX && !pmu->is_core)
+                       continue;
+
                if (parse_events__filter_pmu(parse_state, pmu))
                        continue;
 
To be clear, I only compiled this change but I have no chance to test
it. @Ian, could you confirm this?

Thanks,
Leo


> So no. That still needs to be fixed, or the whole "prefer sysfs/JSON
> by default" needs to be reverted.


