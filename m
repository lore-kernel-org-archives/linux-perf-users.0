Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0D1624CE;
	Wed, 21 May 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851241; cv=none; b=A57zbdUsGih218/w2TywuS0zGkB/3J3FWhBpGd50K4PVkciv4Pi3o7tj57Xtx+OliJ/V3oJJpn5lXm+97L7wrpCUc2NJ/PvdYLfCBwA9RGaHJVzZsl+TZCuS25sSTv5UL+9b8dq5a/CPQFILhnQ2NXYlmZ+LJOHBFArfe6l+BTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851241; c=relaxed/simple;
	bh=IVRrr3bXX1aOFwL4/OoLF2L3j9b8aaTdFDzcimwf2uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5eAc9LZDuw+NR129WqHmQhlu7s4CEge7zkd81wt/nInwKW1jhvxFCD0g1geUB8gqBqrhL7xA4RUIAYHWKefMhFN0Ev6WmamkobQ3VwNIY2nW7PuuRYAqmw4G9ETsnHWrwxPYbUplo1PiPQjvb/L4hhOVPTiSVJKYLLxsINTl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJikY25a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJikY25a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747851240; x=1779387240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IVRrr3bXX1aOFwL4/OoLF2L3j9b8aaTdFDzcimwf2uE=;
  b=eJikY25a7SfCYfgFPIK3KmH7lPUJfAb/vb/p+qbSUaHeJi22znoeoX+8
   tryFYxti8mc0f4r5rFZQuQNwf3ZB4AjMmWRS3BEqLJkbraRaSP2eK09Dn
   RlOqeESo+JM0lxBzkhl33SI20kW+UsFadwwqGV7y5+omdEdPPFdVVQ3Kp
   NoKQSMR87sCxo2jzf/zsM9FvdYCsZ6f5Z9+RZ4WCjCrnL8Dknf2vyBc6Q
   mL9snSfRRoE0pC0YkcAHbyvTHzgn2FakQkhytFw2SiRxTNAsCwCoQjwSA
   sxrLCq3APKIYBeNAbHnjAkECePLmPgP8qbmlQGw2rSg4PjjCs38w/ey1/
   w==;
X-CSE-ConnectionGUID: 8gKRQ71TR9q6bTWHzF9Nqg==
X-CSE-MsgGUID: AQUxvczcQ9i1WS5UhFcEBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49550221"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49550221"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:13:59 -0700
X-CSE-ConnectionGUID: jNk7/eBMTU+K36IIfe3xfA==
X-CSE-MsgGUID: s6uLh/mXS6yj5C4PU+kURw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145453010"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:13:58 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9A5A020B5736;
	Wed, 21 May 2025 11:13:55 -0700 (PDT)
Message-ID: <9aa2c899-80e0-4626-acb7-5331fbf46a0d@linux.intel.com>
Date: Wed, 21 May 2025 14:13:54 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fX5q7rDgBdB+cMH6fTyHBBPyiac7tuv9WJOMcg9OFdq5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-21 12:16 p.m., Ian Rogers wrote:
>>> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>>> index 7b6cde87d2af..13ef0d188a96 100644
>>> --- a/tools/perf/builtin-top.c
>>> +++ b/tools/perf/builtin-top.c
>>> @@ -1747,7 +1747,14 @@ int cmd_top(int argc, const char **argv)
>>>
>>>       setup_browser(false);
>>>
>>> -     if (setup_sorting(top.evlist) < 0) {
>>> +     top.session = perf_session__new(/*data=*/NULL, /*tool=*/NULL);
>>> +     if (IS_ERR(top.session)) {
>>> +             status = PTR_ERR(top.session);
>>> +             top.session = NULL;
>>> +             goto out_delete_evlist;
>>> +     }
>>> +
>>> +     if (setup_sorting(top.evlist, &top.session->header.env) < 0) {
>> I doubt a valide env can be got in perf_session__new(), since there is
>> no perf.data in perf top.
>> Maybe just need to invoke the perf_env__raw_arch() instead to fill the
>> env->arch.
> I think the current code is making things harder than it should be, we
> should work away from perf_env__arch and strings, instead using EM_
> values which we can default to EM_HOST avoiding any runtime costs.
> Looking at perf_env__arch:
> ```
> const char *perf_env__arch(struct perf_env *env)
> {
>         char *arch_name;
> 
>         if (!env || !env->arch) { /* Assume local operation */
>                 static struct utsname uts = { .machine[0] = '\0', };
>                 if (uts.machine[0] == '\0' && uname(&uts) < 0)
>                         return NULL;
>                 arch_name = uts.machine;
>         } else
>                 arch_name = env->arch;
> 
>         return normalize_arch(arch_name);
> }
> ```
> in this case env->arch == NULL and so the uname machine will be used.
> For perf_env__raw_arch the behavior is similar but it populates the
> env:
> ```
> static int perf_env__read_arch(struct perf_env *env)
> {
>         struct utsname uts;
> 
>         if (env->arch)
>                 return 0;
> 
>         if (!uname(&uts))
>                 env->arch = strdup(uts.machine);
> 
>         return env->arch ? 0 : -ENOMEM;
> }
> 
> const char *perf_env__raw_arch(struct perf_env *env)
> {
>         return env && !perf_env__read_arch(env) ? env->arch : "unknown";
> }
> ```
> Aside from caching the arch, the main difference is that
> normalize_arch isn't called. Not having normalize_arch means the code
> in arch_support_sort_key and arch_perf_header_entry would need to
> handle strings "ppc" as well as "powerpc", "i386" as well as "x86",
> etc. As I'd prefer not handle all those cases I think the way the code
> is is best given how the env code is currently structured.

Right. The perf_env__raw_arch() doesn't improve anything.
But I still don't like &top.session->header.env.
Because I don't think you can get any useful information from
top.session->header.env. It just brings confusions. (It seems an env is
retrieved, but it is actually not.)

In the perf top, &perf_env is used for the existing cases. If any env
fields are not available, perf_env__read_XXX() is invoked to get the
information.
I think we may follow the existing usage, e.g.,
setup_sorting(top.evlist, &perf_env).

Alternatively, it looks like the perf top doesn't support --weight. The
env->arch should never be used. If so, a NULL can be used as well, E.g.,
setup_sorting(top.evlist, NULL).

Thanks,
Kan

