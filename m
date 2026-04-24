Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BC19C553
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022867; cv=none; b=Gyzk8s7gqMabFwLVyQzhXpcBupVfgsyuPHsxQvhyP140sNFAZAQUbLboA4Cle+Aql3inhH4yrV9dMtjtmGRN+ql9VOfv2oC6VOF/fRB6uIxQX1jmEtWuzu2ol+oJ9gY5wGbDN3FeWQ2hvwHy7pcLl0APwyjiDXFl485CJITltIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022867; c=relaxed/simple;
	bh=V/jDuuit/T0gqKfbF6JeLznQVF5Pdk5pDHcHi3VooEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPc855/Eem7qkHM0+sbaRN72gI/zEtJqrqyTYZ2NVQ2aj4+rEuU98/RMkECoYKwuOUU0jx20G9PZBoHbgc4x7xhgvSTgC22JxCwL9eOGKukwEbQHDcImtJRsnYgIIUE3NRESN6MVmvV0ec3s/t9GID/NJAxL4IMn2PPuudIF6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mf07BGoU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mf07BGoU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso104471275e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777022864; x=1777627664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQGPdSUZArT+x56gw3hYUPcGQkhIE6zaM5Sc2CVHtBo=;
        b=mf07BGoUioypiIQVS8ZS5gfJKzAL1MFx4V31ZeWPjf924+J2g9EGByfq1fkB1sdhf0
         0WW7llJm0UkTuo52WGDGYd4mv16lXi56eI03Th4BZ2TbLHvNJZbLNa9KOkmnpZbI44SM
         If9vDtyfnPoGvkdBGQDwe1Dol5Y1VDsSOSaKPng35v8J8DbrinO5GCCH+ABp3lVQEioE
         44+vDoAA0ifZoWbY2M2CbssLBBc+TFNnPRT0yh/1Hco/2miI0nWPXK2ak2N8jk+8DKtK
         PfaXIvd46aPcALOsQf8rMqa8ZeYkMNB/L4MGy6UDHO/viYP3OEzUuzwpPAw3JKU+dkn2
         J9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022864; x=1777627664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQGPdSUZArT+x56gw3hYUPcGQkhIE6zaM5Sc2CVHtBo=;
        b=kb5Icc/atyYqy5KBGf8vtAFktxdthplB0I+axxkJt01b3mvR4hbuPLAddxmUd7A/py
         X45S+I3JBW6QNbm2jbaQCM4e5rPb88yuRQsZLhhL4KdSQxhJRrUzTBl2MG4XaNgehYaY
         M+p/eZXlqp0vV+hNnYuu8DZNAvCCk/fBV0cEPmesv/SsoK+5bryIudLI8R/KvPk7fQ68
         U63G1Y2fhnj9/yspnYgN3C2jR2GuKV0zrhLJeEkUbwddsV4mQvW/L8tekQ9G5FxlqIwN
         T3SAJPaAy5Rm3tYC4YDIOSUpPiHAGfsS4u/hsd/vnFp0ChYcaPnwhbfT4GFhotDhWTSW
         AONQ==
X-Gm-Message-State: AOJu0YzE+DTO3HJiejUnY9f/mFT7Znh6QDdVx/mKpb7hl1fBDPX6kNKb
	9KaX0sTOWwMcKM5pgY3nZE/FEhpy0uRFZPdnGs6plwqsCvDRaevrWXCrGfBs4Vj92tVG8NePR87
	DKBtR2hM=
X-Gm-Gg: AeBDievTxNUfrp4KITB+MxyOJWKrKwVmtskAF7y+Em6LCyWIWsBEPptjmEUTAPFYlfF
	dFEZSjvYUNSMKcBO+dVzcf+JwosmImPqZ3Ifhl7S+n+OmU/ECnWQpoJN9y+Bh90+m21o0AeUCct
	mhlDU/jKYMsj59O9/G7TYTS9JnnYmXZFyrv3UIGPlBZ0RMzojYPmeWZaCwv/wiAFM5gx7tUW+SR
	7ezOn31CzTioJ2I3mkJ1/9NWXuNWdYOOhsvmqqjwb3CjrRcBCrsPuFmsa0j3pOTcT9nA5E/F0PX
	Jxdobl1kjU/RoQlxxwokU7ugALY34LHEBMNrhF6tgdSfHPxH5sA2GYgp4lQJIz9yoGdrYXc5uJ/
	HYJgU8du4qE1tCVQOYJfBTh38qlIYnwHKrTJie1aP6/FdhEO0nfaCKTf0eW9KWOUhOlGGWumCz6
	7DbAmuh6+irofC5JggSwet6DFleiBtqlj/Vrq1cX+FPaQ=
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id 5b1f17b1804b1-48a53638e07mr183977195e9.22.1777022864225;
        Fri, 24 Apr 2026 02:27:44 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm59874331f8f.10.2026.04.24.02.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:27:43 -0700 (PDT)
