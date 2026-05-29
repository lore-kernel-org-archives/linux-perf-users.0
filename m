Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621913BAD94
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047115; cv=none; b=OD6BlkDf0bkpESs+aSICKKHq72HHfe9LcAo1BlATSoNqJaLKdCDPlgC5iAJpLm+4G88NCSgIWIX6DyrTOqFN9ZbXwETdbFcqTh3NAVyrk8Z/Wzswv6rIzpP74gJ0wTaFavrrg5hED390ps806ZDWKiYcWtr02FJ7M1gn9P6Dep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047115; c=relaxed/simple;
	bh=X31hwU/W1+w6coSj7aO7Nv8kRxibj0glKaqW0VcC39w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ud4MWxuJP1cxQZtM+ZsEKw4uWmzIQC3uPScEcuQkDdoOUk7uSlk2lEClEjmt/IskJqb2VYeuXqHkiVjQjAay8yjnCY9URcTAxL4nwvDV1LQTzgZGkv2iPqJUCXXpdInrrj8hjv+RM0V6eWCld1l5OQj4r+T70xJ/Ozssqc6/EhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3v2gBiV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3v2gBiV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905e190c71so63361895e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780047113; x=1780651913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3QH1JdOLE0AFKliWzrTEO0D9n2KH8w2Vf/pq2j5CMc=;
        b=L3v2gBiVYdgVZX4TMOdrogYVzlFc/75rKTQjpwGfnUhhjMUSz+j1/ZjNdSl5x/LAGB
         OPpFe65Bc/FLitJrXB3JkuuDlYoQWHZDjbUKOFiYNAhx2L7v+XGuyUbf0GVss6FlxcPn
         0cRYFDK2o7/UHY5TCASAdYyBE24/B9b8OAUwkw0lH9Xb6pCmiFAS47FPkZvcUF/d0pVE
         o2eMkp45v6BPkpVjBmBbTYfpvtGiT68tgszxZl44ijvYpSLN8L4nqRl636ZMohmqqmKE
         4beelargo9ibWZIWw30v2rOy6FoZXPThDu87bf9P/sPE+tLRAQTZITUkC+nm2WB/ya27
         YmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780047113; x=1780651913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3QH1JdOLE0AFKliWzrTEO0D9n2KH8w2Vf/pq2j5CMc=;
        b=QROfdnS9wt/2o9eRiZpWuTssHXJ1snLG2YMK49pqQswzkThcRsyoVlYrkdZRfUjO9C
         Et+g7OwfEmQVLADlraxisPADya7t01fDRrkpFAtlwm2W/Qv7pc6U9fFeli/K2ZJvTBWX
         Oswk7IR+0JmAQmeIiTQy2ic567n+NTTvrabxm+4tnxfNKy/nzzXEwmUT3GzgpeqGDAue
         gSc4FkMn9WT9+v29C1WJpHF/WiWNUv7uZalARkMznMk4oguHMXT9zslNkEVSkpPOG1So
         rzFp525IdbmzRBxmXo8Ap/kXc9xDJov/Parit5rIpD5TBRgiOYOpwWsj45bKQ6VCdEaE
         DpRA==
X-Forwarded-Encrypted: i=1; AFNElJ8V1ZkFFKR93g5p+ceHD66T48deAIu9Wvv/1JJU8jqKZhmC5d9zFePH+FtbDKUTMKxvKIjPRK9WyIA6+60+xmH3@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6/8LHr4b1oLt6R2Z5LaHDpsdw4BJRKBZ5pEpIGUzYAAxXj+U
	tjyfrwLjng9QKzqntBTyam0Ubma4jDJf5vkWSdT2vBYaUGJwoAPKVu2RGgHoqVe/RBc=
X-Gm-Gg: Acq92OFQ4p0l0FJCb2AGBD2t3yRgtRv8BlJy38NCAaquz2v/7i/pkawGdEDG8lfB383
	JxaZZVH2VQ/wztc+QgxdWPbhRyFwunH2zdUbOlSZpS9VRaNcFWsDgwHjcR57m47z7Z1tJBYPZSQ
	+BC9BUXRdYSfRCQLrGamGqFDPrPg2s0DSNyArUHIf36WgVRsVbYoBQPWTl4vrB/x0RNBdOnieku
	231IbMag38R8S4Ys7O8ABB+xnfoikgTpX9JPTvHq3EXP4WJecgTp2oA0u00mmCHncez7sJ0ogWR
	bKYX58D8Dd+ueLt9iPqWTD6e6nXVuId+bBsFuQ6n5psUWF4Fs2lwfYgRCu0v+L6Pvt7AjwuInh+
	q2hFrSSskJ+326p/ZoltnBcwE3H8Qu4/LdlQelNyMSvtO60CwaBSLG9CYrc1twOqa0zZD+4adC2
	auQAsrBCTL5QDCyu/8EtUPDz5wnNz43+X54zcdET/in3d1V7Matg==
