Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707632;
	b=q+8gHo89atQ6AmLzpYI5ZWpavqhNiPwZUn1KM7vFkTqUTUdkjV+Jo8XgSu1mtr6rWU5j
	 kaErjyiciLMidAYtVaICqV2CPVI7qUnt8rxeDuhc8Goyv07+w80KunZAbSPCbBCsobMPm
	 gflasxWv+ILQ1+520YhRMpBDruafKzBRtnpz+SSf8hp+6f2TfQ5/mb4RgG3QNDurG2dHh
	 w4Q/BlUKKNdOUQnRwe9jGMzXQC6+icrjF0o2BuR1uLZP6puQ8eJ44mMpqEF4wLGR4MAQS
	 vvD/BIng3uRlzN/aqX5dUGL1Uun77MAuuTdH0wtbjRu8oWdUFueE8NFw0J2ZOyAVOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ySKYasBAII9CIYefFSpb/rg/yMp8IEyXS3kf72/gGBA=;
	b=tl3+HgTLSk/32w688QeiinrIy38cDEPcpRcUT4Ep9S6JmEVPRCp+LW7OWjDp+Vzrx04q
	 eTlY5GuvLnWfdFq3ZWR/TzOD4U3xMPXDWu8RsJ5+dJ+ta+FTZBXIGSQ1nCDykM5SvcEfP
	 PQzNC7vWeUgA12IeA5MLbOXeTVdzxuzsOVvmtoxxTXSBkJxVNfk8JOsz7PRFNUoU8Ylxh
	 lFZIraQyPoCEYRTxtOiXYGBWKiZxjkDd/Z3ofqou95zAz9Rh19kD3tYE270VC2P6ALai4
	 nV9QkQBdoGVruB/Os8nUOVeOICIbuftRGRPfKj/tO6q0YiCDgNo2Y+ICpIwSoyeG6LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m3WUwboX;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A508606A330
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 12:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A508606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m3WUwboX
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2461907f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 04:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793707631; x=1794312431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySKYasBAII9CIYefFSpb/rg/yMp8IEyXS3kf72/gGBA=;
        b=m3WUwboXryGP5oVHnpI0HTzT9uj7fYvhet6mk4sWWx0x4PrenYceEUJlv3euNPKAEo
         BbArikY82AVFcsR3v3ktJXu59DemC8n06or/d9t8esVwbC+0zqTm+veRMq9ktkjRDpWK
         FFldoBEWsCAFy3szNe2uF5pilY/Qdbzg/BIQA9g3Yxs9pWFLrBebl8W3+IY9hDUTNj7j
         A+aixhJV8XJQnDBA7LLphsWRsi2u5wYREm1FJDZ9B+3M3ep8ZkgORTwBQh+2smHpbCKd
         hIE1bmbd9UxOBmBJtP6w+vYznTkRkhYQS4gTSNHh+ca/oAGe7BqS99MI3g8T6Gb/c8Ow
         AkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707631; x=1794312431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySKYasBAII9CIYefFSpb/rg/yMp8IEyXS3kf72/gGBA=;
        b=rN+ZSpqPUJ2TvYME3bVG+RNeVg+3X4MaOQYKPL3aUQ48cqJRRZ72QloboE0aXGmKiP
         CF5+8sVeU2Ppy64qxWuTFBsaq+lzvpimQNw1ZXJ7dm2Q3UaZwTc2R/Vnt1FnO5h1o7t3
         959ATvlpSNp9MyYbZ12ueCiRKbUhvEYtFiCg2a08vC6jDq3IQuG//AynVptYsnTdndhD
         sewcu5DMmMKFUTyfE7Wdhc8B642O86e4UK/t0bM65rkVrYWEPX/BUDI3/PVQSUMiZI6c
         x7IwlxS+PMjd83GQiwPhXQ3i9v9Him1jdLBa5erHeYmAegEg8fq6rcQDPbi5ht5YHn+3
         bvQw==
X-Forwarded-Encrypted: i=1; AKwUvBxM5Fe2DYx9lGJMTa0kEuqY3kctXJlqfX1l9ZhkYULBB9l/px/cl8SD046UPcJHAixeyJt4C/VuYyj6EanAWBL6@vger.kernel.org
X-Gm-Message-State: APuU4Z8GiQmWk2SnDVwp0kAF1xfkA8StBAU1fsXNYHLL3uQoHU2qGeyg
	Lk6Lmv8lafWFEdIlNoEXWI2eqqqrs47qAx/5yey+uRlNugxpKc0xACu7XjjjYAKjQ7zFMo3CROr
	xStyxIC8=
