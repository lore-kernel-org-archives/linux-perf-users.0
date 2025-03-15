Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A868166F29;
	Sat, 15 Mar 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002027; cv=none; b=uB15O77M2cQwxm75pCMWwQ2PsJN/30CdKB+3lmM5xmOo3QzmXNNQz0MEyMNyjUdU6KyoomnMVuTRlqdff5QiLpyPvj49NaDCs5wLN0EJq86yd2wuOZVxeWG9M8h24C0wc1vbo/Qfw22Jy+HL6B29eyKR7NbkB1KlHSoxAPQMpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002027; c=relaxed/simple;
	bh=8egcx/vYyp9cvVQk4aERo4dhciNE6hu6dWigqRqgLqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEGOOYRuCcW4V++28jD3qk2K1xogHmj65USZ9YpEkXdpfWMtScKZD5NscRutHS6qLIqoSefwCRKDxVRIefncRxhazi/w3a8npmo4eTswnhEhqLsAvd487CRGsxpYsa7/YRF1cWzEgFFcjgel3mpM6XFRfnLbn0uXxikeuMY3CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0+wSiJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0+wSiJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B38DC4CEE3;
	Sat, 15 Mar 2025 01:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742002027;
	bh=8egcx/vYyp9cvVQk4aERo4dhciNE6hu6dWigqRqgLqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0+wSiJMVx8NahNRI1/h/lM5DD8VXgVmkIt3Wnxd89J/QPG0s3uGal92gyCRwcEUP
	 Bbi/lBqSuv4DXgobpeZkGc45sECtA2Ge6RmQ6QQAUrCo8lv8ujK8CZ/4iAwhGXmnbZ
	 Qj8nqDNAMVpLluCYJZPZ2ST3LLLzPOLp47n9Aw3+Hf0n7PL+XB5L7vHXJwJuyP1j/J
	 NYHJ9DzbyG9xNqvjsPQsEm+vKtSNLHVodpFoYxouREg8uFbpRFjgH6oqvKw+dBDQ4W
	 qIZyWxRQbl/mrCWPWjH8dUuoI2rRk97LZf8nh1qUDQXHhng5KkbZUYUCMzNnAsvw22
	 ipDPbLRbjj/IA==
Date: Fri, 14 Mar 2025 18:27:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9TXabugl374M3bA@google.com>
References: <20250303183646.327510-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303183646.327510-1-ctshao@google.com>

Hello,

On Mon, Mar 03, 2025 at 10:32:40AM -0800, Chun-Tse Shao wrote:
> The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> asan runtime error:
> 
>   # Build with asan
>   $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
>   # Test success with many asan runtime errors:
>   $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
>    83: Zstd perf.data compression/decompression:
>   ...
>   util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
>   0x7f69e3f99653: note: pointer points here
>    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
>                 ^
>   util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
>   0x7f69e3f99653: note: pointer points here
>    d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
>                 ^
>   ...
> 
> Since there is no way to align compressed data in zstd compression, this
> patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
> `data_size` to specify the actual compressed data size. The
> `header.size` contains the total record size, including the padding at
> the end to make it 8-byte aligned.
> 
> Tested with `Zstd perf.data compression/decompression`

Looks good to me.

Arnaldo, are you ok with adding a new record type for this?

Thanks,
Namhyung

> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> v2:
>   Add deprecated comment for `PERF_RECORD_COMPRESSED`.
> 
>  tools/lib/perf/Documentation/libperf.txt      |  1 +
>  tools/lib/perf/include/perf/event.h           | 12 ++++++++++
>  .../Documentation/perf.data-file-format.txt   | 24 +++++++++++++++----
>  tools/perf/builtin-record.c                   | 23 ++++++++++++++----
>  tools/perf/util/event.c                       |  1 +
>  tools/perf/util/session.c                     |  5 +++-
>  tools/perf/util/tool.c                        | 11 +++++++--
>  7 files changed, 64 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 59aabdd3cabf..4072bc9b7670 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -210,6 +210,7 @@ SYNOPSIS
>    struct perf_record_time_conv;
>    struct perf_record_header_feature;
>    struct perf_record_compressed;
> +  struct perf_record_compressed2;
>  --
> 
>  DESCRIPTION
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 37bb7771d914..09b7c643ddac 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -457,6 +457,16 @@ struct perf_record_compressed {
>  	char			 data[];
>  };
> 
> +/*
> + * `header.size` includes the padding we are going to add while writing the record.
> + * `data_size` only includes the size of `data[]` itself.
> + */
> +struct perf_record_compressed2 {
> +	struct perf_event_header header;
> +	__u64			 data_size;
> +	char			 data[];
> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_USER_TYPE_START		= 64,
>  	PERF_RECORD_HEADER_ATTR			= 64,
> @@ -478,6 +488,7 @@ enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_HEADER_FEATURE		= 80,
>  	PERF_RECORD_COMPRESSED			= 81,
>  	PERF_RECORD_FINISHED_INIT		= 82,
> +	PERF_RECORD_COMPRESSED2			= 83,
>  	PERF_RECORD_HEADER_MAX
>  };
> 
> @@ -518,6 +529,7 @@ union perf_event {
>  	struct perf_record_time_conv		time_conv;
>  	struct perf_record_header_feature	feat;
>  	struct perf_record_compressed		pack;
> +	struct perf_record_compressed2		pack2;
>  };
> 
>  #endif /* __LIBPERF_EVENT_H */
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 010a4edcd384..cd95ba09f727 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -370,7 +370,7 @@ struct {
>  	u32	mmap_len;
>  };
> 
> -Indicates that trace contains records of PERF_RECORD_COMPRESSED type
> +Indicates that trace contains records of PERF_RECORD_COMPRESSED2 type
>  that have perf_events records in compressed form.
> 
>  	HEADER_CPU_PMU_CAPS = 28,
> @@ -602,7 +602,14 @@ struct auxtrace_error_event {
>  Describes a header feature. These are records used in pipe-mode that
>  contain information that otherwise would be in perf.data file's header.
> 
> -	PERF_RECORD_COMPRESSED 			= 81,
> +	PERF_RECORD_COMPRESSED 			= 81, /* deprecated */
> +
> +The header is followed by compressed data frame that can be decompressed
> +into array of perf trace records. The size of the entire compressed event
> +record including the header is limited by the max value of header.size.
> +
> +It is deprecated and new files should use PERF_RECORD_COMPRESSED2 to gurantee
> +8-byte alignment.
> 
>  struct compressed_event {
>  	struct perf_event_header	header;
> @@ -618,10 +625,17 @@ This is used, for instance, to 'perf inject' events after init and before
>  regular events, those emitted by the kernel, to support combining guest and
>  host records.
> 
> +	PERF_RECORD_COMPRESSED2			= 83,
> 
> -The header is followed by compressed data frame that can be decompressed
> -into array of perf trace records. The size of the entire compressed event
> -record including the header is limited by the max value of header.size.
> +8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size` indicates the
> +total record size, including padding for 8-byte alignment, and `data_size`
> +specifies the actual size of the compressed data.
> +
> +struct perf_record_compressed2 {
> +	struct perf_event_header	header;
> +	__u64				data_size;
> +	char				data[];
> +};
> 
>  Event types
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9af3f21fd015..d07ad670daa7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -648,14 +648,27 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	struct record *rec = to;
> 
>  	if (record__comp_enabled(rec)) {
> +		struct perf_record_compressed2 *event = map->data;
> +		size_t padding = 0;
> +		u8 pad[8] = {0};
>  		ssize_t compressed = zstd_compress(rec->session, map, map->data,
>  						   mmap__mmap_len(map), bf, size);
> 
>  		if (compressed < 0)
>  			return (int)compressed;
> 
> -		size = compressed;
> -		bf   = map->data;
> +		bf = event;
> +		thread->samples++;
> +
> +		/*
> +		 * The record from `zstd_compress` is not 8 bytes aligned, which would cause asan
> +		 * error. We make it aligned here.
> +		 */
> +		event->data_size = compressed - sizeof(struct perf_record_compressed2);
> +		event->header.size = PERF_ALIGN(compressed, sizeof(u64));
> +		padding = event->header.size - compressed;
> +		return record__write(rec, map, bf, compressed) ||
> +		       record__write(rec, map, &pad, padding);
>  	}
> 
>  	thread->samples++;
> @@ -1534,7 +1547,7 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
> 
>  static size_t process_comp_header(void *record, size_t increment)
>  {
> -	struct perf_record_compressed *event = record;
> +	struct perf_record_compressed2 *event = record;
>  	size_t size = sizeof(*event);
> 
>  	if (increment) {
> @@ -1542,7 +1555,7 @@ static size_t process_comp_header(void *record, size_t increment)
>  		return increment;
>  	}
> 
> -	event->header.type = PERF_RECORD_COMPRESSED;
> +	event->header.type = PERF_RECORD_COMPRESSED2;
>  	event->header.size = size;
> 
>  	return size;
> @@ -1552,7 +1565,7 @@ static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
>  			    void *dst, size_t dst_size, void *src, size_t src_size)
>  {
>  	ssize_t compressed;
> -	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
> +	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed2) - 1;
>  	struct zstd_data *zstd_data = &session->zstd_data;
> 
>  	if (map && map->file)
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c23b77f8f854..80c9ea682413 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -77,6 +77,7 @@ static const char *perf_event__names[] = {
>  	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
>  	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
>  	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
> +	[PERF_RECORD_COMPRESSED2]		= "COMPRESSED2",
>  };
> 
>  const char *perf_event__name(unsigned int id)
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 60fb9997ea0d..db2653322f9f 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1400,7 +1400,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  	int err;
> 
>  	perf_sample__init(&sample, /*all=*/true);
> -	if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
> +	if ((event->header.type != PERF_RECORD_COMPRESSED &&
> +	     event->header.type != PERF_RECORD_COMPRESSED2) ||
> +	    perf_tool__compressed_is_stub(tool))
>  		dump_event(session->evlist, event, file_offset, &sample, file_path);
> 
>  	/* These events are processed right away */
> @@ -1481,6 +1483,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  		err = tool->feature(session, event);
>  		break;
>  	case PERF_RECORD_COMPRESSED:
> +	case PERF_RECORD_COMPRESSED2:
>  		err = tool->compressed(session, event, file_offset, file_path);
>  		if (err)
>  			dump_event(session->evlist, event, file_offset, &sample, file_path);
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 3b7f390f26eb..37bd8ac63b01 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -43,8 +43,15 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  		decomp->size = decomp_last_rem;
>  	}
> 
> -	src = (void *)event + sizeof(struct perf_record_compressed);
> -	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
> +	if (event->header.type == PERF_RECORD_COMPRESSED) {
> +		src = (void *)event + sizeof(struct perf_record_compressed);
> +		src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
> +	} else if (event->header.type == PERF_RECORD_COMPRESSED2) {
> +		src = (void *)event + sizeof(struct perf_record_compressed2);
> +		src_size = event->pack2.data_size;
> +	} else {
> +		return -1;
> +	}
> 
>  	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
> --
> 2.48.1.711.g2feabab25a-goog
> 
