Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B743E4BD
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582335; cv=none; b=YYIUg3GA9WcyDip599Bai262mOAcX4PqoQ83yckklOQGT1Wm+LQ8DY295RlKodZ54pmxYpSwNs3KyxaaFB6irIBZIfXI3lkxW/XpZnAKpxQnOChBWxstQ5W6BnLOLgq2jFh7WBJgpbzdCXe5KndlWF208S9wJQXoc7Qtji0Sk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582335; c=relaxed/simple;
	bh=yJaskfWO/TzIqLN2v1Bq9Ds7T78h+QLg4VxvbluRET0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJD0zn1V8fgqdJSAbpsr4zsDCDVhYB23/wWVv20lcfVPkiY3WIay9sGhL563X4dGP9oG2Y6zCk+YbfpZWu6Ue/lStDzGGLWHh98uQSLFb7YM+UUV1VIdDJCEkYYgJseNvU+0zKB8ccdL3DtQP2sYgDU0I1ypmG7yCPAIpOPEn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4Q+RYqf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4Q+RYqf"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c1630159bso875562a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780582332; x=1781187132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnIodUEuNnOHA2tst2ZqiQsOh5UQYABgRLPNUrbWXpI=;
        b=Q4Q+RYqf8OskESOPWIOEpGei6u6HKuDQ6A2agRp0V2v1OTsJn7WKvfbnVohXLutN8T
         uMwDLCK4I67M3PmLES4Ak9AduEJmEL/h8l1/TXsIFV0ZPEndDsoTiGiWi4Bk7NVRIeCX
         G+oZu/gQIq8AtY9oaYCYOEeyEl5KVkIJ0HkuA4ztdycijbGbWHTCwT1IFtTcGb735q0Q
         ORdoQxeDIsxSKN6EBh2vxZGVJwhf4QLCwLlwFR56he6ZYrodrczVqIcCAfAWci8bFuDB
         YIylavG9cbQwqWHlsiSWuW5eOpI9gC1ffH4A9ofJ4dn0LA37mBVKKPdd2L4QKs9oQyC7
         a6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582332; x=1781187132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnIodUEuNnOHA2tst2ZqiQsOh5UQYABgRLPNUrbWXpI=;
        b=mAYNkrh6Nh2XeDRSAHz+0WKhwenFkftX3AMpnPP6OptPijLXULD/QgJUHZXj60IgXw
         tSAgNNYm6rX5O67TuuwA5vABOIhHKWIO2iZpIJG/MRK+UydWijW/5nldiPIvr8CYHAI/
         ADuFbfZjLC9kg6/jtQSqSr8XkqC8aUsQ8SI0CXLuzgoCnrwux2iFhU/mSl7F1rztIq9d
         lgvdZMP/Kc8a5aDmO2AGZmtLVOM5k4pFxn6S8MfW1D8sm53G7tacFsfIY+DMMKKX8+uu
         ATqKGCpJIadwrZ70mP8e90JNoWRblwGEb0PBHF+BpBxVCqlQqerb8XufiMnqnOifm4G7
         JN0g==
X-Forwarded-Encrypted: i=1; AFNElJ/fz2xzosesyfqlO83NDxAuMX8xjhP86GKwyCL8yiY5Sn2AEVjzu907adXgBG32r+jK/z113N7BMjKO2HSJvUkH@vger.kernel.org
X-Gm-Message-State: AOJu0YzazN7+MLTUFuchDr84krkx9xBUMKBPQJHphyGBr0cTd+GiF46j
	z1SjinSdf43xRoIGUW+65dDHwZiMwp6WFGG3ck+d/4liOngoLkh3LikVOvZvLzDttF8=
X-Gm-Gg: Acq92OF6yFc9sHzZFmZHm8XafE7uc4L6ilC18FUJc+ApeLNxxbwds0W3Qa8aipQDfvP
	ISdOe1hVi795ttCqxB3tQpdwRezAWD/nqV07cUY7GGXSrRvwRZX/P2JMKAN/X7V9Q5h95IWB+MH
	FXocMX7Mg0nwk32F2AVF0MSW2InJCBpbFQG9aiuyMzWBixy0TU57LMaMbsn3f5c/DlH4V6Jo2EP
	hWZm57k5Py4xWGtmjHu7WmVGdAk16HUCynzzYoytTf4Jf6GIv0vD5UIjWQn3wipOoEv8mg0EhOU
	5Xf20vnnwzFYQE8D4p4imZL87OdrB67EhyGTRckL71HDC+2SVQtrKUfFh/0rc1EdHYMbFMgZPmt
	5lxLRVgwQJJbVH9nkZiP6J5MOXrArG6C5jPAq/H/cdlx5v3jhwVCiRsrCWiZdATt8Jh9/eRlWLt
	zi/FlPPQ670yAIFf5gMzc1bZ5TMa0KthLvj2MGfSo=
X-Received: by 2002:a17:907:d8b:b0:bf0:550:d9f with SMTP id a640c23a62f3a-bf0ae9f9d78mr401378666b.31.1780582332084;
        Thu, 04 Jun 2026 07:12:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1aaasm309629366b.59.2026.06.04.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:12:11 -0700 (PDT)
Message-ID: <8bcb7a89-96db-4898-9d91-62360606602f@linaro.org>
Date: Thu, 4 Jun 2026 15:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] perf cs-etm: Flush thread stacks after decoder
 reset
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>,
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-4-f9f49f53c9dd@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-4-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/05/2026 5:59 pm, Leo Yan wrote:
> Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
> this causes trace discontinunity globally.
> 
> For callchain synthesis, keeping thread-stack state after decoder reset
> can leave stale call/return history attached to threads that are decoded
> later, producing incorrect synthesized callchains.
> 
> Flush all host thread stacks after a decoder reset. When virtualization
> is present, flush the guest thread stacks as well.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 398ab3b7a429d402cc8e5f6cccb35c0b7c253732..ea2424175558ddc0a6f20a9de6c30f377facdc52 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1956,6 +1956,37 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
>   
>   	return 0;
>   }
> +
> +static int cs_etm__flush_stack_cb(struct thread *thread,
> +				  void *data __maybe_unused)
> +{
> +	thread_stack__flush(thread);
> +	return 0;
> +}
> +
> +static void cs_etm__flush_machine_stack(struct cs_etm_queue *etmq, pid_t pid)
> +{
> +	struct machine *machine;
> +
> +	machine = machines__find(&etmq->etm->session->machines, pid);
> +	if (machine)
> +		machine__for_each_thread(machine, cs_etm__flush_stack_cb, NULL);
> +}
> +
> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
> +{
> +	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
> +
> +	if (!etmq->etm->synth_opts.last_branch)
> +		return;
> +
> +	cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
> +
> +	/* Clear the guest stack if virtualization is supported */
> +	if (pid_fmt == CS_ETM_PIDFMT_CTXTID2)
> +		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
> +}
> +
>   /*
>    * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
>    *			   if need be.
> @@ -1978,6 +2009,12 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
>   		ret = cs_etm_decoder__reset(etmq->decoder);
>   		if (ret)
>   			return ret;
> +
> +		/*
> +		 * Since the decoder is reset, this causes a global trace
> +		 * discontinuity. Flush all thread stacks.
> +		 */
> +		cs_etm__flush_all_stack(etmq);
>   	}
>   
>   	return etmq->buf_len;
> 

Reviewed-by: James Clark <james.clark@linaro.org>


