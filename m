Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397244B4043
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157457; cv=none; b=aHE4PdqgRVhXU+UqYQHXp1JVvhX0/oYvbjVNxb1iF/qluxY05SO+CxFV1QaepF+chOiALaouCzLcFuk6hqbQIqffBDf73j01MKOIZAZWe1yM8P2RhSbtyK3ZRMbCbqAsHV0Czn+bwHjy5VCsE5C2+UGLtJY7KQcCHNSf7IOgjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157457; c=relaxed/simple;
	bh=FoawsJ+Jr3o0i73fWcswOJpI48/6PChdwPWdkyAtoTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxhLi5ws2agU92j2VF2jV5rR6ddGiD/YMJbNce3mAl9A8sYwV5Op59cVeUXsMNaaSllnEK1QYpbV613dDkqnbfYwidFs/5XY4z40V018R8QluxkzSBZu8zQwGq7yD15CiujOzyV6r3I4UoGAY3shdborhb52EDb/RA5BZiWfR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIvF0kbV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIvF0kbV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so58850365e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792157445; x=1792762245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=apXFfUjY7v6M2DPDE8emOTN5c6EUenT2ynsNF+r1xeQ=;
        b=IIvF0kbVRNi0dZynG804epltf03Gh4/YrTHuvpcr9S/dez6TOD/N9QZYhoJigionLy
         bAuua5/yN9/QtJKnG0TUnGMcbe1DsQ5q33l7FncmInMctzOStgCQN9VCCllYeXb8B7sX
         00hkLXUIccBFL2aI5pakenfJGGYsvc7gYkKN1cDyGbKRYyVjEPAZN0agdOpkmwXQyNah
         qPcE3C4N+gi0jI0EX6o7xIkJ8JABePou++kN4VSRRBLu69rSHrDrh/dXS+eYk4arShLB
         UKwcNL8KrlruiEgHQsXbjY+vThdb1cZsg/9D9EszM77W7cJVwX08cRFLTsSC7i/88Ocp
         nsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157445; x=1792762245;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=apXFfUjY7v6M2DPDE8emOTN5c6EUenT2ynsNF+r1xeQ=;
        b=2qXO5uxJ8c899/SVqngyg0No2oM98TOwd5msugV7QGfL8z33mrk93pci24HPF4vPxa
         PbaEpn1WProC5bjqw6PwxblcDsHqa7mUwmTySKy06Z/aI8MUfeUPqxeyvp9g80H3qKsp
         RhalX5MgmALoFhuHEsk+Jn3moE3OHITvtbc77bLdYf3OGv4NovmK0idG8zcUxkldLaCw
         nfN6XzPW4OaqnDkVVbpaeb57iaPlPcEkal+TSgBOBINRH/BBri3latrJly9zplnNw9XJ
         fWRFEEyNArQlFsBCL2CmCPTkrT5y74z2hk77R1Z4OhwNck0cRpq6+hdlKmwbPzrdp9JA
         GMaA==
X-Forwarded-Encrypted: i=1; AKwUvBxiJW+VzgukfIX8nqwF/xQ5C6pznxAfhMB4vU8D6W3UQ1/d6A7arCbXBRJ/qF1321+rygIkRTDVM0Z5kaN0Ku1f@vger.kernel.org
X-Gm-Message-State: AFq9FYKCTrdb29SbK5GGV7H0xnxtu98MxzHiFOCD0iIrNw11Mbr8aH7u
	XEvbb1LgayxG/rV46byyTKSM8Px8LrfqQyB/XiX3VTqlSwwKLxFzap6EsYf6pSPJuPA=
X-Gm-Gg: AYBFou0HSuc2GxJhTqcKTvZCdVoePHlG9+Mt8a2AmAX0tR1JlZ2H/kllS2LvXGPn/X5
	RPXQYEBUtKY6BZBSJ5UlLlusCWA0uRoWGOhTxSlqq4CS7CZ4TDy2t3MllmnvTJOi6TZe/JFhpQ2
	fJmbbukzPcprWF8mEKXLc7pXZ+MiI79DFLSAc0UV62qmFSUsNPJr+ShaoxDNq5QEqusAS5WXVxA
	le4md/b2gzelELNXzl89cGe7DFqdRBtihdBLBVihuRIfLo3s/RtAW9sw5twHOR5XKOOTYL4xPhL
	+zjSCoLCyOxTrnY1iJmqWjjnPfWZtnY4TwPWEnHTS9+LF6ykLp10jrlSGuh+wxaJ9watdKD5XZ1
	5WCM9+oS+Le0gBIo969zgPnAKboXiCtixHKv9Ss8CtyB26+RZqrRR/XrKjJdO618eJrH0yDE8g3
	PON9ROuDXEHYeyD2eVhiMUyZNklKGTEcfTqDAbGnRyM6NBI2qxpPYOuvvA9JtHJFSlnvHrB6Uou
	aQCLAreHgiltHxMAWoSIyIJYMps2dqDL/BDoZt9d5iLK6xnUuGi9gWv8ivlTPqe7MH37lxBxLPb
	ykejyQ==
X-Received: by 2002:a05:600c:83c7:b0:4a1:d456:dda9 with SMTP id 5b1f17b1804b1-4a1d456e0a2mr15854635e9.9.1792157443112;
        Fri, 16 Oct 2026 06:30:43 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm60109555e9.6.2026.10.16.06.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:30:42 -0700 (PDT)
Message-ID: <ad5f5981-7133-431e-ac8d-8ac064a97f02@linaro.org>
Date: Fri, 16 Oct 2026 14:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/25] perf/core: Export output copy helpers for CoreSight
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-3-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-3-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:48, Leo Yan wrote:
> CoreSight AUX sampling needs perf_output_copy_aux() to copy trace data
> into samples and perf_output_copy() to prepend zero bytes when the
> available trace is shorter than the requested snapshot.
> 
> Export both helpers so the CoreSight snapshot_aux() callback can use
> them when CONFIG_CORESIGHT=m.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   kernel/events/ring_buffer.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 1b1ffe0533e58a9d976d0eb0fc23e09d5936da2b..e69ea5b077a5e94b5b6bb1f4c6f0ca5b8a94a6cc 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -298,6 +298,7 @@ unsigned int perf_output_copy(struct perf_output_handle *handle,
>   {
>   	return __output_copy(handle, buf, len);
>   }
> +EXPORT_SYMBOL_GPL(perf_output_copy);
>   
>   unsigned int perf_output_skip(struct perf_output_handle *handle,
>   			      unsigned int len)
> @@ -617,6 +618,7 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
>   
>   	return len;
>   }
> +EXPORT_SYMBOL_GPL(perf_output_copy_aux);
>   
>   #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
>   
> 

Reviewed-by: James Clark <james.clark@linaro.org>

