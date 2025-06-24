Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD827A93A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757853; cv=none; b=h7ZQOeTXwI5nKGcsa6iGcUZWzcDNyRU/HLF9Y2Tx+7SbyFbZ5W8irBkdUS4o8DDh3pQWMXOIjLJZ8o3W3RZ4qBKArF8M9PVHyPGflc1qlBCHpHmlxryL12NMq6hnYjPDf4zrWTeRl+789RlP43gtCxWkdmq1vgBhmiugv2ODoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757853; c=relaxed/simple;
	bh=7GyfuRcxHI3wYfcpmH6DQc3hqO5Ia6KBlYMD/4ztclE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMtdb/b50UtJp3QQfrCAKeImj8nrYIGJChIiZ7RSNsqiDDVXWMk2fOB34ffrDAa/wmbvwIWPOO8P5boXccLMAz2q0OLTFJzgkbtT6zZteEigmSfWGmIJOI8dHXvbkTj/oYrSnWctYs7vmQvwhjDB83IJl+Ii72nLftSKu6mhuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a0rULMdd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0rULMdd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453426170b6so36373275e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750757849; x=1751362649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfNXhz6q5k0P6nkegY6baRJCP6HE9s3bplv9nGDUkoI=;
        b=a0rULMddNetPPp8T9I529skpQJj48bh+uWwF/VyTCD+5sC1kb726hCN/KIgRHMjG2z
         LQM1Lmk8eGBrqZWgmNWau7HA9EPXsxrngZZOrESKOsDTCA82fe+WhDlGDRsfKPZ9gi6Y
         yqSnYNJtMro2bDgA1OwR2cZGtmiFri3bU5vIJzWF4mEpRKReuHOX/5VdyRngqNKZAlpX
         mJ98xvpDNJtxsyEu0vgv1Ije+Ed7i1a+6ygWazG6VhJa8MHxVFzeoK9ncsnY8KTZQXcb
         3p5yKYvijVJw5VtwNLRAaCmClt/4eminuEWsBMmLHOh+cgjrXaZYGfIk14+hlhJLLL1X
         AbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757849; x=1751362649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfNXhz6q5k0P6nkegY6baRJCP6HE9s3bplv9nGDUkoI=;
        b=R3rnnonOFjExCd/rwI9Y45lBEmja67Uf0x1IujJIRgw9VPirtcvLHrOikfUVmASvLK
         IXq72ed8lEC21+JP8Zc8J1PoBD9YMNNhjCH9tbUR6ruZHtnMzkX7PdnDKB1WmTDil8sm
         7lbGlZsjRmhv5KzjbmL7cHop9IhiJP46/3Vl4dpGclgGwxKu9KQa3XC1m8EzjDsE5Ltj
         fzPQJMoAjGatFWcf4Zw3D1ToVM0/W46a3mVk3wplv7NmCyDp0FFOJ4ULxAWNOtzxrlRP
         B/pwTK0bOlfCZTkzChDUijumv4J6Z1sGDo6QTjvWpaNyFR/awJbH/GWFXjoHNRrEyNu8
         9Ykg==
X-Gm-Message-State: AOJu0YxJxlAjANy3LQ2PnO5hWpo/KOG+n/r7BCZqZ7g2JxrbA9SXlr3E
	7gnuI18DAu1GxOb6dVWgByUc70Z5aV7xYOeabE9Ylvj6616GYmXEv9Dy8zN4nfUOmjE=
X-Gm-Gg: ASbGncu1bS1bwiWQbHc6Jl6esL1zSWx6MJ/w7Uog3tS9Ya+MUQROaLk5HKtLowr+FJJ
	nmywft1lgwnp/V6Y6AU7smSP67LgbBLXMEhkUchLMnlXUTGFb9PwkhBgdK7iOk4mNDyiivN2VhK
	5NmZWi49UNL+6BVHKqicNWPNp1SdIELLlxyfpOMh9/XncC7Qs/6VUlXlQQ495z8yVxOjYYQV2JJ
	MdxW9MFqbwk9mDiJH+nXk3XITZGEoRKvldfVQi83VpwOK2t7lptY7bbgpeN5uLc/II1RlBKKMTp
	VykauJkcbA2XdADeAEEY011zIqEVGmLVYgKGtLYsaN3LEcWQE3K1lVO47sNh1jZAb1A=