X-Gm-Gg: AYBFou2dxkVju1XquF7LgumBgfqJU0s41ss/yIpdsjlngfdewA5hpizOjirMvDFLmbx
	wI8Rb2818cUTamw5ZakQgTdZHgW1lOD9S25kXIM/jfu8H0nlGT5fzc2M3z/KF7WFnF7CzHlVwc8
	4KMeRBpH9mIR/uJKnhDsiQdbYPfzIz79+zatC9mR5VXWuMlz10Sx3Cak1HQH7EJvYpPjLUAcP/J
	Fp+J7DSPLki+EDclupNqBRnIlQPxQGHR/Uwdn7GraLZmq7iiNs8vzHrRO5SzwjTz6LRb4IX2rB9
	LmbFd+wMvDiCs34JRTqurLfeE7AvA9+gzzmT1LKGx7cu3f/KoPhGqX2HoDdO5lOY2cnwPJLNeLB
	/LhA3pvX/pJgIl6ETFRcZe745gP9/J/2LgIz/kNZdccRCVqIqgr6iUPL1shOMj0XmlrWIseX3YZ
	VDFIEQu9bUmgIRh5ukgigIlMljjrdECw3Ur/aCTe3hjy/C2uhlwo9NiBMaKRvs07Fl9mCQf4HpJ
	Hgw6MMc0C7zQ58WFoehIXTlphCpmsmAvJ1rH8HrFBP3FgJGBufJ0mZvfchyUXqxGMiBj2rkJK4e
	SetUMm0J6oMsm94mEjWDz7jOfV4A29Qu
X-Received: by 2002:a05:6000:4311:b0:48e:20ed:d5e7 with SMTP id ffacd0b85a97d-48e6e2ff167mr26869683f8f.34.1793707630565;
        Tue, 03 Nov 2026 04:07:10 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c0b6sm23904045f8f.41.2026.11.03.04.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:07:10 -0800 (PST)
Message-ID: <a188c604-46c0-48fb-9cbd-9eacad88b5c9@linaro.org>
Date: Tue, 3 Nov 2026 12:07:09 +0000
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
Subject: Re: [PATCH v2] perf vendor events arm64 AmpereOneX: Deprecate
 BPU_FLUSH_MEM_FAULT
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.garry@linux.dev>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com>
 <20261103112609.3772250-1-takano32@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261103112609.3772250-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/11/2026 11:26, TAKANO Mitsuhiro wrote:
> AmpereOne named event 0x121 BPU_FLUSH_MEM_FAULT until
> commit 10a149e4b4a9 ("perf vendor events arm64 AmpereOne: Rename
> BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT") renamed it.  The next patch
> in that series, 16438b652b46, added the AmpereOneX tables with the old
> name in memory.json, so 0x121 carries two names: GPC_FLUSH_MEM_FAULT in
> core-imp-def.json and BPU_FLUSH_MEM_FAULT in memory.json, and the
> default perf list output shows both.  The old name has been in every
> release since v6.8, so deleting it would break scripts that use it.
> 
> Mark the entry deprecated instead of deleting it, as Ian Rogers asked:
> perf list then shows 0x121 once while those scripts keep working.  The
> x86 tables use the same wording, and
> commit eda39f98bbc5 ("perf vendor events amd: Reintroduce deprecated
> Zen 5 core events") brought back deprecated AMD events for the same
> reason.  The flag is only read when listing; the entry still registers
> event=0x121, so perf stat -e bpu_flush_mem_fault resolves as before, and
> regenerating the tables changes nothing but that flag.
> perf list --deprecated still prints the name in the text output; the
> JSON path does not consult the flag, so perf list -j cannot show it.
> No metric expression and no other file refers to either name.
> 
> The duplicate came in because jevents checks repeated names, not event
> codes, and one encoding carrying several names is legitimate, so nothing
> is added for that here.  No AmpereOneX machine was available, so the
> listing was not run on hardware; Ilkka Koskinen, who added both tables,
> tried v1 and v2 and reports that they behave as expected, and his
> Acked-by is for this variant.  The JSON edit and this changelog were
> written with an LLM assistant, Hermes Agent, working from the code and
> the thread; the checks above were run here.
> 
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
> Suggested-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/20261021224527.167637-1-takano32@gmail.com
> Link: https://lore.kernel.org/CAP-5=fX+2eRGCHcU43sqU=gi9iKvxqyS6ipwRSnvFcap3D+QzQ@mail.gmail.com
> Link: https://lore.kernel.org/42801873-8908-07a6-aed1-c7076c689e8e@os.amperecomputing.com
> Acked-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
> v2: keep the entry and mark it deprecated instead of deleting it,
>      as Ian Rogers suggested, and word both descriptions the way
>      the x86 tables do.  Ilkka Koskinen Acked-by v1 and asked for it
>      to be carried over to v2; the description wording was added on
>      top of that, as said in this thread.
> v1: https://lore.kernel.org/20261021224527.167637-1-takano32@gmail.com
> 
>   .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
> index 6c06bc928415..114f95e41e0d 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
> @@ -35,9 +35,10 @@
>           "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
>       },
>       {
> -        "PublicDescription": "Flushes due to memory hazards",
> +        "PublicDescription": "This event is deprecated. Refer to new event GPC_FLUSH_MEM_FAULT Flushes due to memory hazards",

Extremely minor nit, but there should be a full stop before 'Flushes'. 
But if marking it deprecated makes it not show in Perf list, then it 
doesn't make a difference.

Reviewed-by: James Clark <james.clark@linaro.org>

>           "EventCode": "0x121",
>           "EventName": "BPU_FLUSH_MEM_FAULT",
> -        "BriefDescription": "Flushes due to memory hazards"
> +        "BriefDescription": "This event is deprecated. Refer to new event GPC_FLUSH_MEM_FAULT",
> +        "Deprecated": "1"
>       }
>   ]
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

