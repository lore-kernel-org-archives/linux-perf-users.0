Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777022;
	b=3Nuatbxc1PM1IcqTs38tEiHOULk9Bg64iwcECPFNah39DMdi8f6KH6dwi2ySpL7r/auM
	 XSdjAA1BRzgT8oCsURrTDgc7UB03M5/NYGT6X81Ku7CPxnSLRvyJyHbvn4ruskLINCxyx
	 lKCRfkK19pg8AgRarjsoA31i6ZVI5jPVoQ63q6J1lqOb+yBwcL9F/IxHnq03h7JFWptcS
	 8rExn2fYrIrOUjVBhsrkihwRTccH8xG57bt2Oe2he6SpvD/awtroHTWgvnmzto4y8grVs
	 lraiBqq/rWuYBCdrF4KDymICoPmHLZpXLhsdkVo76RnTtNAZLywxq7FpAj+Bw2N2PeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SrR+taCSYKOy0V34lVNOUOBJDJI1/m+bArOv03O8lxI=;
	b=CvASo+0tpEwIcUn1BLq24ahWc6WFabv2Fq33GgfgCyzBwyKfv1X1XeoYSnb5II+8vnVe
	 QVPJMbT1BUxlalS4qX10TGc7ltnv9cluzkTRu5qHaDfWAel5pQR2M8WuhNmIWcSXsl0+f
	 1OB8Hxo36G9RUcZgsmlHVxxCmKnLNlnePPqYD6EhomPBXnLGCBAESjX3QEw+pk14iUpw0
	 5esc5PubWTyrRgROzGxDihpCMIdS17VDca14JReHZKzA8KdM0phCv3abQPY1EWRkoL/pC
	 CjawGwMx4Nuf3Hw9lb5V8iQk8qfpDAJW/DRpEMF374WPQO+UUmD7LGTE9VaiQZpCGpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uKoUtz9e;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1FF606A324
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 10:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D1FF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uKoUtz9e
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so5375720f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795777020; x=1796381820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrR+taCSYKOy0V34lVNOUOBJDJI1/m+bArOv03O8lxI=;
        b=uKoUtz9exeCtT/J0MSQPWgKYzoqnghWgPHR6RZKb0OlBDMgOpv9wU7GcWOajaySaQB
         3D+NEuj5+2gaKkr5zM8FsiR8swBbOluzol4gjepNpc7N2SehB3AxrNCf3g72md+7nw7z
         SJdx159tA5ouvrWReL5wvUu0ihLsMnJsRiE3+PC7vk1Ln9iW/87tPDQCAc9SBdGoK8y6
         tf6SnKemDvo2VJsXLGmZEkXEeD7st33nOYFUSMF4+/sGrOY1Ntl8tLH71ikp4pmJF7Vl
         hVW8ehIz/zqQ8dlJHeSNB2JmMi0v76jYphOAqwMoP3Y5FX9ttIEnaIqsKrtU5oCX+oTo
         j2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777020; x=1796381820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SrR+taCSYKOy0V34lVNOUOBJDJI1/m+bArOv03O8lxI=;
        b=ndsC7Pl621ItVsACruSI3kyBtY2YXWjz9h0j064uSbzEdQfXheSVrurWskmYcAw+Yq
         GLtD+7PY2mwor4OMdZX2+pC9H1+UaMl6/AR1vbuwdoct9AbOUroJWOOiQEiN/tmYf7Vy
         qOgt2cN8gNeTFv9aG5h70Ol+zgfunaHf4bmqMv7TAB9BpQ3JBmdYMqVPrITcTjLA5JUZ
         DnHIqbhmb8fNKGH6rkpjzvUOny7BrO/SfDANEbViQz6FxXLoRfLrrdJjicxh/MVTr9Wf
         fS+13FdCepxpfH8aHSq0QqKhCqNkvBLuLkvJUoTrMLgohKRhGH6Ww9NH2/PQATooogPM
         qQ7w==
X-Forwarded-Encrypted: i=1; AL+hErEEH13w8zcRyHzmt+XwAQF1WI9P/1vHaxoFprk/piZJmgn44fhi/W3u4CODnLlrUo3C0k+A03zhk3Qf5Mh1lbLG@vger.kernel.org
X-Gm-Message-State: APuU4Z8PPJ0H7OUmuD11kNfGQrV7ZyYEIWBWgH+8bF6oHjdw8T5dZYJY
	sM6D3uS48ZG+PVrOovQQHU105YpTs+f7ICYrgDuNzaYgFZAv03Nokw06I67Y4ficG0w=
