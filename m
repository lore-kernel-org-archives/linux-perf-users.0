Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582D202F9A;
	Fri, 23 May 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011864; cv=none; b=KSln9flsJzMAJqaDgrIz0sggRiKhzQ0FAL6gyVGtMkptEyVCY3+pG3iVEK++1oArj7l0tZoFelRBRYhiKMs40TDMKdcW9sBJvDUzWmcGcMobW74KNBYsBiSYX51WokY0yVPg1G1+270c3ns0vW+SblULYt1QBzmkY2+2gg0RwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011864; c=relaxed/simple;
	bh=iQNEWUeLCB352bTu3ok5V6qZW15EZquP6l1y9wrUrVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxzNs7UkcNsjpNmugY49UnYzs4GH6yVhtRU+JE9s7xEkxxSBBh35uCn6O4meejrXqFBvOzBiQOEasi3iNBgjjknhMCc3xX4NZS+npIUZ6zU8915twFS5KinTyj7PGAqnTEqkEa47cGAQSmiM/Qc8Z312E0Rh93wxBAlMwWtgrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coIpBfJv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coIpBfJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748011863; x=1779547863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iQNEWUeLCB352bTu3ok5V6qZW15EZquP6l1y9wrUrVo=;
  b=coIpBfJvctMCMq5+iXjDJRytoCizoIrpgBbqnYRlUHJ4++nxUq+sBKrK
   oh4nd5uPcN3IYI+LT1P6hZFNOHdJe5xb/ISb7l4ggIBcbcRi5SgSzlXG6
   wmaVvIVB082zR9liwTA3d1G/q3J/GPVD1J0mmkoCeB+0+y0rTTrShEtdr
   dpGIl1FSeT7Aivtkna6VYV0hTA4ANzyfQ8jdWFIvlODN4xxC59t4ePFzw
   NdWiFXYZSkb4X5kbcwdHi7zxU/NmfNqJUfjFvqYnH/kknpsqVgrQz1cGr
   f4nEeriiKQXhCqJ7VjnAjSOdgBqnogQOS0sVlGdSFediaB6Q253hm1YmD
   w==;
X-CSE-ConnectionGUID: 9kPrQ/4MRR6yvBdOqM9Dnw==
X-CSE-MsgGUID: qc0sEfCvTa2iyS56BNtyLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61475178"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61475178"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 07:51:02 -0700
X-CSE-ConnectionGUID: cot97aG8Sl6Sk3nzhwRTlw==
X-CSE-MsgGUID: jH6Cx1IFTq2CHlSbh3IE8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="164414225"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 07:51:01 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id CAA1D20B5736;
	Fri, 23 May 2025 07:50:57 -0700 (PDT)
Message-ID: <c56c9e23-cf6e-4040-aee8-da13d5157dcf@linux.intel.com>
Date: Fri, 23 May 2025 10:50:56 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf sort: Use perf_env to set arch sort keys and
 header
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>,
 Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming
 <matt@readmodwrite.com>, Chun-Tse Shao <ctshao@google.com>,
 Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250521135500.677508-1-irogers@google.com>
 <20250521135500.677508-4-irogers@google.com>
 <3e8b674e-38f7-4212-923d-f53626de69f2@linux.intel.com>
 <CAP-5=fX5q7rDgBdB+cMH6fTyHBBPyiac7tuv9WJOMcg9OFdq5g@mail.gmail.com>
 <9aa2c899-80e0-4626-acb7-5331fbf46a0d@linux.intel.com>
 <CAP-5=fW4brQZQ-tMDj+N9MnddRVZidi4L5uSw1mvv_9OD_vOSA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW4brQZQ-tMDj+N9MnddRVZidi4L5uSw1mvv_9OD_vOSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-05-21 3:19 p.m., Ian Rogers wrote:
> On Wed, May 21, 2025 at 11:14 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2025-05-21 12:16 p.m., Ian Rogers wrote:
>>>>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>>>>> index 7b6cde87d2af..13ef0d188a96 100644
>>>>> --- a/tools/perf/builtin-top.c
>>>>> +++ b/tools/perf/builtin-top.c
>>>>> @@ -1747,7 +1747,14 @@ int cmd_top(int argc, const char **argv)
>>>>>
>>>>>       setup_browser(false);
>>>>>
>>>>> -     if (setup_sorting(top.evlist) < 0) {
>>>>> +     top.session = perf_session__new(/*data=*/NULL, /*tool=*/NULL);
>>>>> +     if (IS_ERR(top.session)) {
>>>>> +             status = PTR_ERR(top.session);
>>>>> +             top.session = NULL;
>>>>> +             goto out_delete_evlist;
>>>>> +     }
>>>>> +
>>>>> +     if (setup_sorting(top.evlist, &top.session->header.env) < 0) {
>>>> I doubt a valide env can be got in perf_session__new(), since there is
>>>> no perf.data in perf top.
>>>> Maybe just need to invoke the perf_env__raw_arch() instead to fill the
>>>> env->arch.
>>> I think the current code is making things harder than it should be, we
>>> should work away from perf_env__arch and strings, instead using EM_
>>> values which we can default to EM_HOST avoiding any runtime costs.
>>> Looking at perf_env__arch:
>>> ```
>>> const char *perf_env__arch(struct perf_env *env)
>>> {
>>>         char *arch_name;
>>>
>>>         if (!env || !env->arch) { /* Assume local operation */
>>>                 static struct utsname uts = { .machine[0] = '\0', };
>>>                 if (uts.machine[0] == '\0' && uname(&uts) < 0)
>>>                         return NULL;
>>>                 arch_name = uts.machine;
>>>         } else
>>>                 arch_name = env->arch;
>>>
>>>         return normalize_arch(arch_name);
>>> }
>>> ```
>>> in this case env->arch == NULL and so the uname machine will be used.
>>> For perf_env__raw_arch the behavior is similar but it populates the
>>> env:
>>> ```
>>> static int perf_env__read_arch(struct perf_env *env)
>>> {
>>>         struct utsname uts;
>>>
>>>         if (env->arch)
>>>                 return 0;
>>>
>>>         if (!uname(&uts))
>>>                 env->arch = strdup(uts.machine);
>>>
>>>         return env->arch ? 0 : -ENOMEM;
>>> }
>>>
>>> const char *perf_env__raw_arch(struct perf_env *env)
>>> {
>>>         return env && !perf_env__read_arch(env) ? env->arch : "unknown";
>>> }
>>> ```
>>> Aside from caching the arch, the main difference is that
>>> normalize_arch isn't called. Not having normalize_arch means the code
>>> in arch_support_sort_key and arch_perf_header_entry would need to
>>> handle strings "ppc" as well as "powerpc", "i386" as well as "x86",
>>> etc. As I'd prefer not handle all those cases I think the way the code
>>> is is best given how the env code is currently structured.
>>
>> Right. The perf_env__raw_arch() doesn't improve anything.
>> But I still don't like &top.session->header.env.
>> Because I don't think you can get any useful information from
>> top.session->header.env. It just brings confusions. (It seems an env is
>> retrieved, but it is actually not.)
> 
> Well there's a certain consistency in using the session env to set up
> the sorting, etc. This pre-exists this change with nearly every
> builtin-* file doing `symbol__init(&session->header.env);`. perf top
> does `symbol__init(NULL);`:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-top.c?h=perf-tools-next#n1811
> but the code now has lazy initialization patterns and handling NULL as
> a special case of meaning host machine:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/symbol.c?h=perf-tools-next#n2350
> 
>> In the perf top, &perf_env is used for the existing cases. If any env
>> fields are not available, perf_env__read_XXX() is invoked to get the
>> information.
>> I think we may follow the existing usage, e.g.,
>> setup_sorting(top.evlist, &perf_env).
> 
> So using the global perf_env rather than NULL feels preferable but I
> think the global perf_env should be deleted. Whenever I see the global
> perf_env in use I think the code has a bug as the perf_env should be
> coming from the session or the machine. The global perf_env can have
> no meaning for cases like `perf diff` where more than one
> file/header/env is open at a time. The global perf_env variable's
> existence encourages bad or broken code, so deleting it should avoid
> errors in code. Another place these issues can occur is with TPEBS
> where we're maintaining multiple sessions for sampling alongside
> counting.
> 
>> Alternatively, it looks like the perf top doesn't support --weight. The
>> env->arch should never be used. If so, a NULL can be used as well, E.g.,
>> setup_sorting(top.evlist, NULL).
> 
> So I don't like NULL because then we have lazy initialization of host
> data and NULL meaning use host. I don't like the global perf_env
> variable as it has a code smell about it. I think moving the session
> initialization earlier in perf top so its env, although unpopulated,
> can be used is consistent with `perf report` - this is consistent with
> `perf top` being `perf record` glued together with `perf report`. So I
> think the change here is the smallest and most sensible.
> 
> Longer term let's delete the global perf_env variable,  perf_env__arch
> should be switched to a perf_env__e_machine as then we can avoid uname
> calls just to determine the machine architecture, etc.
> 

I'm fine with the session's env, as long as there is a consistent env
source in the perf top. Because in the recent perf top fixes, we
randomly pick the env source. Thomas's patch used the global env, but
this one chose the session's env. It brings confusions.
https://lore.kernel.org/lkml/20250513231813.13846-2-thomas.falcon@intel.com/

Could you please send a clean up patch to address the inconsistency?

Thanks,
Kan

