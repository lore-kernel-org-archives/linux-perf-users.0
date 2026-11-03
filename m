Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698426;
	b=eCASXc3C/VbHQR4kY9wiNUEeE6eXb5v+4pp+APcY8h5F/Zmvw7NSx7S7ykdL59eW45mC
	 nmaPfHzgALtFwB/q0vXWkyd3hb3nihK7Gg3hm+vtPddPOofdl9CafQ2CSj9vATus+GoIn
	 j3VYZUMy6roQs7uGUf8/3MzijbMPKFMo5f/GJMhxmafnpct/3TPVA6Xj7svlHGB6Wb55l
	 TgZ/6YbgzMxKhmyecBDTz+/BuTtgeCIqRa5CbwcEvSsNDfgOQF2XNNh98gRqaDfhvfBlD
	 hHhEFPzjnSOJRvNpMUIu1FCeqJw3fE7NnQ+JJjRg4FvsBuBJSD6y/jkK91W7zPVI+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=W203lu3CpfzgbyGH8OhcQmIar1AuF/mp2AeZJuFgT6U=;
	b=bYZGdJ87aYHpkmGYBac7+NdKhAZk6Hgmw11JLRZD1CuRFxBdKWYH7fX3dWkDUBQexLWG
	 wchJgvd/SYiANg7sYe362Ibue+UHKHuppVi9EU0UB5i+seXmet1EeNXNJTMdBLpGiWICv
	 1G6Bk/0UjtWaVhN481+WI+ZAO3cnlCJscIq4eQ5U2fAauWsFIsChj2OWgPx4lrHuUI81h
	 v1TRB7xh9HOIIj3CRz9D/sU4bLFp1lAtXMcjLIGL5AzGCDUUE5XDqX8CwFFQjnLSHalAi
	 ztNLsvdaiV99qtPK0ngJJLthw8AauSvY1q9Y+jYoEGX/DBxiUboNCpZIlwmamJ/DipA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YnOF5gQr;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA170606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 09:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA170606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YnOF5gQr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so40974975e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 01:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793698424; x=1794303224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W203lu3CpfzgbyGH8OhcQmIar1AuF/mp2AeZJuFgT6U=;
        b=YnOF5gQr8IEIkW6HWm20AuyPACLS1OptSJKmzC+7y88SO8N31+NVbPs4JcqFkm7HoE
         gWfEs7JEUNGGE8CCHmw+8v34umJM0oBTRoPEW3rHBjm/LcKoFUEvBhdTYiM7CSqQQQPC
         irEh5Aguvm51tcn+pqCn6FsodUqOXc1YoSRX/DeDs1Pt3NQhvY4LThC50Oma2Ukdx5NV
         xRGd+QWnnCYFKqBiLiIbnSwSmnKZcXIGPk7tNJELq1ekU3m3yOy1IxGC0J7f/AbvvR8y
         BfU7HY4zIsVKAhWaHKlQ/bcPN0/vcdjr/omLstUTAnFPa4W5qB0fvdLA4RwNpUN4BNao
         UU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698424; x=1794303224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W203lu3CpfzgbyGH8OhcQmIar1AuF/mp2AeZJuFgT6U=;
        b=MvqghAevWhyr5x0dBszrfVwKmQl5oezLKUH0MOTv16YgZU3JNLocvv8nA8bQpXbveL
         oxzeYNYMuyZXD8ZaRLCTXmn51AyR+p+Dj37afC9jMa1NT35fqDw5u04vox2txRew+AH+
         cjr929wNAMC/XmxtlGDTqvenNifZSH0rnWCFLXMvShGH5UcbPUE1XpmB+4uOPDmMPVem
         fSz4vHhIP8AXlydN2LdXeuHnLRdkOKTOxeYR866IXS3+mTh9HWLXzDl64bjeoAr2HJpV
         e7uxvcl9ZEWLPgSlljq4icraJokoQmeTrJRSFS0jcSg6Cr9RLBqKULRMv2gFJoJfOw73
         1p3g==
