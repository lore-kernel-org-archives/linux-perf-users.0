Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CC1E7C2E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666245; cv=none; b=LHeBXEi+iHcZQ0vfT0DdaY/kPbyrG6FqAb3Q8OHp4CpBN1sJgtqww03dn/fEmKcchnEzhduaKFS9xWsbAHDb2LiSl85XY+pJZ2AAxN1MRPb+r0tKW0OLd2NDKInOp8KPEXbbenDMGv8YufFdhIkWtF6h+hdxAQ4EJEoro47v+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666245; c=relaxed/simple;
	bh=FRct19OAbx0JJ/siNE7NxXqvXE/tfxAwAybWkm3Xm2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNi9il6bJ6EM0GukrI0AKV4zSXij08Bfu0z+chqElYfQLd/qOGEGbAW+MhV0wqTezuF5PFThPAZJB7KEYOhO37pSQxrBiJBsfNu519+meAoeqFTNbG6VG4g34yuJgBfoq8FFalcaIEuL3oSrFScZtZdOdKoulQw5pIxRUGGfrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PC31B3Gn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PC31B3Gn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441ab63a415so40541615e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750666242; x=1751271042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdbQQJ+oM3Ao6FCPJJXeLk0AYTnG+ErtpUOCanma8hA=;
        b=PC31B3GnQG+jsi9XfkD8BzeVf4Y/S1r9/+vlKDxBJiASSpip1EQQNv5LS+QZgXRJeA
         kWmzSnu+JzRku16GFgT/0aUcsKqeFXOO1uCPuYzD3a9SmsDbaOAJRwK1o803V3wjhm1J
         BqpwW+W7nETJg1U50YWe7HK7f7fc1aJNpOMLcM66MKpFFZAI/GMYmJoUOdKmUe/FxRxW
         T0NCI9l7xN7JdDfHbgF+Y5+F1wTXDoVQqwX/eeh0XU0TehbQsfyHisvzfuyxZx4JhtMi
         oEP0fFb3U9+Rg9DUg2Da5hVsxX7SuyNgUL3XGYXLxhaQ3X9tP+6uYa7RhpV/aF7PlWw4
         SpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666242; x=1751271042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdbQQJ+oM3Ao6FCPJJXeLk0AYTnG+ErtpUOCanma8hA=;
        b=Js3RJqPBl2zrN0aHWOXEBkPm7ie09d/Nxq/o41XG/m84O6db8q5Kvz2toTphfnUb+d
         4XDfwdFYdW8lbS/ksUITkBWGjb0QpCttbE2GcNsgTyziHq2k4s36htD/keX6+xyCRjJ1
         PlACT1AQGNnxs0tubvFftPw6xzNBTGipQdKha6YaKaO8Eu3MAeHlCKa8t6sIrAFqFvG4
         /sJDh6IIB5k582eXfcflrXdYjJpJ4guMR+AdnqcJo6jAiEWclEemnxbpu/Q6B07uIQAo
         lYqUjl5wJJXWKw+P/Igj2rJqa8XO2yNPC8wGPvVTvbs05eAE54JkMwtzeVcNLCDoy0Xp
         x2gg==
X-Gm-Message-State: AOJu0YyRrSqJF2IL9hfMNrAV/O75EthFHzqsMIY4GyVfQoS31kouAc6Q
	Rcl2ogcgD/qMcJiamxU3wv7b64LpJp4l8cTKAWzmgEaFRBkPzD8mJPgHxNz/Kpg9suw=
X-Gm-Gg: ASbGncvgwijl/v6RiTLq9phwdV+25cnxXQy5wuyw0i7WpierRqb5aUcV446kRsTJaa/
	qWA33v9LtZG3LrvemSz/6HVqeTZm7R2fGI7Ip30qD0CwUTY53rOVh1ONmzpebn/HyrGRlZ44MLp
	AGml+yOQbJfiiEbZFwqlvoeDCmMn8woqEWai9vJ3D7M3aiz9kfB6C5YLoiyH0dX4gdo4U2yt71Z
	w9E10teBmjMrKIHKNDSEEr5PMHclfjZgVEvZEC3L1Zlo2OdsN6UMdoz3xZYUofXnq6UNwkgnksu
	1kZyHpKb65XtJLWxEnDtgt8xmqlnk1Np5b6abGSpEcqEVJxaxTQ+T+WSQQiqw+5Pouw=
X-Google-Smtp-Source: AGHT+IG9/WCgHCRLCRdBfUm5EF+Cuc835GyTFmEmRHyzreAZVR+wonfkISgnq+jwxtYSzmlRlgOmfg==
X-Received: by 2002:a05:6000:310a:b0:3a5:8cc2:10aa with SMTP id ffacd0b85a97d-3a6d12fbab7mr6880864f8f.32.1750666241927;
        Mon, 23 Jun 2025 01:10:41 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f17d3bsm8685301f8f.21.2025.06.23.01.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 01:10:41 -0700 (PDT)
Message-ID: <6f524405-a9a7-45c4-bf4d-9ae33e52bfbc@linaro.org>
Date: Mon, 23 Jun 2025 09:10:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash
 dialect.
To: Collin Funk <collin.funk1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org> <874iwa71mo.fsf@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <874iwa71mo.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/06/2025 6:40 pm, Collin Funk wrote:
> Hi James,
> 
> James Clark <james.clark@linaro.org> writes:
> 
>> If we're enforcing bash style with static analysis shouldn't we also
>> change all the hashbangs to bash? Recently there have been changes to
>> change sh to bash in some of the tests so presumably the hard rule for
>> sh is no more?
>>
>> In the past I've had to replace bashisms that didn't work in sh but it
>> would be nice to have only one language to write tests in. I doubt
>> anyone running the tests today is running somewhere without bash, or
>> that changing it will break anything. If anything it will fix more
>> bashisms that have already been written.
>>
>> Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in
>> tools/perf/tests
> 
> That sounds reasonable to me. Writing portable shell is a hassle and if
> we already assume a working /bin/bash in some places, I don't see a
> reason not to use it for the others.
> 
> Regarding this patch, shellcheck will use the file extension or shebang
> only if it does not find a 'shell' directive in a .shellcheckrc. So that
> change will still require this patch.
> 
> I saw it was used in other places, so I assumed this patch was fine:
> 
> $ find tools/perf -name Build | xargs grep bash
> tools/perf/Build:	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> tools/perf/trace/beauty/Build:	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> 
> Collin

In that case:

Reviewed-by: James Clark <james.clark@linaro.org>

And I'll send the bulk hashbang change separately.

