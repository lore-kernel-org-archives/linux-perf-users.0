Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C02A3655D4
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751247; cv=none; b=txCTOI2kdr/l4I28TpLhCW+lboL/+xKs9nWr1a7QQJOmYM6M+1CjuGSKsMhkRr/DJVVZbjy5tP37ZAxJND2Pp2c/Gg8sWegKUUOuYGCGzaHLdjWUxhzX8OGgdEjirhZcweiaCFbzH08O/XIZrx8s+4brS2WFOlYralcKFw7eUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751247; c=relaxed/simple;
	bh=HCC8D+G0rb1aAiQw9n58KzRT16izY5PvVK0a7SdEOV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENy/2qiAzYyMg1yceZl5Do5i+0MEyNIjHMGeqnZP+LdIV6ZxDzwnswPNySkVtyexuMe2MgIiCRaCuV7X7Z6MN3Uf8YTxIiaSNsEh6sHr8jkg4A1KARBPxhwIPQP6Ac71D6JSluagwmxxIEBFWi0oncoJsJRsISGY1VaSExI8lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuBz7l6Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuBz7l6Z"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15dd4b9132so496162466b.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785751243; x=1786356043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxMk4MUQUDc+H1bfo3Qxr4A1ELX+7kM8nIGEj1DxyWY=;
        b=DuBz7l6ZSRxVFCHSNJMdxDJNRgWuPAIaYRV4P/nwAWpahXGH1xyKUxYztOFOcxfxAu
         tIS40BzBHNqPTy/epf8/Zq07KMoyZdHtTgz+n5xdAMxw4slNASF+EmzOvtFrzzpZS67N
         frno3LKE4doXKzEJtXvQRUy8gM3mN5umH5y4W1GB/E1sPfJ30BIAxxDsKvH5zqdbQJYI
         mMf9etBmeAlBwqSprXkSVZQrWRdh9aLUfvy3NK91vHhycH2Hh34mLzmrqeDUuYLPfipU
         UuwBO9QdgenZvKFEdno7Dkgwzoo9GwwiijaYHx/iJbJpZIX+MtcA+wloYa22FlickLPo
         OZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785751243; x=1786356043;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxMk4MUQUDc+H1bfo3Qxr4A1ELX+7kM8nIGEj1DxyWY=;
        b=LSEe4slkSaJSjR1wlTlfJb19pBo+uMojMZ88HTSrX8/IWh9KeT0WoDVcQIF/hkEEng
         B08obHzEaF9FyBBI5mIi7qhOLxzz0Eh4XA4D+HHRpIBRp2NNde/VGjmzKD6P9qU7dVSg
         7iDzxCHRe/jlISuE2JcbhraI5D4e1tLvuN4m7Wy0ok/YJCTq7uwJeKoMoVaINjc1Ur2l
         gAqWDViwEu5cOjKNMP3VyqvSJ1MoKXvljh38py/hPMpMzobfGHgAbaCqJUXPJsy8WkwV
         A+FQvO7dvwtlg64kkP20FkpiqdrfQkBKDKwAqCA3byRYqellseKPTWM84yCEbZkuELTx
         hsjA==
X-Forwarded-Encrypted: i=1; AHgh+RrXprw3+0CwvdIPuXIVflhtUD5g9oapOhfzlHz7G8Za3WCl1A0427g3sZb3Rbu3PLNhC8tXGVevaHkKKdJZkatj@vger.kernel.org
X-Gm-Message-State: AOJu0YyOd9u3MNVTx4twWI9cG8lnOFCxw4ioDI05GNOdBFNT/XvNVYo1
	u7UazCF5V8fHKnQM12UkU+NzS7ZYle3kRdTNV1b4Ygwh5Wpsj34cr9CrC90wKldUyBA=
X-Gm-Gg: AR+sD12cXxWNW1H8nqsPP6ZMnzc4bwPxpXfbiDMtwE/oRnI5QM9JFmnb1YiWY0nec2q
	bEBLdp8Zzbl4ES/fFdlCX9dunZ5uExC3f/dLqVayjat6rl03dSNr45PWWLcYj9hT+qfFz86dHz9
	DNjP2pL2uLQhz1eg7n725fYx8L0pV/XzGc4aENeeqz24mZlrnOZ9S29cMqjnFydJmtbC0bEpb9G
	7uN+WxokK+TtobOm9fb7LzdNvnpHuuLkSASFN81EE9W1LkRYm2PS6Gd4mam/zFCyAspHqPlsvsm
	ZACo5jAk8FpsOyvprOH3o05Z35Ic/RwTFgK/qpILx2JZRzm5nUTWUKn9I99mZtLJqMyrW0a2d4A
	opmfaeV7ZWOTFfH9ofwnSIAlTrFdbRRQMsvE6UAXNJj2K0hTUnBqRgQP+tUOEm7wGn+3RTsYbMK
	7OTXL+IjWXTYWE3s2bH1n4Gpl/pLXUI+QMN1CsL7OvNvLm3m6h0cVMr2wNiOORqE/BQ42FDtXAJ
	VCFTK4=
