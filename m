Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8E3822B5
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942000; cv=none; b=jz30MOE/tTul8TcyBB3/FnCnSWdGxfmFfW0e9A+KFmMgLDdCPvyTVMnPA3OyOzjWi8ru46pUxuDdwL9bWuQ+J1pyvf5cpA4elDOlCSxOwjHdul6twNyMPepHUnME4GifkQjjgoYfqjNi6p2wtdx40uN3qf9phfqq0v0r6IiRwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942000; c=relaxed/simple;
	bh=9j1zwOiqYR/j62a4SmkndR3I/fBKjx3NMWjiae/q3ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtgW8kRnhGfTMuBo0/2BfWbhbcUi/ws+UrV4NA9y3otHB0XP4irSRD2637MRzjiYBaqGh0Mb4NKReruYqHqUXBKUrz3vpdRTe/38QT13slFAsn6CF/RCNqb6N2dDh7M1IJ2wkp3+hgcyLHkItuGk9dS5pu4zVofHDglZvLA0+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/CmtwqX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/CmtwqX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46019edc13dso2162500f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780941998; x=1781546798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruO8SnBumLZRLs1kOpD88cW4Qstol4o2xlBdcC+hpIQ=;
        b=D/CmtwqXNyGX0yfK977KF9gElPvNCIInU2NrzbQmhyWE0xKKWUEcjUNzDODyE5jo4H
         sBnXO5I/0mY3/8ps/lM9mP4IK2FwzXYuwTOflph70TpmF3rnTN6gqDaNYNwD6gSU/A2i
         4Sj93K9kZ8snRreaiYJrDglKHandL+bfm1LmLR+8JXL+aAaHdBBqOzcRtKSyAuSLosNx
         aYPfG8IU6BbSM/T4+q37xRRpQjqlIpRzvMZHBH73AK/lA6wU26fM1UNDAxO6ysSSwxuk
         bZQ/xe4x3cNYqeM95kcG6dE+ZG0/FhSehLhpAG9lcHIYS1nzGJlGPeXUl9dFkvc3bHbO
         82Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941998; x=1781546798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruO8SnBumLZRLs1kOpD88cW4Qstol4o2xlBdcC+hpIQ=;
        b=Y2IC644U2fPdLgeM7zEfjt010YAm/QKSAy2WD8WU9bebbU1WgFOHJ3hIm7AUisBRXJ
         MaAfX/mHPMOvoQAJ/W98GmSNq4iADgsFVdXCy3UzqsHIHaIUjodquDWWAnFHb8pFzG0h
         chGpJyVuxf7Aj17lpywXembQuUKFTo2GOWQqrcAvxRDpoMDYDKH3Cx8xKgNQyXRP/Ueh
         GNorJ6aTgq+y7RJZ7su5GFpsL7jYqb7+qLsfIt10/kNubU2ZlM6RLeyXiWvWDf1WQW6m
         cQADwhDtsub9w4CkezjObCB5GNd7w04/1I0XUf2xNuiLJOiSEvLM3cHTPvOjjcbuTSPb
         rEOw==
X-Forwarded-Encrypted: i=1; AFNElJ8kFmhBMQcGr0DJYSdq41ElxfX4qDSf5QTl5N38N+rWn8CRcjV0Xf1VxNcSBTcCAnp3Q+kRig1ZJL8AZk8thqZs@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHvzRxYllQtcvT7VQZYZqdqhMIbE2LWWN0Fiboh493k0ZQ1Uz
	nGPvXShQTkdgUozoOnV/s54G0tlK511aLAODBoDCg9T24ZyEoAt4lhhzFZMeezXDVZI=
X-Gm-Gg: Acq92OFgEtWSK/3m9fSQsirBSmoPDEEmjQmppub4+P0Aw/ySqI+MYvd7NQGY/LCmVxz
	ADSyuLo7KixwV/qCnPEvFajzvwHd5AhWriOJnoR8ueZWw2rcEYmmqFDB8bWno/WADxUM6h4er1Z
	Hwirp4uTWZSI56trvSlg2oGLBSkKCFIsaq8WjyttRgOiTYRNZ64qKoewM5re9KGTlBj0r0yH5OX
	mEDl5MHf2HDtYrK4seWdFM0O1MDs5sgyInbKqLujW7ErndDhovENi/tbYamdSOE9SgwvkxCRGmj
	4CnGfUd51Crpoji94OtHVO8kZxt0YZzuZQ+bh7GxYPzt0aWyX/w/nNgXkx1zKbN/YcqSmvHsvyQ
	/DHDTOhSlitYfRkkp5Fc/Voesx3SzjvqlXd/hdhTSMunfG/4irY1fYQSJjPqHimtfVw5VmgSoK/
	IeBYrrmvs3XUtmphlRwQHr14EIngnHWNOJdfIosTo=
X-Received: by 2002:a05:6000:468d:b0:446:db72:e8ec with SMTP id ffacd0b85a97d-46030643609mr17198053f8f.23.1780941997560;
        Mon, 08 Jun 2026 11:06:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm54421372f8f.2.2026.06.08.11.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 11:06:36 -0700 (PDT)
