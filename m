Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4398391845
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432182; cv=none; b=PQ1tIA5+VpLElDTAa8E//lO51VqRmKCSVGJVnkd+Suuxm8udnJAtRnIIhJ4gShVVrWwdpOTlmRz53PzI+kTHfcBgcmqk89Hoht5pM3RX8wxePEPe+xuST/DNOfj0fdY6DOwVNAIFN81dnNK/jhageWc9u+FiDPYKtijPINS57CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432182; c=relaxed/simple;
	bh=vTYCcf0wAf+8haG2OrJz2MEtgGTUmq4EVtDo+7uotEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugBGN6BDv68nfxKgPtsy95JfJdkHUM3h7KHN0VT9Bki5RZrcsZOqhE/QVNT2kdcBjrPCooAzhj0o02Nx1GKpCbd1GVq7ycG7uYR6m2r/KzOorkz0GWqdvoQ8iKRLjLZz+HyR8pdFdVXavFmkuyUkgw08YavMS4FPNIrbfGoc73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnMmdm1T; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnMmdm1T"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3aacde0cc0fso202898a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 21:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791432180; x=1792036980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LvRoOScbaY6pOmwJ9M2q65FEL0FaRp9KXeXeqjl1z2k=;
        b=QnMmdm1THRQW9Cgla6AwziHOZbrZ7Qak0Psb2yxldN1U20gbI2LeXkF7zxris/UpyR
         SC4bRTUijzjv3P9NyEqb+rmXkaO4F3bOoEivovjvmPqNAbXiN8QA1gHAxXRFxlKix9gI
         fbvFU6kOwNusOkPXMS+8shLSJAMEgMVrJuzt+PzrPXfx/CwzvtzXDuyeBGqxohxpA15N
         +Nxy/wtyt7zK5ZBHSzwUKihwU85F8zTcHuVGbygXFxWGF16L7t8EmGvo8yKGPWCr/44Y
         26oY7n30UAXg6HX1uxaaYG0GdtXYhj0CapDKZy0d1UOBAasEXQTFasDhrQYcE6bdiL2E
         2uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432180; x=1792036980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LvRoOScbaY6pOmwJ9M2q65FEL0FaRp9KXeXeqjl1z2k=;
        b=WKwi+5VCvBh0zfKHi/9rh3xtz2cOjnik9Hnbi5lbyv69l9OLXoSuZzR4H15WMXUZr3
         WYTB6iObEdjmQYLawaKE/hpvYtlph1QYZjXcGWczKbMLrXF5X4wn/sL/teuTRg5rytDf
         WkC7AQjWXHUGcH1Y4tgpEONvGOk/IjgJxcJXEvE0TYKpRiZmzYglFd18wgKjZYScuLqI
         SWFZOEyIBle9usaYT7yQX1ookWJS74KaTkflji4jdJCOYGjDtuJSDAgyILTQj2D7WUGA
         Je1KxvP8fNijScJhUPfmEB6Wn3DWKNSSAaovEs+7nOkjHj5TLqwkThew1mBu/DY+3Dkv
         0/kQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8Pr2CqqhNop6bYIATw1SbBZJxv/CdOlu4Hom2RvJQ7iO7keJDLSB+UUKB1QkSLzFcbYwSOMTPxHXJYFZUzSYO@vger.kernel.org
X-Gm-Message-State: AFq9FYK0lY88CEIPL1sVu987NEa6oQupNdaPusgYhTyssZXdSiRk/sEy
	3r5EElWeschHxTC2OTc6H3PS4V33iNK/B4hBnrrdTeoDNDealgn8BTS9onXeQHwCSFE=
X-Gm-Gg: AYBFou1gxgzO+WhVhNaXFziKV24kV+7/Jpu3SCsUGI3AE7Y/nde/WyGrjanAXeWa/Qf
	T5GWzIt1LPp6eYkFrxJFAZqYv/Z7RTOEdhvz15f58FIpAbIbTkYLsABcwoJPrQ7Q5CQvwGrfRxe
	QidAGR/DmbdsNgo+sKSoA+D+KdypgJkuDiHpJ1LvPwFSu0hImtGzehlC5QreIpqrRDVbqN+u92Q
	qeNgsrLR4YkS8WclzVgrfCvH/zc66TOPlFZga0iFPTQWTRdIk96eneUgCW6WNHY6HaQ+XoWOrZf
	3h+ERVW1YHO3evo7d3ozbcW7gBbCGTzIZbdnI0zI7ttfp5fGYmQW7qy/cQFj9gNORzCCXs1HNJh
	UmEqYNubuBf6Of/W+loYATK5ro7dUHtwUznmajDsUxLqSUqwsHdwgmjw6eSOMrOCXiHBo0nPYVM
	a5Yq5jd7n352CFQvMXuedkYm3htyHbS/F9/7XhS6w879Ka2m0zFELRcpR2dHXU659VIl3jGvOhd
	Q==
