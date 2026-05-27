Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA6403E9A;
	Wed, 27 May 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886860; cv=none; b=rrfls7dd3ue1pWtqT9MjiQHUJ2dmbs6nuiD0J9lCyUYFPDPuxGJH2Eg42U9skIz0VkghYIfTNBpmL162Yf3G/tYynPbPxcQfkeeeOitvZrjnAf2yFuu9gVfEdXxTOtryHsDY0NOrF1YlioRTbAyv7ZNren36at5xc7Fy1yhANrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886860; c=relaxed/simple;
	bh=TwZr8bHwu+sl4F5v/6B8sISxG0NLlTexW1hZQxoqWFU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jQKo3f/ZdleUFR31EZcXn9kU7dmhkwpQcCMIArDBeI6i69rucMBGoq0FJUL3RaFKKYXllPmsucEfHXKBoi5gv55u4aYvqfKEEtNFG2HX/38MItMhCXu0yW5MvQq081IRvxAmthmppLbuK1xm8dA9QQu+woirEZ23qVvTNvMQIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUUlIxD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUUlIxD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B04E1F000E9;
	Wed, 27 May 2026 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886859;
	bh=Y49yKLCcUdOoPfuJLpPT3hWr1AHwnP3o2LT5mHHv2+o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iUUlIxD5zKEkXPE9ZMfaoUy+x4nykjkWV7nZM1MFpvc+pMmlTn4fcZJWfETdYNttm
	 IGyd340RlAqTs2vyhTDP0SnHMcaY/hSCbcmwJ1EgAUB3Nvik6yP6cBQh/gDsyEEgp0
	 +jGTWZt99xk32pDMY0RXW3sL4EjqYdxFsPmsl0CucgM5QdCkBIZLw7XL60bNdRmLdR
	 bAEZ1FZlLB00aHNwznFc5CS0sunq8xOvAh5OC8hmOSYbN97g1bjp76iJsMZVUY9Ejl
	 yTZaBEnxXPztXhEWuFgE3U0KdzNMtaPh1qannEzAZ2xWDmPfhWLjH5DppNZJtPdO6G
	 lQNO2vNASlkNg==
Content-Type: multipart/mixed; boundary="===============4572472540278009869=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c76146b9af70845f55114d28e59d8a94a15e9365aecc7f28d42f08b157f10065@mail.kernel.org>
In-Reply-To: <20260527121207.2312181-3-puranjay@kernel.org>
References: <20260527121207.2312181-3-puranjay@kernel.org>
Subject: Re: [PATCH v4 2/4] perf: Use a union to clear branch entry bitfields
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,will@kernel.org,mark.rutland@arm.com,catalin.marinas@arm.com,leo.yan@arm.com,robh@kernel.org,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,james.clark@linaro.org,irogers@google.com,adrian.hunter@intel.com,shuah@kernel.org,leitao@debian.org,ravi.bangoria@amd.com,eranian@google.com,memxor@gmail.com,usama.arif@linux.dev,linux-arm-kernel@lists.infradead.org,linux-perf-users@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 13:00:58 +0000 (UTC)

--===============4572472540278009869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     perf: Use a union to clear branch entry bitfields
>
>     perf_clear_branch_entry_bitfields() zeroes individual bitfields of struct
>     perf_branch_entry but has repeatedly fallen out of sync when new fields
>     were added (new_type and priv were missed).
>
>     Wrap the bitfields in an anonymous struct inside a union with a u64
>     bitfields member, and clear them all with a single assignment. This
>     avoids having to update the clearing function every time a new bitfield
>     is added.
>
>     Fixes: bfe4daf850f4 ("perf/core: Add perf_clear_branch_entry_bitfields() helper")
>     Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

The Fixes tag points to commit bfe4daf850f4 which introduced the
perf_clear_branch_entry_bitfields() helper, but that commit was correct
at the time.

The actual bug was introduced by commit b190bc4ac9e6 which added the
'new_type' field without updating the clearing function. Commit
5402d25aa571 also added the 'priv' field with the same issue.

Should the Fixes tag be:

  Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..f7360c43f902 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1474,14 +1474,7 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
>   */
>  static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
>  {
> -	br->mispred	= 0;
> -	br->predicted	= 0;
> -	br->in_tx	= 0;
> -	br->abort	= 0;
> -	br->cycles	= 0;
> -	br->type	= 0;
> -	br->spec	= PERF_BR_SPEC_NA;
> -	br->reserved	= 0;
> +	br->bitfields = 0;
>  }
>
>  extern void perf_output_sample(struct perf_output_handle *handle,
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index fd10aa8d697f..c2e7b1b1c4fa 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1491,16 +1491,21 @@ union perf_mem_data_src {
>  struct perf_branch_entry {
>  	__u64	from;
>  	__u64	to;
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
>  };
>
>  /* Size of used info bits in struct perf_branch_entry */
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index fd10aa8d697f..c2e7b1b1c4fa 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1491,16 +1491,21 @@ union perf_mem_data_src {
>  struct perf_branch_entry {
>  	__u64	from;
>  	__u64	to;
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
>  };
>
>  /* Size of used info bits in struct perf_branch_entry */

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26510917353
--===============4572472540278009869==--
