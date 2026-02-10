Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F021D3F5;
	Tue, 10 Feb 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762758; cv=none; b=R3x87SesoBVk4Xmli34Y8uXt/4xLvpQCpXxo5fR/ABDcOACiQb99g9gAsb2F2fv5DOf5DtN7QXTbGRQCc4sOo3/McZTWF6qM3al+qs6dHVipXz5gQXOllpeFONVwOr+VFE1AVd/tJsJsMf0EHeLHj1R0iA74JANbNcNa14Kx5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762758; c=relaxed/simple;
	bh=lQShhXRR7IH8EGbmwe7892f/78pw63VYr2eXANexL7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLtsb0T0njc6CGOjqG5Ls9z3PliA9LjCOeqgPcwa9BWhoH/mUSqXPVIrjyqP+fH0QysXtUQ3dAin4+MU1qKKT9HzJTyGCK/7HKGga/AloGhoVnYvQLI5N9sx9NnNIkgqYkzFa31AgepnEsPs0L+QqIaNntDXlpAsR/aGToEdFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rrq0wEse; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rrq0wEse"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/fEgFns1kwx9nXJ9QDG/fVw151aqyiWDOD+Kq7bDaSo=; b=Rrq0wEseH2cHAXfMq+sQu2R0UR
	codgJeURL2xCj0wuO8LAXsSYFOWovmnDBMlTgVCiCPpd7xsKLpgNekzrWNi06owMQiUVRPyaUYKOS
	38lp/EvD9BUEbxAajLreOCFDpcFmdOpHDy/yQmPVWzkTrf81Qe8LDZNBKEf7Hq/l1pp2OpeY3gVVG
	OrljQeCaBktEVk/EvpQFXuUYP2AGdfR5Vf1Z9+HKuEpbNlGTxWMUILjqUTxh/smk25enMEWxWwzK/
	RdMx5eZpKl14PT1MGnW4SgkAz07B2a+SmJKEPoXZWtuyU2bCHJbebWejbE2wK6rApg/bTDWMS6KgS
	GMkQ/R/w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpwHO-00000008zSw-3QUE;
	Tue, 10 Feb 2026 22:32:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11FBC30075A; Tue, 10 Feb 2026 21:04:07 +0100 (CET)
Date: Tue, 10 Feb 2026 21:04:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v6 12/22] perf: Add sampling support for SIMD registers
Message-ID: <20260210200407.GQ2995752@noisy.programming.kicks-ass.net>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-13-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209072047.2180332-13-dapeng1.mi@linux.intel.com>

On Mon, Feb 09, 2026 at 03:20:37PM +0800, Dapeng Mi wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d487c55a4f3e..5742126f50cc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7761,6 +7761,50 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>  	}
>  }
>  
> +static void
> +perf_output_sample_simd_regs(struct perf_output_handle *handle,
> +			     struct perf_event *event,
> +			     struct pt_regs *regs,
> +			     u64 mask, u32 pred_mask)
> +{
> +	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
> +	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
> +	u16 nr_vectors;
> +	u16 nr_pred;
> +	int bit;
> +	u64 val;
> +	u16 i;
> +
> +	nr_vectors = hweight64(mask);
> +	nr_pred = hweight32(pred_mask);
> +
> +	perf_output_put(handle, nr_vectors);
> +	perf_output_put(handle, vec_qwords);
> +	perf_output_put(handle, nr_pred);
> +	perf_output_put(handle, pred_qwords);
> +
> +	if (nr_vectors) {
> +		for (bit = 0; bit < sizeof(mask) * BITS_PER_BYTE; bit++) {
> +			if (!(BIT_ULL(bit) & mask))
> +				continue;
> +			for (i = 0; i < vec_qwords; i++) {
> +				val = perf_simd_reg_value(regs, bit, i, false);
> +				perf_output_put(handle, val);
> +			}
> +		}
> +	}
> +	if (nr_pred) {
> +		for (bit = 0; bit < sizeof(pred_mask) * BITS_PER_BYTE; bit++) {
> +			if (!(BIT(bit) & pred_mask))
> +				continue;
> +			for (i = 0; i < pred_qwords; i++) {
> +				val = perf_simd_reg_value(regs, bit, i, true);
> +				perf_output_put(handle, val);
> +			}
> +		}
> +	}
> +}

