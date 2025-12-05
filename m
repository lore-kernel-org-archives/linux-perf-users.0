Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54998326D5F;
	Fri,  5 Dec 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764934821; cv=none; b=OM1KivuO58LoIhcrjUPQz6YeGpC7v+7rsmY55aVDDoy0KK/o7Rzf/IJw2xkQdgtJVPLKIOT3f4XwlgXtoqN/RDgsiBebrjzdum+pFsKff79muKlGPuWQQ8ED5rWnn19Azhs7Ol8hc2CKfBl7KenJ/GxBvlsy9Qk+Vx8h6wXIRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764934821; c=relaxed/simple;
	bh=e5hjX8i5z5Z2onGdVYoVwpxzP8eZn7vZ5siBdWmqjOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyOCWSTRbqyEV8NK1xtApeH7RAzGwAupKviz/wyRpA8hjapkXl4VD2nRje2HEaiIGYF8ajAk4cnhYC6HVsT4FaI/jqRUT87KTr2h4zwQ3vA7f+GN8/EtyTvw6cyuZrUP02SIo7bfZ4sMzatNUq474KU+kHElNUuLG8nfq5dWqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ci+IBYZE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ci+IBYZE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UmQzgcRG+abG0yYk1OfGfEHn9k9kBopV1RQRDrKZrn4=; b=Ci+IBYZEOSEEo8LMxcraZ+hXba
	8KKexGi43HQk8gWSUsNGEbaaTW8RYNVxE+XC+x/URII5VUoyoUCiEv/A2YStawfOjnujmbAhKe2QA
	2IaQW0Z08bCGjx+h9QuzE3jN75K1qRhPDo63vsI4et5FRePMvPPGY4/d1okMnUCCM+N3l49zGyQsp
	tX/24/Q2e4QTsPPWxNk3NaQURjkpPJPluo4UnOy+inqh3E6oRGRJ8G79HMKQF7muO9ebKdr3SZsWL
	KMQQ0jHOlSCnIauF0rQGTOdaJWX2t3P9ja15puMCLWiq4HNnmdtUDm3PgWgBaaFxLqBB82pEvfUKA
	aqVOEFmA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRUAR-00000005drl-1CEn;
	Fri, 05 Dec 2025 11:40:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE6DA300499; Fri, 05 Dec 2025 12:40:06 +0100 (CET)
Date: Fri, 5 Dec 2025 12:40:06 +0100
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
Subject: Re: [Patch v5 07/19] perf: Add sampling support for SIMD registers
Message-ID: <20251205114006.GV2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203065500.2597594-8-dapeng1.mi@linux.intel.com>

On Wed, Dec 03, 2025 at 02:54:48PM +0800, Dapeng Mi wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3e9c48fa2202..b19de038979e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7469,6 +7469,50 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>  	}
>  }
>  
> +static void
> +perf_output_sample_simd_regs(struct perf_output_handle *handle,
> +			     struct perf_event *event,
> +			     struct pt_regs *regs,
> +			     u64 mask, u16 pred_mask)
> +{
> +	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
> +	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
> +	u64 pred_bitmap = pred_mask;
> +	u64 bitmap = mask;
> +	u16 nr_vectors;
> +	u16 nr_pred;
> +	int bit;
> +	u64 val;
> +	u16 i;
> +
> +	nr_vectors = hweight64(bitmap);
> +	nr_pred = hweight64(pred_bitmap);
> +
> +	perf_output_put(handle, nr_vectors);
> +	perf_output_put(handle, vec_qwords);
> +	perf_output_put(handle, nr_pred);
> +	perf_output_put(handle, pred_qwords);
> +
> +	if (nr_vectors) {
> +		for_each_set_bit(bit, (unsigned long *)&bitmap,

This isn't right. Yes we do this all the time in the x86 code, but there
we can assume little-endian byte order. This is core code and is also
used on big-endian systems where this is very much broken.

> +				 sizeof(bitmap) * BITS_PER_BYTE) {
> +			for (i = 0; i < vec_qwords; i++) {
> +				val = perf_simd_reg_value(regs, bit, i, false);
> +				perf_output_put(handle, val);
> +			}
> +		}
> +	}
> +	if (nr_pred) {
> +		for_each_set_bit(bit, (unsigned long *)&pred_bitmap,
> +				 sizeof(pred_bitmap) * BITS_PER_BYTE) {
> +			for (i = 0; i < pred_qwords; i++) {
> +				val = perf_simd_reg_value(regs, bit, i, true);
> +				perf_output_put(handle, val);
> +			}
> +		}
> +	}
> +}
