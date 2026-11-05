Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877921;
	b=XeRb3D2ZJ60eKzdGK/U/L75oDDUDLLJbPCpzVOPrt1/SKG3s0/kHnHd1mYI04GT+qON4
	 0H666WpcAM7ENofXJ9Q1kmuAdMBOshEPbbhSwmRI+byxMEcMeOpdBhiTxGhKGI6fDbXjG
	 plF/XBTr97tfts/BIuIN/3yYIG9PuddAXrlsKzdlT7A68GXTX0/i+nywWzUTodV/WzOdM
	 8crFkCFP1Sx+lLdzC89FuvbmUmM3HyV0AsCsgT57+OM/hbNy/8HO+vXET6NKWQkHplItM
	 6EBfxPZgBgPTjCbElCOXoGpDNNQc6XICUKwfVqOVWXl/gSHklB1BSy1Yzy7FVZa3Rug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3mJGye2YtwpQkhnGEhkQL3n+Wj1sQKRFgleMKG2s6yw=;
	b=ReEqM5Yb58E7sTrGP1NTDae/HbpXOvEjXb9WbhvCl0wSZIM7WBgHqOGPRUt2J/zMGVHa
	 1TEMe536eSRuPlbuM0ieTeW+XqFhMN8fbnDj+01+w43E7R+5Lg0fPaEElhLQtqCvYVvCJ
	 settyAbB0tCi/F+NCSCAn8MNCaThlgqRS7+LUNj5Rzws+Nhapa1541m5ia/YrBg/aDK57
	 os9MjSAo20NZsHFOU7eJY3frUQXQngPF5tFeKJlwTndTkFhXYQwor8sSHQswysOm4wBB6
	 aPmxYNWpu4rydFGSFaBoWCUBmOnPvfs8QlsPwGyFek/i4KioklDla60VNxqV7ZKg/Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mhY0PwDy;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300E606D81C
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D300E606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mhY0PwDy
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b467581b98so12331505e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793877919; x=1794482719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mJGye2YtwpQkhnGEhkQL3n+Wj1sQKRFgleMKG2s6yw=;
        b=mhY0PwDymj1XIUOjomKVgagn4ktpdMTG05zQOMeuw2WHdQktnrOQH43d+xvZFpxaEc
         CCBnGul/W0WxsrFDrMSYREdcu8247Jsa8YW25+mOn5Z0YGCmF+O/wUcFvHEwlkZYWILK
         +ncGxTRKJxhBkV9HRDXEh+kSmPpdS41EGsF+LMnnpeGAzT+SLURBmG6vfdNsaQU2Xht2
         dPz3OzLHNtOysu+u1ZKgDqD8hbifyGQIL4yl1kENbU6JkgJ2H2YYDH4VvBMIFJ/vMILP
         GZDqx2XmgevFqhFb6htScjr2MIAjYS9rN8K8toC7JHNsAvfmUrOjAQcQ1p1EAP/aAlZB
         QfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877919; x=1794482719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mJGye2YtwpQkhnGEhkQL3n+Wj1sQKRFgleMKG2s6yw=;
        b=WIfTAEAY/qjbpaovZ54ZDJtdpLNkMgsdyFVPWlADitvEVcU+NERzfI4cD4qsHD2tZO
         rr3x/moPFJLzz+6YjYTfcXh9L/fP8YIkgwzImBs4ZHA3EDaPUReIF6b/6MCUHMMYExgl
         4zOPpaHTOhnsV999i7UcEdR71535cBZFAX/Qf21YhhHx3zMi0jxDG3vv0qp2SR+IeYmx
         82ZaembKFcU4CJXkILkDER6EjYqsrFYYDLSItfPDpbiukW5uUftYsNSb73GUWEYfCeR0
         c5DzigswVop8m3h44FClqOEZ3mMvOEuuBnjvyyoSsc2jUwNgdn52YZ7o0Ij6zUI77LLk
         k7ng==
X-Forwarded-Encrypted: i=1; AKwUvBwZcBFDo6SbXqfDz1hmhWxMw/o/cAkkyNWjEy9VGCH/f/SxDhLOv6lLA+IkwIN2lHnJnil0n3vsxzCf4pjc2J8/@vger.kernel.org
X-Gm-Message-State: APuU4Z9vV2bO+nwzrGf0wxWoDKqPp+30mM+8/cXPQJWhk2YghuozbrmH
	939FsnxTsiB9gpW/gSDlqtGHopSQunGOdRjrTnn2BC6VBFb335Q8mbLghJcF2LWpIp0=