X-Received: by 2002:a17:906:a98:b0:c19:611c:fa94 with SMTP id a640c23a62f3a-c1fe7f520f5mr446666366b.27.1785751242813;
        Mon, 03 Aug 2026 03:00:42 -0700 (PDT)
Received: from [192.168.1.183] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b387sm496061166b.2.2026.08.03.03.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 03:00:41 -0700 (PDT)
Message-ID: <9f2c4bbd-5889-4899-b96d-41566363c408@linaro.org>
Date: Mon, 3 Aug 2026 11:00:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] perf/core: Clear the whole branch entry in
 perf_clear_branch_entry()
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Leo Yan <leo.yan@arm.com>,
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
References: <20260616155716.2631508-1-puranjay@kernel.org>
 <20260616155716.2631508-3-puranjay@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260616155716.2631508-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2026 16:57, Puranjay Mohan wrote:
> perf_clear_branch_entry_bitfields() resets the bitfields of struct
> perf_branch_entry one at a time and deliberately leaves from/to alone,
> since callers overwrite those immediately. The list of assignments has to
> be kept in sync with the struct by hand, and it has already drifted:
> new_type and priv were added to perf_branch_entry but never cleared here,
> so stale values can leak into the records handed to userspace.
> 
> Clear the entry with a single struct assignment instead:
> 
> 	*br = (struct perf_branch_entry){ };
> 
> Every caller writes from/to right after the clear, so zeroing them as well
> is harmless and the dead stores are elided on the x86 LBR read paths.
> There is no longer anything to keep in sync when a field is added.
> 
> The helper no longer touches only the bitfields, so rename it to
> perf_clear_branch_entry() and update the callers, fixing up the
> br+nr/br+out spacing on the touched lines while at it.
> 
> Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
> Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
> Suggested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/x86/events/amd/brs.c   |  2 +-
>   arch/x86/events/amd/lbr.c   |  2 +-
>   arch/x86/events/intel/lbr.c |  6 +++---
>   drivers/perf/arm_brbe.c     |  2 +-
>   include/linux/perf_event.h  | 16 ++--------------
>   5 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
> index 06f35a6b58a5..68c5f42965e9 100644
> --- a/arch/x86/events/amd/brs.c
> +++ b/arch/x86/events/amd/brs.c
> @@ -343,7 +343,7 @@ void amd_brs_drain(void)
>   
>   		rdmsrq(brs_from(brs_idx), from);
>   
> -		perf_clear_branch_entry_bitfields(br+nr);
> +		perf_clear_branch_entry(br + nr);
>   
>   		br[nr].from = from;
>   		br[nr].to   = to;
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index d24da377df77..08401fd60585 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -181,7 +181,7 @@ void amd_pmu_lbr_read(void)
>   		    entry.to.split.reserved)
>   			continue;
>   
> -		perf_clear_branch_entry_bitfields(br + out);
> +		perf_clear_branch_entry(br + out);
>   
>   		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
>   		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c6..295da179fa74 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -755,7 +755,7 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>   
>   		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
>   
> -		perf_clear_branch_entry_bitfields(br);
> +		perf_clear_branch_entry(br);
>   
>   		br->from	= msr_lastbranch.from;
>   		br->to		= msr_lastbranch.to;
> @@ -846,7 +846,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>   		if (abort && x86_pmu.lbr_double_abort && out > 0)
>   			out--;
>   
> -		perf_clear_branch_entry_bitfields(br+out);
> +		perf_clear_branch_entry(br + out);
>   		br[out].from	 = from;
>   		br[out].to	 = to;
>   		br[out].mispred	 = mis;
> @@ -920,7 +920,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>   		to = rdlbr_to(i, lbr);
>   		info = rdlbr_info(i, lbr);
>   
> -		perf_clear_branch_entry_bitfields(e);
> +		perf_clear_branch_entry(e);
>   
>   		e->from		= from;
>   		e->to		= to;
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c..effbdeacfcbb 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -604,7 +604,7 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
>   		return false;
>   
>   	brbinf = bregs.brbinf;
> -	perf_clear_branch_entry_bitfields(entry);
> +	perf_clear_branch_entry(entry);
>   	if (brbe_record_is_complete(brbinf)) {
>   		entry->from = bregs.brbsrc;
>   		entry->to = bregs.brbtgt;
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..e034be4a473a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1467,21 +1467,9 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
>   	return size;
>   }
>   
> -/*
> - * Clear all bitfields in the perf_branch_entry.
> - * The to and from fields are not cleared because they are
> - * systematically modified by caller.
> - */
> -static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
> +static inline void perf_clear_branch_entry(struct perf_branch_entry *br)
>   {
> -	br->mispred	= 0;
> -	br->predicted	= 0;
> -	br->in_tx	= 0;
> -	br->abort	= 0;
> -	br->cycles	= 0;
> -	br->type	= 0;
> -	br->spec	= PERF_BR_SPEC_NA;
> -	br->reserved	= 0;
> +	*br = (struct perf_branch_entry){ };
>   }
>   
>   extern void perf_output_sample(struct perf_output_handle *handle,

Reviewed-by: James Clark <james.clark@linaro.org>

