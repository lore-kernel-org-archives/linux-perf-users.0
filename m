Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676725A322
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918899; cv=none; b=gitj1If5J4Xxjzyko3w4NCGzpEgNxLfuiMDoKL6rDrcmMldSS30RYKg8mAgROtteOfnrg0bhWZnQh+zhY7xtBOziPe/HXX9U2UaL7AsVvNMyYQSzkDlWjJepvqE1t8EXg2/3JU4fn+vjU1y5zKBcTUX4jAw6zKzM+KJ52KDIZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918899; c=relaxed/simple;
	bh=EhLgvD7E0LABHvPRP91GEEdQZfhx3aehQkmOfRxJheE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F79Q2PyHMqbyBLrjTboZJPlPNPkG6Zd2qTnTthOMqo0TiBUKMzw0lZr0BLsvJGMDcHs2mR28GkEd28zwy0KRKuXahThOKkOrffcMVvRdee9qBpMvf0k4IorgDV9Yrrggw90phVEdK4tvJcXV7i4NG4M6WfId8m0QyBRa1YwGenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tlDENX4m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlDENX4m"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e52279279so49829825e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759918896; x=1760523696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3YnocctbkZ7er98rP3Yets/VbNBUnYoPrVtlDdecDc=;
        b=tlDENX4mJM6+GtI5bY9xJqe3OSpmWleq57QyNwlSsoOAg/uRexxhlxEW693PXfcYYF
         4GHFEhx7e+kQ88IvyeZMs89q42+MCTr6uc3DSk0QsgVqxdsED+vsG+zQy5vmVXpjoEtt
         9zIzb+rZkFO3YuyJLFY/0rR59oSRd0F+jVTvWrvZgGnMVZoUVzbqXpnypce4i/nMHSzo
         SImAPWWjFiq8wPtAxx2b1CiaN0e6HY8/2qsNeE1kNkYLRd+aVItpVJtz9uGPXSq5KpCm
         cfCjrctx3yvc2V4TUTwnufXSerlxS6myX3wqOrFcNtH9ECcfTaJou3FK4ouXeqVeyn3p
         Qv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759918896; x=1760523696;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3YnocctbkZ7er98rP3Yets/VbNBUnYoPrVtlDdecDc=;
        b=S9sZ6PRHuPtEN2UhmDCh05PnK0Cw9Rsqh+KnwguUndZJ2dSMOn4lpEwl1+7z/HEYPd
         fe0Rc1KcQC9W2H0Jtq8MGMbXCxbDqme15/RNM68f0pQwMGlISa57ydtzPu1TpliW6bzi
         7MND+HpfYE/L/Q+e7CIEN+gMGsEeeEOiL1WovRj3LupIdyKH2P1jkjhR+jMp3uK6Elhh
         McvtUu1jEJt2E4oOeIwIqgx8guQkBnx4LGnaKy/64v+m1S7BN44YoRPfAXV+hIxX9Ohm
         +/m78qJ2xs4I4Cs7+pT/lkIARWfFQ4PhOsVTz9hJ7TOekSQjFzC2fy2knqgNXXNKjFu2
         mdjA==
X-Forwarded-Encrypted: i=1; AJvYcCWRSLEbrf8Yl4OCoUvGEwJzpGj9LmmLtoYbWz8n/VWM4HZq6BwNhj5QbdxEWnwc/ALxJmZ8KxiE26nbdFUUgOt2@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvMvog/+98qk+mbYdxuJEs0QHOLl7PZQJ6do+fVIgijNfqNoY
	5UE2HySefWiOT7gJ0VnSIYrLbWCYBVkD6nB9XcYUmbAeZuAz/OAo6nlqwfXeeZDaQtI=
