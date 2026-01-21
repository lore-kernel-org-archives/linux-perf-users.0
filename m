Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D947ECDB
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989095; cv=none; b=nG1LU9VJtoy2StnFTbuGmWSQNhwPeBItNBMVxZ/keC8tfZXiAWxcqE2lLE8jxYvFQWXd7oYyorQ+0mkyd/sR3rbvRGF0vD/zbRRBG4Td0k3H6WIMlKxxhzxhV5bH6EMn6GdZox0VfhRdS68RW0UN/Gzv9LRg98BdNEBTb2Rm1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989095; c=relaxed/simple;
	bh=RO8mQhj5gdjYBuOXvtRKfKce29yP/W3yJwhKMGE0dAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rySQJ3giZ2y5eVg0WTtciMPcNs6ULc7tNL3+pFxYWRky/8Hmm9su5VIYDPZUGlP40hNoleUkbht1H8lcHc21/s3JDlJ4OKn1uT1rsrWWuQxtF130toeMJIXmQAKFb00Gvioc1DZ1VN6fIR7S/2C9bCKxJQTvzXHIE+NXWfW9Lug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wM3SD+1E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wM3SD+1E"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so51760705e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768989092; x=1769593892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyZPTbndzgzGtoUVWromIVw8AjJk4PYTo78zTA51KK0=;
        b=wM3SD+1EE6+/IcVhJrwd3LPoke6FxFGHtcKVj679r8HS/0UAlYz27L478CEkyAJCa7
         9UDa+aUXxyv86MWMw1+36NJfOcfdmKfSJ0CfaWoIIFrCd5bZI7MB8XcR7n7YzR+kpfLJ
         buoj/L5mMcsycKN6ySDH7I0hnpF0ZSXqGMok9IbCRm6bHGCaBJN4JoRvrpPBxPugAPRV
         wP3DNEjk0iJcL0H5bFbhA1zfXwEiZh/pjcmCScwlCRjRQbUPJuZqKLBCNGOoy7V6GgcC
         QdnrIx/KmiS1c7NqivEzuOXgxjV2MBss/IdsgBaENGglflOnoiDCAUC6cOW4PaWmFuYI
         FM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989092; x=1769593892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyZPTbndzgzGtoUVWromIVw8AjJk4PYTo78zTA51KK0=;
        b=XpLm0h2KECl57wfNnKLh5M37iQFWRR7FYTU+vETNBpFB9wgpwZHiqjekjLfXJryKaC
         8ugRzks6jdbZqWuvUf31g+J+LNrziDcTNAOw/lrtQgx2+WYCh7lF1eLhx9iQemyFBWLw
         5vuIuiQDug3GXnPEumRPV4z4zd4tG0qzqv1DOMR+c5a492mgE+CYIYmdoY7vd3811dyc
         TtqGB8ck+GCniYGfSWYyezcNO1H8ErAYabd7s0U45DSNWnA29YAo2Dd1DW7kawjp82FF
         pwvpLFsVdRtzN3NGUVvpq7fEexCDDmWSN11AUE4W9S+96bDEPmYP0j2oeyMl+UmFdJKb
         M1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgu5hpartqQP7+NOJFybu7hUeIFLmDN/7blSWigEnyeO+tdFDT5pd05vIvTycJyddYE4JO+4QAnczwiny/jam@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bYcUO2j2qG52phBHnTVBXjvbbyXUoOhH8nVlMIGmC/Me8TBi
	2PcnQq73pAaC0yjf1H2zIMEJcehVOeVkA+Dmyb8/tGmGCsbL1h40AiG19C6eYKx4BZU=