Message-ID: <48f06bc5-0283-4720-a5e5-843af16cb9dd@linaro.org>
Date: Mon, 8 Jun 2026 19:06:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] perf: Use a union to clear branch entry bitfields
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
References: <20260527121207.2312181-1-puranjay@kernel.org>
 <20260527121207.2312181-3-puranjay@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260527121207.2312181-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/05/2026 1:11 pm, Puranjay Mohan wrote:
> perf_clear_branch_entry_bitfields() zeroes individual bitfields of struct
> perf_branch_entry but has repeatedly fallen out of sync when new fields
> were added (new_type and priv were missed).
> 
> Wrap the bitfields in an anonymous struct inside a union with a u64
> bitfields member, and clear them all with a single assignment. This
> avoids having to update the clearing function every time a new bitfield
> is added.
> 
> Fixes: bfe4daf850f4 ("perf/core: Add perf_clear_branch_entry_bitfields() helper")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   include/linux/perf_event.h            |  9 +--------
>   include/uapi/linux/perf_event.h       | 25 +++++++++++++++----------
>   tools/include/uapi/linux/perf_event.h | 25 +++++++++++++++----------
>   3 files changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..f7360c43f902 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1474,14 +1474,7 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
>    */
>   static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
>   {
> -	br->mispred	= 0;
> -	br->predicted	= 0;
> -	br->in_tx	= 0;
> -	br->abort	= 0;
> -	br->cycles	= 0;
> -	br->type	= 0;
> -	br->spec	= PERF_BR_SPEC_NA;
> -	br->reserved	= 0;
> +	br->bitfields = 0;

The comment above here says:

  * The to and from fields are not cleared because they are
  * systematically modified by caller.

But this is an inline function and the to/from fields are always 
assigned right after calling it. Surely the compiler can work that out 
and this was a premature optimization.

If we rename it to perf_clear_branch_entry() and do:

   *br = (struct perf_branch_entry) {0};

Then we can delete a big comment, remove a potential source of bugs if 
even more members are added, not have to update the uapi headers and 
simplify it instead of working around the original issue.

>   }
>   
>   extern void perf_output_sample(struct perf_output_handle *handle,
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index fd10aa8d697f..c2e7b1b1c4fa 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1491,16 +1491,21 @@ union perf_mem_data_src {
>   struct perf_branch_entry {
>   	__u64	from;
>   	__u64	to;
> -	__u64	mispred   :  1, /* target mispredicted */
> -		predicted :  1, /* target predicted */
> -		in_tx     :  1, /* in transaction */
> -		abort     :  1, /* transaction abort */
> -		cycles    : 16, /* cycle count to last branch */
> -		type      :  4, /* branch type */
> -		spec      :  2, /* branch speculation info */
> -		new_type  :  4, /* additional branch type */
> -		priv      :  3, /* privilege level */
> -		reserved  : 31;
> +	union {
> +		struct {
> +			__u64	mispred   :  1, /* target mispredicted */
> +				predicted :  1, /* target predicted */
> +				in_tx     :  1, /* in transaction */
> +				abort     :  1, /* transaction abort */
> +				cycles    : 16, /* cycle count to last branch */
> +				type      :  4, /* branch type */
> +				spec      :  2, /* branch speculation info */
> +				new_type  :  4, /* additional branch type */
> +				priv      :  3, /* privilege level */
> +				reserved  : 31;
> +		};
> +		__u64	bitfields;
> +	};
>   };
>   
>   /* Size of used info bits in struct perf_branch_entry */
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index fd10aa8d697f..c2e7b1b1c4fa 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1491,16 +1491,21 @@ union perf_mem_data_src {
>   struct perf_branch_entry {
>   	__u64	from;
>   	__u64	to;
> -	__u64	mispred   :  1, /* target mispredicted */
> -		predicted :  1, /* target predicted */
> -		in_tx     :  1, /* in transaction */
> -		abort     :  1, /* transaction abort */
> -		cycles    : 16, /* cycle count to last branch */
> -		type      :  4, /* branch type */
> -		spec      :  2, /* branch speculation info */
> -		new_type  :  4, /* additional branch type */
> -		priv      :  3, /* privilege level */
> -		reserved  : 31;
> +	union {
> +		struct {
> +			__u64	mispred   :  1, /* target mispredicted */
> +				predicted :  1, /* target predicted */
> +				in_tx     :  1, /* in transaction */
> +				abort     :  1, /* transaction abort */
> +				cycles    : 16, /* cycle count to last branch */
> +				type      :  4, /* branch type */
> +				spec      :  2, /* branch speculation info */
> +				new_type  :  4, /* additional branch type */
> +				priv      :  3, /* privilege level */
> +				reserved  : 31;
> +		};
> +		__u64	bitfields;
> +	};
>   };
>   
>   /* Size of used info bits in struct perf_branch_entry */

