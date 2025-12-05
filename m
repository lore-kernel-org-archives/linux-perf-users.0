Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA872DE6E3;
	Fri,  5 Dec 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932846; cv=none; b=rgXrvnW/AYzOlWMP7dU7caLZmm+XI16mIe/bRJ9AQRuhbam1T0wZ6Muhvjsz3tdXXcDRbjODpOaqmsi0KugQGMAzzQ0AEuXkiHIEtgF6Bzq0SslITGXRDMi7Rsj0Y7hwlSFmQhpb8q8NGDeWPrp0tI75DcnEzi5TP/FrXRZP8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932846; c=relaxed/simple;
	bh=bRrb+8Q5ZRnXrTkx+jEs28tHrGBlIImR98H2WBQYM4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC3MD7SchhO3pIT36Ygpxo6XZnbb/BdoGt0q+AASGKxI1FYKRwwJXhmmrCL/4etYltQWfKqnVVWT2C1LEYOpu2Vp2TdhE+jl+M3lvgYCHNn4J1Je2uTgHoB2fEW+kqHfzy86tcIKgtZYLSCxLaKG/Jz+kwWPUDkMo4cb0poXjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NhrVxaVC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NhrVxaVC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5dGDTOXT6AFdadWGfcrsOZEESdafhFkFNnqBlj3hmKQ=; b=NhrVxaVCtfLiNUGvox2H66tlFT
	QgX11z5SE7+tNt4dfPHqiNj9B1yD/plbhladJuPwFKY4OIgCrk/bwW4lXONaclEeBmmIMnbOWon2K
	3GoYOT6kRisewRICUO64v2r2x20YXEZgyq5kPaB2fTVbwlWGZXIiB+x30udZIpm4CY2h65n8MM0gY
	oqffjaHTC/KdBUQSyMj3sf+/9zAJe88sU7+bBZR0IgJNzVHP/1c3ggUPef33nEZoN46GpsJZlObFf
	FUgpYGKFj1K3Y5xiuTMf3851otH+7NLuzH+HBhVe+nIHmDSpTqgsTvzgrMDF7Qnp5Ev5cIZxWlFbZ
	kH5GxqRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRTeV-00000005bYM-1std;
	Fri, 05 Dec 2025 11:07:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB6FB30027B; Fri, 05 Dec 2025 12:07:06 +0100 (CET)
Date: Fri, 5 Dec 2025 12:07:06 +0100
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
Message-ID: <20251205110706.GT2528459@noisy.programming.kicks-ass.net>
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

> @@ -545,6 +547,25 @@ struct perf_event_attr {
>  	__u64	sig_data;
>  
>  	__u64	config3; /* extension of config2 */
> +
> +
> +	/*
> +	 * Defines set of SIMD registers to dump on samples.
> +	 * The sample_simd_regs_enabled !=0 implies the
> +	 * set of SIMD registers is used to config all SIMD registers.
> +	 * If !sample_simd_regs_enabled, sample_regs_XXX may be used to
> +	 * config some SIMD registers on X86.
> +	 */
> +	union {
> +		__u16 sample_simd_regs_enabled;
> +		__u16 sample_simd_pred_reg_qwords;
> +	};
> +	__u32 sample_simd_pred_reg_intr;
> +	__u32 sample_simd_pred_reg_user;
> +	__u16 sample_simd_vec_reg_qwords;
> +	__u64 sample_simd_vec_reg_intr;
> +	__u64 sample_simd_vec_reg_user;
> +	__u32 __reserved_4;
>  };

This is poorly aligned and causes holes.

This:

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d292f96bc06f..2deb8dd0ca37 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -545,6 +545,14 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u16	sample_simd_pred_reg_qwords;
+	__u32	sample_simd_pred_reg_intr;
+	__u32	sample_simd_pred_reg_user;
+	__u16	sample_simd_vec_reg_qwords;
+	__u64	sample_simd_vec_reg_intr;
+	__u64	sample_simd_vec_reg_user;
+	__u32	__reserved_4;
 };
 
 /*

results in:

        __u64                      config3;              /*   128     8 */
        __u16                      sample_simd_pred_reg_qwords; /*   136     2 */

        /* XXX 2 bytes hole, try to pack */

        __u32                      sample_simd_pred_reg_intr; /*   140     4 */
        __u32                      sample_simd_pred_reg_user; /*   144     4 */
        __u16                      sample_simd_vec_reg_qwords; /*   148     2 */

        /* XXX 2 bytes hole, try to pack */

        __u64                      sample_simd_vec_reg_intr; /*   152     8 */
        __u64                      sample_simd_vec_reg_user; /*   160     8 */
        __u32                      __reserved_4;         /*   168     4 */



A better layout might be:

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d292f96bc06f..f72707e9df68 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -545,6 +545,15 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u16	sample_simd_pred_reg_qwords;
+	__u16	sample_simd_vec_reg_qwords;
+	__u32	__reserved_4;
+
+	__u32	sample_simd_pred_reg_intr;
+	__u32	sample_simd_pred_reg_user;
+	__u64	sample_simd_vec_reg_intr;
+	__u64	sample_simd_vec_reg_user;
 };
 
 /*

such that:

        __u64                      config3;              /*   128     8 */
        __u16                      sample_simd_pred_reg_qwords; /*   136     2 */
        __u16                      sample_simd_vec_reg_qwords; /*   138     2 */
        __u32                      __reserved_4;         /*   140     4 */
        __u32                      sample_simd_pred_reg_intr; /*   144     4 */
        __u32                      sample_simd_pred_reg_user; /*   148     4 */
        __u64                      sample_simd_vec_reg_intr; /*   152     8 */
        __u64                      sample_simd_vec_reg_user; /*   160     8 */