X-Received: by 2002:a17:90b:134d:b0:3a4:ee64:b880 with SMTP id 98e67ed59e1d1-3a8a0dfb941mr3122084a91.32.1791432179787;
        Wed, 07 Oct 2026 21:02:59 -0700 (PDT)
Received: from mail.google.com ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9d94ef876sm2306775a91.0.2026.10.07.21.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:02:59 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:02:52 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Changbin Du <changbin.du@gmail.com>, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf bench: Add atomic operations benchmark
Message-ID: <ascVxPSLiALhI8iz@mail.google.com>
References: <20261007053027.1738402-1-changbin.du@gmail.com>
 <sashiko-outbox-162645@kernel.org>
 <asa7RZ3NNwpogn8M@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asa7RZ3NNwpogn8M@google.com>

On Wed, Oct 07, 2026 at 02:36:05PM -0700, Namhyung Kim wrote:
> On Wed, Oct 07, 2026 at 05:39:22AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] perf: 64-bit atomic builtins on u64 cause link errors on 32-bit
> > - [Low] perf: Missing explicit inclusion of <stdint.h> for UINT64_MAX
> > --
> > 
> > commit 1f5903d48b4529edce94275c5756879218402332
> > Author: Changbin Du <changbin.du@intel.com>
> > 
> > perf bench: Add atomic operations benchmark
> > 
> > Add a new atomic collection to perf bench for benchmarking atomic
> > read-modify-write operations with multi-threaded contention testing.
> > 
> > > diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
> > > new file mode 100644
> > > index 0000000000000..08497910b563f
> > > --- /dev/null
> > > +++ b/tools/perf/bench/atomic.c
> > [ ... ]
> > > +static void *worker(void *arg)
> > > +{
> > > +	struct worker_stats *ws = (struct worker_stats *)arg;
> > > +	struct timespec tstart, tend;
> > > +	u64 i;
> > > +
> > > +	pthread_barrier_wait(&start_barrier);
> > > +
> > > +	clock_gettime(CLOCK_MONOTONIC, &tstart);
> > > +	switch (bench_op) {
> > > +	case OP_CAS:
> > > +		for (i = 0; i < iterations; i++) {
> > > +			u64 old_val, new_val;
> > > +
> > > +			old_val = __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);
> > 
> > [Severity: High]
> > Does the use of 64-bit atomic builtins on a u64 variable in worker() in
> > tools/perf/bench/atomic.c break compilation on 32-bit architectures?
> > 
> > Without 32-bit fallback definitions or omitting 64-bit atomics entirely,
> > calls like __atomic_load_n, __atomic_compare_exchange_n, and
> > __atomic_fetch_add on the shared_counter might generate unresolved
> > __atomic_*_8 library calls on 32-bit systems.
> 
> Probably it's ok to go with unsigned long.
> 
Yes, just fixed it by using the native word size for the shared counter — 
unsigned long instead of u64.

> Thanks,
> Namhyung
> 
> > 
> > > +			do {
> > > +				new_val = old_val + 1;
> > > +			} while (!__atomic_compare_exchange_n(&shared_counter,
> > > +							      &old_val, new_val,
> > > +							      false,
> > > +							      __ATOMIC_RELAXED,
> > > +							      __ATOMIC_RELAXED));
> > > +		}
> > > +		break;
> > > +	case OP_INC:
> > > +		for (i = 0; i < iterations; i++)
> > > +			__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > [ ... ]
> > > +static void print_default_format(struct worker_stats *wstats,
> > > +				 struct stats *time_stats)
> > > +{
> > [ ... ]
> > > +	/*
> > > +	 * Per-thread statistics from the last measured repeat show
> > > +	 * fairness / imbalance in CPU scheduling.
> > > +	 */
> > > +	if (threads > 1) {
> > > +		u64 min_ns = UINT64_MAX, max_ns = 0, total_ns = 0;
> > 
> > [Severity: Low]
> > Does the usage of UINT64_MAX in print_default_format() in
> > tools/perf/bench/atomic.c require the explicit inclusion of <stdint.h>?
> > 
> > This might violate strict musl compatibility header guidelines, which require
> > explicitly including <stdint.h> for this constant.
> > 
> > > +		double min_thru, max_thru, avg_thru;
> > > +
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20261007053027.1738402-1-changbin.du@gmail.com?part=1

-- 
Cheers,
Changbin Du