X-Forwarded-Encrypted: i=1; AKwUvByJ0UeB2c/rCnJ+UFxpzcs4yc6X4+bzCX7PY4nSzMtOVFsWcZpQFYXnkTB4TrPCxAv4hr7KTiZZTWpFGI01CZ5r@vger.kernel.org
X-Gm-Message-State: APuU4Z9+v/NjcFUIy/uGe2ELvdezZNz9zgqv72Qc1KiJGUx44YkOwlvv
	11KOfwENuFCzC0R7K6HFLLlT8ZwtGDjvRr2GfWs8tr7piceWidqMtRmYtN97B1797y0=
X-Gm-Gg: AYBFou3DxqJF3QhH/0yVqivSbGRN2fGEkvSQWcbT+kuH+jL1o1Wa9tbxrSJ5K5s7xug
	0Tg0SNm7e0PUy82HDJfoWCQHpfjPDDW6KPLMbf9GrBn8OJcHhzbe/gsKjhjfMz27O63JAaxdaIK
	SvkbV4faUFcBAFJW+dtz5AALI6ItdrGE1ClFxcgaVARKOfEiJiMkDIiOJXbVhkh9IZDBwiVaje1
	wYuIF4uXr9imMo0MouIOmXY4jJ1mGUGQeSixogyeePLl3HZ+bn4Tk34+aWTM0IPr2TNKCUlI+eO
	Q30d8FFQ0GIYaeYQKIXnuuFvhQLoO6hNSwO1KtV19g7fDsM3XRI2ZawQUduLHnNa18KAaRw5MLI
	voExUb2a2/jkD5kk0u4m64nu9f5efwV9XPJwY9gRzjBexs8s+zrsLRhMmXXdRiQt0005dKXYw2L
	mx1ZrKWEad65bCLydKWQIqVdfj6GOWgmmFemwtvAQGA9y8ueBltwytRqdgF1QIVBkS+AmEarQG2
	71agMFSlGT7OKHKyMh92VoOo4VlbH1MMyw09zbK99aPWLRoyW3MaJRARrsvrn7vhLZ94CzLizb3
	J3E97NSt3xP0AMB/WbhialnJL5iaRORW
X-Received: by 2002:a05:600c:1d07:b0:4a2:18d4:f9e0 with SMTP id 5b1f17b1804b1-4ac18c735b3mr286221315e9.25.1793698424122;
        Tue, 03 Nov 2026 01:33:44 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm25836221f8f.32.2026.11.03.01.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:33:43 -0800 (PST)
Message-ID: <5d15b4aa-dfd6-4d01-86db-df748d84aa74@linaro.org>
Date: Tue, 3 Nov 2026 09:33:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] perf cs-etm: Fix spelling mistake "should't" ->
 "shouldn't"
To: Ian Rogers <irogers@google.com>, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Garry <john.garry@linux.dev>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20261028183137.537812-1-colin.i.king@gmail.com>
 <71e154fe-0810-4292-a955-f0cbab2b7e96@linaro.org>
 <CAP-5=fVqUNoSQ72Hh5Zam3tyqooxpQ0+puAtTvr6omzmW3HZaQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVqUNoSQ72Hh5Zam3tyqooxpQ0+puAtTvr6omzmW3HZaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/11/2026 18:01, Ian Rogers wrote:
> On Mon, Nov 2, 2026 at 2:52 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 28/10/2026 18:31, Colin Ian King wrote:
>>> There is a spelling mistake in a pr_err error message. Fix it.
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>> ---
>>>    tools/perf/util/cs-etm.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index bdcf94813129..65bce2450549 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -434,7 +434,7 @@ static int cs_etm__map_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
>>>                        continue;
>>>
>>>                if (!intlist__empty(etmq->traceid_list)) {
>>> -                     pr_err("CS_ETM: Unformatted queue should't have trace ID\n");
>>> +                     pr_err("CS_ETM: Unformatted queue shouldn't have trace ID\n");
>>>                        return -EINVAL;
>>>                }
>>>
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
> 
> I was curious how this passed Sashiko's review. Did Sashiko flag the
> spelling mistake but the fix was missed, or did Sashiko not flag it at
> all?
> 
> Thanks!
> Ian

It reviewed it, but it didn't flag it. What kind of typos is it supposed 
to look for? I haven't seen it flag one before.

I have a spellchecker in my IDE which didn't catch it either because 
should is correct and t is only 1 letter. Maybe there is a setting I can 
tweak.


