Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7130E826
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413714; cv=none; b=c56k7PxYUq+QrlLU0h8jrwsRb5Ied63KM/RB+SajCWlW9xbxTlURJ6I8XmsSvm4W0hiHRCgfhSRZRje2U0yG0Ao7Di3iQMrxSIJCimI2w2ROJyLCopW6mJgI5K8Vc7gkdnaRFUAGeVZlOW5Y55JAkGoj8c/dhw7Z1ErEETpMKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413714; c=relaxed/simple;
	bh=/oIbt58tuRVwC/4Z7+QARdzA9077RKCqGqQQCvLgcSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ayi8HDHmEGZ1Se0pMvIWbuw2SjYtw3nzpFHP7A+6iuknQt2J9dU+h6dUPR8jqYhBJmAVqCMYa6jv3BCBFY3nGWeFmRLZgYSkpHqv50/YmOMhihHhePLlQ4IOSFf4DRtacheCHx2fRcAuHoLT5TGk8/SYRaQTlAKXrrHxi0IoaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFFkoJaT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFFkoJaT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a510432236so1285324f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750413711; x=1751018511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1V33PwliDsadgSCJN5N+hOgt1qTEJhFyyYHDF4V+qVo=;
        b=pFFkoJaToCJ9PHZrHlYf8pQJxzrAI23blyDQcsL+o3k7xDk9bdeyojYRaH5je8TPK/
         OLWcvNqsnVoNJWC5CjbwoGhSbupW18azoufJkJkvuMQq3sTpw6cfScRtCfYpCEQ+/XRI
         QU6AAJwRXPsjisbEUhaBcgVA6aJunwRnPiprUxRzkkv2fO4w3NdWeCVBL3oanJWbCPbH
         pIRHJAOlKJMxgMb6N9VBgH1vPJ2ujFY7+O5Eb7MaZpwtmtUAWbpRIc3kE8LpbcPjrCUp
         HfTQs+lLdLViV8MFGXnIiCxzOftzicgtu7y41sXH7ZlAKgHSeAgQ5ik8TSWfQDSk8kUk
         kgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750413711; x=1751018511;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1V33PwliDsadgSCJN5N+hOgt1qTEJhFyyYHDF4V+qVo=;
        b=g4wkBJr8DcXHN8G8XfC79yQnIFnhMXgPtYncpAbNXTsd0i+xb1huDPFApVNTTx9lLu
         7sjEN7BgAH0K7fUioIvEvs09XNFAD5cufyhEJUHWL/0rO61aqpn62LM4k4JqlMAEn8W5
         iq7k6DBVcdB3R1lpPY1ccE5b3yXg4W+cbYWwSI36PUixDJYng+K3R1Df3cveMQPGag/g
         iRApRyYQ6DAKba9/rii22RWqDY3elNKJ1bpqga5eMnPA0tLyzirK8QLoq1oKqDMXYb2C
         hFOWC1eSOGWA+CN4s3ZkN8FyAuR1RLzg6Y/fV9zwdKyOCmXc3Bh1hYaA2NgjC5TS7doH
         /9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWp6fdNyGmDAhqnkGhuM3eQ1s5PKjD1hAdlO1EquHzU4HeWgLnvoEwmZBmDzS7I7sgJmzrCXnOrAOYwDQ2Yag/g@vger.kernel.org
X-Gm-Message-State: AOJu0Ywunrnan7plGLUlOgml86GgLclsqhA5rdxR70rYyyyoRtTzCGd3
	TUfqZrduImYBCks18whl3zio8KrKc77B240T59gytRIY8BEiVGzcFfGRIeYbuMx+x18=
X-Gm-Gg: ASbGnct0UeK86FFBevjfEg182m5aXlGzRS9Sa9JlESGgw1Fp0tGPA59pHLeTYtt14j4
	nKA6BzbL9zfZ5atIkZex/BifjbtVVnzaP7m91IPyGnRK1vkokpJh9QQUP4Pnvsr9+/Dn7Zf34tr
	SypBup0S5zGlc59fY6Ki3HWXJD6xcFjjtZ5XeeJsMNUKunrCFTDREkVNzqoQueShNBabbGmtPmM
	raQg94IENbl8HFFMHz7k952B4qrDr97vKJ+zbsvQByi2/ciRjvo0lPsG8cbNC0zo2jnHocRadM7
	2i+/uTcbfr0u9m6Hjcb5cMumO3NotFzFUw3pvm2RAZS2798VMBsOszjKuJtFSh1W9T0=
X-Google-Smtp-Source: AGHT+IEOxlN14CZssrk21oXKOAAcd7bGl3s1RkhHEHJxhspuMIQNqubVwKdpBhp8yq4BcmgE9nzj5Q==
X-Received: by 2002:adf:e181:0:b0:3a4:edf6:566b with SMTP id ffacd0b85a97d-3a6d12dbd65mr1556907f8f.6.1750413710684;
        Fri, 20 Jun 2025 03:01:50 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647070cesm19750175e9.33.2025.06.20.03.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:01:50 -0700 (PDT)
Message-ID: <069ef044-7e06-466f-a10f-66f7c8aacac1@linaro.org>
Date: Fri, 20 Jun 2025 11:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop
 process
To: Ian Rogers <irogers@google.com>
References: <20250619002034.97007-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250619002034.97007-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/06/2025 1:20 am, Ian Rogers wrote:
> Name the noploop process "perf-noploop" so that tests can easily check
> for its existence.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/workloads/noploop.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
> index 940ea5910a84..8b954d466083 100644
> --- a/tools/perf/tests/workloads/noploop.c
> +++ b/tools/perf/tests/workloads/noploop.c
> @@ -2,6 +2,8 @@
>   #include <stdlib.h>
>   #include <signal.h>
>   #include <unistd.h>
> +#include <linux/prctl.h>
> +#include <sys/prctl.h>
>   #include <linux/compiler.h>
>   #include "../tests.h"
>   
> @@ -16,6 +18,7 @@ static int noploop(int argc, const char **argv)
>   {
>   	int sec = 1;
>   
> +	prctl(PR_SET_NAME, "perf-noploop");
>   	if (argc > 0)
>   		sec = atoi(argv[0]);
>   

Reviewed-by: James Clark <james.clark@linaro.org>

