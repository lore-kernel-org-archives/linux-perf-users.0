Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291C7261A;
	Mon, 20 Jul 2026 05:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784523776; cv=none; b=C6rGZMFei1i8jVybJ6sOTKXzri5XVAr2OtcGVFJO/HXJaYohyIG4dIbMZ7jnPTOw35XpuzQC/i5SOpDaaJkZ8pyXTHFK3Q04uiZ56Vd03+b5lRKlnVdUvqekSVVSBgfNOtsM24F5GW3BuONxDXlKme7HTkxHtFEPzJn3YSisRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784523776; c=relaxed/simple;
	bh=t94naa01ZXjvBT6Ama3296bKFaiF5usttDLkrSd2xIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGuypXvyinfqwt9lo01VXcznKrdn9YfNNMwEJE3T8RMghEAowmnWuLHtC/XX92Kcl8b6A0Bq0eIB0Oa1sIZobAirC5CP06wlpqSlNPLXFnnxQNFnQCdS3qi1zYjzrkqiCJZDHvbE44bS0gN3BpyGM7K0r7MNE93cW5Kq9keb8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJDn+nln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJDn+nln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB91F000E9;
	Mon, 20 Jul 2026 05:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784523775;
	bh=uvtBQBgSQqy1IN0xAXHYXnTrVVXGljr5+dDHQq2fcZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EJDn+nln18G/EOpjW5Oyuczh0aV5+PTrxDVuQOoyxLXDKE2aqpGdHtO8sAksvN2C7
	 lkAgIjR0biPEAt9WDo3cfKCv8bv+eCkOqurFW+sTq/ZgDLyn9sZKmntqQMngUUL912
	 vCkxjKo1HSP+GWKF18+e7nhPWDk/PDQ7SxyCLX2dc/TgpIwjiO8rrLKVmBKiU1X9zQ
	 Ro9SCWeVdXpDN9/f4BMJfM8pvPRUX6S1h/OPLEgZh8cj7cKTfGiS/2hGIX5h0t0ENT
	 QWMjxaP/yWdvdkTqvbfCBtgPecVdvrnOODtiZpZ+oHtUJIHAH7sGBZoUW+h73q9KaY
	 fnS81wgKCV7Ug==
Date: Sun, 19 Jul 2026 22:02:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf trace: Correct default cpumask formatting to
 hexadecimal
Message-ID: <al2r_MoSrBkbLAmA@google.com>
References: <20260719001510.398616-1-atomlin@atomlin.com>
 <20260719001510.398616-2-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260719001510.398616-2-atomlin@atomlin.com>

Hello,

