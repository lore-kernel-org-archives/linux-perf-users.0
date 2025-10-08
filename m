Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE32F6190
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921815; cv=none; b=qxOIKqqjy4TQnCWQn0ynrGRVK5IGrQJBGCfavLRgQz/pkasgsdQ4LyQnuO4BoYSee4OO6tnd8BM4qtnmS3TXgXvdOStcHH2NXzf86VAA6pUsxjPTseMzPhnNx/WlP5o2Nv7T1CUFJXMOdjOWkVzfbpVeGojzbwrObFLFk4ujvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921815; c=relaxed/simple;
	bh=Hc9v4R2rZeWS6dhtjrba26/RGxHd6MKWKm0ydk+IG8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwPaydxno0QLDOhcxMz45he7JiXZvMuAwYJkMyQIvL3cY6OsNXGnLyw/fljjDDjZH3qYpwj4MhA8KhqJUeBNz6+Gd0M/nvTna8Z/eMPOcZZ3xcbM7HJrEXhlAgBEAhy97NLESdJJcHhClapci+R8LNslMLtUnbFmHQEJG3FiCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3pCEMDQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3pCEMDQ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so2288298f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759921810; x=1760526610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOoCoo/kRZ9H2eYNIlPbfERHPSdBnOUarDV0tF/Vsy0=;
        b=U3pCEMDQ/WqeBM8hQfnfzwat+VF4i2qoSxyZ8MAtW3AvlvVVW66eYShQEfSYYOnS0B
         6MU63fw6aNHFWMfCUnGfdEHNyu8AdWET8cX5bx9G8YZyBqhgFiA1lJ92Jw9394fHSu+R
         VzkwkVhQOXreIoB7xn9tgrePlAXrjE19MqE/dgAIzRnCWdyzcjbUocg8NB5vqs6q4GkW
         +hV+8hvkvtmBrBOVOLjgb/LY5YRigX2G7kExBbdaEuabMQ39TxcgHPjoJC3joGfZpd3p
         CTEej2M2/pv/QXiOUBBsXPIjbKzn9Vm4ZsEvZU6NuW7lPthm9y7adaXfUuzuw6c0+Sub
         Z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759921810; x=1760526610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOoCoo/kRZ9H2eYNIlPbfERHPSdBnOUarDV0tF/Vsy0=;
        b=tfkEmpDEECR1tG4XAWMTPNXpAKEYRXcDKx5691plzmQrc0fv2dP5idqUw8ELZ99vcm
         NHDiDc3QLBiMXuYU/aOi7AcKAX5941JK/gu5+0YkngwNYtfrwnEqTthjgiTPDCOa7e8K
         nO2s1D/W7w3K208S5eHvs76dvWz+9X0mW92n63lPMLIvChvwPeM88tvlKGlbzi+BMfAy
         SJk/trp7ehN22NXDci1BfOBTFMLRSCR7GbWqVOUGNTC4rrf4RHv+ljC3c90GqEtBdOu3
         TsYn3ZP9l8k7VG1ZsJHzprqamvZzvn6SIqRhjctBnG3fONwn3zFLPvnAIDsgnHt5c4bI
         c48g==
X-Forwarded-Encrypted: i=1; AJvYcCXcSxxm6WMB5v0TioKddBwdBndlprY9k7+NGBaTiBe6eLF5qIcKTMPTRTi0UtllaS/IZcFv8AzrRuW3Jsf5j72Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyb6NJnx7esHKcQ6JqLtvbVdZ0PnK9xE6o2BIGj4nhqzbjAU+
	Bxk89ClI1ogybyqF+Deaey+dvoQpDb37f2fTEdTAYfKpWa3eMbF9WTVI4LplI9nEH3Y=
X-Gm-Gg: ASbGncvveTaKX17R+daNHlrwUHsEL9g88PZsWm8XMZLGZSFxlP6qGiUem4sXBIzCdrT
	BZ8ZOOM7EYWk+MsY//k3xgiYE9COIM0z+kV7yHhTwsoV0ZyfHD1ohF73mZAou5qw7H8+UHyixrs
	R56NO1bL5SGJrGKX0ilpvP29K0Mz9P4pQXfl/j6Zcbiixry8wlfyfsAeT/htkZO+jmWavT98dYq
	DWmdGkm1KVdFn3f5xyAfgg/bBDTmphFVgCUkX9A484Q6YVThcy2OpdzAYlXhsfDB8TfHC6QKaQc
	yTtpS+CgDjccYcAopKDaon2l1YW7qcO1cOnXdnyOPaBTbqEzPIkXarDmoWi3t9SlSa4gR6HOXUm
	QAO3Bx0WKGa5Y+DNGsMaQW2nDYMedQjaOqzro9STlbYVAw0yb64ft6DV5
