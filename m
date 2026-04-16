Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4301C84CB
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345461; cv=none; b=gHcD4oL21BawchdHJER2blWxoVbrz2US/VcGMUXKqp/Pcc0LYGSsyEBDVF4yxgrzP1OoTIodA3mO/xm+sfGYNhC2mL/En8OiEelykJUqReNXAKKB4Cmk8534jz0eNmoDkUZSIvM/Y8wjFIqJtMtCci9zqk7fRAER7N2yx1UK4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345461; c=relaxed/simple;
	bh=KhFW0S7+B+BcgHfsB+XZahSH88X5m7q3B/nYp2+legk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRGqZgryKG12d0MR4ElJ7+CqY/Rw4C7OMUl8OAte176Dfqt2zN8CPdmSzRuEHgU1zkdMiioW3gzZyIvsGQFtsbeUs9q/QNRxk9W3XfTR7yJZRDFteipC6dl/QKfZepqnZWJYEE+l2rULaAThjMdTLbnW9NKk+j/rvTNgnDq/Fyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPmBRCc4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPmBRCc4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso122332325e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776345458; x=1776950258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuzKgEinBx7T9lBlbBf/nAloxv8a3OQ8uRp19PW3Uvs=;
        b=TPmBRCc4gqHA4ma0n9lsPpeo72T5jRqtpdfkoN1igAH3lj6jARQ2CCCYYsDvfvOM6F
         IDFghPdmjHkbGd2KGtChN2KrXUJv5N3sBcSKddD4Q58JRqI7kAI7o2T1MOlXKRzPWsPB
         A2oJ7UZGnqe5WRa5vcnydz7/lWEylWn3n0lwkdT84xMSLlWC1AR4avuWVheL6+1wvACw
         PPYgXOPz+q7YwZp5wt6qajfPDA2FhgqIGIzUvSFQPdrgcEF/yxayZ2OYwxRC2RXFpLOW
         +VtrEu9fVntsBx1eRxfvZBseCFERVXk1ZzNrLs52M1QDdgyb7dklRCyZZ9xzCPKa8Z1p
         2K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345458; x=1776950258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuzKgEinBx7T9lBlbBf/nAloxv8a3OQ8uRp19PW3Uvs=;
        b=IKJBjR2HihbM52+Oiv62BPGi4OMzbK+yoggXGZlxejfs3u5JVJ9Kib/hGliqLy2vDr
         MQxAa/uPKR2CE7qp93NhCt6re8a0DfdC9mFOWowobRGfkQwIOUd7rw5X2fTobRVfHAIz
         1LKOLRdBdTDshTEYYV7QRmA1iTBNaGXE+WFrtr9kNOw6yg3baXzvcTodKQQG9j0zpG4h
         9nANsfXDzjsIGOZxE2LdO/PWP5pSK6au6X/d6dUooJU6LCF8ddmswvKeZFeIEbEY9nNA
         T+MQF5waO1ckCa5IZDyEtiOK21ZHJSz12rPTaNRNGeesC6N3dVxyooYLSvWYQEvO4s1y
         2DlQ==
X-Forwarded-Encrypted: i=1; AFNElJ90DpQ3Q3ygiNn+QsAzcAOei5Rizqj/RtescDCRjetzbEvJTSAmUNGKlTf3MEl2Uod3Hx+fY7MHWIFztDbvm06+@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvIP2a60ETz3mYyqn+QnczeSFR/sJ8ZVgZumM2hOb9IBH3AVE
	PHsl9HEZN30MPJHxXv9J0GRZrVE75EIavbaH5Lb0C0fH+VzEBvSiybUGMOT+i2RgXLI=
X-Gm-Gg: AeBDieuBxACHbOmIFImL7AuL78FrN2n7AEN2mHvwDou4G/FaBewfQ/1F6I0c5AGKWPo
	U5qwYIVK6KR9/eUThacm0oZl65HJl//R4wDQBy3+0OrX1lOsH88st5FIaYR6w2S3etFfN5lAKtj
	LaI7INaszclp6ZptqvIFQ3ZVQ620kqYdp2aaxDLj9xlTQXb6KtZuJdvOLQggebZCVXf9RUlHkLV
	I5HkWFxGC2gwwAKumk6bxb4TBsT+wXuPRqwxI7R7a7ZQqIqF3YqlRPDV1KdUHc4P7Mgx3FEZE3s
	5R0kLqXuL9WvpBZ9uGM+aAsF3O7ylcBHgplboIMk4Oyc6bXqHhoHa+TL9qZznab1XhLbKvOfz+d
	mZMTCjr7OaAeAlwgmNZwdK+N+7vA5pUpOPguaX3cL6IM1k1xgi2WQj625eWg5gPaoc8PhRAd2LB
	wCEdLkEy0iSKSdwRfb4t6LQ+4mbUGJwxgNW5kyWRRKch/wojOPzSSP2Q==
X-Received: by 2002:a05:600c:4443:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488d686c044mr354005635e9.23.1776345458347;
        Thu, 16 Apr 2026 06:17:38 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eaffaasm44690165e9.23.2026.04.16.06.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:17:37 -0700 (PDT)
Message-ID: <2231f14c-0467-41d7-8774-5f720edc0e18@linaro.org>
Date: Thu, 16 Apr 2026 14:17:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 0/5 v2] More perf.data header validation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>
References: <20260416001424.362797-1-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260416001424.362797-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/2026 01:14, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	This is picking up from what was reported in the previous
> series, pre-existing lack of perf.data file validation, processing files
> and buffers in header.c in a similar fashion.
> 
> 	There is more to process in the trace data, but that is a
> different can of worms that needs to be dealt with in a similar,
> upcoming patch series,
> 
> 	This is probably 7.2 material, but if feeling this can still
> sneak into 7.1, feel free to do it :-)
> 
> 	Now lets see what Sashiko discovers while I still don't have it
> running locally right after Claude, before submitting it publicly, which
> will soon happen :-)
> 
> - Arnaldo
> 
> v2: Addressed sashiko comments, adding a patch to the series.
> 
> Arnaldo Carvalho de Melo (5):
>    perf header: Add section bounds checking to the fd read path
>    perf header: Validate string length before allocating in do_read_string()
>    perf header: Sanity check HEADER_EVENT_DESC
>    perf header: Validate bitmap size before allocating in do_read_bitmap()
>    perf header: Fix 32-bit incompatibility in bitmap serialization
> 
>   tools/perf/util/header.c | 57 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 48 insertions(+), 9 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

