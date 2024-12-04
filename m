Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E48192D7E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300697; cv=none; b=WAQ2tDOqNQmJ2GPuYADohRnM4Ajq0dMtOzEWBcfM7g64XcKTGv2uQDlbcNidHSfEj/cGu0MWG41mb7CsUIy8pSX02y3DBo28pXdkzD1AaDYS4QGNg1ocERS25cK1LNMFtMRPlKm5FFLHHiDJEgs1i0P9vwvucZ5crn+dca4504E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300697; c=relaxed/simple;
	bh=e9tRk85WV4aAL6kjg/kGyhEydAR1rXS8kbUjxEXXP60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwozoSlwjXX1qK/QckKT8oB905rQJLhbVvKKEUhU7fidl2bHiIKyr+bHSrqCPWoKc7KO+kj005912wxpxMAr4SqiELREQdcczM8MrR0liploe6M+SHeV/Iryx2Gg+OWBp+BHjFmeZnkweu2kyWJbhFVJZdcIL3ZaPWoq4NizLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EurIbj+3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EurIbj+3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf3e36a76so60716545ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 00:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733300694; x=1733905494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1UFD+46MuBiqXRl46YpGOAZ33mlvvrjXgngl4fM9t0=;
        b=EurIbj+36iGpbc7553twTQjoOIW+Fg4m8ZMmPmV5t4KyTH5MdQH1PDBFbUXv/tZMYY
         bbTv97jRMkX3fPeNjFhQmazLLq5g83iZ443bSnczIEcWNBnFb3ug1zlc10VJSU/qVQ8b
         MCOsiZL47QP6C/e/xDxdyKbiWnBAFWmc8MnfOJrlra/Zf1YW55Ht7fx7p5AMNqFU/mk+
         DdxnkS7UwPN///UwKc43WiH/aFbRAsiFUXmHetlMAZyd/Vs5ubYynTTqHGj5l1CrzIZd
         5mpNQ+vADfot3H3NRTZjRdbdaxjFk7j22XVlA6n8N5bVdDXe86ck1iQlngzLNSj9wBMQ
         MAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300694; x=1733905494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1UFD+46MuBiqXRl46YpGOAZ33mlvvrjXgngl4fM9t0=;
        b=UpY/857Yn7E2LI7MpIQ+zsX5wGMB9IY9sPzgvoNsz1kBr33WdcSfQpGOCt40CJxn5O
         A4RkwlyGmfC0L1UqVBMvgNs1taUxTOSU8N12TULBBdRyExBbZ9Xetuk+FE2y0O9ut9iW
         dQ9VYC1rUQOangTHbX/JWriFceRX9yGlJCtnHzChatCrg02UJ7hOn0IQBLAIXbjYu8X+
         /09u/HcTHl0Df3JQprEsfOehUoK+j9Wz5NILfwMMGXzQD5ytSiYw1yA0H8MPN6yvqgBv
         GxOTjCAH1NNyOm+wvjmXW7KGBPXswqgOmAZcweMqEt4xj36FEV+SDBvgbePVRFEP/fdM
         GUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVBdfoHfh6aURlDhFz6V2klqtS8YZToM6jDJbSbn4u8BgqhTE4jsjZRNINEvx2IA56Isw+lXJzz4FcohArWAtF@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNNAa8asvZIUXyuxbkBhEzHdSafXmlRuizqnKfVsjyV71OM3k
	y8CkGjuVeRsBpDha2ksEIvyp0XRreNRwOmiTG2dE9T0XLupVfLc5FV9q7ZROw20=
X-Gm-Gg: ASbGnctnpiwyCFanMUuqKGUGE+xBWQj8e8DRnJMva1QZqR358SS/odZJ/rFakY5QR2V
	zCqcaIYufoZmKlYpbAm28uBSw8+/fHZOTNTQqQ+vz2TgBnpnbficy9TYIGCCKWpdTjOoLvNQ8QI
	nFmK+3pYNFyrZgG/aPOFq6oLj7uH0OXMRCrY0jQFbtT2XiF/9+f9606687jvvnmdtDbRFNHjsER
	Lt+1ACyzSSXUyCBiNrBuE7UsQDBC/J3VtKm4v75Dn/cdklUkEzM4ruvVAgmohU=
X-Google-Smtp-Source: AGHT+IHerA5k+FXrjuEQ+gtAhpCKKVjzpxM3rClxP/nhHtSLOgcnOx9LrKmupbZ8P8lwzyuUhRn3Cw==
X-Received: by 2002:a17:902:cec6:b0:215:a172:5fb9 with SMTP id d9443c01a7336-215bd14189fmr91694895ad.48.1733300694302;
        Wed, 04 Dec 2024 00:24:54 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbfdesm11784559b3a.99.2024.12.04.00.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:24:53 -0800 (PST)
Message-ID: <2f3938f6-41c7-46f8-a8f0-a3792fb21e96@bytedance.com>
Date: Wed, 4 Dec 2024 16:24:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 01/12] perf record: Add event action support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-2-yangjihong@bytedance.com> <Z0jQXPF-tLXRh-Mt@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jQXPF-tLXRh-Mt@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 11/29/24 04:19, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:42PM +0800, Yang Jihong wrote:
>> In perf-record, when an event is triggered, default behavior is to
>> save sample data to perf.data. Sometimes, we may just want to do
>> some lightweight actions, such as printing a log.
>>
>> Based on this requirement, add the --action option to the event to
>> specify the behavior when the event occurs.
>>
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/Documentation/perf-record.txt |   8 +
>>   tools/perf/builtin-record.c              |  31 +++
>>   tools/perf/util/Build                    |  18 ++
>>   tools/perf/util/parse-action.c           | 230 +++++++++++++++++++++++
>>   tools/perf/util/parse-action.h           |  75 ++++++++
>>   tools/perf/util/parse-action.l           |  40 ++++
>>   tools/perf/util/parse-action.y           |  82 ++++++++
>>   tools/perf/util/record_action.c          |  15 ++
>>   tools/perf/util/record_action.h          |  24 +++
>>   9 files changed, 523 insertions(+)
>>   create mode 100644 tools/perf/util/parse-action.c
>>   create mode 100644 tools/perf/util/parse-action.h
>>   create mode 100644 tools/perf/util/parse-action.l
>>   create mode 100644 tools/perf/util/parse-action.y
>>   create mode 100644 tools/perf/util/record_action.c
>>   create mode 100644 tools/perf/util/record_action.h
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 242223240a08..d0d9e0f69f3d 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -833,6 +833,14 @@ filtered through the mask provided by -C option.
>>   	Prepare BPF filter to be used by regular users.  The action should be
>>   	either "pin" or "unpin".  The filter can be used after it's pinned.
>>   
>> +--action=<action>::
>> +	Actions are the programs that run when the sampling event is triggered.
>> +	The action is a list of expressions separated by semicolons (;).
>> +	The sample data is saved by bpf prog attached by the event.
>> +	The call currently supported is print(); some commonly used built-in special
>> +	variables are also supported
>> +	For example:
>> +	  # perf record -e sched:sched_switch --action 'print("[%llu]comm=%s, cpu=%d, pid=%d, tid=%d\n", time, comm, cpu, pid, tid)' true
> 
> But at this point in the series this isn't available, right?
> 
> I.e. when testing this specific patch I can't follow what the
> documentation above says and expect anything, right? It will just fail?

Yes, The entire patchset needs to be applied to fully support this feature.

This patch simply implements the data organization structure.

Thanks,
Yang

