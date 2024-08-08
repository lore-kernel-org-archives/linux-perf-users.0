Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03C1474C3;
	Thu,  8 Aug 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123745; cv=none; b=XKuWuwol1eDBFoTIsIXxSV8IPHQ3tRXhdRSJupy/t6TRYHpVGmHc9WJlBhtIz4IOL+EPn7AQOTOYp0r2IjyNGYGVp4GP106sGFJQUYc3Fl1QFVazeW/NB+htzB61k65ARN4mtinWgg8jF29htY1rmZYSjErxEIdNw6V4QilzyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123745; c=relaxed/simple;
	bh=P/Ca3Np1WJ2XK9rV93v4suEXB1BgIog/6YtJbEbOBEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+4QP9b4VcCSG9tWCajDlUdcagxUjLKNjAFhNFHim3ZT9M7G0zBQENRF4OIw/7UhdefBkks3woXy9UIhQU4z3GriTTXaPR7/ZXjz5IHStDXI+VHr/hmnhaqMbFTSRDnxoOlsn7PvNOH71TMzRo1jUjQQJzP5c1nASrqoZYoxT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRXOu7bb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRXOu7bb"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c1f480593bso726618a12.0;
        Thu, 08 Aug 2024 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723123743; x=1723728543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rLQxZSvtzrt/DPi5zi+47hd+I2RTWokqoNuqbyM5iM=;
        b=GRXOu7bbUB47BYo/fxVvy+Lf8VpTOAOQtaHVa8L+xOkTJ7Zfq3LH+v4p3RyAVWmsFD
         QjqBEe0GGazP+ZEQTkbyxZs2wz6NRZ66+mtDgWJC9RJwmVKZDocEFzbjYOjCIaZQy5DU
         LmlliwCZ5Gg1KW60L4RbQzDVd5YZb0XrDjGT5GPTwBa1B1A1zh04hUf0On6hM6aVlWWy
         IBypI0NRtbFkwPkBsnN0C+zx3PHo3U2XtSi5HZPE2my2TjY7R0zs6VrhRFWPS1mnDXsA
         ajkVTvr4BG1HFoJWhxQPzYIPFmpRLnf8+M8AA648OnQA+eq8ZhZ5lYs0H1KUg67UZ+Ze
         8hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123743; x=1723728543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rLQxZSvtzrt/DPi5zi+47hd+I2RTWokqoNuqbyM5iM=;
        b=PAiH6J7wZtzdAB/9Yo3M4rUjsf1aE2iVj5/s92y8jlPPXTguUxe2rcONPjgGZT3lHB
         8HuqH8DNSpgoxSt6uk3amR/j2JjUyCsC/Ns6BHV++agWnxKeSKC1OCog26s9U2d2/l0R
         t9yH/xKixgChCUVbYBOBFxT636LMlz0wqXwfMfCQxOsH1o0jWc5zgzzzIvINR1Jw6yKf
         ZxJHfwV2wes0aYtHnPp2GF4xtEuT7B7GTTWwDASpXKHjqpGxemfZu2DHue+3LmYtZJgB
         /xJUkaOjQMaTcA0aGXeiT0N+aYJSRRn1FE69w/KEIu2LPks5PItQpGlxybQHZxE0xK9I
         V1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX6wZsRJKJt+FDYiRznbhADOD7ok+sM/2PyYS3BGzGkBVECfPGs4NcnBFt1kViWFzfYn/vLMdNgGZ9Yxx9ACMTxRd0YamwhRO0ihZN0DDo41N5diRZOs+WQuOO5zBHUeEtbcfvwVKmplFmywqmsKg==
X-Gm-Message-State: AOJu0YxvTTvZQY4sDtkFmM9I+q86jUnf1yedz9EeNbJRtb8PXNLjAcF8
	Gyjw5W66vQQflTJdhyRKu7R2DcZX6LfH0z75XfmMTESUpuKd0G4B
X-Google-Smtp-Source: AGHT+IFCX36byr8PCG+IGj2zg9vDaZv2Jv2EW8Hzu5dt2R8dSC4RRyLwxQ2dSNIpo4ipau+6gIBsGA==
X-Received: by 2002:a17:90b:1989:b0:2c9:9b16:e004 with SMTP id 98e67ed59e1d1-2d1c34747b7mr2065344a91.43.1723123743221;
        Thu, 08 Aug 2024 06:29:03 -0700 (PDT)
Received: from [192.168.1.3] (123-243-193-68.tpgi.com.au. [123.243.193.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5d6a1sm1121149a91.6.2024.08.08.06.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 06:29:02 -0700 (PDT)
Message-ID: <580c0798-0587-45e9-be13-adb719069894@gmail.com>
Date: Thu, 8 Aug 2024 23:28:57 +1000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script python: Add the ins_lat field to event
 handler
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240808080027.3559776-1-fzczx123@gmail.com>
 <95455271-83dc-4765-b5b8-0851a75b9164@intel.com>
Content-Language: en-US
From: Zixian Cai <fzczx123@gmail.com>
In-Reply-To: <95455271-83dc-4765-b5b8-0851a75b9164@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2024 21:12, Adrian Hunter wrote:

> Patch does not apply.
>
> Needs to be based on upstream kernel.  Latest perf tools kernel
> tree and branch is:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git	perf-tools-next
>

Sorry for the mistake. I cloned the default master branch, and generated a patch on top of it.
Will send in a V2.
