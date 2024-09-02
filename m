Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB11C68C
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268564; cv=none; b=fD0gHo659hqO/8HU0D+rS43m2PwaxQp8XohgIgow9Ja4hfm85Jn3oUT4qcZj6pH6axvVJ9Q+9eYFJVV0VhQzjE3RdWCVE6bD1p0Gz3BxfA5/o8iD6xy8tjlFR2fv5sEFEqkUvC3L466Hn/wJqAd1WAdx1EWZE0reD3aKdn1va9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268564; c=relaxed/simple;
	bh=sU2Zeg8uSu1OdKxW66HtqBOojELTmmz59osdKKEreLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pk3gWGyIwT7vOrTMTzS7+PlaHayEUJLZXZWiAH8h0T71UwxrCYd+bwS9PIzDC7s5/XV7RoGfNlU3YVzyiJ3H//dNUGSbsFa737cYNy29RW5xjJxNdw025Sw8yiewmz7yI3y0VDEFW5gJ2pK0y9a9pVOqAXpvGrwB9mrVV5Pd9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qva3GESC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qva3GESC"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so395462866b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Sep 2024 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268560; x=1725873360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqtUFpntbJ3Eo7PvN32OL3nmlhHeCsCaqdg7902Q0I0=;
        b=qva3GESCVTjkBZK4sPR0otFKHVQtzEyR8eWNDzNE4gE6CkQNo/jnckYSpzkh+1WCio
         3BsJn5k/GBGs2Qm2xwNenDIaPvHJAgbMtFNWrT6mycnT5uoDMdF79m/ggj91NmaHLWH5
         fNKO8CRnDAM+aDBE6V/TFFw/Al3ozKmPYswTQUNr5TM53TYBPVs+J+4q9YP2rHow4Bdm
         0IZTGpYeY8tXIzx08lRQvb+CTCltL9DoaEQOTEE/eYfBIv3ZtxV6IaIJ6hWGNhcP8di4
         liacnF0Wl2EZAtXZrPulMMCEZUIuptF2++Bh9tmxrRcaReb47CMJA07gzrZypWJ9bym7
         eEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268560; x=1725873360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqtUFpntbJ3Eo7PvN32OL3nmlhHeCsCaqdg7902Q0I0=;
        b=epaorJ7sIac1tPhj3PxkB1dtA0tCdJDrO0iyp1BUHJ5vmQ9k1dMbcA6JNP11SW29LY
         BQJGCvbMEfGTj9MyovPZfS8rle43RUz98QvF7KKb5BQWPXvlsKas0t05Cgzxx6cI/+49
         sQ4tPKVh+GoiolMrtUplTJk2rsC9Sp73uj9LlsUt1ev5pw98rgUkchjCZt/NtxXHPbrh
         ozLeNSZhw0AlS+o0+9CQtHhFMpCJkaKFeZWlviVODobXs886092ob6B+eh5ibhnwH0RD
         mS2KPA5U9aNmtMNQF9xczCk3NjG4LRINvkquP0E3yR3iT8+tpRvhaqzMOpgy90dkZ2aM
         QMBA==
X-Forwarded-Encrypted: i=1; AJvYcCXQL4y8ZAq67JKxJ8iXU7CQIuYfKiymrjue6BBBtj+ciC8KBw/cUY+TbDUi7oSwdoyvHdm2LSnAo4fAjEUYQP44@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvKcfvTccXg9uZ4Bszwh0bIH9lHz2RYsKflW43xa3f4dYJAct
	6FaSs2f3zuwEmzkoaprNuKfIlONvI7KEjxKKKn5Gmm+DFBj5hC0e9fObiVn0Zkg=
X-Google-Smtp-Source: AGHT+IGCtlCu217igjODSADYqKW+kDzr94TvbAxrekukLF2TKFBYEGsz6MxdsPAx8xOBY7cNeheAsQ==
X-Received: by 2002:a17:907:9342:b0:a7a:9144:e242 with SMTP id a640c23a62f3a-a89d878230fmr366912066b.27.1725268559963;
        Mon, 02 Sep 2024 02:15:59 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892231c4sm526672666b.221.2024.09.02.02.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:15:59 -0700 (PDT)
Message-ID: <f9377001-f6d1-4e7f-a3b2-c80f5741b4a1@linaro.org>
Date: Mon, 2 Sep 2024 10:15:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf tools: Don't set attr.exclude_guest by default
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain
 <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>
