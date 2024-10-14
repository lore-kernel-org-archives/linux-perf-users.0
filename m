Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF0153BF8
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895269; cv=none; b=NpyBsHqsnbCvOtpqrwOir+F8/wjWAsPHQVWPytT3LSP2qjh9GiYl4rZvPz4n6IBKpU8rPTdctZrQdH6I39KdajjX4GqJeyNbJkjA6xZXSkBA4Epcfgg7JLVybLRVk/IQ9dvgm1d7ZZA8czExtIilEgkKVtHHV8FVGVMMdTxtu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895269; c=relaxed/simple;
	bh=xZ/0mFJsN0uX6bZq0vqYSXkP6POKdmnylv4KXdMluNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On3eZvTNxClEabcFEIs9hNjPnc0TpWx0HvuPaNl6fKJThjiOLGckPIbnjVS5RdaMGfKk8em9XJvy0FzGofzBm2Vy1XqFP+f+WbgOUV66m1AwSl7eQaPEWflPtqO+9gUR07tp4jOskr2TtMsIDbGWCRGsXbcc0ZKTSzLA0nplIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oYySi/Uu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYySi/Uu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so39168465e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728895265; x=1729500065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gSGOk1StsSVQ0B/tQclfKgAa1y1dk9HJjhymNlVhCA=;
        b=oYySi/UuhJSx2xp7BffKTmCaED3iTAHMMRCg1TirLBTBfmah7ukcHsQ9fEkuXd0wpa
         5cE9qKLCP9o252alj1keBofeR/37/otUWW5jFThcZKpb9/Qxth1RcyJiNlcAZhPbwyA2
         r7CK70dQhezqz6nmeyxM+RayfIDVZlZt2xrZodVXx2crP7PSZw5+cgAOf6yFlcC9AvW0
         /owyrkbDY3Yh4XyxrqUfEV/rBi3R8+5R6bi2px+/qIO61x97Akf/I4aQmG6L3PffRT9a
         J/4Zm+iBVk8hRPmWiSIKi/qMirtXkqjz5y9LYObtWNx2nEO2vcBajK2MU6fMWPePz6Qb
         LU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895265; x=1729500065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gSGOk1StsSVQ0B/tQclfKgAa1y1dk9HJjhymNlVhCA=;
        b=fLNS+mYG2YUovsgM5gu46QNh97+PpY0EAWtbPgi32y36J7lfqyJPNXhJ5wcnozvnJY
         KQvgF+4pw4hiSocXqZKQW6/a4Aicuhqd5SxuzvOPb/sWJZa9bzVUtSRsL5lKsUfQWLb5
         9GA1ZIl7obTHpLtWAgbVMGNI/11DcFQHWt4SyCIrkgMbjSAYAeTKP3acPPJKuvlDHQHD
         VyCIq2CutzAJd6iW1pfcoAqF1AkxJrYiqAH4r49dVTwi+7musVH6FRWYr3QyWB+n+ku4
         EgwTis6dtrY31PeMfEOKSGVZAVgs2QisAJ/cIH5TDQzjldWpnd/+b63roQLzF4GXzuMR
         mQOg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ocpS7UyZ6HHzaiNVHo018CDfSU4b7Q9d+9U247PWDqbt6YNAPOuQMSZ/AhpOi4jl4DmHxBHY4kyzswqmngho@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLypE0/Ukd82phMGaIkISOrC9oFDWJNNJC+p/NH+G/8/Es1QT
	2IEIFnhH5LaJl0rAHb++v0Log0MKyAj+eTUY/l3LVLVq8g3vI/kWBy0nEmIYFAmAeX+GrBGAb4M
	Mulk=
X-Google-Smtp-Source: AGHT+IEveUAgZbDhy2DQdu0VRzyJ/Oh+ZamPGbCYi7D425oZff8DPXg7iNomCrsClFGNJU+6zT6AjA==
X-Received: by 2002:a05:600c:1d26:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4311deaea05mr83712215e9.2.1728895265251;
        Mon, 14 Oct 2024 01:41:05 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b444csm148010215e9.33.2024.10.14.01.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:41:04 -0700 (PDT)
Message-ID: <d4d5528a-2420-4f0b-a251-cc3db26345fc@linaro.org>
Date: Mon, 14 Oct 2024 09:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf test: Document the -w/--workload option
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20241011171449.1362979-1-acme@kernel.org>
 <20241011171449.1362979-4-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011171449.1362979-4-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 6:14 pm, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Wasn't documented so far, mention that it is mostly used in the shell
> regression tests.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/Documentation/perf-test.txt | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
> index 9acb8d1f658890e9..62ce705d365f0442 100644
> --- a/tools/perf/Documentation/perf-test.txt
> +++ b/tools/perf/Documentation/perf-test.txt
> @@ -48,3 +48,17 @@ OPTIONS
>   
>   --dso::
>   	Specify a DSO for the "Symbols" test.
> +
> +-w::
> +--workload=::
> +	Run a built-in workload, to list them use '-w --list', current ones include:

Should be --list-workloads now