X-Gm-Gg: AZuq6aIJZNhP/3iQPENujhkZactTRH9EP0NeVvSZKTHgIQsydYznLpIRk8788l2HXJ0
	5UOH9T/6p52cqjbbxnK8NmitGH4X16qYcCvJYOTQjjFym8zkypzV6hpvBp6JRr+4BqEhFr28gSM
	Yj6ixZg6bpqO29yw+7SCPO75qkNNyZh7n9+fPaaqiTOLnMZuA4Ua2dgWaIZprqoHxq0XCjJyOqG
	Q6OPhfkr9sfewkXwdmhRcGGAo+YUiudC/OxjPGJdY5NkoOSE/wOwLkHj5u9m6XJ7cleONukEiwT
	OPyaSghK7lLMWIJ7NpseRc0GjFXZmhzCapIQYkDSeSpv/V6/pKhF/u+YH8ERWDB9SVah5jHOnSd
	8U2nc0nlI+WXq06LgafaPRecss5jmbcwujt8eSNOXnPJRy0GCJ/zD0DqCE/BtJiXMPLmhyNHy9T
	Y4S6s4iC0n/TQTu9gT
X-Received: by 2002:a05:600c:3b90:b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-4803e7f184amr73180175e9.25.1768989091597;
        Wed, 21 Jan 2026 01:51:31 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm34259717f8f.19.2026.01.21.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 01:51:31 -0800 (PST)
Message-ID: <185f91de-f0cc-4a84-9e41-56370df718fd@linaro.org>
Date: Wed, 21 Jan 2026 09:51:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf jevents: Handle deleted JSONS in out of source
 builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
References: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
 <CAP-5=fVxMcMt=red5+D9_m4+wrUdPGkNP0irNqr5PU1UPJSO6A@mail.gmail.com>
 <aW_PXct-oIyOyrNe@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aW_PXct-oIyOyrNe@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/20/26 6:54 PM, Arnaldo Carvalho de Melo wrote:
> On Tue, Jan 20, 2026 at 10:01:52AM -0800, Ian Rogers wrote:
>> On Tue, Jan 20, 2026 at 7:39 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>> The cp command here doesn't remove files that have been removed from the
>>> sourcetree. That means incremental builds can either succeed with stale
>>> events or will fail completely if a stale json file has a broken
>>> reference in it.
>>>
>>> Fix it by using rsync instead of cp. legacy-cache.json has to be
>>> excluded as this is a generated file isn't present in the source tree.
>>>
>>> This only happens when deleting a JSON file, which has only happened
>>> once since the linked commit. The fixes commit is marked as the origin
>>> of the problem in case any future changes that delete JSONs are back
>>> ported, rather than the first commit that deleted a JSON file.
>>>
>>> Reported-by: Mark Brown <broonie@kernel.org>
>>> Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
>>> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>> This is a bit of a hack and I thought that making jevents.py handle
>>> multiple input folders would be a much better solution than this. Then
>>> we could have "gen-pmu-events" for only generated files and "pmu-events"
>>> for only in-tree input files. It would be very clear what's generated
>>> and what's not and all copying rules and special clean rules just
>>> disappear (and this isn't the first time these rules have caused build
>>> issues).
>>>
>>> Unfortunately, after a while of trying to modify the script I thought it
>>> was too invasive for now. The script does output per-file at the very
>>> bottom of the logic in process_one_file(), so adding files in another
>>> folder ends up re-emitting section headers when another chunk is output.
>>> Although other parts of the script do build things up in memory before
>>> outputting so it was possible to make those parts work with multiple
>>> folders transparently.
>>
>> Thanks James!
>> Acked-by: Ian Rogers <irogers@google.com>
>> I see other rsync uses in:
>> tools/testing/selftests/sparc64/Makefile
>> tools/testing/selftests/bpf/Makefile
>> but they aren't the most compelling mainstream uses. I wonder whether
>> we can test for rsync's availability and if not fall back on cp?

That will work if we completely wipe the destination directory every 
time. But it would be an untested path, because in reality everyone is 
going to have rsync. It might be better to re-implement rsync and then 
at least the same thing runs everywhere.

> 
> It is not mentioned at all in Documentation, so probably its best not to
> add a requirement for it?
> 
> - Arnaldo

I can hack together something that does the delete in a few lines of 
bash or make then? I did consider that originally but I thought that's 
what rsync does so I'll just use it.