References: <20240902014621.2002343-1-namhyung@kernel.org>
 <20240902014621.2002343-2-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240902014621.2002343-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/09/2024 2:46 am, Namhyung Kim wrote:
> The exclude_guest in the event attribute is to limit profiling in the
> host environment.  But I'm not sure why we want to set it by default
> cause we don't care about it in most cases and I feel like it just
> makes new PMU implementation complicated.
> 
> Of course it's useful for perf kvm command so I added the
> exclude_GH_default variable to preserve the old behavior for perf kvm
> and other commands like perf record and stat won't set the exclude bit.
> This is helpful for AMD IBS case since having exclude_guest bit will
> clear new feature bit due to the missing feature check logic.

Probably another case where again the real fix would be to add 
/sys/bus/event_source/devices/cpu_core/caps/exclude_guest and then we're 
able to keep the defaults.

> 
>    $ sysctl kernel.perf_event_paranoid
>    kernel.perf_event_paranoid = 0
> 
>    $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
>    switching off PERF_FORMAT_LOST support
>    switching off weight struct support
>    switching off bpf_event
>    switching off ksymbol
>    switching off cloexec flag
>    switching off mmap2
>    switching off exclude_guest, exclude_host
> 
> Maybe Apple M1 users will scream but actually the default event for
> perf record was converted to "cycles:P" which doesn't set the
> exclude_guest bit already.  So they need to specify the necessary
> modifier manually like "cycles:PH" and I think it's ok.

I'm reading this to assume that the default record command was always 
broken then? But what about any other command, now isn't just "cycles" 
also broken making it worse?

See 25412c036:

   ...
   (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest
       is set as the hardware PMU does not count while a guest is running
       (but might be extended in future to do so).
   ...

> 
> Intestingly, I found it sets the exclude_bit if "u" modifier is used.
> I don't know why but it's neither intuitive nor consistent.  Let's
> remove the bit there too.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/builtin-kvm.c                   |  1 +
>   tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
>   tools/perf/tests/parse-events.c            | 18 +++++++++---------
>   tools/perf/util/parse-events.c             |  2 +-
>   tools/perf/util/util.c                     | 10 ++++++++--
>   tools/perf/util/util.h                     |  3 +++
>   6 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 692267b1b7e8..ca94dd3de04d 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
>   						"buildid-list", "stat", NULL };
>   	const char *kvm_usage[] = { NULL, NULL };
>   
> +	exclude_HG_default = true;
>   	perf_host  = 0;
>   	perf_guest = 1;
>   
> diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
> index 576ec48b3aaf..8ce6f0a5df5b 100644
> --- a/tools/perf/tests/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/attr/test-record-dummy-C0
> @@ -37,7 +37,7 @@ precise_ip=0
>   mmap_data=0
>   sample_id_all=1
>   exclude_host=0
> -exclude_guest=1
> +exclude_guest=0
>   exclude_callchain_kernel=0
>   exclude_callchain_user=0
>   mmap2=1
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index edc2adcf1bae..9179bf3084c3 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
>   			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>   			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
>   			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>   			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   			if (evsel__has_leader(evsel, leader))
> @@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *evlist)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *evlist)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> @@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *evlist)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>   		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>   		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index fab01ba54e34..ab73b3d45f04 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1739,7 +1739,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
>   		if (mod.user) {
>   			if (!exclude)
>   				exclude = eu = ek = eh = 1;
> -			if (!exclude_GH && !perf_guest)
> +			if (!exclude_GH && !perf_guest && exclude_HG_default)
>   				eG = 1;
>   			eu = 0;
>   		}
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 9d55a13787ce..7e3159faaa19 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
>   
>   bool test_attr__enabled;
>   
> +bool exclude_HG_default;
> +
>   bool perf_host  = true;
>   bool perf_guest = false;
>   
>   void event_attr_init(struct perf_event_attr *attr)
>   {
> +	/* to capture ABI version */
> +	attr->size = sizeof(*attr);
> +
> +	if (!exclude_HG_default)
> +		return;
> +
>   	if (!perf_host)
>   		attr->exclude_host  = 1;
>   	if (!perf_guest)
>   		attr->exclude_guest = 1;
> -	/* to capture ABI version */
> -	attr->size = sizeof(*attr);
>   }
>   
>   int mkdir_p(char *path, mode_t mode)
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 9966c21aaf04..d33ae883a54f 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
>   
>   extern const char *input_name;
>   
> +/* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
> +extern bool exclude_HG_default;
> +
>   extern bool perf_host;
>   extern bool perf_guest;
>   
