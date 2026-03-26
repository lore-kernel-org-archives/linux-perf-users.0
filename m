Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E823EA80;
	Thu, 26 Mar 2026 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504124; cv=none; b=j6syuofWEnEpMM1DEqyqQZvE786NULJdLOo5e9oxAF2T2niDbSo7YjTZHQb0pjXLPqTIi/gLOzg2pBlKfCaFyMJMAaSU5kgx7eruYx55nS1YeOxOLaGNBPQneRsE3PymIjLJ1lyVK9wCkNDDWPTxcD58+Dg8Lm4lcyjFapxODLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504124; c=relaxed/simple;
	bh=0/YZmtUCY1dAJfWm67+UR88v2rIu3ykR3u+aDddgHKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgyrP34mRNjctJW3xe/Ak1VX+ujrJtD5Nrx+5cNntF59jpbyk2jbRnJvvadpnqnNHZqDA0qIkPhH0KApIqS9Kmr9Pfv7pewNRK2t52yEF1KWQNdBHueaZaUjeX7BpqKrcx9nJ+Cv/M3cQJBmwXoXofRAdVfc8h4xVkNYwkhwTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WguZF1AN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WguZF1AN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774504122; x=1806040122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0/YZmtUCY1dAJfWm67+UR88v2rIu3ykR3u+aDddgHKw=;
  b=WguZF1ANCUaKl8Qp1RC4Gu6PFyacN9HVj3xIFsBpw998eKj1APYxft9x
   4OAbfDAI2BT1UMHDzIrXjLeJ6j9EMs+TGyhFbs52qC1Wc23IdgRgbFyTp
   Z5ojrugaxc822SBLiLc7cXeq2hr9i7emPoQ2t2UJ9E8BNJsQgQb1zBOea
   qfc/jMikmBLF7UGpWsPpUHiOVauBKGTZMOoyo+7AEh+44mWPiF4UXXPNy
   xbSOxvV0uEqKMdW4MyjRCy8+L6NwVdtHZatb0hWcndyHwIWO3bQtSkI5I
   81lt0PCykYUi3i0ibk2Zdpt2BgsRhqkZx0UsisPzNVam4hETk82mMU5LW
   g==;
X-CSE-ConnectionGUID: mu0mBL0ARmCI7cd3loEt2g==
X-CSE-MsgGUID: oJno2gj5Q4mZRemcd+fZ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75748267"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75748267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 22:48:42 -0700
X-CSE-ConnectionGUID: FHy5/ePLSTGF6lL8p3EXAw==
X-CSE-MsgGUID: 5o3KN/sJQ0K3AG9Bky2IGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="222005638"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 22:48:37 -0700
Message-ID: <383b7c01-3d83-48ac-9dab-e9a5894ca907@linux.intel.com>
Date: Thu, 26 Mar 2026 13:48:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 4/4] perf regs: Enable dumping of SIMD registers
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260324005706.3778057-1-dapeng1.mi@linux.intel.com>
 <20260324005706.3778057-5-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324005706.3778057-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/24/2026 8:57 AM, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> This patch adds support for dumping SIMD registers using the new
> PERF_SAMPLE_REGS_ABI_SIMD ABI.
>
> Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
> platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.
>
> An example of the output is displayed below.
>
> Example:
>
>  $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
>  $perf report -D
>  ... ...
>  237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
>  179370/179370: 0xffffffff969627fc period: 124999 addr: 0
>  ... intr regs: mask 0x20000000000 ABI 64-bit
>  .... SSP   0x0000000000000000
>  ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
>  .... YMM  [0] 0x0000000000004000
>  .... YMM  [0] 0x000055e828695270
>  .... YMM  [0] 0x0000000000000000
>  .... YMM  [0] 0x0000000000000000
>  .... YMM  [1] 0x000055e8286990e0
>  .... YMM  [1] 0x000055e828698dd0
>  .... YMM  [1] 0x0000000000000000
>  .... YMM  [1] 0x0000000000000000
>  ... ...
>  .... YMM  [31] 0x0000000000000000
>  .... YMM  [31] 0x0000000000000000
>  .... YMM  [31] 0x0000000000000000
>  .... YMM  [31] 0x0000000000000000
>  .... OPMASK[0] 0x0000000000100221
>  .... OPMASK[1] 0x0000000000000020
>  .... OPMASK[2] 0x000000007fffffff
>  .... OPMASK[3] 0x0000000000000000
>  .... OPMASK[4] 0x0000000000000000
>  .... OPMASK[5] 0x0000000000000000
>  .... OPMASK[6] 0x0000000000000000
>  .... OPMASK[7] 0x0000000000000000
>  ... ...
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> V7: 1) add assert() check for SIMD fields in sample data.
>     2) optimize regs_abi[] defination.
>
>  tools/perf/util/evsel.c   | 36 +++++++++++++++++++++
>  tools/perf/util/sample.h  | 10 ++++++
>  tools/perf/util/session.c | 66 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5f00489e714a..24cc7ba71ae1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3520,6 +3520,24 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			regs->mask = mask;
>  			regs->regs = (u64 *)array;
>  			array = (void *)array + sz;
> +
> +			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +				assert(regs->nr_vectors <=
> +				       hweight64(evsel->core.attr.sample_simd_vec_reg_user));
> +				assert(regs->vector_qwords <=
> +				       evsel->core.attr.sample_simd_vec_reg_qwords);
> +				assert(regs->nr_pred <=
> +				       hweight64(evsel->core.attr.sample_simd_pred_reg_user));
> +				assert(regs->pred_qwords <=
> +					 evsel->core.attr.sample_simd_pred_reg_qwords);

