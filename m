Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE214D280;
	Tue, 23 Jul 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727520; cv=none; b=oxi1l7BARedTddb5qWi6m+W+liL9bXWArKaIiKpUHCeRFhkh1fwtz9pkGPtubpv+CT0/T7tOvBemBmyOPWZwbqbRGAShL1FsMbs30FSO5YObYsDmetRAkl4MfpqFentqOBueVtrG1DHhc4aF4+bV7e8msQlxUeZzBsPuRVcHb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727520; c=relaxed/simple;
	bh=tTaCjEsKqRpzcHF+EyOIq9OzbUjorqzZxzkrSqU2dz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aasEl2YVCZCW8PhuDkE0195G4ASVicjcnIDpIXiIPTX77Ac2OqMvdUYWaFldTD7QHD7ohBPqlRnIcgxJ4IHdL0GdjstJZqTmwD+4k0FInQvfVlN1ub+1K6jlHRq403QmVdJbGjVFBP8xzQLWdCRD3pnNyOE/s6MaijXIHotRjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zao6tOSY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zao6tOSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721727518; x=1753263518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tTaCjEsKqRpzcHF+EyOIq9OzbUjorqzZxzkrSqU2dz8=;
  b=Zao6tOSYpVsa0KRxNduYLETeV9WqpSt8utjuUDTzlxgsExpB8P5pPN5u
   4DOEf0fkD/WPEHv+eHeYyZifreBDHgbuCjxmxwcmZUN4kHShQLEbs+iph
   zvvW6VcmBS41bFf19LreyUbVgosBnXrhOxcbp7tU+WNIUW5Ey9GucdQIx
   4tSi1yGJ4inmbRLfTkNQlmONSWSt9ITX2pDo9xZAs5ZUfovS5ayCDXg9a
   QwXzcFhFqbLIVaMrX2KiXerTuJsWOgevcXWoo0sm3Mb++Af+vKhcARWX9
   FGrJjVVVf+7LLq5khq92LFKYNIaTbKCVrBi7Cn4hKCdFc5CcNz9w3PBis
   Q==;
X-CSE-ConnectionGUID: bg3l6NvER6e0XAn4+JIbgA==
X-CSE-MsgGUID: gujjYWv0Twa2wPYoUgtWKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="12664229"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="12664229"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 02:38:37 -0700
X-CSE-ConnectionGUID: R8uSE1D3SFSnfG/uRIwByQ==
X-CSE-MsgGUID: PiTE7INaRpCepkEeiegFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="56732595"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 02:38:30 -0700
Message-ID: <5444c426-a4be-4b85-b9d4-65aac78115be@intel.com>
Date: Tue, 23 Jul 2024 12:38:24 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Nick Terrell <terrelln@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240718010023.1495687-1-irogers@google.com>
 <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
 <05fa0449-4fd4-41ed-93e8-db825e48268f@intel.com>
 <CAP-5=fU9riOR7onxCE3a2xOs_bVdQdTSkAHD5QLb=SO6SCzkzQ@mail.gmail.com>
 <CAM9d7cjbi_P+V=QkLFg6OuEJqmCOsOoDBddQbyhMYD3aF8do4g@mail.gmail.com>
 <CAP-5=fXd3t4pXKU7hVDRZp5DnRbZpJRp9zO3ia8cwbRSROKMRQ@mail.gmail.com>
 <CAP-5=fW4LmOMo6fD9d9Ymc9stDttxQv-Pjg-=Xeq41-LGumwSA@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fW4LmOMo6fD9d9Ymc9stDttxQv-Pjg-=Xeq41-LGumwSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/07/24 21:04, Ian Rogers wrote:
> On Mon, Jul 22, 2024 at 10:50 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Mon, Jul 22, 2024 at 10:45 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>>
>>> Hi,
>>>
>>> On Mon, Jul 22, 2024 at 9:06 AM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> On Mon, Jul 22, 2024 at 1:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>
>>>>> On 19/07/24 19:26, Ian Rogers wrote:
>>>>>> On Fri, Jul 19, 2024 at 1:51 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>
>>>>>>> On 18/07/24 03:59, Ian Rogers wrote:
>>>>>>>> struct perf_tool provides a set of function pointers that are called
>>>>>>>> through when processing perf data. To make filling the pointers less
>>>>>>>> cumbersome, if they are NULL perf_tools__fill_defaults will add
>>>>>>>> default do nothing implementations.
>>>>>>>>
>>>>>>>> This change refactors struct perf_tool to have an init function that
>>>>>>>> provides the default implementation. The special use of NULL and
>>>>>>>> perf_tools__fill_defaults are removed. As a consequence the tool
>>>>>>>> pointers can then all be made const, which better reflects the
>>>>>>>> behavior a particular perf command would expect of the tool and to
>>>>>>>> some extent can reduce the cognitive load on someone working on a
>>>>>>>> command.
>>>>>>>>
>>>>>>>> v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
>>>>>>>
>>>>>>> The tags were really meant only for patch 1, the email that was replied to.
>>>>>>>
>>>>>>> But now for patches 2 and 3:
>>>>>>>
>>>>>>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>>
>>>>>> Sorry for that, you'd mentioned that pt and bts testing which is
>>>>>> impacted by more than just patch 1.
>>>>>>
>>>>>>> Looking at patches 4 to 25, they do not seem to offer any benefit.
>>>>>>>
>>>>>>> Instead of patch 26, presumably perf_tool__fill_defaults() could
>>>>>>> be moved to __perf_session__new(), which perhaps would allow
>>>>>>> patch 27 as it is.
>>>>>>
>>>>>> What I'm trying to do in the series is make it so that the tool isn't
>>>>>> mutated during its use by session. Ideally we'd be passing a const
>>>>>> tool to session_new, that's not possible because there's a hack to fix
>>>>>> ordered events and pipe mode in session__new:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/session.c?h=perf-tools-next#n275
>>>>>> Imo, it isn't great to pass a tool to session__new where you say you
>>>>>> want ordered events and then session just goes to change that for you.
>>>>>> Altering that behavior was beyond the scope of this clean up, so tool
>>>>>> is only const after session__new.
>>>>>
>>>>> Seems like a separate issue.  Since the session is created
>>>>> by __perf_session__new(), session->tool will always be a pointer
>>>>> to a const tool once there is:
>>>>>
>>>>> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>>>>> index 7f69baeae7fb..7c8dd6956330 100644
>>>>> --- a/tools/perf/util/session.h
>>>>> +++ b/tools/perf/util/session.h
>>>>> @@ -43,7 +43,7 @@ struct perf_session {
>>>>>         u64                     one_mmap_offset;
>>>>>         struct ordered_events   ordered_events;
>>>>>         struct perf_data        *data;
>>>>> -       struct perf_tool        *tool;
>>>>> +       const struct perf_tool  *tool;
>>>>>         u64                     bytes_transferred;
>>>>>         u64                     bytes_compressed;
>>>>>         struct zstd_data        zstd_data;
>>>>
>>>> That's the case after these changes, but not before.
>>>>
>>>>>>
>>>>>> The reason for doing this is to make it so that when I have a tool I
>>>>>> can reason that nobody is doing things to change it under my feet.
>>>>>
>>>>> It still can be changed by the caller of __perf_session__new(), since
>>>>> the tool itself is not const.
>>>>>
>>>>> Anything using container_of() like:
>>>>>
>>>>> static int process_sample_event(const struct perf_tool *tool,
>>>>>                                 union perf_event *event,
>>>>>                                 struct perf_sample *sample,
>>>>>                                 struct evsel *evsel,
>>>>>                                 struct machine *machine)
>>>>> {
>>>>>         struct perf_script *scr = container_of(tool, struct perf_script, tool);
>>>>>
>>>>> can then change scr->tool without even having to cast away const.
>>>>
>>>> Agreed, but such things happen in builtin_cmd where the tool is
>>>> defined and presumably they know what they are doing. My objection is
>>>> to code in util mutating the tool as I want the tool to have
>>>> predictable behavior. As callers that take a tool can call fill in
>>>> defaults (not all) then the tool has to be mutable and I don't want
>>>> this to be the case.
>>>>
>>>>> Really, 'tool' needs to be defined as const in the first place.
>>>>
>>>> I'd like this. The problem is initializing all the function pointers
>>>> and making such initialization robust to extra functions being added
>>>> to the tool API. It can be done in a long winded way but I couldn't
>>>> devise macro magic to do it. The other problem is around variables
>>>> like ordered_events that can't currently be const. The patches move us
>>>> closer to this being a possibility.
>>>>
>>>>>> My
>>>>>> builtin_cmd is in charge of what the tool is rather than some code
>>>>>> buried in util that thought it was going to do me a favor. The code is
>>>>>> a refactor and so the benefit is intended to be for the developer and
>>>>>> how they reason about the use of tool.
>>>>>
>>>>> It creates another question though: since there is a lot of code
>>>>> before perf_tool__init() is called, does the caller mistakenly
>>>>> change tool before calling perf_tool__init()
>>>>
>>>> If they do this their function pointers will be clobbered and their
>>>> code won't behave as expected, which I'd expect to be easy to observe.
>>>> In C++ if you were to initialize memory and then use the memory for a
>>>> placement new to create an object which would call the constructor,
>>>> the expected behavior would be that the initialized memory's values
>>>> would get overridden. I see the use of _init and _exit in the code as
>>>> being our poor man replacements of constructors and destructors.
>>>>
>>>>>> how they reason about the use of tool. We generally use _init
>>>>>> functions rather than having _fill_defaults, so there is a consistency
>>>>>> argument.
>>>>>
>>>>> The caller does not need the "defaults", so why would it set them up.
>>>>> The session could just as easily do:
>>>>>
>>>>>         if (tool->cb)
>>>>>                 tool->cb(...);
>>>>>         else
>>>>>                 cb_stub(...);
>>>>
>>>> Multiplied by every stub, we'd probably need a helper function, how to
>>>> handle argument passing. There's nothing wrong with this as an idea
>>>> but I think of this code as trying to create a visitor pattern and
>>>> this is a visitor pattern with a hard time for the caller.
>>>>
>>>>>> I don't expect any impact in terms of performance... Moving
>>>>>> perf_tool__fill_defaults to __perf_session__new had issues with the
>>>>>> existing code where NULL would be written over a function pointer
>>>>>> expecting the later fill_defaults to fix it up, doesn't address coding
>>>>>> consistency where _init is the norm, and adds another reason the tool
>>>>>> passed to session__new can't be const.
>>>>>
>>>>> perf_tool__init() is not a steeping stone to making 'tool' a
>>>>> const in the first place.
>>>>
>>>> It is because the patch series gets rid of fill in defaults which is
>>>> why we have a mutable tool passed around. I don't think this is up for
>>>> debate as the patch series clearly goes from a non-const
>>>> tool to a const tool at the end. Changing perf_tool__init to make all
>>>> the function pointers NULL and then making every caller have to do a:
>>>>
>>>>          if (tool->cb)
>>>>                  tool->cb(...);
>>>>          else
>>>>                  cb_stub(...);
>>>>
>>>> I think it is a less elegant solution at the end, it is also a large
>>>> and more invasive change. The various refactorings to make tool const,
>>>> changing the aux use of tool, etc. wouldn't be impacted by such a
>>>> change but I think it is out of scope for this patch series.
>>>
>>> I don't think it's a large and invasive change.  The tools are mostly
>>> zero-initialized so we don't need to reset to NULL.  And tool->cb is
>>> called mostly from two functions: machines__deliver_event() and
>>> perf_session__process_user_event().  Can we change them to check
>>> NULL and get rid of perf_tool__fill_defaults() to keep it const?
>>
>> As I said above, I don't think that is good style and is out of scope
>> here. It clearly can be done as follow up, but I don't see how that
>> fixes the style issue.
> 
> Just to be clear on what the style issue is. We already have code:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-record.c?h=perf-tools-next#n1461
> ```
> if (rec->buildid_all && !rec->timestamp_boundary)
>     rec->tool.sample = NULL;
> ```
> that relies on the special behavior of NULL in a function pointer
> being changed at dispatch time - a simple reading of that code would
> be anyone calling the function pointer would get a segv. I'm trying to
> make it so that NULL isn't magic in the context of tool and you can
> simply look at the tool to understand what its behavior is, much as a
> virtual method table would work if we could do proper object-oriented
> development.

In C, NULL or zero is often used as a special value to mean
no-value.  Optional callbacks that are NULL is also not remarkable.