X-Received: by 2002:a05:600c:a08c:b0:490:9d1b:2033 with SMTP id 5b1f17b1804b1-4909d1b228fmr36218915e9.9.1780047112792;
        Fri, 29 May 2026 02:31:52 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm2294640f8f.26.2026.05.29.02.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 02:31:52 -0700 (PDT)
Message-ID: <1749d7b0-c3ed-47b7-b14c-6acbcc763aa0@linaro.org>
Date: Fri, 29 May 2026 10:31:51 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf annotate: Fix crashes on empty annotate windows
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420-james-perf-annotate-assert-v1-1-ddf04d640569@linaro.org>
 <aegvUXJTQT9qRoDs@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aegvUXJTQT9qRoDs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/04/2026 3:15 am, Namhyung Kim wrote:
> On Mon, Apr 20, 2026 at 12:52:17PM +0100, James Clark wrote:
>> Annotate can open with an empty window if the disassembly tool fails.
>> After the linked change, the TUI started assuming there was a current
>> annotation line and could assert or segfault in the seek, refresh, and
>> source-toggle paths.
>>
>> Handle empty annotate windows explicitly: set the asm entry count before
>> resetting the browser, return early when refreshing an empty list, and
>> ignore source line toggle when there is no current annotation line.
>>
>> Fixes the following when opening an annotation:
>>
>>    perf: ui/browser.c:125: ui_browser__list_head_seek: Assertion `pos != NULL' failed.
>>    Aborted
>>
>> Fixes: e201757f7a0a ("perf annotate: Fix source code annotate with objdump")
>> Assisted-by: GitHub Copilot:GPT-5.4
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 

Ping, I think this one might have been missed.

Thanks
James

>> ---
>>   tools/perf/ui/browser.c           | 3 +++
>>   tools/perf/ui/browsers/annotate.c | 5 ++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
>> index dc88427b4ae5..321187b204d3 100644
>> --- a/tools/perf/ui/browser.c
>> +++ b/tools/perf/ui/browser.c
>> @@ -513,6 +513,9 @@ unsigned int ui_browser__list_head_refresh(struct ui_browser *browser)
>>   	struct list_head *head = browser->entries;
>>   	int row = 0;
>>   
>> +	if (browser->nr_entries == 0)
>> +		return 0;
>> +
>>   	if (browser->top == NULL || browser->top == browser->entries)
>>                   browser->top = ui_browser__list_head_filter_entries(browser, head->next);
>>   
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index ea17e6d29a7e..0261cd922183 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -449,6 +449,9 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser,
>>   	struct annotation_line *al;
>>   	off_t offset = browser->b.index - browser->b.top_idx;
>>   
>> +	if (browser->b.nr_entries == 0)
>> +		return false;
>> +
>>   	browser->b.seek(&browser->b, offset, SEEK_CUR);
>>   	al = list_entry(browser->b.top, struct annotation_line, node);
>>   
>> @@ -542,8 +545,8 @@ static void annotate_browser__show_full_location(struct ui_browser *browser)
>>   static void ui_browser__init_asm_mode(struct ui_browser *browser)
>>   {
>>   	struct annotation *notes = browser__annotation(browser);
>> -	ui_browser__reset_index(browser);
>>   	browser->nr_entries = notes->src->nr_asm_entries;
>> +	ui_browser__reset_index(browser);
>>   }
>>   
>>   static int sym_title(struct symbol *sym, struct map *map, char *title,
>>
>> ---
>> base-commit: 841dbf4871c57ce2da18c4ea7ffac5487d0eda16
>> change-id: 20260417-james-perf-annotate-assert-20f520eeb35b
>>
>> Best regards,
>> -- 
>> James Clark <james.clark@linaro.org>
>>