Sashiko complains

"

Is it safe to use assert() to validate untrusted perf.data file contents here?
If the sample data exceeds the SIMD register bounds, wouldn't this crash the
tool instead of gracefully returning an error?
Additionally, if compiled with NDEBUG, would the bounds checks be removed
completely?
Could these asserts also be evaluating uninitialized or zeroed memory?
The assertions are executed before the union is populated from the sample via
regs->config = *(u64 *)array. This would allow the checks to trivially pass,
potentially allowing an attacker to bypass the intended capability bounds by
providing arbitrarily large values in the configuration data.

"

It's correct. Need to move the assert check after "regs->config = *(u64
*)array;", and would change the assert() check to a regular if check. If
the check fail, gracefully return an error.


> +				regs->config = *(u64 *)array;

Sashiko comments

"

Is a bounds check missing before reading the SIMD configuration word?
There doesn't appear to be an OVERFLOW_CHECK_u64(array) before dereferencing
the array pointer. If a malformed perf.data event payload ends exactly before
this configuration word, could this result in an out-of-bounds read?

"

It's correct. Need to move the later "OVERFLOW_CHECK(array, sz, max_size)"
before the accessing.


> +				array = (void *)array + sizeof(u64);
> +				regs->simd_data = (u64 *)array;
> +				sz = (regs->nr_vectors * regs->vector_qwords +
> +				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);

Sashiko comments

"

Can this calculation overflow and bypass the OVERFLOW_CHECK below?
Because nr_vectors and vector_qwords are u16 fields, C integer promotion
evaluates the multiplication as a signed 32-bit int. If large values are
supplied (e.g., nr_vectors = 65535, vector_qwords = 65535), could the 32-bit
integer wrap around to a small positive value?
This might allow the size check to pass while subsequent reads process a large
amount of out-of-bounds memory.

"

Although "nr_vectors" and "vector_qwords" can't be so large in reality,
it's a risk in logic.  Would fix it. 


