Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A51527AA;
	Thu,  6 Jun 2024 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666959; cv=none; b=faXbVG7Q+WipZPAtiKasMEBRo/hyKcvajYJaVGRQi8yiDOMOc74gQjOfEh6AOp8g63SXddIQK2GUXPUxcjV5UbeKyDlZfJcP/nTIo3bZQOItdNqC8UWJcl2q8nJa3JshfcyxEZgZ0hMgs6TLCvVo8ww4gTkBk8t59/B3mkJ4M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666959; c=relaxed/simple;
	bh=WfZOLSDl+Ni7nETLkrLA9ZjhM4icZcFITRF4meVlCdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD73ViVQBtYR+AMGbvm+EsVDTFnquNQ0bhV9MWck300GYMYHJdTkxuY+em1z9xbbWr58hpEuC7lbgq3TaA7avzOqXZ1NsQ9DMHeZSCFkuT4GOxFesknXaGnSeQoubjjXa+68W84lJev3zCcq3Y2i1zNq23iUZeUQnSDzTQ+zGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17757339;
	Thu,  6 Jun 2024 02:43:01 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2743F762;
	Thu,  6 Jun 2024 02:42:34 -0700 (PDT)
Message-ID: <f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com>
Date: Thu, 6 Jun 2024 10:42:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527105842.GB33806@debian-dev>
 <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
 <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
 <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
 <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
 <ZlkC_Tm6kKIL3Phc@google.com>
 <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
 <CAP-5=fUq6jLCtjPNb0gngtR0cXopG+-mJ-+CnEOAXeG7VShh8A@mail.gmail.com>
 <CAM9d7cjPe68PMb1hnbypMOQUQOybpisdqH3eTH1B9G-KG5rKXw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cjPe68PMb1hnbypMOQUQOybpisdqH3eTH1B9G-KG5rKXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/06/2024 08:09, Namhyung Kim wrote:
> On Wed, Jun 5, 2024 at 4:02 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Jun 5, 2024 at 1:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>
>>> On Thu, May 30, 2024 at 3:52 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> On Thu, May 30, 2024 at 06:46:08AM -0700, Ian Rogers wrote:
>>>>> On Thu, May 30, 2024 at 5:48 AM James Clark <james.clark@arm.com> wrote:
>>>>>>
>>>>>> On 30/05/2024 06:35, Namhyung Kim wrote:
>>>>>>> It might not be a perfect solution but it could be a simple one.
>>>>>>> Ideally I think it'd be nice if the kernel exports more information
>>>>>>> about the PMUs like sampling and exclude capabilities.
>>>>>>>> Thanks,
>>>>>>> Namhyung
>>>>>>
>>>>>> That seems like a much better suggestion. Especially with the ever
>>>>>> expanding retry/fallback mechanism that can never really take into
>>>>>> account every combination of event attributes that can fail.
>>>>>
>>>>> I think this approach can work but we may break PMUs.
>>>>>
>>>>> Rather than use `is_core` on `struct pmu` we could have say a
>>>>> `supports_sampling` and we pass to parse_events an option to exclude
>>>>> any PMU that doesn't have that flag. Now obviously more than just core
>>>>> PMUs support sampling. All software PMUs, tracepoints, probes. We have
>>>>> an imprecise list of these in perf_pmu__is_software. So we can set
>>>>> supports_sampling for perf_pmu__is_software and is_core.
>>>>
>>>> Yep, we can do that if the kernel provides the info.  But before that
>>>> I think it's practical to skip uncore PMUs and hope other PMUs don't
>>>> have event aliases clashing with the legacy names. :)
>>>>
>>>>>
>>>>> I think the problem comes for things like the AMD IBS PMUs, intel_bts
>>>>> and intel_pt. Often these only support sampling but aren't core. There
>>>>> may be IBM S390 PMUs or other vendor PMUs that are similar. If we can
>>>>> make a list of all these PMU names then we can use that to set
>>>>> supports_sampling and not break event parsing for these PMUs.
>>>>>
>>>>> The name list sounds somewhat impractical, let's say we lazily compute
>>>>> the supports_sampling on a PMU. We need the sampling equivalent of
>>>>> is_event_supported:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/print-events.c?h=perf-tools-next#n242
>>>>> is_event_supported has had bugs, look at the exclude_guest workaround
>>>>> for Apple PMUs. It also isn't clear to me how we choose the event
>>>>> config that we're going to probe to determine whether sampling works.
>>>>> The perf_event_open may reject the test because of a bad config and
>>>>> not because sampling isn't supported.
>>>>>
>>>>> So I think we can make the approach work if we had either:
>>>>> 1) a list of PMUs that support sampling,
>>>>> 2) a reliable "is_sampling_supported" test.
>>>>>
>>>>> I'm not sure of the advantages of doing (2) rather than just creating
>>>>> the set of evsels and ignoring those that fail to open. Ignoring
>>>>> evsels that fail to open seems more unlikely to break anything as the
>>>>> user is giving the events/config values for the PMUs they care about.
>>>>
>>>> Yep, that's also possible.  I'm ok if you want to go that direction.
>>>
>>> Hmm.. I thought about this again.  But it can be a problem if we ignore
>>> any failures as it can be a real error due to other reason - e.g. not
>>> supported configuration or other user mistakes.
>>
>> Right, we have two not good choices:
>>
>> 1) Try to detect whether sampling is supported, but any test doing
>> this needs to guess at a configuration and we'll need to deflake this
>> on off platforms like those that don't allow things like exclude
>> guest.
> 
> I believe we don't need to try so hard to detect if sampling is
> supported or not.  I hope we will eventually add that to the
> kernel.  Also this is just an additional defense line, it should
> work without it in most cases.  It'll just protect from a few edge
> cases like uncore PMUs having events of legacy name.  For
> other events or PMUs, I think it's ok to fail.
> 
> 
>> 2) Ignore failures, possibly hiding user errors.
>>
>> I would prefer for (2) the errors were pr_err rather than pr_debug,
>> something the user can clean up by getting rid of warned about PMUs.
>> This will avoid hiding the error, but then on Neoverse cycles will
>> warn about the arm_dsu PMU's cycles event for exactly Linus' test
>> case. My understanding is that this is deemed a regression, hence
>> Arnaldo proposing pr_debug to hide it.
> 
> Right, if we use pr_err() then users will complain.  If we use
> pr_debug() then errors will be hidden silently.
> 
> Thanks,
> Namhyung

I'm not sure if anyone would really complain about warnings for
attempting to open but not succeeding, as long as the event that they
really wanted is there. I'm imagining output like this:

  $ perf record -e cycles -- ls

  Warning: skipped arm_dsu/cycles/ event(s), recording on
    armv8_pmuv3_0/cycles/, armv8_pmuv3_1/cycles/

  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.008 MB perf.data (30 samples) ]

You only really need to worry when no events can be opened, but
presumably that was a warning anyway.

And in stat mode I wouldn't expect any warnings.
