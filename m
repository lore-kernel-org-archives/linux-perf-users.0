Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876059;
	b=5EeZcSoinUAPm0lTLKue9XoUfniGnc2bphS8u/ziB9+FfcMXukAQ+LsTLwcTVGtBDw7U
	 riwelzc8djTJ4NHH6QVRlunfS7UjVFCYNhj/47kYHI3+FfDM6/f58Nh3PCyQrtiv8CDLO
	 CQYKguhU6VW56ITU3jOGvtGlJJYkBokUhFlf9ODDqX+9uO2Vz5ok0Uck356oSltrT8mwl
	 xcHk3NozBuFzjejDQovc8wGAjcyopJebnnWoqhnEVyX61oFH+e83EML+oh9si4wh2xA5F
	 HmOlfop+F5u5n16M06W1fuGUKWwcCqaKfWW0Yli2J+3+z6jGCw1IeM2ACYIbgKgOtRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876059;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=uuLCQ5vdJSCNf8EK2nOCyp7/0y68brkrYFtyf0bFFsc=;
	b=h7JAxUB0KAakZQzAHpJlbWLk9LYOLXwNKksh9xYR/+MPcHjuZfeCsZBzUpc4+ygr2dEn
	 gfDiYqqhJBNPjo4KHp0Jk/2VCSUO03jfgBjBqWNlWW1nEFkFNRtGPL3MVfjpt/+Fp1wBL
	 hwE72VsQq3sezqIiG72eWoSAeskXxjEyfIdVMBqM61H45t+RTKswOdFD3sEcAakegH5hP
	 4GCNJz5/UeZ8jMLmG3XInvN6/D1tt/INpUcHGf0Vbq9iGdwjJFBfnrzboEWLYNV1e20Dr
	 qGmpRYspfonbciROEu0jgGpFzHFQ9Vgd3Nck1rv/qMvgX3ZLKAC2XGCr9n3PGq/iSdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OOYpymob;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAA606A326;
	Thu,  5 Nov 2026 10:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDAAA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OOYpymob
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB411516;
	Thu,  5 Nov 2026 02:54:15 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976C73F673;
	Thu,  5 Nov 2026 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793876058; bh=sIBaP94YRtB79rtMZyrt9dVTqFG1JE1zf+vMbgJ9phU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOYpymobwadPTFqvrgvEgaxVMzn4xZAL9tqSsDkcyJBBigjWGT1qJ7UJxmH+BPP/d
	 OQHPaUqlAi2jkjp0Hk67m0pgS6q6DsuPy8elY/zkJkasFSWoE5tq1APhhM4r3fPREY
	 NAi/HbgohI/9lUg6sX+7+n2SX27ex0lSOrfTEqFE=
Date: Thu, 5 Nov 2026 10:54:15 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 04/18] perf cs-etm: Use per-CPU queues for per-thread
 mode
Message-ID: <20261105105415.GP9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>
 <20261104142412.GI9176@e132581.arm.com>
 <54182c51-8dfe-46fa-9369-5e4e31a63796@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54182c51-8dfe-46fa-9369-5e4e31a63796@linaro.org>

On Wed, Nov 04, 2026 at 03:07:24PM +0000, James Clark wrote:

[...]

> > Why not use PERF_RECORD_AUX events as an opportunity to update threads,
> > similar to how we handle PERF_RECORD_SWITCH_CPU_WIDE?
> > 
> 
> In cs_etm__queue_aux_fragment() we check if the TID from the AUX record is
> the same as the one on the buffer, so it doesn't make a difference. They're
> always the same:
> 
> 		if (auxtrace_event->tid != sample->tid)
> 			return 1;
> 
> We can't use it directly in cs_etm__process_event() because we're not
> decoding in order with Perf events yet. In my WIP JIT patches we do, but it
> still makes sense to continue to use the TID from the buffer because you
> don't always have timestamps available to update threads when the AUX event
> comes.

Makes sense. Thanks for the explanation.

Reviewed-by: Leo Yan <leo.yan@arm.com>
