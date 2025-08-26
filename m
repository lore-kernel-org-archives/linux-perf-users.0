Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAF2FD1D4
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Aug 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197508; cv=none; b=HP3mmifgyMlVx8BCT9sttFMM8uUcMzs2u7l+/Lnd7bCNGWit3mJnADre1Bd9QYr38XASEvX36S+1C5J/GBmwWzRzHnSP94thyLlI5HOlTBi0bGruEZ9eGnoFa8r+pG3yc+rNcF4ubbCY+ZRj8Fow8Y37AqvxTTEZWFIKNEe2hSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197508; c=relaxed/simple;
	bh=TuGhfyWtejXoSJXXQd3ZBKxoBEDJ+7uL75KJD3StkDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=G7cUBbIPfe4ZvO0Xbqp2ZCrVnhDzNyBAfNeYYhCjJwwyj13lRhEHFHloLxlHat++q+v6mwpghkA+8QOWV4iipKju/CnyfV8cwGdA4IgCRaNn0RsRQbwnTXPC666ddkaOMuDm0ofyLPOUYVLabpIhiWWqce4efpmYRChuJCHgYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mIh6tYod; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIh6tYod"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c79f0a5c5fso2034045f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Aug 2025 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756197504; x=1756802304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bcapay0b5BMrsUC3omNVwn5FU3Q2XQrVHbsogJXMiPw=;
        b=mIh6tYod/vpqm5G0V8VuNmrD0M6esjeFN9i9wxvuX1DElC1iDgAGgUJGHwmy+NJtSm
         ER0HOik+HLK7EgtkpWtaEppd7RyctPSDljn/MpNGo8wP3j5N6vD40HwbSzqgI58dGeAf
         fkM/Aipy6SU+YZP1zCC36dlhbUP979vMD9qpC0tTPFq8EVojwgHLREajyJbHApNVB5ud
         oSLfABMu/bFxFMBPkMDeMVTk67Z6PRvHJ9fpV9YkU2ayegKYcDO2a52RJKCXI+lMB92d
         OogwIJi2JbHlBA3YWT1PWpe+pg5AdWFWqTEtaOGkLw33zOAaQqMFDCELhA6U3KaA5bxA
         KSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197504; x=1756802304;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcapay0b5BMrsUC3omNVwn5FU3Q2XQrVHbsogJXMiPw=;
        b=mu6lcT+cITLbp/7VYW3riHY93tmVhjuR+Rvfg9JxQADJ+hyb7I3hnsCp+JnXxuhyNm
         +5tpoT9JYeoMz/epKc3+llC3jO/B6sQtXNDfoxyOzjDxVwt+WGvRXC80e/lyTTXdWnfQ
         AEK7hHN4v5I0BbWKdPQ1Hb9JYAB5aY7LEW3rk7gK97bPdfqGb6EVPPln3uciMA31HtSU
         1C8LTkaaG+01tktobHLPqlEXDr7xlalbNQN7t1PUi47RmkP4M2CYbAOcxhM7IShS8y6U
         H2YkQJjTwv/ikm709Ts4NXKZPcNVAeBihSdpLrVeXRVEMtNddlrp5plXD5nud9I6Biys
         VMkA==
X-Forwarded-Encrypted: i=1; AJvYcCXbp406b/7Xaq0V5IYFPX6i+j4Iv4HHjQyM4F81HDw0dyO9FsvzKBTLVCJMBAa9drhiaA7Yfm8eImd8OzTleeGc@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcy0X8GBz+ltC1HjXpU/gkY7pcdYePf1+D3EBj3LzksQnZlod
	1oOhkjWYdsYMRpN7fFyu79XDWHvnhOuJz17KRjXF/ZdQX3EVLEyP1BPwwPYhnzwEOBM=
X-Gm-Gg: ASbGnculqudBafJFbJPLrNv6vRnXBTrhvTVOn4WbxxuR7/PrhUCsIr1KTtfyDtj/k89
	Jx6I9oLBx4RfEOY7cHku4ApeDJRujihJTry/9/V9V0sg708ruwiAl5OWEsh6Zmb1tIYcpLbDz9L
	eFKk8r3U6OzubEEwMGfZHBgl1lcOGhFDit1tb1vH7UWcydtu/f7wS642Ve1vDNrQEAPlo2PC6Se
	jdXg8+FA0cAaKK1SzTrVYdZCNzUFLB4ZE01GkVwz1EzYCnFrNPkdw5JBrJxWOdNH0QIfBDNCn13
	/E9uuhRFp9zZ2MU2cUUaPJmM7BkG+kwPNdGzMZAWnkBZR1j+h3/AmKsGC9JK53hve/IIAp6vlfb
	2N6aRYV8KvTps80BCsJMMwwdYEN41J7d8INUA9g==
X-Google-Smtp-Source: AGHT+IFeEqRJ21XXnuc1DJjIvgLFKOV7L5q0hp++j6i1DLS6bEL3rc78ittualLZitamll1u+nuxmQ==
X-Received: by 2002:a05:6000:2404:b0:3b8:d30c:885f with SMTP id ffacd0b85a97d-3c5dcefe32fmr12441530f8f.53.1756197504511;
        Tue, 26 Aug 2025 01:38:24 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm16293557f8f.14.2025.08.26.01.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 01:38:24 -0700 (PDT)
Message-ID: <8b7351d2-6a45-4fef-a149-ae511b52f552@linaro.org>
Date: Tue, 26 Aug 2025 09:38:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Various fixes around undefined behavior
To: Ian Rogers <irogers@google.com>
References: <20250821163820.1132977-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>,
 Blake Jones <blakejones@google.com>, Jan Polensky <japo@linux.ibm.com>,
 Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/08/2025 5:38 pm, Ian Rogers wrote:
> Fix various undefined behavior issues, improve tests to make them
> easier to diagnose and add assertions so that problems don't recur.
> 
> v2: Add Namhyung's acked-by. Drop container_of assert that ptr !=
>      NULL, to simplify the series. The bsearch UB fix was picked up as
>      a patch by CT:
>      https://lore.kernel.org/r/20250303183646.327510-2-ctshao@google.com
>      It seems this patch series fell-through the cracks as v1 was
>      sent/acked 9 months ago.
> 
> v1: https://lore.kernel.org/lkml/20241213210425.526512-1-irogers@google.com/
> 
> Ian Rogers (5):
>    perf disasm: Avoid undefined behavior in incrementing NULL
>    perf test trace_btf_enum: Skip if permissions are insufficient
>    perf evsel: Avoid container_of on a NULL leader
>    perf test shell lock_contention: Extra debug diagnostics
>    libperf event: Ensure tracing data is multiple of 8 sized
> 
>   tools/lib/perf/include/perf/event.h       |  1 +
>   tools/perf/tests/shell/lock_contention.sh |  7 ++++++-
>   tools/perf/tests/shell/trace_btf_enum.sh  | 11 +++++++++++
>   tools/perf/util/disasm.c                  |  7 +++++--
>   tools/perf/util/evsel.c                   |  2 ++
>   5 files changed, 25 insertions(+), 3 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