X-Google-Smtp-Source: AGHT+IF8pm2Ysws9HfcmS5cWanYD1JrHATnvRtGm0Fo22qsjus/ifCiHFP30UTcyrVr2FtN+/LKHoA==
X-Received: by 2002:a05:6000:4301:b0:3d8:3eca:a978 with SMTP id ffacd0b85a97d-4266726d56emr1504591f8f.21.1759921810043;
        Wed, 08 Oct 2025 04:10:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f011bsm29928260f8f.46.2025.10.08.04.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:10:09 -0700 (PDT)
Message-ID: <fcba9459-9a5a-44c9-976a-323a6f4e0429@linaro.org>
Date: Wed, 8 Oct 2025 12:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/27] perf jevents: Support copying the source json
 files to OUTPUT
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20251005182430.2791371-1-irogers@google.com>
 <20251005182430.2791371-6-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251005182430.2791371-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/10/2025 7:24 pm, Ian Rogers wrote:
> The jevents command expects all json files to be organized under a
> single directory. When generating json files from scripts (to reduce
> laborious copy and paste in the json) we don't want to generate the
> json into the source directory if there is an OUTPUT directory
> specified. This change adds a GEN_JSON for this case where the
> GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
> specified. The Makefile.perf clean code is updated to clean up this
> directory when present.
> 
> This patch is part of:
> https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.com/
> which was similarly adding support for generating json in scripts for
> the consumption of jevents.py.
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi Ian,

This commit breaks the build on x86 for me, but not Arm. I also had to 
do a clean build when bisecting as it seemed to be sticky in some way.

It fails on the empty pmu events file diff check:

diff -u pmu-events/empty-pmu-events.c 
/home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.c 
2> 
/home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log 
|| (cat 
/home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log 
&& false)
--- pmu-events/empty-pmu-events.c       2025-10-08 11:49:46.341849139 +0100
+++ 
/home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.c 
  2025-10-08 11:54:40.619999115 +0100
@@ -19,239 +19,8 @@
  };

  static const char *const big_c_string =
-/* offset=0 */ "software\000"
...

The output continues with the rest of the diff, but I assume it's not 
important to reproduce the issue.

Thanks
James

> ---
>   tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
>   tools/perf/pmu-events/Build | 18 ++++++++++++------
>   2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7d6ac03a7109..278e51e4b5c6 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
>   bpf-skel-clean:
>   	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
>   
> +pmu-events-clean:
> +ifeq ($(OUTPUT),)
> +	$(call QUIET_CLEAN, pmu-events) $(RM) \
> +		pmu-events/pmu-events.c \
> +		pmu-events/metric_test.log \
> +		pmu-events/test-empty-pmu-events.c \
> +		pmu-events/empty-pmu-events.log
> +else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
> +	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
> +		$(OUTPUT)pmu-events/pmu-events.c \
> +		$(OUTPUT)pmu-events/metric_test.log \
> +		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
> +		$(OUTPUT)pmu-events/empty-pmu-events.log
> +endif
> +
>   clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
>   		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
> -		tests-coresight-targets-clean
> +		tests-coresight-targets-clean pmu-events-clean
>   	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
>   		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
>   	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
> @@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
>   		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
>   		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>   		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
> -		$(OUTPUT)pmu-events/pmu-events.c \
> -		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
> -		$(OUTPUT)pmu-events/empty-pmu-events.log \
> -		$(OUTPUT)pmu-events/metric_test.log \
>   		$(OUTPUT)$(fadvise_advice_array) \
>   		$(OUTPUT)$(fsconfig_arrays) \
>   		$(OUTPUT)$(fsmount_arrays) \
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 32f387d48908..1503a16e662a 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,7 +1,6 @@
>   pmu-events-y	+= pmu-events.o
>   JDIR		=  pmu-events/arch/$(SRCARCH)
> -JSON		=  $(shell [ -d $(JDIR) ] &&				\
> -			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
> +JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
>   JDIR_TEST	=  pmu-events/arch/test
>   JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
>   			find $(JDIR_TEST) -name '*.json')
> @@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
>   	$(call rule_mkdir)
>   	$(Q)$(call echo-cmd,gen)cp $< $@
>   else
> +# Copy checked-in json for generation.
> +$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,gen)cp $< $@
> +
> +GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON))
> +
>   $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
>   	$(call rule_mkdir)
>   	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
>   
> -$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
> +$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
>   
>   $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
>   	$(call rule_mkdir)
> @@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
>   	$(call rule_mkdir)
>   	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
>   
> -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
> +$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
>       $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
>   endif
>   
>   # pmu-events.c file is generated in the OUTPUT directory so it needs a

