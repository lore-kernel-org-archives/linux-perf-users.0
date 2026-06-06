Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079403B14B8
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760874; cv=none; b=i4uiicK8Awbq1Z/wTncE//Px0VQq1a9+She/9Nb9/aPqkmODpYJHXjqIi71DbzOwHnU+5ffx62jx/aPCuo5CR2/w6HSqGfv3DuOdTS03YjO4hN5khBClLDUGa25meha71s8X2nnsSThktSvzyLrJvZyh3GV5hk1HKtxdh3qXEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760874; c=relaxed/simple;
	bh=+qshEydwPXU+AaCDb7amEefBGt5ZMFd9hX7s89Doj3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICSICvlbLKQAAHmbCawynYrfLa6ncx2sFXWHiR5Hy+l4616dinhJy3cpPnvUkuuv8stbcHDsWs/3Taixd7p7HqtTJqWuAKftQz4o1HwhV3AM0E3ULkc11lGPHHRZJIDCUQR4hLwV+dSAthN7C3nKtaF3c/Y7iiW/mec9rfuay4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaCR7gLa; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaCR7gLa"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43f5e285111so1983071fac.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780760872; x=1781365672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBIQwnzyczSMuelweDl8NlDOdyBwM4IqiVAl/8fUc48=;
        b=VaCR7gLaVM5dCaFDUurQCpSB2HhDUdcxT3sHGJbH/QOPCQnuXimeX+V0woCQ9i3Jw5
         ySFibRsDRIRe3IP35BqRi8MaqYhN1/Nknz4JNxmCpG9rxpGLUyhAWFQfNa1fAX/T1aui
         QaecFqYETMRA8CKsz33YB6tGN/CvfK1wTz3rlkDDRe8I+p+5ZQ/+htIRAXf5R4cnGH6t
         Dr1htj35T20Q9CTo3BHGW2WWyWABnYNzKOAuJ86NsF5Ccc50w+1VjTngSPyKmlQmZZZd
         Fj8rGVzQ/dcQAv9RV2NdYVOxPOAP2o5rw7URhgBEITy2BD9eY2arik8EqO3psn4uP5E1
         nQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760872; x=1781365672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBIQwnzyczSMuelweDl8NlDOdyBwM4IqiVAl/8fUc48=;
        b=AOtG64y36CvzydQqQZfAQAa1wgaDdL+LB1kIWCQM7CMHkYKXnmPzY274bWHXW4cnVd
         Ca6oeWeAWbZ0OsXQkcrcfSkM3INftjmpRBALyV45n2BzVDzA6/Kuqat3unzdqZnt1Koe
         j7Blt3wLqBIkb9gtnhl9LoCxD1JA7HYc/l6RCJCPhWFkT+/eZ4ia4y4K5ipFeZsCvZp1
         NuVxxuTLi+ZLMiafc4Cj+JH/P5R1Ursug7dE2WRG3rnoGfpv7KRlGBQJlnmNMMocoBgC
         V1lN27Y2Y1Rhsv291cce4SR4NozHmt9Thct0YL1k3FpIXhbk/Ybi37bb11Y3F1PXrMHL
         yANQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vxG/8JInqYI6IHmSIoOJQt/UT8yEW6FqosqeFt661kO4AUFVZBkdEGLMsB/Kuwl6/BTQW7VqC/L9XlH0O5EEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAeMcyYPmQGtp3vsEBGplwkN2/eFvpvdmy+Lkr4cUMwznyDqg
	83Lo1eoQEUwBSEsi7O6ASUQK4U5gRHtLvWARQS3xpz/r5vwZPHGWDFvx
X-Gm-Gg: Acq92OFL/V87SAYEqxmZgJ6z30iP++WVV6rh9mg7xCHCOwDsClJMfJMTcD29pHirBbg
	Lel2evObHi4VSNIWjCv3fARIRkUh5cPZlSYkZU/64tiichXmvQebDjGaNQ4moa+NmZQpaeU7qto
	v8Jyq4JcTQxGzbjFanWlebjJ5DdNvFFs1IS7dntcQvQIMuG58e7TL0XTJQiEyl5J+6C6TOl/WlG
	UejQD05t/9HA+W+A6MUX8lrMJgjltLTnhzFCz+bBo46o88ORZNdlywCsvRkQzUAnMWyLwQrkOE1
	3IyYUGfHu7jjcf639lrQ7t4N1lY8zigPWDuS5KpSkym7YLA3isWbc8zuiuCdVe2nkk0FEold4Ok
	Ri/+1waHzkRC9WV/J1ZENkDKWTdnwGePonJ1CGr+YMjsjNhmHa8G3xMYd/O7iygas+LG39GyZeh
	A6wxFZ9IzTLRdGE/X2EAZJ1YpsKXcMop/X+HZbBh3R12pKA+sYPywAqwDn6cXbf/RSjEE6UJxNC
	TZcwoVfMz8M/HEBbFYpIqj2aChp
X-Received: by 2002:a05:6870:e3cf:b0:43b:637b:c33f with SMTP id 586e51a60fabf-4413d2657cfmr4538546fac.6.1780760871906;
        Sat, 06 Jun 2026 08:47:51 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:856a:da39:d9b3:fb8f? ([2601:282:1e02:1040:856a:da39:d9b3:fb8f])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-440d8297395sm10158925fac.11.2026.06.06.08.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 08:47:51 -0700 (PDT)
Message-ID: <11689da4-fd35-4177-be03-8bbd750dbe8f@gmail.com>
Date: Sat, 6 Jun 2026 09:47:50 -0600
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] perf sched: Fix thread reference leak in idle hist
 processing
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, sashiko-bot <sashiko-bot@kernel.org>,
 "Claude Opus 4.6" <noreply@anthropic.com>
References: <20260605233837.1773732-1-acme@kernel.org>
 <20260605233837.1773732-8-acme@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260605233837.1773732-8-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 5:38 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> timehist_sched_change_event() sets itr->last_thread to NULL at the end
> of idle hist processing without calling thread__put() first.  The
> thread reference was acquired via thread__get() in timehist_get_thread()
> (line 2581), so every idle context switch leaks a thread reference when
> --idle-hist is active.
> 
> Use thread__zput() to properly release the reference before clearing
> the pointer.
> 
> Fixes: 5d8f17fb5822 ("perf sched timehist: Add -I/--idle-hist option")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


