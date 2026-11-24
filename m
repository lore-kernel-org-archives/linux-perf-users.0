Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481577;
	b=ituEtccvOnXvp/BKsp5v4S6TgB1/tBu8VH3f+ytgXzGVTB4OuK/h/Gt6HkuPQjwwyG8z
	 mdsUkVisP8NTUqRaf4IE6/wZ9oxsajC1xGoD+Oq9mOtSU7iKA8Jo7HfvuV3qYJEGvftqX
	 MlIS1qg4Qui+MrU2+4T8RQCUqVwbPtdRezHQpDTLX4t6Not5uBdBib6ImTeHL0U3nPBZu
	 GM7EWuUkoylGqvUjVKVgKaiDG2b8wi5SdICKqGXS2uY1drAqy+DFS8NPS4ndQEwlLV5LG
	 UYXBA0hFabJzrQ64KGVXQGP89+USkAUuIAXRC67abMQSb1/Wv72dnRzvvypHnfAo9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481577;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TN0QsqY/V2fkTj5wDpgPHVId5manIhkJMyjK2wWz4Lw=;
	b=0SL4UqJpppN+kX3giQcb8SihEmyDJoXDXa4HKSzwe98kZAZPY7fiVJKy1wKjtv71QNwY
	 knRvJSLmVc/c7A5IS0TcSJeiZ8GpTkdV4g7AcUdQyKQHg9AzXOvMYoE1eUl0RzIaqTC/0
	 eVlozkLaPQ56MzvGMdjLapFGeThnXUDCDwhRATW/xLNAJJIcgXCIOtC5Pc/URFCOaltT9
	 xU60VOCIJibyTfCg2hYOmmA4aVV0g0ScNmxRqwMYuSQSU9TGYk5mTFXE+AsBsUlAsHWYp
	 VOZ1Qv76KmCaz8CLXPpWZiw1UkMKF3KuxEgUoMlBYuWCW7zGNOwOnIiTKmYpgAECklA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XouKBksH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED5606A31E;
	Tue, 24 Nov 2026 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XouKBksH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D751F000C0;
	Tue, 24 Nov 2026 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795481576;
	bh=TN0QsqY/V2fkTj5wDpgPHVId5manIhkJMyjK2wWz4Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XouKBksHfKvaWuuVq0YJLD33niBP86pKM0xJn0Qm3v3m93YKQjnXh9A2sohByu1Xy
	 YdThGtUtpyzPUOdUjMnoTs5JDC5ufM8VBU0UXNiUj6qvpr8D1qC2nu6exqOhp7xLvh
	 Cl8EszAz1lawpHwaHIL/7XoCw2jacTtDmqASfYcKY06hQX1NmaxstgRO94FpvEzwJy
	 b9N0IXET1JlcBpt0puJqCbQXqeZJbQ1ARcZ0/9nYIAatCV7SFQ7SAGtZrPBD8qI93N
	 1EkPu1eVaNoVRnsz17QrUsoZoRxjuhstkuQugGZbM4fauCjOWC9AeBS7NfumIXPwcG
	 JFFdWyBGbp06Q==
Date: Mon, 23 Nov 2026 16:52:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to
 UAPI
Message-ID: <awTf5TZhEyoYCgjH@google.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-4-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116074414.3174737-4-irogers@google.com>

Hello,

On Sun, Nov 15, 2026 at 11:43:58PM -0800, Ian Rogers wrote:
> Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> 
> For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> set), encode a deduplicated table of variable-length build IDs
> (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> u8 data[size]; } entries padded to 8-byte alignment) and an array of
> 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> 0x00 for unresolved user addresses and 0xff for kernel/context entries).
> In common cases where multiple callchain frames belong to the same
> binary, each unique build ID is encoded only once.
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index deb7c42d109b..775420ed9aee 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -165,8 +165,10 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
>  	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
>  	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
> +	PERF_SAMPLE_BUILD_ID_OFFSET		= 1U << 25,
> +	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	= 1U << 26,
>  
> -	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 27,		/* non-ABI */
>  };
>  
>  #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
> @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
>   *
>   *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
>   *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
> + *                                         PERF_RECORD_CALLCHAIN_DEFERRED events
>   *
>   *
>   * PERF_RECORD_MISC_EXACT_IP:
> @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
>   *   Indicates that thread was preempted in TASK_RUNNING state.
>   *
>   * PERF_RECORD_MISC_MMAP_BUILD_ID:
> - *   Indicates that mmap2 event carries build ID data.
> + *   Indicates that mmap2 or deferred callchain event carries build ID data.
>   */
>  #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
>  #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
> @@ -1095,6 +1098,38 @@ enum perf_event_type {
>  	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
>  	 *	{ u64			size;
>  	 *	  char			data[size]; } && PERF_SAMPLE_AUX

I think AUX should be the last entry so that it can take the rest of
sample area after processing all other sample data.

Thanks,
Namhyung


> +	 *	{ union {
> +	 *		struct {
> +	 *			struct perf_build_id	bid;
> +	 *			u64			offset;
> +	 *		};
> +	 *		struct {
> +	 *			u64			zero;
> +	 *			u64			context;
> +	 *			u64			cookie;
> +	 *			u64			ip;
> +	 *		}; && attr.defer_callchain
> +	 *	  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
> +	 *	{ u32			nr_build_ids;
> +	 *	  u32			nr_offsets;
> +	 *	  struct {
> +	 *		u8		size;
> +	 *		u8		data[size];
> +	 *	  }[nr_build_ids];
> +	 *	  u8			pad[];
> +	 *	  u64			offsets[nr_offsets];
> +	 *	  #
> +	 *	  # Entries in offsets[] include PERF_CONTEXT_* markers (which
> +	 *	  # have top 8 bits 0xff). Kernel/hypervisor entries (after
> +	 *	  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
> +	 *	  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
> +	 *	  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
> +	 *	  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
> +	 *	  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
> +	 *	  # encode a 1-based index (1..254) into the build_ids table and
> +	 *	  # the lower 56 bits for the DSO file offset, or 0x00 for an
> +	 *	  # unresolved user virtual address.
> +	 *	} && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> @@ -1306,8 +1341,22 @@ enum perf_event_type {
>  	 * struct {
>  	 *	struct perf_event_header	header;
>  	 *	u64				cookie;
> -	 *	u64				nr;
> -	 *	u64				ips[nr];
> +	 *	union {
> +	 *		struct {
> +	 *			u64		nr;
> +	 *			u64		ips[nr];
> +	 *		};
> +	 *		struct {
> +	 *			u32		nr_build_ids;
> +	 *			u32		nr_offsets;
> +	 *			struct {
> +	 *				u8	size;
> +	 *				u8	data[size];
> +	 *			}[nr_build_ids];
> +	 *			u8		pad[];
> +	 *			u64		offsets[nr_offsets];
> +	 *		}; && (header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)
> +	 *	};
>  	 *	struct sample_id		sample_id;
>  	 * };
>  	 */
> -- 
> 2.56.1.703.gf848ed807c-goog
> 