On Sat, Jul 18, 2026 at 08:15:09PM -0400, Aaron Tomlin wrote:
> Currently, dynamic non-array fields such as 'cpumask_t' are mishandled in
> 'perf trace', causing the raw length and offset descriptors to be interpreted
> and displayed as a literal integer (e.g., "cpumask: 524320" instead of the
> actual mask data).
> 
> Correct the parsing of dynamic fields that do not have the
> TEP_FIELD_IS_ARRAY flag set by introducing helper functions
> format_field__get_raw_data() and format_field__get_cpumask().
> Using these helpers, resolve the pointer to the raw bits within the
> payload and format the cpumask as a zero-padded hexadecimal string by default.
> 
> Fixes: c5e006cdbd27 ("perf trace: Support tracepoint dynamic char arrays")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-trace.c | 70 +++++++++++++++++++++++++----
>  tools/perf/util/evsel.c    | 90 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h    |  6 +++
>  3 files changed, 157 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ba0f8749fc7d..f8b8431f9543 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3207,6 +3207,21 @@ static void bpf_output__fprintf(struct trace *trace,
>  	++trace->nr_events_printed;
>  }
>  
> +static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
> +{
> +	unsigned char b_val = 0;
> +	int bit_in_byte;
> +
> +	for (bit_in_byte = 0; bit_in_byte < 8; bit_in_byte++) {
> +		int b_idx = byte_idx * 8 + bit_in_byte;
> +		int host_w_idx = b_idx / BITS_PER_LONG;
> +		int host_bit_in_word = b_idx % BITS_PER_LONG;

Better to add a blank line.


> +		if (mask[host_w_idx] & (1UL << host_bit_in_word))
> +			b_val |= (1 << bit_in_byte);
> +	}
> +	return b_val;
> +}
> +
>  static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *sample,
>  				       struct thread *thread, void *augmented_args, int augmented_args_size)
>  {
> @@ -3238,17 +3253,54 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
>  		syscall_arg.len = 0;
>  		syscall_arg.fmt = arg;
>  		if (field->flags & TEP_FIELD_IS_ARRAY) {
> -			int offset = field->offset;
> -
> -			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> -				offset = format_field__intval(field, sample, evsel->needs_swap);
> -				syscall_arg.len = offset >> 16;
> -				offset &= 0xffff;
> -				if (tep_field_is_relative(field->flags))
> -					offset += field->offset + field->size;
> +			void *ptr = format_field__get_raw_data(field, sample,
> +							       evsel->needs_swap,
> +							       &syscall_arg.len);
> +
> +			if (!ptr) {
> +				pr_err("Problem processing %s field, skipping...\n", field->name);
> +				continue;
> +			}
> +			val = (uintptr_t)ptr;
> +		} else if ((field->flags & TEP_FIELD_IS_DYNAMIC) &&
> +			   strstr(field->type, "cpumask")) {
> +			unsigned long *mask = format_field__get_cpumask(field, sample,
> +									evsel->needs_swap,
> +									&syscall_arg.len);
> +
> +			if (!mask) {
> +				pr_err("Problem processing %s field, skipping...\n", field->name);
> +				continue;
>  			}
>  
> -			val = (uintptr_t)(sample->raw_data + offset);
> +			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> +			if (trace->show_arg_names)
> +				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> +
> +			if (syscall_arg.len == 0) {
> +				printed += scnprintf(bf + printed, size - printed, "0");
> +			} else {
> +				int i;
> +				bool skip_zero = true;
> +
> +				printed += scnprintf(bf + printed, size - printed, "0x");
> +				/* Print bytes from most significant to least significant */
> +				for (i = syscall_arg.len - 1; i >= 0; i--) {
> +					unsigned char b_val = bitmap_byte(mask, i);
> +
> +					if (skip_zero && b_val == 0 && i > 0)
> +						continue;
> +
> +					if (skip_zero) {
> +						printed += scnprintf(bf + printed, size - printed, "%x", b_val);
> +						skip_zero = false;
> +					} else {
> +						printed += scnprintf(bf + printed, size - printed, "%02x", b_val);
> +					}
> +				}
> +			}
> +			free(mask);
> +			continue;
>  		} else
>  			val = format_field__intval(field, sample, evsel->needs_swap);
>  		/*
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ea9fa04429f0..912d77044141 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -16,9 +16,11 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <stdlib.h>
> +#include <string.h>
>  
>  #include <dirent.h>
>  #include <linux/bitops.h>
> +#include <linux/bitmap.h>
>  #include <linux/compiler.h>
>  #include <linux/ctype.h>
>  #include <linux/err.h>
> @@ -3933,6 +3935,94 @@ void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
>  	return sample->raw_data + offset;
>  }
>  
> +void *format_field__get_raw_data(struct tep_format_field *field, struct
> +				 perf_sample *sample, bool needs_swap,
> +				 u16 *len_out)
> +{
> +	int offset = field->offset;
> +	int size = field->size;
> +
> +	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
> +		unsigned int dynamic_data;
> +
> +		if (out_of_bounds(field, field->offset, field->size, sample->raw_size))
> +			return NULL;
> +
> +		dynamic_data = format_field__intval(field, sample, needs_swap);
> +
> +		offset = dynamic_data & 0xffff;
> +		size = (dynamic_data >> 16) & 0xffff;
> +
> +		if (tep_field_is_relative(field->flags))
> +			offset += field->offset + field->size;
> +	}
> +
> +	if (out_of_bounds(field, offset, size, sample->raw_size))
> +		return NULL;
> +
> +	*len_out = size;
> +	return sample->raw_data + offset;
> +}
> +
> +unsigned long *format_field__get_cpumask(struct tep_format_field *field,
> +					 struct perf_sample *sample,
> +					 bool needs_swap, u16 *len_out)
> +{
> +	u16 len;
> +	void *ptr = format_field__get_raw_data(field, sample, needs_swap, &len);
> +	unsigned long *mask;
> +	struct perf_env *env;
> +	bool target_is_64;
> +	int target_word_size;
> +	int nr_words;
> +	int bit_idx;
> +	int nbits;
> +
> +	if (!ptr)
> +		return NULL;
> +
> +	nbits = len * 8;
> +	mask = bitmap_zalloc(nbits ?: 1);
> +	if (!mask)
> +		return NULL;
> +
> +	env = evsel__env(sample->evsel);
> +	target_is_64 = env ? perf_env__kernel_is_64_bit(env) : (sizeof(void *) == 8);
> +	target_word_size = target_is_64 ? 8 : 4;
> +	nr_words = len / target_word_size;
> +
> +	for (bit_idx = 0; bit_idx < nbits; bit_idx++) {
> +		int w_idx = bit_idx / (target_word_size * 8);
> +		int bit_in_word = bit_idx % (target_word_size * 8);
> +		bool set = false;
> +
> +		if (w_idx < nr_words) {

Nit: Can you change it to something like below to reduce indentation?

		if (w_idx >= nr_words)
			break;

Thanks,
Namhyung


> +			if (target_is_64) {
> +				u64 word;
> +				memcpy(&word, (unsigned char *)ptr + w_idx * 8, 8);
> +				if (needs_swap)
> +					word = bswap_64(word);
> +				set = (word & (1ULL << bit_in_word)) != 0;
> +			} else {
> +				u32 word32;
> +				memcpy(&word32, (unsigned char *)ptr + w_idx * 4, 4);
> +				if (needs_swap)
> +					word32 = bswap_32(word32);
> +				set = (word32 & (1U << bit_in_word)) != 0;
> +			}
> +		}
> +
> +		if (set) {
> +			int host_w_idx = bit_idx / BITS_PER_LONG;
> +			int host_bit_in_word = bit_idx % BITS_PER_LONG;
> +			mask[host_w_idx] |= (1UL << host_bit_in_word);
> +		}
> +	}
> +
> +	*len_out = len;
> +	return mask;
> +}
> +
>  u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample,
>  			 bool needs_swap)
>  {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 163fc2b6a7ea..02129a022ea3 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -400,6 +400,12 @@ static inline char *perf_sample__strval(struct perf_sample *sample, const char *
>  
>  struct tep_format_field;
>  
> +void *format_field__get_raw_data(struct tep_format_field *field,
> +				 struct perf_sample *sample,
> +				 bool needs_swap, u16 *len_out);
> +unsigned long *format_field__get_cpumask(struct tep_format_field *field,
> +					 struct perf_sample *sample,
> +					 bool needs_swap, u16 *len_out);
>  u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
>  
>  #ifdef HAVE_LIBTRACEEVENT
> -- 
> 2.54.0
> 
