Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63F3BBE9;
	Mon, 13 May 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626484; cv=none; b=k/vfCNZcdIw/UlbsU4kyTB6ZHH1WsmGrITOKkbjNyZWlVF3we9I/NNKrs0SUDfaQW3FXKXVfjt1ezTxmUEwcsUSqMeQ+t1Mz2QyJ16YX8MwG3ypVZyos3V6/XDnRsiDwlH/lfcLtamo66lHfvCh6E7JVkmVkMRp5mLsrY20iSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626484; c=relaxed/simple;
	bh=d2jgkbkMoV3Siq9CkSyxiqhZl+sMSfVZF3OGa6qLXek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpqEB4RRgQam8HAWriblp61pDShySOx8IylVix9pP78v1cWS5+cH1v18+jK1OGDxesdtGQAnTQOEXHJZkseJLW/HJKEV17xCFgXN0qWVNbao0T49LNLeFB6dGmf4Z+NH9ZPU1r7F49xYz2N1+9cbWQc2u5dAvnaP6pDTP//ETYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KMTqIsdK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KMTqIsdK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vGf/jTtuUwk/HfEDJqDmtiYZAy8X+Zz7Hwm9/iogRd8=; b=KMTqIsdKZZtq0XAnw1JFppwfJB
	drxZVDMm8YEO6YQTHtlUaMNrpuWBLQ/dijcZB4JpgDFvxlY/UJvKtCTPJXYmGG+GwCcaTw2nTywpm
	hlxoOFUE3Ck6baAyVfJSqz2RB+xrUCOl0dR0L+VYWEZTB0II2qLKTBu3HnMOT3pfyx9VLpv1QoWxz
	7HfOINW9c2M0V2BJducBB4d+oEOfKtQ6ujoyCHvpJxu4VqYsbBNp7SH53tuR9f4p8sSOnqIFCYrls
	FMCfqIvD10B6rwSSTF7BH3WlvTm1PJjUOchwtjIay7lq9YXoTrc0Ku4FkQHMIU9+3g5mjOHPMY3xK
	yFqDsz+A==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6aoi-0000000Dvoe-2NFs;
	Mon, 13 May 2024 18:54:32 +0000
Message-ID: <f24eef54-e32f-41bc-b4cd-13ca83e1ea48@infradead.org>
Date: Mon, 13 May 2024 11:54:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] perf Document: Sysfs event names must be lower or
 upper case
To: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240502213507.2339733-1-irogers@google.com>
 <20240502213507.2339733-3-irogers@google.com>
 <fe41f9a7-5726-49d5-9bc6-70102d9680a1@infradead.org>
 <CAP-5=fWHrX5AgH8=62f3=a-SSqUACXX1rkDZJ-WV1RcNieeHFA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAP-5=fWHrX5AgH8=62f3=a-SSqUACXX1rkDZJ-WV1RcNieeHFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/13/24 9:22 AM, Ian Rogers wrote:
> On Sun, May 12, 2024 at 3:08 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi,
>>
>> On 5/2/24 2:35 PM, Ian Rogers wrote:
>>> To avoid directory scans in perf it is going to be assumed that sysfs
>>> event names are either lower or upper case.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>  .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
>>> index 77de58d03822..e7efeab2ee83 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
>>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
>>> @@ -37,6 +37,12 @@ Description:       Per-pmu performance monitoring events specific to the running syste
>>>               performance monitoring event supported by the <pmu>. The name
>>>               of the file is the name of the event.
>>>
>>> +             As performance monitoring event names are case
>>> +             insensitive in the perf tool, the perf tool only looks
>>> +             for lower or upper case event names in sysfs to avoid
>>> +             scanning the directory. It is therefore required the
>>> +             name of the event here is either lower or upper case.
>>> +
>>
>> This is ambiguous to me. Is it clear to everyone else?
>>
>> "for lower or upper case event names":
>>
>> Is that a logical OR or an exclusive OR?
>> "AbC" contains lower case or upper case characters. :)
>>
>> I think the code [static bool permitted_event_name()]
>> implements an exclusive OR.
>> The code also allows event names to contain numbers AFAICT.
>> The documentation doesn't mention this.
>>
>> HTH.
>>
>>>               File contents:
>>>
>>>                       <term>[=<value>][,<term>[=<value>]]...
> 
> Sorry, this reads like a troll. Assuming good intentions, could you
> propose a fix in the form of a patch? When a word is made upper or

Sure, I'll send a patch.
No trolling here.

> lower case I believe it is generally assumed the operation applies to
> all characters within the word, but I'm happy to see ambiguity cleared
> up.
> 
> Thanks,
> Ian


-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