X-Gm-Gg: AYBFou0fHD82gwdC8bRzVG+TvdJoT/S0gvoc5ke1NcKO2yIsvhVjosbDSuVtAFwk5p/
	WtZVP3D4C23NoBH9jEgFPtVGRZOTDWBtuNgaIMj5CxxlB8Yp7nioRnz/mHcEFk9L6jI8iekdvVH
	22KLgw7SPDaBQEgsgE56TvJoUdPAQmdDIFb6PQFON11Z2GWYnj125Ze8pcWL8YZStSeXEyhtYyw
	HK3e7zr+O7wDOnH65EW3uAg0JHWJI71NaRTaREi0kbRe5n9SDp9t8Eb//VKTooR+3lJ8YG9+fvG
	D22S4JSS3mTl4708H2riEu9EaVDmw8d3lQLrecVTdXS+51NNtcMw4lAqI92JVaXZYqS1fMFlo4Q
	NBXDmJZwJCc7wbTOmAvf71cHJRwvLOavdgNAscnErHlvsQUsIBa0OXHRHWZpnaxtqBsw1F5RMzT
	bTSeYx7xKvaIl8JDpAQN1Z6a3rRxzLoPekn6BXA/dKgZ/7GqsJhNJcaifYwa1kLjswPYxVn6+gS
	Vs0DFshGYI2LkvsL54To2evA4qfwaA61sqXtEFQITBfcp2o/u8AoFpAHf8mSCR2s5D69j/qa4M6
	YVbyI96RnxLHWn7gzz1p44LVa0LXIQju0ZND+f//aeWEeRH3tRfttA==
X-Received: by 2002:a05:600c:a11b:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4b23c810353mr147042095e9.5.1793877919221;
        Thu, 05 Nov 2026 03:25:19 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725fb0d1sm57614235e9.8.2026.11.05.03.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:25:18 -0800 (PST)
Message-ID: <7ee15d67-54ad-4608-8ae2-36b764140248@linaro.org>
Date: Thu, 5 Nov 2026 11:25:17 +0000
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
Subject: Re: [PATCH v2 3/3] perf: initialize and destroy error list in
 test__pmu_config_helpers()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 "acme@redhat.com" <acme@redhat.com>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <b9796c017042a3074956474a83c9b2170caec6db.1793867553.git.jirislaby@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <b9796c017042a3074956474a83c9b2170caec6db.1793867553.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/11/2026 08:33, Jiri Slaby (SUSE) wrote:
> test__pmu_config_helpers() passes an uninitialized "err" to parse_events()
> without ever calling parse_events_error__init() on it first. Sashiko
> pointed this out in review:
>> When parse_events() fails and records an error via
>> parse_events_error__handle(), list_add(&entry->list, &err->list) and the
>> subsequent list_for_each_entry() walks in parse_events_error__print() and
>> parse_events_error__contains() will dereference the uninitialized err.list
>> pointers on the stack, and any allocated parse_events_error_entry objects
>> will be leaked.
> 
> Fix it by calling parse_events_error__init(&err) before parse_events(), and
> by releasing the list with parse_events_error__exit(&err) on the new
> err_out_errlist path taken once the list has been initialized.
> 
> Assisted-by: LLM
> Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and config change tracking")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
> [v2] this is new in v2
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
> ---
>   tools/perf/tests/pmu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index b6ad2806659c..f208932590df 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -224,13 +224,14 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
>   		goto err_out;
>   	}
>   
> +	parse_events_error__init(&err);
>   	ret = parse_events(evlist, event, &err);
>   	if (ret) {
>   		pr_debug("failed to parse event '%s', err %d\n", event, ret);
>   		parse_events_error__print(&err, event);
>   		if (parse_events_error__contains(&err, "can't access trace events"))
>   			ret = TEST_SKIP;
> -		goto err_out;
> +		goto err_out_errlist;
>   	}
>   	evsel = evlist__first(evlist);
>   
> @@ -289,6 +290,8 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
>   	evsel__get_config_val(evsel, "krava23", &val);
>   	TEST_ASSERT_EQUAL("krava23 not overwritten", (int) val, 0);
>   	ret = TEST_OK;
> +err_out_errlist:
> +	parse_events_error__exit(&err);
>   err_out:
>   	evlist__put(evlist);
>   	test_pmu_put(dir, pmu);

Reviewed-by: James Clark <james.clark@linaro.org>