Yeah, that works, but it does make me sad. The existing
perf_output_sample_regs() has yet another solution.

Wondering how hard it could possibly be to write a for_each_set_bit()
variant that works on a given word (instead of an array), I did the
below.

It works (at least, the assembly looks about right); but I'm not sure
its all I had hoped for either :-(

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7754,18 +7754,27 @@ void __weak perf_get_regs_user(struct pe
 	regs_user->abi = perf_reg_abi(current);
 }
 
+/* Until GCC-14+/clang-19+, which have __builtin_ctzg() */
+#define __ctzg(val, def) \
+	(val) ? _Generic((val), \
+			 unsigned int: __builtin_ctz(val), \
+			 unsigned long: __builtin_ctzl(val), \
+			 unsigned long long: __builtin_ctzll(val)) : (def)
+
+#define __next_bit(val, bit) \
+	({ auto __v = (val); \
+	   __v &= GENMASK(sizeof(__v) * BITS_PER_BYTE - 1, bit); \
+	   __ctzg(__v, -1); })
+
+#define word_for_each_set_bit(bit, val) \
+	for (int bit = 0; bit = __next_bit(val, bit), bit >= 0; bit++)
+
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
 {
-	int bit;
-	DECLARE_BITMAP(_mask, 64);
-
-	bitmap_from_u64(_mask, mask);
-	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
-		u64 val;
-
-		val = perf_reg_value(regs, bit);
+	word_for_each_set_bit(bit, mask) {
+		u64 val = perf_reg_value(regs, bit);
 		perf_output_put(handle, val);
 	}
 }
@@ -7778,14 +7787,8 @@ perf_output_sample_simd_regs(struct perf
 {
 	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
 	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
-	u16 nr_vectors;
-	u16 nr_pred;
-	int bit;
-	u64 val;
-	u16 i;
-
-	nr_vectors = hweight64(mask);
-	nr_pred = hweight32(pred_mask);
+	u16 nr_vectors = hweight64(mask);
+	u16 nr_pred = hweight32(pred_mask);
 
 	perf_output_put(handle, nr_vectors);
 	perf_output_put(handle, vec_qwords);
@@ -7793,21 +7796,17 @@ perf_output_sample_simd_regs(struct perf
 	perf_output_put(handle, pred_qwords);
 
 	if (nr_vectors) {
-		for (bit = 0; bit < sizeof(mask) * BITS_PER_BYTE; bit++) {
-			if (!(BIT_ULL(bit) & mask))
-				continue;
-			for (i = 0; i < vec_qwords; i++) {
-				val = perf_simd_reg_value(regs, bit, i, false);
+		word_for_each_set_bit(bit, mask) {
+			for (int i = 0; i < vec_qwords; i++) {
+				u64 val = perf_simd_reg_value(regs, bit, i, false);
 				perf_output_put(handle, val);
 			}
 		}
 	}
 	if (nr_pred) {
-		for (bit = 0; bit < sizeof(pred_mask) * BITS_PER_BYTE; bit++) {
-			if (!(BIT(bit) & pred_mask))
-				continue;
-			for (i = 0; i < pred_qwords; i++) {
-				val = perf_simd_reg_value(regs, bit, i, true);
+		word_for_each_set_bit(bit, pred_mask) {
+			for (int i = 0; i < pred_qwords; i++) {
+				u64 val = perf_simd_reg_value(regs, bit, i, true);
 				perf_output_put(handle, val);
 			}
 		}