Message-ID: <e6358476-d85a-441e-97e9-80abc9e1dee6@linaro.org>
Date: Fri, 24 Apr 2026 10:27:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched: Fix crash in sched stats diff due to
 uninitialized perf_data structure
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
 Shivani.Nittor@ibm.com, acme@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
 maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
References: <20260422173545.73144-1-atrajeev@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260422173545.73144-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/04/2026 18:35, Athira Rajeev wrote:
> perf sched stats diff fails sometimes with below logs:
> 
>   # perf sched stats record ls
> 
>   # perf sched stats diff
>    *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminated
>    Aborted (core dumped)
> 
> Also in some runs, perf sched stats tests fails
> 
>   ./perf test "perf sched stats tests"
>   92: perf sched stats tests                                          : FAILED!
> 
> ==172375== Conditional jump or move depends on uninitialised value(s)
> ==172375==    at 0x10393BD0: open_file_read (data.c:264)
> ==172375==    by 0x10393F63: open_file (data.c:317)
> ==172375==    by 0x10394067: open_file_dup (data.c:334)
> ==172375==    by 0x103942DF: perf_data__open (data.c:379)
> ==172375==    by 0x102F7CAF: __perf_session__new (session.c:169)
> ==172375==    by 0x100B5E63: perf_session__new (session.h:116)
> ==172375==    by 0x100D5D37: perf_sched__schedstat_diff (builtin-sched.c:4568)
> ==172375==    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> ==172375==    by 0x1010231F: run_builtin (perf.c:348)
> ==172375==    by 0x1010262F: handle_internal_command (perf.c:398)
> ==172375==    by 0x1010286F: run_argv (perf.c:442)
> ==172375==    by 0x10102C67: main (perf.c:549)
> ==172375==
> ==172375== Conditional jump or move depends on uninitialised value(s)
> ==172375==    at 0x10393D20: open_file_read (data.c:282)
> ==172375==    by 0x10393F63: open_file (data.c:317)
> ==172375==    by 0x10394067: open_file_dup (data.c:334)
> ==172375==    by 0x103942DF: perf_data__open (data.c:379)
> ==172375==    by 0x102F7CAF: __perf_session__new (session.c:169)
> ==172375==    by 0x100B5E63: perf_session__new (session.h:116)
> ==172375==    by 0x100D5D37: perf_sched__schedstat_diff (builtin-sched.c:4568)
> ==172375==    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> ==172375==    by 0x1010231F: run_builtin (perf.c:348)
> ==172375==    by 0x1010262F: handle_internal_command (perf.c:398)
> ==172375==    by 0x1010286F: run_argv (perf.c:442)
> ==172375==    by 0x10102C67: main (perf.c:549)
> 
> The valgrind logs and error message from the logs points to
> below snippet:
> 
>       static int open_file_read(struct perf_data *data)
>       {
>              int flags = data->in_place_update ? O_RDWR : O_RDONLY;
>              struct stat st;
>              int fd;
> 
>              fd = open(data->file.path, flags);
> 
> The "struct perf_data" is defined here :
> 
>      static int perf_sched__schedstat_diff(struct perf_sched *sched,
>                                        int argc, const char **argv)
>      {
>          struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>          struct list_head cpu_head_ses0, cpu_head_ses1;
>          struct perf_session *session[2];
>          struct perf_data data[2];
>          int ret = 0, err = 0;
>          static const char *defaults[] = {
>                  "perf.data.old",
>                  "perf.data",
>          };
> 
> Here due to uninitialized "struct perf_data", the arguments to "open"
> is getting wrongly passed sometimes depending on value in stack.
> When perf_data__open() function calls open_file_read(),the
> "in_place_update" could contain garbage value.
> 
> After initializing "struct perf_data" in perf_sched__schedstat_diff() function,
> perf sched stats tests runs without issues in multiple attempts and also
> "perf sched stats diff" ran individual without issues.
> 
> for i in {0..20}; do ./perf test "perf sched stats tests"; done
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
>   92: perf sched stats tests                                          : Ok
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>   tools/perf/builtin-sched.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..5d2740099eed 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4538,7 +4538,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>   	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
>   	struct list_head cpu_head_ses0, cpu_head_ses1;
>   	struct perf_session *session[2];
> -	struct perf_data data[2];
> +	struct perf_data data[2] = { 0 };
>   	int ret = 0, err = 0;
>   	static const char *defaults[] = {
>   		"perf.data.old",

Reviewed-by: James Clark <james.clark@linaro.org>

I had a quick look for other instances of the same thing and didn't see any.

