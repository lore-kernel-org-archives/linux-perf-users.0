Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E65A3A7F58;
	Wed, 21 Jan 2026 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025135; cv=none; b=K9T4+vRd0odDqL28MI+aMntM22QjjpIE6Kdz9KM9XAENzvAkcSigENE0vm+3rJqvpZNlcx/TEXgqnAFMB2+gGJY4csbVZrNEBbe1AO+h//xsJivQeMcswjNOHq+VImcduV6kxAAeMrux0nmE6VmlXMp/8OegbUU6mmKC3KiXFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025135; c=relaxed/simple;
	bh=svxYNJpVS8XzHWG/VcJk8g3kHMyWpP174pnBUuF91aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR7AbYw7NcUGCBRljYVrezsm11mGd69AF78BSxbQSMqND3P1fqPMezT35IX4OozqeF780U3X6k7ddy+17QdiosRAFc5vsvy2eYgU6MpKB6FAtFVpPstI8taQ49NQVddkU8BvOrLyHFimXAgcDEJMfbHp/92uY56Y3t4DI07wiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ThS38EAE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ThS38EAE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y2HuPnAHG2V9KhuHLyOdXH5hlStIJb9kToRsMrD2JbQ=; b=ThS38EAERyKVyYc6BJG8FJkayc
	1+nU7azXlFm8w0WLJ8qQdpTihV6QCEve6W9LnS0pXER/NZlzphVHjnw7C3JsWg8Rqo/Ki5WcQ/pyl
	nQYONJF+emoZIim9281ldZJfIQP4r3hvCK0lOSoMX//oL3Qj1gMSbkrmvqwM9DZcKbch99h+7zjNQ
	uBqQr0MGbTbGgMp8FEFS8b2oZxj9OE1lhLoGIbQu3+sAhy5TOEMkV8jCRxd3yR5PD+v1uKomZbFqU
	nXN0hwrK7pCa6GI+XrciVc6fQu7uDkKAQwKhEUK1eKjvqhocwEd0JTUeHAQ1BeeA1OC61oO2CxQq9
	XAf0yF4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vieFA-0000000Gq48-1M2x;
	Wed, 21 Jan 2026 19:51:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40B61300328; Wed, 21 Jan 2026 20:51:55 +0100 (CET)
Date: Wed, 21 Jan 2026 20:51:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, ravi.bangoria@amd.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, james.clark@arm.com,
	acme@kernel.org
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Message-ID: <20260121195155.GP166857@noisy.programming.kicks-ass.net>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>

On Wed, Jan 21, 2026 at 09:12:20AM -0800, Ian Rogers wrote:

> I'm still wondering if we can make some of the /proc/schedstat data
> appear as tool events similar to proposals for networking and memory
> tool events in:
> https://lore.kernel.org/lkml/20260104011738.475680-1-irogers@google.com/

Yeah, someone with a bit of spare time could make it happen:

  https://lkml.kernel.org/r/20250703141800.GX1613200@noisy.programming.kicks-ass.net

It would be:

 - convert all the accounting sites to tracepoints
 - write modules that connect to relevant tracepoints to provide the
   'legacy' interface
 - convince world+dog to not auto-load above modules
 - have beer and wait for people to complain about something :-)

I'm sure there's 'interesting' details glossed over, but I *think* it
should be doable.
