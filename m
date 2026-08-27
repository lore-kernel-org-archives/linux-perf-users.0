Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA03FB052;
	Thu, 27 Aug 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854915; cv=none; b=bPlydBIccSjLUOqFdM5+WaX7UIsTK8r5F4TOJ7k0aoAW7z8akYVoi9yqycEBM9lHUQwdtIOjAsBeW1g+mQtFpdY9a6kzA+2hbGqvBS87cw2GFEqA3QWPAmAbStMZjHPaXixqWTSNnU/rQsP9eOqFACJAlgEqhlY3XsHGdPBh3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854915; c=relaxed/simple;
	bh=rUd7+J/8/iNJI3bKZQzX3i/RyNWMQTasR2RA1ttzPaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giUuZUHomdXWSkzHMkge6mvT30KUsvoVv9DNHFtl675Mr6Zbdr0mWTX1NuXOWXof1wGk5XNJwM8sPGKOQUU5dfaRfykKz453Fc4ALLJpYQptbH9T6dClwvS+jKPjQfRoDEVi4oKVFIasJdAFI8UbMeHn21s2MWTRlIGq7FI2vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Iob+HDAG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Iob+HDAG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1681688;
	Thu, 27 Aug 2026 11:21:48 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A39303F66F;
	Thu, 27 Aug 2026 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787854912; bh=rUd7+J/8/iNJI3bKZQzX3i/RyNWMQTasR2RA1ttzPaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iob+HDAGtrc0jBrbEfWc/4fcivNp0bnI9NUeUJhCK1UBLaNzPhwgKnUCsNLRrHoIX
	 fuyU7Ggy4b7+Tlzg9spHJZunbmB7Zf6sRtQcJSywt9AAN+fEcachMrlOPH1IkJ8kpm
	 VIlZVsnAUEeNLjMZACsqGm/mQoTIoiSH3glLfpUw=
Date: Thu, 27 Aug 2026 19:21:49 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 11/14] perf auxtrace: cs-etm: Capture wrapped snapshots
Message-ID: <20260827182149.GQ8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-11-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-11-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:09AM +0100, James Clark wrote:

[...]

> @@ -2061,10 +2061,20 @@ static int __auxtrace_mmap__read(struct mmap *map,
>  
>  	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
>  
> -	if (snapshot && itr->snapshot_has_wrapped) {
> -		err = auxtrace_find_snapshot(itr, mm->idx, mm, data, &head, &old);
> -		if (err)
> -			return err;
> +	if (snapshot) {
> +		if (itr->snapshot_has_wrapped) {
> +			err = auxtrace_find_snapshot(itr, mm->idx, mm, data, &head, &old);
> +			if (err)
> +				return err;
> +		} else if (itr->monotonic_snapshot_head) {
> +			size = head - old;
> +			/* Force a full buffer read if a wrap has occurred */
> +			if (size > mm->len) {
> +				pr_debug3("%s: wrap detected, adjusting old from 0x%"PRIx64" to 0x%"PRIx64"\n",
> +					  __func__, old, head - mm->len);
> +				old = head - mm->len;
> +			}
> +		}

Wouldn't this be a bug fix, since CoreSight did not have a
find_snapshot() callback before this series?

I am wondering whether CoreSight could reuse the common callback
introduced by this series. I expect this idea may be pushed back :),
however, my concern is more about the overall code complexity.

Reusing a common find_snapshot() mechanism could give us a couple of
benefits:

 1. Userspace could share the same snapshot/wrap handling, rather than
    maintaining different mechanisms for different AUX trace.

 2. It could also make it easier for the TRBE driver to use circular
    mode for snapshot, which would avoid IRQ maintenance and many
    redundant RECORD_AUX records (and avoid the mentioned trigger
    counter for assistance in snapshot mode).

The monotonic head pointer can simplify some calculations in userspace,
but if the common find_snapshot() callback can be extended to handle both
arbitrary and monotonic head, seems to me, this is a good chance to
simplify the code.

Thanks,
Leo