X-Google-Smtp-Source: AGHT+IGfuT+QbNunAWA1rLzvFK8P6VCNJjKEWWQJNrtnAVEE+2a4LO8VDvs/sqlIuJ/iW6fqtkOhYw==
X-Received: by 2002:a05:6000:2801:b0:3a6:d95e:f37c with SMTP id ffacd0b85a97d-3a6e71c0f28mr1661908f8f.2.1750757849312;
        Tue, 24 Jun 2025 02:37:29 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8062e9csm1469051f8f.25.2025.06.24.02.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:37:28 -0700 (PDT)
Message-ID: <6f1c995d-2db3-46ef-b113-31139903aaa3@linaro.org>
Date: Tue, 24 Jun 2025 10:37:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf build: Specify that shellcheck should use the
 bash dialect.
To: Collin Funk <collin.funk1@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2025 6:44 am, Collin Funk wrote:
> When someone has a global shellcheckrc file, for example at
> ~/.config/shellcheckrc, with the directive 'shell=sh', building perf
> will fail with many shellcheck errors like:
> 
>      In tests/shell/base_probe/test_adding_kernel.sh line 294:
>      (( TEST_RESULT += $? ))
>      ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.
> 
>      For more information:
>        https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone ((..)) is...
>      make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kernel.sh.shellcheck_log] Error 1
> 
> Passing the '-s bash' option ensures that it runs correctly regardless
> of a developers global configuration.
> 
> This patch adds '-s bash' and other options to the SHELLCHECK variable
> in Makefile.perf and makes use of the variable consistently.
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>   tools/perf/Build                | 2 +-
>   tools/perf/Makefile.perf        | 2 +-
>   tools/perf/arch/x86/Build       | 2 +-
>   tools/perf/arch/x86/tests/Build | 2 +-
>   tools/perf/tests/Build          | 2 +-
>   tools/perf/trace/beauty/Build   | 2 +-
>   tools/perf/util/Build           | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 06107f1e1d42..b03cc59dabf8 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -73,7 +73,7 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-y += $(SHELL_TEST_LOGS)
>   
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d4c7031b01a7..e0cf8db5462b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -252,7 +252,7 @@ endif
>   ifeq ($(NO_SHELLCHECK),1)
>     SHELLCHECK :=
>   else
> -  SHELLCHECK := $(shell which shellcheck 2> /dev/null)
> +  SHELLCHECK := $(shell which shellcheck 2> /dev/null) -s bash -a -S warning
>   endif
>   
>   # shellcheck is using in tools/perf/tests/Build with option -a/--check-sourced (
> diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
> index afae7b8f6bd6..d31a1168757c 100644
> --- a/tools/perf/arch/x86/Build
> +++ b/tools/perf/arch/x86/Build
> @@ -10,6 +10,6 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-test-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 5e00cbfd2d56..01d5527f38c7 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -22,6 +22,6 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-test-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2181f5a92148..d6c35dd0de3b 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -89,7 +89,7 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-test-y += $(SHELL_TEST_LOGS)
>   
> diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
> index f50ebdc445b8..561590ee8cda 100644
> --- a/tools/perf/trace/beauty/Build
> +++ b/tools/perf/trace/beauty/Build
> @@ -31,6 +31,6 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 7910d908c814..2dfa09a6f27d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -421,7 +421,7 @@ endif
>   
>   $(OUTPUT)%.shellcheck_log: %
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
>   
>   perf-util-y += $(SHELL_TEST_LOGS)
>   

