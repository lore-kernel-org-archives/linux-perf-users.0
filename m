Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736C1C1AC7
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690536; cv=none; b=TTGnHML5A4cP4qyRSi5brs8bowhjJju1AZwqamfuPpkPsXo4dEedwJGpny0Hvg/pdXeoElKReg7yiOeLgaf8yRI4H3lLYWk6HeBgAck68ivmYVlW11W9AsqDposeZmM3NiJv9hdXvTXzKK4y6k/1xZLAP9L5Hv9EaQS0dxF/aDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690536; c=relaxed/simple;
	bh=Ha61I876TblLYFDhHqA5vVHscdFniq6vVqA1oU4/wis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBdaVbfO4DAbcRrvx1UR0oFD4nhyUg6HYc8bJWapc7o0dPAtzipbepVCcrgN/3oAJLeqMgZkE41Kx/f7PTFH9Jlgml+sNq5vCT8a6mzGx80VZFwk7OI/umSv4v/mAGs6kNqGYXPJD46welvyMFISiCJ0L+NrZBeboVibohomFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InWdSF5u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InWdSF5u"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso17584675e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734690532; x=1735295332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hv9izHYh4yds6qMPpg6uy9/eWSJVpqOvDJb2R797EWs=;
        b=InWdSF5uLZ0ZTsUUefIfsWN5JqtngSBmj6MpEHpU9AwKZ59al+yx2vLKC25P6Tmuh8
         CC9W2SPufXeTKlkNoBheeUdSfxc44nvZdxhQIbW9WvfH40NAnVGYJtw1gXSf6tPAFZAl
         b2ZMg0vuOoarn+joeuDXqnIJ8A3weXrlRLF0YitA/P7pZa7DWsCbdnZtdizsVPOfvY0x
         XTN0KYecrEp0+tm69zohyUQchmt7k5QSEdu/3lcbDacrLjpDP/sE+7QejMEzDbICMMJ4
         ltVWxTjESzmsl6hytBsmQJBikUf4fjNbnhR/lkh3IdpxCvOxNhkRq+JiwRmauNC92JMw
         BLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734690532; x=1735295332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv9izHYh4yds6qMPpg6uy9/eWSJVpqOvDJb2R797EWs=;
        b=DiT58VOhNYxdv5lA/FezIl50I7bL7hUVXHo0tYI7cg/0tr9mb2ML/8TWOrh7TUEzGf
         kHzJ/tKzmh21wixSDlEKxG9S17Kpph3Rhixl1srxJn6GnssX75hSSwGIxx80y9rj93+e
         mwtystBUJH+BQba+edygNryqlIb5ezjxRZ40a2nkNtBgE+w4BM2cOXc5bOjh/dzSwxBf
         XUHWLCjB//TZHDa2CeU6ADc+GlV3b4EWhEba+s1Od2pLnT+2p9Y+U1vE10NtQYTC9m00
         32EoNomSi/s5yhFmbxy7t4QklDE+n6o4tYbtgkHKkzKpPLFFbOewO/QjFDokTZM6dn67
         nhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGaWyI1Qa+9WEPVvNeWPIACr8T3/uDwFD3PblqWQy+WEz32nh9bB/l2SH+Hv7RVgqYrKi6BPvQ9V9YqIUNB9ZB@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoj0/hX81Z+kexDIgOwnPW9bYATjrDxIdvALHguAGFHxbQJ2j
	gde3rkffGQ216sFRTa+GtN3WyXwz+m+GynkzzEl3Jy0W7uD94ny+XRLVNtJRULo=
X-Gm-Gg: ASbGncu+FwgC0GjLXCK3V4MNkv1eYogYjnNgHkT3HsJFBQQPuS0ttemWmTzjJ5iL2iW
	6BP2A+LgyU1OsTiKArPHxFg2aDnWiJ1PmQVIGXGpZ7yKdSvBKV4EwZ1xI9Mh5TamdW3xY+L8CLn
	Vh+FW0vYHGxRFsG2KY445EMx/FVC1DcE0eBpp7jE3fasrnSxGb2GJaMInQl3oUAkL+qVcRJBjYI
	Uy8dwjrwx/BpIYYxCXd3kmZUFgjhFn3Nsgxie/KTrjQ+dpHH9Acf5mS+Kt1gWI6ZTs=
X-Google-Smtp-Source: AGHT+IF5UBB+5OOkN4l8dyULOH6puPv4/rHuHl9sToLZCBoL/0c38q6rWWBuxPS2+j6QY6qW6Df8EQ==
X-Received: by 2002:a5d:6d8b:0:b0:386:3356:f3ac with SMTP id ffacd0b85a97d-38a221f2dedmr2344425f8f.26.1734690532292;
        Fri, 20 Dec 2024 02:28:52 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6e19sm3684931f8f.100.2024.12.20.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 02:28:51 -0800 (PST)