X-Gm-Gg: AZFdTZeAVQUsGG47+KpV30FGwGOE2gCIfsvzSMq1L7RjVgIPj7PIXVpQt9b4ROIxr4H
	Rf/phF5bKvnfrX0GH/h8A2RY5CKVBGl8ynPgz05Su7kWozpDNFbDgF44HxE3aHmISYg04EgqRp/
	Qff84Uy8d+7I/v16K1bx3iGjTRiafGfRDRbP3zpdA7jVHHbwSF1Hu147oyFAN4WagbEljXbLc4p
	7CVb60ZZig+xzwfUL8tzg/pd2rfDjhXCHM6p53Soe86ICnVOa3HWKdYfDt3DQp4Icg7Z+PeebCS
	7paL/kcprX59oPY+kHF5fOb6TQOQKVXI6s4niIaWWYjRR8eVkMUhCdvz21MyVH1vo1wOLXLSpVi
	46ataqhN471E7CESLbm2IBbzw10WX7c8rYAgY3p+neU8wSGi9cM+50rufp6HMk3krKLrkRUWLBD
	gx/RwbF2q5Eqe9FC+kbN5cMPO3yKYQNFbJ+/KFXxekwFitXOcRQX/7ReJf/G1xDlWcJH5pqFjSO
	P45cLMV4cMjufvBXIX+w+8Iq6Jvef1AxY2fumKkp6cgVuOG/+tkd2TshvzD71JR/2RjexvFblc6
	5vzxuG56kEQfJZq+h3dHvqRwCPNm6WtJ/w==
X-Received: by 2002:a05:6000:2309:b0:4a7:45a2:ec26 with SMTP id ffacd0b85a97d-4abb0f3bc89mr49275277f8f.16.1795777020031;
        Fri, 27 Nov 2026 02:57:00 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm46346149f8f.4.2026.11.27.02.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 02:56:59 -0800 (PST)
Message-ID: <167b3016-4881-4ef4-9c1c-100ba96b50bd@linaro.org>
Date: Fri, 27 Nov 2026 10:56:58 +0000
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
Subject: Re: [PATCH v6 2/3] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
To: Leo Yan <leo.yan@arm.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>,
 Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Stephane Eranian <eranian@google.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif
 <usama.arif@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <20260810164622.1829843-3-puranjay@kernel.org>
 <20261126171904.GA809232@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261126171904.GA809232@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/11/2026 17:19, Leo Yan wrote:
> On Mon, Aug 10, 2026 at 09:46:19AM -0700, Puranjay Mohan wrote:
> 
> [...]
> 
>> +int brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>> +{
>> +	u64 brbidr, brbfcr, brbcr, pmcr;
>> +	int nr_hw, nr_copied = 0;
>> +	bool paused_here = false;
>> +	unsigned long flags;
>> +
>> +	/* Called with migration disabled, so this is the CPU read below. */
>> +	if (!valid_brbe_version())
>> +		return 0;
>> +
>> +	flags = raw_local_daif_save();
>> +
>> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> +
>> +	/*
>> +	 * PAUSED is only ever set behind our back, so finding it set is final.
>> +	 * likely() keeps this inline; a taken branch costs a record.
>> +	 */
>> +	if (likely(brbcr && !(brbfcr & BRBFCR_EL1_PAUSED))) {
>> +		/*
>> +		 * Stop the counters so a freeze cannot set PAUSED behind the
>> +		 * value read below; the D19.3 conditions need a PMOVSCLR_EL0
>> +		 * bit, which a stopped counter cannot set.
>> +		 */
>> +		pmcr = read_pmcr();
>> +		write_pmcr(pmcr & ~ARMV8_PMU_PMCR_E);
>> +		isb();
>> +
>> +		brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> +		paused_here = !(brbfcr & BRBFCR_EL1_PAUSED);
>> +
>> +		write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>> +		isb();
>> +	}
> 
> AI pointed out a edge case:
> 
>   1) The PMU is enabled (PMCR_EL0.E=1). The first BRBFCR_EL1 read
>      observes PAUSED=0.
>   2) A counter overflows and hardware freezes BRBE before the helper
>      stops the counters. This can happen while interrupt is masked.
>   3) The helper saves PMCR_EL0 and clears PMCR_E. Its second BRBFCR_EL1
>      read observes PAUSED=1, so paused_here becomes false.
>   4) The only write restoring the saved PMCR_EL0 is inside
>      "if (paused_here)". The helper therefore returns with PMCR_EL0.E=0.
> 
> This can happen with a normal PMU IRQ because hardware can freeze BRBE
> while local IRQs are masked.
> 

Nice catch. This can be fixed by adding 'pmcr_saved' in addition to 
'paused_here'. So 'pmcr_saved' would always always be set if the 
likely-not-paused branch is true, and then 'paused_here' is still set 
from the second read of BRBFCR.

Then on exit they are both treated separately. 'paused_here' invalidates 
and unpauses again but 'pmcr_saved' can control restoring PMCR.

>> +	trace_hardirqs_off();
> 
> The irqsoff tracer misses the time between raw_local_daif_save() and
> this call. Other callers could introduce similar gaps by using the raw
> helper.
> 
> I'll reply separately on the pNMI / NMI cases with an approach that
> may avoid adding the raw helpers.

And that other approach also avoids having to disable the PMU counters 
so avoids the edge case above.

> 
> Thanks,
> Leo

