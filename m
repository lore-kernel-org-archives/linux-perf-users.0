Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A113E8661
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176019; cv=none; b=hh5c0lYMAKF85uJKNAPb3Q97PZ7z0zHW1b5Vcer5kUeUckFredDr/jeqskSw5K+nWzP8M1wnrwiPksIDtDLTndorIQtQppYpnaVa6nbvYpNiCifCMd7rgMguSEWSiO++/bW5KDbU6I6UKoSbDaUdAiZzkiLrvczzCG40YVGTNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176019; c=relaxed/simple;
	bh=D9kkciSYLlfxqhIOYnVkWaLSaW30TWuPx2vmvKos2qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcj9ufprbR7mXd+O8gZklGxNn8WcE4s32LPsezM7AV50yoRrRTik+3TrXRJf+Jbb2IQFdDZue2j5NMTUOZFcsrl+UfVGUswo6krOCnhZW1mmK5Fv9kU9AmpZHOw2fuTjBv8TLKy6x62/umLab/SzqyXAgYkPq/7F4WXfz6ITAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHsur/9X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHsur/9X"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso5751934f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776176016; x=1776780816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wszm6aLEcUiLQ1Kk0G+I9eoocPOdS7FUfJ9suaTdAkI=;
        b=aHsur/9Xy4BY2oEmffeOxpT3y0e2XpRXHKX64HHgzmAk2Vcgs6yt1GkIY3tkqpzw5q
         bSzq2+ynhHnEWdTeFmP/8w9Tb3EyqKUQunatj17oXspu1NwrKp5Ls3PgnhCmn1TRARtu
         VFrmAmJJ7kjv5mHwVweyhKegVk4lPVXr1oD2fKdZaKXszuxxRMbBgitQsr9R3okT7Kgf
         idSG6H+KrPn2EWRb2iT/PJ0CA9ucbAwChV44HemOY9m2EnUcxJLHMj0PNJpBfLlATHHT
         4C/1Gz1dA7ppFeQLYt8LCxpSSz0rw/Lq3InSbKBHuV7Lk3zIS27AS0AnHfWXfqttq8RZ
         WRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176016; x=1776780816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wszm6aLEcUiLQ1Kk0G+I9eoocPOdS7FUfJ9suaTdAkI=;
        b=TKVnWvTt1IGtNw3CM4d6Gde4AwavZ1Ene5I6JXl905uvFttClJxpr9townVoA/RZvU
         MMIeYSBd9goMi3QyN2TiVdn5FJJyjem4B5rrdCxp1x+ChbxdmNrYGso2hUdL7rRi60vo
         2XnmgLeu/Sc3ClHcVnY/pwRrJYx7OhL65Ic2dKQFQk76uzk5zHTaVHKx8Y4R8FzLAt/v
         2d0Zv30mxjjVuZZJ4EibVDKK8JTWKJSuIJyT+KwPSaDCWgEsyF1mQR+p9ySOEcXFhTvA
         A+rDUDkTDGs0ACMaz002jLR7xEHlhwAFL6HIH0GCiXas2QMR8W/wVJviXiqyl+dZFdsi
         r5gg==
X-Forwarded-Encrypted: i=1; AFNElJ+IPIhg1ho+kN8Ophbtfk/xrtQAHpyPHfiPBoVaOp/OorC/3HdC5zhK/vCm6c21B/WTau54GmpjGo2skusTN2wb@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgfeVEGGWwXCTjQvoZ1ONreeECB2o7I+09xs+AN2v25aKsLiB
	DGL6egByFu/EeCElg2G4uJS5cvwife5Qs40iKv4TBrozzp2wsA9HHEhvEnArnh6iQ+M=
X-Gm-Gg: AeBDiestV7bPBqB2pcutCiH0ORR+27oMO3xkG9+hMKQLc/6gweOjRVVawyJgqeDCqY0
	TZA1k1MVTZ2qv09nffPkEMr8xTrFWY/sHe/7ETv94S1j629Atk8Up8/J1znOEavm3dNDo9dGg7q
	ckpmwT+ZyYalm3nuW5MJEjXKWSpwTKW7vgSlM61KeFp8mUzFomiQ/E/wxBVCSZcabJoA0zt2uaw
	i5dAkL1hWaikdbpdjb9hC0R3pS5+xDySRYfJW8s+hsJLZ6ybhm/ZE7i9IR5SUjaqNNs2XW7uOPu
	UE2ElkCqdpqYgbQv/Y4tMmpSI/4ojV2xC8ysDJc/tc7Wpo/SJzhfo6TDNHVhImlbP9Nb9R7tD42
	QOOC/ftIIHJ4uGAvU4KwyQFvi+y4gWVO8eypgxjE4MVXemti5FDSafzwUiba+ctUAX17bVkRqNC
	qOAbZnVFi3/M0exFRkN1GgZyA8p7mHVFxha01oWh0m
X-Received: by 2002:a05:6000:1ac5:b0:439:b60a:b400 with SMTP id ffacd0b85a97d-43d642c8697mr26566959f8f.31.1776176016149;
        Tue, 14 Apr 2026 07:13:36 -0700 (PDT)
Received: from [172.17.16.20] ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a53sm40731568f8f.5.2026.04.14.07.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:13:35 -0700 (PDT)
Message-ID: <50a6456e-fa30-447e-8b56-3d2af496fede@linaro.org>
Date: Tue, 14 Apr 2026 15:13:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] perf annotate-arm64: Generalize arm64_mov__parse
 to support standard operands
