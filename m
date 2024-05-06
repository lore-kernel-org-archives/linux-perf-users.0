Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A41419A1
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984230; cv=none; b=uytSEoTyHJyqmAPY6qrz1nYgz9tm0LLhCp/37KpYLneHbuNy+6Hw5jxpHOZA2zo+mgfuvmcmGwJTzWC2Nm5fYs5HzWRmMpuXe7Q15XZtrZPleyN8s60YzsmxtoZry1UDbNgdNPzmXBQCAfxe1qNGVD0+ud5lzt/GsiEhOR0FsTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984230; c=relaxed/simple;
	bh=63oxEyBCA5bteZ7RaNQd79xS14EgCY6m+wpCWVO/yP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRcEKFj5eHL1U/wn8c+tiYneoo+QhsVSObqjMSfgiC4XEeaGVho6DvEP8ISy5mS6tvalf2CZ1/kvc+OuWXj/NJnZwHJy+KaOwu6dH/rSepXbzVbCSvevn1lyQkHkEKQdlISCB4qB2T3x7GQaGzi7+48Yq6MAJAmRvzGwZ7EGUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HtRcOLhX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HtRcOLhX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3ca546d40so10911425ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714984227; x=1715589027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMt+ZntDc5chBmUaFnMrMv3K37IPvBdeyGhz9mqsUc4=;
        b=HtRcOLhXbbMmZpSAveccl/cxMXIMI14ERJh3paTmX/BIq5ZIckp0/G6jSXH7N9gLPo
         iP4LB3kMVimV0eqISzqQVVjd1lDE206+EjXkzJ2dv98/RSGCvbkXj5Adm1dB3DfWv4LM
         9YcgPjruuRSQM2/ROko5JY4NdjoYR0mkc+Ur4ag3VxEiBVPthvZCaxCn84DOsLQiBDHu
         kIvpUC29+riS9vnTFzrsTOGiNbwfcaueQhVsa6HdQfph0wPiieCrMve31qn2NlhixEIw
         bOO77J8Si5x+Bv8G/cO8q7P4BdVZ5t+X/OCPgm2Y7pwTqK4ZiSBY67qcvMKfp54G2/LJ
         2rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984227; x=1715589027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMt+ZntDc5chBmUaFnMrMv3K37IPvBdeyGhz9mqsUc4=;
        b=skwzCWWGOpnTziek28AUuApGe+wxgy+hFdvyl1weBK35xin7SgbmS3GagsxRVyBSeA
         8smD+GNPQb2MjB8Ob5KEhUA+s03MbEMqQm5cTtLVu6zMVfJPpB8qILQ2C9uQI2ouo26G
         T33wr210sAmCZACeYkULN2p8WabetaO4BaWo5mVJxbHIU3Aamv1wmc20vN+lRhDYfUvG
         vKe1Gm/G/YbIFK+7QdPnxD4izKZAgs13QOcmDKZQ4ATWOSj9Ek0RQO7DWEJ+Z3fsju3c
         Cyc2SJEperC1WRnoegHw9Ed5DShtiw5WbO8kIQALFGYLKEpTngNDJLkCd1TIES5BOcBi
         Kyew==
X-Forwarded-Encrypted: i=1; AJvYcCV7gPdiEsqnpLj6cFI/bI0qxRGr2Ls7ge3VkU12SItZbZ6u0ashI92XfszjT9xQRpzsEfrGnCqiLWAhWhxUfWVGGm7nvE1cnr2/VH29By2qJw==
X-Gm-Message-State: AOJu0Yw+aCItJj2/WrUhWwFPzCQasrZHSZ9rcQ+cHfMjA9sRA5H8p0iU
	RCrXPE7vMkKU5S5xx1xfngl3+3i3oQ1vsDNR4iqlxcHIvLBnYssghi3P++K/1Ys=
X-Google-Smtp-Source: AGHT+IHQdhPRWqNG+K+yzJ3bek8djCHJ1JFlGUUnMpiPX6WZdtG5z3m1dA24s75CqqgeolzOUgnulA==
X-Received: by 2002:a17:902:e846:b0:1e0:f473:fd8b with SMTP id t6-20020a170902e84600b001e0f473fd8bmr10417617plg.9.1714984226742;
        Mon, 06 May 2024 01:30:26 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id ko15-20020a17090307cf00b001e3cfb853a2sm7724074plb.183.2024.05.06.01.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 01:30:26 -0700 (PDT)