> +				OVERFLOW_CHECK(array, sz, max_size);
> +				array = (void *)array + sz;
> +			}
>  		}
>  	}
>  
> @@ -3577,6 +3595,24 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			regs->mask = mask;
>  			regs->regs = (u64 *)array;
>  			array = (void *)array + sz;
> +
> +			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +				assert(regs->nr_vectors <=
> +				       hweight64(evsel->core.attr.sample_simd_vec_reg_intr));
> +				assert(regs->vector_qwords <=
> +				       evsel->core.attr.sample_simd_vec_reg_qwords);
> +				assert(regs->nr_pred <=
> +				       hweight64(evsel->core.attr.sample_simd_pred_reg_intr));
> +				assert(regs->pred_qwords <=
> +					 evsel->core.attr.sample_simd_pred_reg_qwords);
> +				regs->config = *(u64 *)array;
> +				array = (void *)array + sizeof(u64);
> +				regs->simd_data = (u64 *)array;
> +				sz = (regs->nr_vectors * regs->vector_qwords +
> +				      regs->nr_pred * regs->pred_qwords) * sizeof(u64);
> +				OVERFLOW_CHECK(array, sz, max_size);
> +				array = (void *)array + sz;
> +			}
>  		}
>  	}
>  
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index 3cce8dd202aa..21f3416d3755 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -15,6 +15,16 @@ struct regs_dump {
>  	u64 abi;
>  	u64 mask;
>  	u64 *regs;
> +	union {
> +		u64 config;
> +		struct {
> +			u16 nr_vectors;
> +			u16 vector_qwords;
> +			u16 nr_pred;
> +			u16 pred_qwords;
> +		};
> +	};

Sashiko comments

"

Does overlaying the 64-bit integer with four 16-bit fields break cross-endian
parsing?
If perf processes a file recorded on a machine with different endianness, the
sample payload is typically byte-swapped as an array of 64-bit integers.
Swapping the 64-bit config word would reverse the structural byte order of the
four 16-bit fields (e.g., nr_vectors shifts to the position of pred_qwords),
which could corrupt the dimension variables.

"

Wow, Sashiko really found a such deeply hidden issue (Copilot didn't find
it). Considering currently perf-tools only does 64bits word swap for the
endians, so it looks the simplest way to fix this issue is to change the 4
u16 fields to 4 u64 fields.

@Peter, @Arnaldo, @Namhyung, @Ian, do you have any idea on this?


> +	u64 *simd_data;
>  
>  	/* Cached values/mask filled by first register access. */
>  	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7cf7bf86205d..453d44d32162 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -972,15 +972,77 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
>  	}
>  }
>  
> +static void simd_regs_dump__printf(uint16_t e_machine, struct regs_dump *regs, bool intr)
> +{
> +	const char *name = "unknown";
> +	int i, idx = 0;
> +	uint16_t qwords;
> +	int reg_c;
> +
> +	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
> +		return;
> +
> +	printf("... SIMD ABI nr_vectors %d vector_qwords %d nr_pred %d pred_qwords %d\n",
> +	       regs->nr_vectors, regs->vector_qwords,
> +	       regs->nr_pred, regs->pred_qwords);
> +
> +	for (reg_c = 0; reg_c < 64; reg_c++) {
> +		if (intr) {
> +			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> +							       &qwords, /*pred=*/false);
> +		} else {
> +			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> +							       &qwords, /*pred=*/false);
> +		}
> +		if (regs->vector_qwords == qwords) {
> +			name = perf_simd_reg_class_name(e_machine, reg_c, /*pred=*/false);
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < regs->nr_vectors; i++) {
> +		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +		if (regs->vector_qwords > 2) {
> +			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +		}
> +		if (regs->vector_qwords > 4) {
> +			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +		}
> +	}

Sashiko comments

"

Does this print logic safely handle all values of vector_qwords?
The loop unconditionally prints 2 elements per vector, and extends to 4 or 8
elements if vector_qwords > 2 or > 4. If an unusual value like vector_qwords
is 1 or 3, could the loop consume more elements than were allocated, leading
to reading past the simd_data array bounds?
The same pattern seems to apply to pred_qwords below if it is set to 0.

"

Make sense. Would precisely check if the qwords length instead of just a
range. 

Thanks.


> +
> +	name = "unknown";
> +	for (reg_c = 0; reg_c < 64; reg_c++) {
> +		if (intr) {
> +			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> +							       &qwords, /*pred=*/true);
> +		} else {
> +			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> +							       &qwords, /*pred=*/true);
> +		}
> +		if (regs->pred_qwords == qwords) {
> +			name = perf_simd_reg_class_name(e_machine, reg_c, /*pred=*/true);
> +			break;
> +		}
> +	}
> +	for (i = 0; i < regs->nr_pred; i++)
> +		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->simd_data[idx++]);
> +}
> +
>  static const char *regs_abi[] = {
>  	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
>  	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
>  	[PERF_SAMPLE_REGS_ABI_64] = "64-bit",
> +	[PERF_SAMPLE_REGS_ABI_SIMD | PERF_SAMPLE_REGS_ABI_64] = "64-bit SIMD",
>  };
>  
>  static inline const char *regs_dump_abi(struct regs_dump *d)
>  {
> -	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
> +	if (d->abi >= ARRAY_SIZE(regs_abi) || !regs_abi[d->abi])
>  		return "unknown";
>  
>  	return regs_abi[d->abi];
> @@ -1010,6 +1072,7 @@ static void regs_user__printf(struct perf_sample *sample, uint16_t e_machine, ui
>  
>  	if (user_regs->regs)
>  		regs__printf("user", user_regs, e_machine, e_flags);
> +	simd_regs_dump__printf(e_machine, user_regs, /*intr=*/false);
>  }
>  
>  static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, uint32_t e_flags)
> @@ -1023,6 +1086,7 @@ static void regs_intr__printf(struct perf_sample *sample, uint16_t e_machine, ui
>  
>  	if (intr_regs->regs)
>  		regs__printf("intr", intr_regs, e_machine, e_flags);
> +	simd_regs_dump__printf(e_machine, intr_regs, /*intr=*/true);
>  }
>  
>  static void stack_user__printf(struct stack_dump *dump)
