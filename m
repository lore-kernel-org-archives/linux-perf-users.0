Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8EC25782A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918119; cv=none; b=bqAedfmdwA/zuOOAnW39JD6ELUTjgOqkAdq2+bqmLa3dICcM4WAC3SqfHHX1bquvkxiHAZBo8gyVHiJOpWsNWcssmAZFVbbSnSDXQGw0stI8bJcRhYXBzf6jTGLTmvhMrUWSPToVbRTFpz0enx+Iz7atJ3BvierAgfF+FwthSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918119; c=relaxed/simple;
	bh=BobVUEY4qK+mzZSb5/y7VZVL+wSb1xSXIUpsrNTTNa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzCjdR/ZZPW7395eSHjXZhyQFV/4VtAZdv4tayK4fDvDMqfDORWFOtiaLSOQwSqBwjKa/qHQ38VlVe6VWYYhNnmZfCNaXoShWc8ZhakdTrkX7CB61yTzlXofbLbNQvo2WEvUH8NITrsHgb7O3KqgqLXhTiCLE7h0F+lI04QRIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LKYMfOE4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LKYMfOE4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C3EE2454;
	Mon,  8 Jun 2026 04:28:32 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F803F86F;
	Mon,  8 Jun 2026 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780918117; bh=BobVUEY4qK+mzZSb5/y7VZVL+wSb1xSXIUpsrNTTNa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKYMfOE4ZeM0wxfN3x/MnCQ7zYLbVQoWb5WhmH0QI3hW9uJyCC90I1Cm1maGDXjqw
	 re2UU9irWDrkejRy80eeIz376GpNGfpsqemWL09OzvHZI+qwg4Jxm1YVvSfxtD2/I3
	 YnNVYRQ9Gz7Y74dL091QRC06zhcl6gzp5v/kDtzs=
Date: Mon, 8 Jun 2026 12:28:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v6 6/8] perf cs-etm: Filter synthesized branch samples
Message-ID: <20260608112834.GM101133@e132581.arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-6-f9f49f53c9dd@arm.com>
 <fbe0a097-ced7-44c6-ada1-01c3e9c1d7e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe0a097-ced7-44c6-ada1-01c3e9c1d7e7@linaro.org>

On Thu, Jun 04, 2026 at 03:42:32PM +0100, James Clark wrote:

[...]

> > @@ -3442,6 +3447,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
> >   		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
> >   	}
> > +	if (etm->synth_opts.calls)
> > +		etm->branches_filter |= PERF_IP_FLAG_CALL |
> > +					PERF_IP_FLAG_TRACE_BEGIN |
> > +					PERF_IP_FLAG_TRACE_END;
> > +
> > +	if (etm->synth_opts.returns)
> > +		etm->branches_filter |= PERF_IP_FLAG_RETURN |
> > +					PERF_IP_FLAG_TRACE_BEGIN |
> > +					PERF_IP_FLAG_TRACE_END;
> > +
> 
> This changes the default "perf script" output quite significantly and will
> possibly break people's workflows. synth_opts.calls is true by default but
> synth_opts.returns is false so we lose all the returns that we used to have.
> Not sure if the new behavior is more consistent with other tools so we can
> justify changing it? Personally I think including returns by default made
> more sense, and it's a more literal representation of the flow.

Makes sense. I will add below chunk to enable return events for default
option:

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ab3aa76dddb3..bd9eb794cc07 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3541,6 +3541,14 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
                                session->itrace_synth_opts->default_no_sample);
                etm->synth_opts.callchain = false;
                etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
+
+               /*
+                * By default, only call events are enabled but no return
+                * events. Enable return events to better represent the
+                * execution flow.
+                */
+               if (etm->synth_opts.calls)
+                       etm->synth_opts.returns = true;
        }

> 
> itrace.txt says the default is "all events i.e. the same as
> --itrace=iybxwpe", but I thought the default was branches? At least for
> Coresight it is, so I'm a bit confused.

"--itrace=iybxwpe" would be used for "perf report" command, the doc also
mentions "--itrace=ce" for "perf script" specific.

Thanks,
Leo
