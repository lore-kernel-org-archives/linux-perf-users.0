Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935E52D2B1
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690135; cv=none; b=S3UIpsykYRfXdmKV2rSh3hHT2w9b3lRu2U9kG2O1RTgl9OiW4Zc3aIQHsu+alil6GTZtQyxcPNbDp0At5jRJ8cY4LvOLjPQDuZb27Ah9eo0iPhK39U8ZSdWIAk77BFasLUtlpFVzwDPnpS2KPK/2NFaS0wCCVGCDNGwZngB1ZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690135; c=relaxed/simple;
	bh=01mIObi44/I6SJJQVnzjJtCLmwfI9RcKRPAf8+VVL7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDyB7ZA3EkM3a4Eg81Bt3QPlJil/nrDTyMfAKneGA4ZQ6I3SXabGjKr0lSqXqEom//Zu9aI0/piGhg0JPr/5J5N/P+XcpROLoyER/Sj1PFLn98YXQPXJOnsA7vZ6BhSfxQ7ZeZ/ehhyTy09UTKalq4WVCWZ7cyH1e0VfqBxl3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZams+II; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZams+II"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e0b486d91so3285766b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790690130; x=1791294930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9UFah7dL2mNY2meqJf4W09SVFZ5MUi1IU/9ko/DymA=;
        b=zZams+IIqJeQ4tpPBrR708tyqb1zkworYtzD4FMinDmXmotkIpATZ4OZEZA1Wqymc2
         QResEFjwn33E5XnU8DDBNZxs0tzyHuHslEVPH0AqQLp1c+xpBvuqoFBUwPJtPTQRco4V
         TYRQ4yi/pXhyKKAmm4OzT9nDHsMbUUm1Ht+KYnyiHm+bBJXwgwSY6oz14gpCcATOfE7e
         fc1dqXuhHppJoWiJd3DqSPE2pHR1xhwvvyaU5zCo50bgfREgX6Nz6q0/dyz9DGf1TTwV
         XQ1XmWqQyubIifMqydlDR5JkHkaiJ2QpFhnPZPcFHSURKGz4YajkU4/QpwfjHj2abE2t
         kuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790690130; x=1791294930;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9UFah7dL2mNY2meqJf4W09SVFZ5MUi1IU/9ko/DymA=;
        b=lhytqMwynAw5bGbzjpU68Tagn19kAmSIzzG05nebKm2pXgY9NFXEh06q6r/hqRSqfU
         PgiYDEB/h5oxDVwGSeOtq1W2b+V5A0ZC9BehPyzHe2wprHVqmgUcQvWFNV7HJ++u6quq
         YqbCD4zxTGhaceFgwa3g2JMloZtdJqq/OBBMo3KGB2n818ONoHFpX0xQej12nNo964fY
         2mDqCxGyK2HWRQ30tXjuLS6LYIcZSYJjPW8f+iPmTxpYWTYSCTEFqBq4oqZU3SYbIiMb
         AS5yjWdsDMkq6Trm60DsK1Id/iaIdWvp3SGmybdsMw8ItzLV8Vqh5KHW06wZOdhj5mQm
         tY8g==
X-Forwarded-Encrypted: i=1; AKwUvBzAJAgyK7Zm5Ew2SjPdJY+sZkjcr9B/3kanIECZI3jjETQC76VyZdq9N1I3VVwjVyBdOr2Ao8uUWDoflqwZw9sB@vger.kernel.org
X-Gm-Message-State: AFuF++mbvrgoNTqD6Yk3Oaeyr9kfJ5Rpt6x5KxYpRpMCdwIM5eVNHpKG
	yFAX3neUlVUtvQA5W215nwGjOQlMegScn7OkJ4FXBZt7BechzY/g2/1P4bEZAg654eg=
X-Gm-Gg: AYBFou024ufj/B6jFpbppQvSXNbGwe0cqBr6SFH3DV3Z5SNhLXHhrhuWQnl8w3w9vAF
	YSHyDF5aKaSlr5UxCHlZFRcP6mJ1DCaWNA6n2zkfDqpKGVHhaQu8ocuNoSI1tcqhHVYHMk5ANRL
	Ryc5hfZRsN1Cy86+gGkp3xupcmMZK80ST7X3aeORzIMHYtnLoy75wr1oxbqtaAcbN5POI0QRm+S
	KUumDz/KZU5AAxaPbV6jYfhpuKZwTofbuHQ5qNl7fWFoP3UkOBNop/pc1XQSvObtZmpoZJfbA1R
	tQRllosgeGw/pRBhaap2acQfJ+B3IbkW3hbV3aUdiGUCrV7Y/lXJ2XRbRwJcoK9sKMuK08adwqH
	kvRQ9XmjQrQIOR/D7l2fYZ7/KGe8vm/Y1TVXNhvL+1w/wXzDP8EYnQjBU4cjPQSdfZSHFo2zD7F
	eo4dA6tJlZs/vCoQNl4FPnmk0njS+0tFuqG1Z63BZghJ1pMnMC3kGSaeVsPlWVkHMaI//niqhZD
	6MLdQ9GofNq3Q==
X-Received: by 2002:a17:907:a28f:b0:c26:2ff1:cac2 with SMTP id a640c23a62f3a-c2ae9f31dedmr1035004766b.31.1790690130146;
        Tue, 29 Sep 2026 06:55:30 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6acb9057b4csm872836a12.33.2026.09.29.06.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:55:29 -0700 (PDT)
Message-ID: <3852b153-9be1-4ab4-803e-cb8a6de34879@linaro.org>
Date: Tue, 29 Sep 2026 14:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] perf cs-etm: Use the recorded instruction size
 for A32 and A64
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-5-6ab8c07a5455@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-5-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/09/2026 16:21, Leo Yan wrote:
> Use packet->last_instr_size in cs_etm__instr_size() instead of a
> hard-coded value, allowing the decoder to supply the instruction size.
> 
> Keep per-address decoding for T32. A range can mix 16-bit and 32-bit
> instructions, so last_instr_size describes only the final instruction
> and cannot determine the size at an arbitrary address in the range.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/cs-etm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2d1ab34f7b6b5a6331005c16c6a418d123c815eb..0163d93ac2d537a2190536e77d24628b4d707751 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1358,8 +1358,7 @@ static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
>   	if (packet->isa == CS_ETM_ISA_T32)
>   		return cs_etm__t32_instr_size(etmq, tidq, packet, addr);
>   
> -	/* Otherwise, 4-byte instruction size for A32/A64 */
> -	return 4;
> +	return packet->last_instr_size;

Why not use last_instr_size for CS_ETM_ISA_T32 too? I'm wondering how 
and when this change actually makes a difference? last_instr_size isn't 
any better than '4' for any instruction in the range other than the last 
one, so it's not clear what the issue is.

>   }
>   
>   static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> 