To: Namhyung Kim <namhyung@kernel.org>, Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-4-wutengda@huaweicloud.com> <adSrL-iZna3pyDrY@z2>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <adSrL-iZna3pyDrY@z2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/04/2026 07:58, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:47AM +0000, Tengda Wu wrote:
>> The current arm64_mov__parse() implementation strictly requires the
>> operand to contain a symbol suffix in the "<symbol>" format. This
>> causes the parser to fail for standard instructions that only contain
>> raw immediates or registers without symbolic annotations.
>>
>> Refactor the function to make symbol matching optional. The parser now
>> correctly extracts the target operand and only attempts to parse the
>> "<symbol>" suffix if it exists. This change also introduces better
>> handling for whitespace and comments, and adds support for multi-register
>> check via arm64__check_multi_regs(), ensuring compatibility with a
>> wider range of arm64 instruction formats.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 85 ++++++++++++++-----
>>   1 file changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 33080fdca125..4c42323b0c18 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -14,12 +14,38 @@ struct arch_arm64 {
>>   	regex_t jump_insn;
>>   };
>>   
>> +static bool arm64__check_multi_regs(const char *op)
>> +{
>> +	char *comma = strchr(op, ',');
>> +
>> +	while (comma) {
>> +		char *next = comma + 1;
>> +
>> +		next = skip_spaces(next);
>> +
>> +		/*
>> +		 * Check the first valid character after the comma:
>> +		 * - If it is '#', it indicates an immediate offset (e.g., [x1, #16]).
>> +		 * - If it is an alphabetic character, it is highly likely a
>> +		 *   register name (e.g., x, w, s, d, q, v, p, z).
>> +		 * - Special cases: Alias and control registers like sp, xzr,
>> +		 *   and wzr all start with an alphabetic character.
>> +		 */
>> +		if (*next && *next != '#' && isalpha(*next))
>> +			return true;
> 
> It seems you check any alphabet charactor after a comma for multi-regs.
> Does that mean the first component before the comma should be another
> register?
> 
>> +
>> +		comma = strchr(next, ',');
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static int arm64_mov__parse(const struct arch *arch __maybe_unused,
>>   			    struct ins_operands *ops,
>>   			    struct map_symbol *ms __maybe_unused,
>>   			    struct disasm_line *dl __maybe_unused)
>>   {
>> -	char *s = strchr(ops->raw, ','), *target, *endptr;
>> +	char *s = strchr(ops->raw, ','), *target, *endptr, *comment, prev;
>>   
>>   	if (s == NULL)
>>   		return -1;
>> @@ -31,29 +57,48 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
>>   	if (ops->source.raw == NULL)
>>   		return -1;
>>   
>> -	target = ++s;
>> +	target = skip_spaces(++s);
>> +	comment = strchr(s, arch->objdump.comment_char);
>> +
>> +	if (comment != NULL)
>> +		s = comment - 1;
>> +	else
>> +		s = strchr(s, '\0') - 1;
> 
> An interesting use of strchr().  Oh, I found the strchr(3) man page
> also mentions that it's a supported use case.  TIL.
> 
> 
>> +
>> +	while (s > target && isspace(s[0]))
>> +		--s;
>> +	s++;
>> +	prev = *s;
>> +	*s = '\0';
>>   	ops->target.raw = strdup(target);
>> +	*s = prev;
>> +
>>   	if (ops->target.raw == NULL)
>>   		goto out_free_source;
>>   
>> -	ops->target.addr = strtoull(target, &endptr, 16);
>> -	if (endptr == target)
>> -		goto out_free_target;
>> -
>> -	s = strchr(endptr, '<');
>> -	if (s == NULL)
>> -		goto out_free_target;
>> -	endptr = strchr(s + 1, '>');
>> -	if (endptr == NULL)
>> -		goto out_free_target;
>> -
>> -	*endptr = '\0';
>> -	*s = ' ';
>> -	ops->target.name = strdup(s);
>> -	*s = '<';
>> -	*endptr = '>';
>> -	if (ops->target.name == NULL)
>> -		goto out_free_target;
>> +	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
>> +
>> +	/* Parse address followed by symbol name, e.g. "addr <symbol>" */
>> +	if (strchr(target, '<') != NULL) {
>> +		ops->target.addr = strtoull(target, &endptr, 16);
>> +		if (endptr == target)
>> +			goto out_free_target;
> 
> Hmm.. shouldn't this part be executed regardless of presence of a symbol
> name?
> 
>> +
>> +		s = strchr(endptr, '<');
>> +		if (s == NULL)
>> +			goto out_free_target;
> 
> It'd be safer to check `if (*skip_spaces(endptr) == '<')` rather than
> strchr().
> 
> 
>> +		endptr = strchr(s + 1, '>');
>> +		if (endptr == NULL)
>> +			goto out_free_target;
> 
> I'm afraid C++ programs can have symbols with <> for templates.
> Probably strrchr() would work.
> 
> Thanks,
> Namhyung
> 

Maybe a test for this function would be good to make sure it still works 
the same for old and also handles the new inputs. A lot of it looks 
quite fiddly and I didn't see any dependencies in it that would make 
testing a whole list of inputs and outputs difficult.

>> +
>> +		*endptr = '\0';
>> +		*s = ' ';
>> +		ops->target.name = strdup(s);
>> +		*s = '<';
>> +		*endptr = '>';
>> +		if (ops->target.name == NULL)
>> +			goto out_free_target;
>> +	}
>>   
>>   	return 0;
>>   
>> -- 
>> 2.34.1
>>
> 