X-Gm-Gg: ASbGncv72p8drI5IbksvRSpg/zgz4LLaXF+KuJw48soKYonX/dEusUNZsMSRSj0Z8Sd
	kVx/8fInqcMXK55PHt+PO18YdxeQlS2T8nlAJksWMIESUyeUgUNbxvykC08FLmVKxuvyFhv4x0R
	qiRytVhuWpCGj93v/Rr8sItSOl10Exi7Gy+8/LGQW01q+hI4vzAWrNTDbuDZgQVzD22dtoyHVDD
	kYM0O4WhcU8ccaCVu3X8CsFzZO5txLpBE6fN5HeY1ONwn/y1EWLATXEn19yl+TS1SOQ7obkNMvv
	4Uj5xNujNDJ9YySWG1cnrGWACbl+bgUVTiBlkNqF6HU7LLcvF0nTf+0jWC388njdCjGk/3gY/+w
	fWU7qC1WH1/x34YYmdvxQ9nw+MhzuuteJs9oTOkA54U5jpfS0zzfr4Hfl
X-Google-Smtp-Source: AGHT+IGrZHG1I4BquDHt0Gxg3DnN1qvMxqgyFGE7TQYpvxCsyV5GBEgNIf4ntzhI0Sph+4sHQIV6HA==
X-Received: by 2002:a05:600c:1e86:b0:46e:4784:cdf5 with SMTP id 5b1f17b1804b1-46fa9a9f254mr21670825e9.15.1759918896295;
        Wed, 08 Oct 2025 03:21:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c0e35dsm32480825e9.8.2025.10.08.03.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 03:21:35 -0700 (PDT)
Message-ID: <887ff02c-c221-4b98-be98-efe62e043727@linaro.org>
Date: Wed, 8 Oct 2025 11:21:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org> <aOVxlEXDMKJyIhME@x1>
 <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
Content-Language: en-US
In-Reply-To: <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/10/2025 9:32 am, James Clark wrote:
> 
> 
> On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
>> On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
>>> On 06/10/2025 4:21 pm, Ian Rogers wrote:
>>>> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> 
>>>> wrote:
>>>>> +       data = zalloc(sizeof(*data));
>>>>> +       if (!data)
>>>>> +               return true;
>>
>>>>> +       data->addr = addr;
>>>>> +       strlcpy(data->path, path, sizeof(data->path));
>>>> nit: perhaps strdup rather than having 4kb per tested_section.
>>
>>> Oh yeah that would have been better, not sure why I didn't do it that 
>>> way.
>>> Although the max sections I saw was around 50, and it's usually a lot 
>>> less
>>> so it's probably not worth the churn to change it now that Arnaldo's 
>>> applied
>>> it?
>>
>> I see you submitted a patch for using strdup() and then there is a need
>> for checking the strdup(), etc.
>>
>> Since at this point this is an improvement on a test and all is sitting
>> in linux-next and the window is closing for v6.18, lets leave this for
>> the next window, ok?
>>
> 
> Makes sense.
> 
>> These would be good things for some tool to catch, before it gets sent,
>> but that is another rabbit hole :-)
>>
>> Thanks,
>>
>> - Arnaldo
> 
> Does Smatch work on Perf? I imagine it would catch this if it does. Or 
> just plain old cppcheck. I'll take a look.
> 
> James
> 

Smatch doesn't know about strdup and seems to be more focused on kernel 
so probably isn't a good fit.

Cppcheck struggles with a lot of the kernely style that's used in Perf, 
especially the headers. We'd either have to silence a lot of the 
warnings, or start with almost no warnings enabled.

It doesn't have a warning for usage of a malloc return value without 
NULL checking, so in this case it wouldn't be useful.

I'm not 100% convinced that the effort of integrating one of these into 
the build system would be worth it. I know that once they're in, there 
would be constant maintenance of silencing false positives etc. And a 
lot of the warnings are more style or opinions about undefined behavior 
according to the standard, but aren't real based on what the compiler 
actually does.

As an example, cppcheck on code-reading.c with --enable=all gives 17 
portability, 11 style, 3 warning and 1 error outputs. Out of all of 
these only two of the warnings are significant, from commit 0f9ad973b095 
("perf tests code-reading: Handle change in objdump output from binutils 
 >= 2.41 on riscv"):

   token = strsep(&version, ".");
   version_tmp = atoi(token);
   if (token)
       version_num += version_tmp * 100;

   token = strsep(&version, ".");
   version_tmp = atoi(token);
   if (token)
       version_num += version_tmp;
			
"token" has already been passed to atoi() so can't be NULL in the if 
statement. I think the atoi() needs to come after the null check.

James