Message-ID: <462b0262-305b-4ed2-9c1c-2afeaec8646e@linaro.org>
Date: Fri, 20 Dec 2024 10:28:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] perf cpumap: If the die_id is missing use
 socket/physical_package_id
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>,
 Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241216232459.427642-1-irogers@google.com>
 <20241216232459.427642-2-irogers@google.com>
 <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org>
 <CAP-5=fVeW+XARtWtdR=XX47w-ZznKiGdhxDBy=Le_QTS=R6SQA@mail.gmail.com>
 <Z2Ov2Gy99KOtctPT@google.com>
 <CAP-5=fUUUZcE8D3q3iNkrym=9g6UQxgfDihC24+1J879fj4kww@mail.gmail.com>
 <Z2SV2A9C6V65YL3x@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z2SV2A9C6V65YL3x@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/12/2024 9:53 pm, Namhyung Kim wrote:
> On Thu, Dec 19, 2024 at 09:20:39AM -0800, Ian Rogers wrote:
>> On Wed, Dec 18, 2024 at 9:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>
>>> On Wed, Dec 18, 2024 at 09:42:27AM -0800, Ian Rogers wrote:
>>>> On Wed, Dec 18, 2024 at 4:04 AM James Clark <james.clark@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 16/12/2024 11:24 pm, Ian Rogers wrote:
>>>>>> An error value for a missing die_id may be written into things like
>>>>>> the cpu_topology_map. As the topology needs to be fully written out,
>>>>>> including the die_id, to allow perf.data file features to be aligned
>>>>>> we can't allow error values to be written out. Instead base the
>>>>>> missing die_id value off of the socket/physical_package_id assuming
>>>>>> they correlate 1:1.
>>>>>>
>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>>> ---
>>>>>>    tools/perf/util/cpumap.c | 3 ++-
>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>>>>>> index 27094211edd8..d362272f8466 100644
>>>>>> --- a/tools/perf/util/cpumap.c
>>>>>> +++ b/tools/perf/util/cpumap.c
>>>>>> @@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
>>>>>>    {
>>>>>>        int value, ret = cpu__get_topology_int(cpu.cpu, "die_id", &value);
>>>>>>
>>>>>> -     return ret ?: value;
>>>>>> +        /* If die_id is missing fallback on using the socket/physical_package_id. */
>>>>>> +     return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
>>>>>>    }
>>>>>>
>>>>>>    struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
>>>>>
>>>>> Hi Ian,
>>>>>
>>>>> I sent a fix for the same or a similar problem here [1]. For this one
>>>>> I'm not sure why we'd want to use the socket ID for die when it's always
>>>>> been 0 for not present. I wonder if this change is mingling two things:
>>>>> fixing the negative error value appearing and replacing die with socket ID.
>>>>>
>>>>> Personally I would prefer to keep the 0 to fix the error value, that way
>>>>> nobody gets surprised by the change.
>>>>>
>>>>> Also it looks like cpu__get_cluster_id() can suffer from the same issue,
>>>>> and if we do it this way we should drop these as they aren't valid anymore:
>>>>>
>>>>>          /* There is no die_id on legacy system. */
>>>>>          if (die < 0)
>>>>>                  die = 0;
>>>>
>>>> I think this breaks the assumption here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/expr.c?h=perf-tools-next#n244
 >>>>>> Hmm.. I'm not sure how it worked before.  The code is already 
there and
>>> it just changed the condition from == -1 to < 0, right?
>>
>> You'd need to be testing on a multi-socket machine to see the issue.
>> If you had say a dual socket Ampere chip and the die_id was missing,
>> does it make sense for there to be two sockets/packages but only 1
>> die? I think it is best we assume 1 die per socket when the die_id is
>> missing, and to some crippled extent (because of the s390 workaround)
>> the expr test is doing the sanity check.
> 
> AFAICS die ID is always used with socket ID already so I guess it means
> an ID inside a socket.
> 
> Thanks,
> Namhyung
> 

Don't we then need to update has_die_topology() to always return true if 
we're using socket ID as a placeholder? And the #num_dies expression 
should potentially become non-zero for consistency?

Seems like there are two options:

  - Fully support "no die reported"
   * -errno is saved into the topology header, but it's still converted
     to 0 for Perf stat aggregation and display
   * #num_dies == 0 as it currently is
   * Anywhere else die is used it's checked for error values first

  - Replace die with package
    * #num_dies == #num_packages
    * has_die_topology() == true
    * delete code to display die as 0 in perf stat

With this patch we get somewhere between the two.

Thanks
James

