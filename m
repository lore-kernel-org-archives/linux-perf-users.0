Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2B21C16B
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357048; cv=none; b=X+BjX3X8w+AtBBk+J600TDxRX5+zTkRxci6HECYozEXHwLjCZvf0EdMIsgA9e960iQiQKuqiKvPNWkbbvWxY+60F6EfYBfZ9r8pAoOrj/H5sF3HWgi12OZo2cYbz6/aFlIHQ4vuyivMIbwMYcAjS+DsA9eSVSYX+9hpLnuFIiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357048; c=relaxed/simple;
	bh=qcmNYIDfA+pW4+IYn4jJnQES1wyn5oAU5tJlDI6SNI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA6mRZkfTnWoyEWEb3VemRwgEqdktrG11qus6bxjOqM1s6x6JB4U6JxTvKYstvrNsbv9NzVUZokzfrvOI/qk7TnmOmPzYaQTUeV47UrAPMhBjJbvagZ7byR+7UIq0WDNXS1jmhHFo4JWEardTT7+oaJ0AuVZSs5LpSP3+qHK2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=os8p1b9x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="os8p1b9x"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so14897945e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741357045; x=1741961845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPPfmGqMcw+FMxvKDCPOdbfmb7wwE6+oyjDmZFYMjSM=;
        b=os8p1b9xMhvK02wC2jNil7a5lA1r7LhTWX0DIafToCEryisEv3Qey+CT4t7I5OA40g
         WiogFBmpToSAiKI6G8/CGQIiUXpYH0Hr+Zk2nTc4OA9GJhxNh9GdGiyOecLCcGc/uKaV
         9H7B9HcmQv9a29X/pyau6F2Z1jYFWm2DoFK7o/RbT6UKHo/wp5+68fkaLY6gQSXVf+M/
         4a4YPieHlwo6tcvYy4c9nccWq8O1XAXIlI8SA9E4G4mTMZT/+BAWg1ik/rYPD5W4yfsF
         hW2nHEP/Jobj7xbHQzNooNV9XVhBbSV/Ik0wsL/s5mLGSfuXkN3W/YdDQH/kopn6RcBj
         jdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741357045; x=1741961845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPPfmGqMcw+FMxvKDCPOdbfmb7wwE6+oyjDmZFYMjSM=;
        b=nwF6Q3MWx7uJR14tSwg1vpRgro8dnGlNjaJ9AOtx97j/uITiuzsqpr3fHovAGweuXi
         8pMU6v8j5dJ08I4v+kAeixIbG2rq4NKygp7EecUVBFZonbLMfYBx8Jn2RQkXgYJmF2z7
         /TE54yyHjy9vPHhLnAk2Y2Bz+qYNStbSFbaZKVJA0o4ou/OdjpnBHV0TB4bQr+1WeE6R
         7G0A4AiKUeNWx0CLHA+z7RSgfeyKzmo/Kg3tVr7NVapCNHyCAaI4yYAlmx4x7Fm17tBi
         9FOFEjlkzjhpREb1dWu7J4ABEoiDUMWjxrAp0QddKxpLvuOTpwyat04omgzhE8xXyNfp
         VPQw==
X-Gm-Message-State: AOJu0YzzTWyAxhVRQskxWprdDwwxrKWS/x2hGuZo7hBUHrL5m30rItSz
	MnQ95QMJcL60uXN8GUEdwLHAh4HhdcR7xeQMefSBXnRZ//Py2T4V3NSB5WC+GDg=
X-Gm-Gg: ASbGncuyPBPmGewKYO17fgkGjNHO79BuzftDnyEFsC6sOE7CLHeWzH496ewjT5SUa53
	7o8At5dHQuUyJBAG0QsmWnNjrx1/M9JaIBmuvjMioG00SY1iew3rOLGAZS3oKiLnv9BzGPPsYDa
	BfLjqsMF1WX96nnEcQRNsXaCoSnIzLSbAhnDQjoVcV8P/cJKJG1byb83wD/iweMOSOcXztWRMMU
	W45KE3cfBMUdK3dafRFiTt18+naTq9ltpPahDiDaZpnTn44uC4CzLaCIIKdW8waeVbXZtjULpCI
	lFyByGGVs4m90eREiPciThwpdWuz1IQ4bhJTjnBFhjOmM7tAWTNyGA==
X-Google-Smtp-Source: AGHT+IHpoNeJ9Jwip1Cdx5uUKipi0qqCHgMLrkGZ0Er+W7OmX2RBd8j0bEQTdafbhn91KFoC0mlOmQ==
X-Received: by 2002:a05:600c:3b1e:b0:43b:c94d:e1e2 with SMTP id 5b1f17b1804b1-43c5a6355aamr22142215e9.25.1741357044717;
        Fri, 07 Mar 2025 06:17:24 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd831719sm55298865e9.0.2025.03.07.06.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:17:24 -0800 (PST)
Message-ID: <80432f35-e865-4186-8b92-26b25279e150@linaro.org>
Date: Fri, 7 Mar 2025 14:17:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] perf tools: About encodings of legacy event names
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>
References: <Z7Z5kv75BMML2A1q@google.com>
 <CAP-5=fVbti6efu6uA9a5os6xhnTuJ0egyesZsy0dmkiScwYFqQ@mail.gmail.com>
 <Z7yJ0Vpub6JeQyYo@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z7yJ0Vpub6JeQyYo@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2025 3:01 pm, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 19, 2025 at 10:37:33PM -0800, Ian Rogers wrote:
>> On Wed, Feb 19, 2025 at 4:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>> Ian and I have been discussing the behaviors of event encodings and it's
>>> hard to find a point so far that we can agree on.  So I'd like to hear
>>> your opinion to resolve this.  If you happen to have some time, you can
>>> follow the thread here:
> 
>>> https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-irogers@google.com/#r
> 
>>> Basically there are some events that were defined in the perf ABI.
> 
>>>    PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...
> 
>>> So perf tools use those (legacy) encodings with the matching names like
>>> "cycles" (or "cpu-cycles"), "instructions", etc.
> 
>>> On the another hand, it has wildcard matching for event names in PMUs so
>>> that users can conveniently use events without specifying PMU names.
>>> For example, "event1" would expand to "pmuX/event1/", "pmuY/event1/", etc
>>> as long as the PMUs have the event in sysfs or JSON.
> 
>>> And there are platforms where "cycles" event is defined in a (core) PMU
>>> (like "blah/cycles") and the event has a different behavior than the
>>> legacy encoding.  Then it has to choose which encoding is better for the
>>> given name.  But it's a general issue for the legacy event names.
> 
> So we pick the "legacy" one, as always, and the one that is in a PMU
> needs to have its pmu name specified, no?
> 
>>>    Q. what should it do with "cycles"?
>>>    -----------------------------------
>>>    1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).
> 
> Right
> 
>>>    2. expand to (possibly multiple) PMU events (like "cpu/cycles/") and
>>>       use the encoding defined there.
> 
> Nope
> 
>>> I think the #1 is the current behavior.  The upside is it's simple and
>>> intuitive.  But it's different than other names and can make confusion.
>>> Users should use the full name ("cpu/cycles/") if they need sysfs one.
> 
> Right
>   
>> So the code keeps changing, for example, the removal of BPF events. I
> 
> Humm, this seems like a different discussion.
> 
>> think the important change and the thing that has brought us here is
>> the addition of what Intel call hybrid and ARM call BIG.little. ARM
> 
> Right, the support for hybrid systems brought lots of problems, most
> people didn't have access to such systems and thus couldn't test
> patches, so the attempt was to keep the existing code working as it had
> been while allowing for the support for the new hybrid systems.
> 
> As more people get access to hybrid systems we started noticing problems
> and working on fixing it, you did a lot of work in this area, highly
> appreciated.
> 
>> have got architectural events and so the same event encoding on BIG
>> and little cores. On x86 the e-core (atom) and p-cores have different
>> event encodings. In the original hybrid work, pushed on for the launch
>> of Alderlake and reviewed by Jiri and Arnaldo with no involvement from
>> me, Intel wanted the event names to work transparently. So a cycles
> 
> Without access to such systems, yes, see above.
> 
>> event would be gathered on the e-core and p-core with a command line
>> option to merge the legacy event cycles on both cores. To be specific
>> the expected behavior of:
>> $ perf (stat|record) -e cycles ...
>> would be as if:
>> $ perf (stat|record) -e cpu_atom/cycles/,cpu_core/cycles/ ...
> 
> Yes, and if somebody wants to profile in just one of those core types,
> just specify the "cpu_atom" or "cpu_core" to have it fully specified.
>   
>> An unfortunate thing in the hybrid code was that it was hardcoded to
>> PMU names of cpu_atom and cpu_core, but what to do for metrics? The
> 
> Yeah, metrics IIRC came before hybrid systems.
> 
>> original proposal was that metrics would have a PMU name and all names
>> would be relative to that, but what about uncore events? What about
>> metrics that refer to other metrics? A decision was made to not to
>> have PMUs implicitly in metrics and the events in the metric would
>> match those given to perf's -e command line. This also greatly
>> simplifies testing events when creating a metric.
> 
>> I set about rewriting the hybrid code not to use hard coded PMU names
>> but to discover core PMUs at runtime. This was to make the metric and
>> event parsing code as generic as possible, but this had an unintended
>> consequence. ARM's core PMU had previously not been seen as handling
>> legacy events like cycles, and appeared as an uncore PMU. When there
> 
>> are both legacy and sysfs/json events then previously the legacy
>> events had priority. This broke events like cycles on Apple M
>> processors where the legacy events were broken and the sysfs ones not.
>> Yes this is a driver bug, but everybody told me a change in behavior
>> of the tool was needed to fix it, that fix was to make sysfs/json
>> events have priority over legacy events. I prioritized fixing event
>> parsing when a PMU was specified but given "cycles" means
>> "cpu_atom/cycles/ and cpu_core/cycles/" for hybrid, why would the
>> prioritization be different without a PMU specified?
>   
>> I knew of this tech debt and separately RISC-V was also interested to
>> have sysfs/json be the priority so that the legacy to config encoding
>> could exist more in the perf tool than the PMU driver. I'm a SIG
> 
> I saw them saying that supporting PERF_TYPE_HARDWARE counters was ok as
> they didn't want to break the perf tooling workflow, no?
> 

Doesn't most of the discussion stem from this particular point? I also 
understood it that way, that risc-v folks agreed it was better to 
support these to make all existing software work, not just Perf.

Maybe one issue was calling them 'legacy' events in the first place, and 
I'm not sure if there is complete consensus that these are legacy. Can't 
they continue be the short easy list of events likely to be common 
across platforms? If there is an issue with some of them being wrong in 
some places we can move forward from that by making sure new platforms 
do it right, rather than changing the logic for everyone to fix that bug.

For the argument that Google prefers to use the sysfs events because of 
these differences, I don't think there is anything preventing that kind 
of use today? Or at least not for the main priority flip proposed, but 
maybe there are some smaller adjacent bugs that can be fixed up separately.

Thanks
James