Message-ID: <5bb8af54-8b09-4b36-b195-68a0626f56fb@bytedance.com>
Date: Mon, 6 May 2024 16:30:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] perf build: Add LIBTRACEEVENT_DIR build
 option
To: Ian Rogers <irogers@google.com>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240314063000.2139877-1-yangjihong@bytedance.com>
 <CAP-5=fV--O=QB8To+cbR=C06JzPqBFLFYTc1oh9gJZwBQ3BE=w@mail.gmail.com>
 <CAP-5=fXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2vKT-TDSOQ@mail.gmail.com>
Content-Language: en-US
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <CAP-5=fXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2vKT-TDSOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 5/1/24 01:46, Ian Rogers wrote:
> On Sat, Mar 23, 2024 at 12:07 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Mar 13, 2024 at 11:30 PM Yang Jihong <yangjihong@bytedance.com> wrote:
>>>
>>> Currently, when libtraceevent is not linked,
>>> perf does not support tracepoint:
>>>
>>>    # ./perf record -e sched:sched_switch -a sleep 10
>>>    event syntax error: 'sched:sched_switch'
>>>                         \___ unsupported tracepoint
>>>
>>>    libtraceevent is necessary for tracepoint support
>>>    Run 'perf list' for a list of valid events
>>>
>>>     Usage: perf record [<options>] [<command>]
>>>        or: perf record [<options>] -- <command> [<options>]
>>>
>>>        -e, --event <event>   event selector. use 'perf list' to list available events
>>>
>>> For cross-compilation scenario, library may not be installed in the default
>>> system path. Based on the above requirements, add LIBTRACEEVENT_DIR build
>>> option to support specifying path of libtraceevent.
>>>
>>> Example:
>>>
>>>    1. Cross compile libtraceevent
>>>    # cd /opt/libtraceevent
>>>    # CROSS_COMPILE=aarch64-linux-gnu- make
>>>
>>>    2. Cross compile perf
>>>    # cd tool/perf
>>>    # make VF=1 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- NO_LIBELF=1 LDFLAGS=--static LIBTRACEEVENT_DIR=/opt/libtraceevent
>>>    <SNIP>
>>>    Auto-detecting system features:
>>>    <SNIP>
>>>    ...                       LIBTRACEEVENT_DIR: /opt/libtraceevent
>>>
>>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>>
>> This all looks good to me, thanks!
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>>> ---
>>>   tools/perf/Makefile.config | 20 ++++++++++++++++----
>>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>>> index 1fe8df97fe88..7783479de691 100644
>>> --- a/tools/perf/Makefile.config
>>> +++ b/tools/perf/Makefile.config
>>> @@ -182,6 +182,16 @@ endif
>>>   FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
>>>   FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
>>>
>>> +# for linking with debug library, run like:
>>> +# make DEBUG=1 LIBTRACEEVENT_DIR=/opt/libtraceevent/
>>> +TRACEEVENTLIBS := -ltraceevent
>>> +ifdef LIBTRACEEVENT_DIR
>>> +  LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
>>> +  LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
>>> +endif
> 
> I'm finding to test a libtraceevent asan build on a system that has
> libtraceevent installed, I need to carry this change:
> ```
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..b356520d8291 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -187,7 +187,7 @@ FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
> TRACEEVENTLIBS := -ltraceevent
> ifdef LIBTRACEEVENT_DIR
>    LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
> -  LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
> +  LIBTRACEEVENT_LDFLAGS := -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib64
> endif
> FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
> FEATURE_CHECK_LDFLAGS-libtraceevent := $(LIBTRACEEVENT_LDFLAGS)
> $(TRACEEVENTLIBS)
> ```
> 
> I'm not sure how to make this something that'll work well with cross
> compilation, etc.

Because of the holiday, the reply is a bit late.

It seems that perf built by asan/msan will not search for shared 
libraries in the -L directory.
We generally use cross-compile perf to analyze performance problems. In 
most cases, it is static compilation (rpath does not work), and it will 
not enable sanitizers.
so can we simply check if EXTRA_CFLAGS contains 
-fsanitize=address/memory, and add libtraceevent dir to rpath?

I submitted a patch, please see if the solution is feasible:
https://lore.kernel.org/all/20240506081648.3890067-1-yangjihong@bytedance.com/


Or we can add libtraceevent's ld.so.conf to the environment. This 
requires manual configuration of the build environment, which is 
inconvenient.

# echo "/opt/libtraceevent/lib" > /etc/ld.so.conf.d/libtracevent.conf
# ldconfig

Thanks,
Yang
