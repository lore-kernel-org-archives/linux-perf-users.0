Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEBA3370E4;
	Wed, 17 Jun 2026 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735829; cv=none; b=Ca9Hire/Tnth4SF8VIiZL4FJJydwBUJocLvSMCP4qDcJOdaxpOBWPEg7+sEgnkMUBHTJUT7ZPGlw7OrCyiMnAIZXvf1LxUmMwLjeh8ObvJiV6L3nWr+zALXn9QEIXAPojHgIuBPoASBFlDHdWk2X+kG5cgKBuVxYDm9st3Q3f28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735829; c=relaxed/simple;
	bh=+l1vbI/ifLAPI4UJs2QSQKrBNCgs/F+xVjF/jtwFCkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnUVMmNq1fWPJKOvIgdm97okxSNd/+spdWtDSAN+RtMRD0IyvBAKrNuekA/GpYcWZYMsc5r8OZgOjTs9GIe9A2nbC7XwSNw2myxfGMK4bxD92Ute6FGr2H0CQN/YwtCM4iHHOIWXR7Q4+VTmX1dirBl02Z5MgXBB0q0tDwsAtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Z9gEFe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Z9gEFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0611F000E9;
	Wed, 17 Jun 2026 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781735828;
	bh=FszISFuXoWUjPkql8lrbo4ikQjUCHXwwhR/UIsW2gQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J0Z9gEFe0xFDJfdkVxW3o64OkvkM4vCkSDS5/Ij+3vs0tRIcYJ09Z6SzmUxPWOGmZ
	 SWpJQsly46D5wrISc/S0STky5fyB/lCevnZUusdHbubx1Dowoem0wjydTFL8UfV9Kg
	 zZOJeJ9fAX6/gZzCNOv0Wgs3UPR/U8wYnyBss9aNhqWQYIgl7V3uS23MnwN2+/QEXj
	 DuvrmgX9JjkI6ewIgwWddBYm9in5GwPoe5YsR4j6MPRb3yW4S698LwpoxBEoEzW/zf
	 f0UdNvY+bGyLx7gK/X8cAKrSfF1IF0X9NU+lYV+mYHYFWK7uCgigxYtxuDPT8Lrf2+
	 spFYoJHFKClqw==
Date: Wed, 17 Jun 2026 15:37:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, thomas.falcon@intel.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v3 04/13] perf tests: Add robust record retry helper and
 use subsecond workloads
Message-ID: <ajMhklrFodxJmb2F@google.com>
References: <20260616061404.41929-1-irogers@google.com>
 <20260616164819.370939-1-irogers@google.com>
 <20260616164819.370939-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616164819.370939-5-irogers@google.com>

On Tue, Jun 16, 2026 at 09:48:09AM -0700, Ian Rogers wrote:
> Introduce `perf_record_with_retry` and `perf_record_cleanup` in a shared
> library `tests/shell/lib/perf_record.sh` to prevent record test failures
> caused by transient recording or workload delays.
> 
> Update `record.sh`, `record_lbr.sh`, `pipe_test.sh`, `kvm.sh`, and
> `stat_all_pfm.sh` to use this robust record retry logic. These tests now
> start with very short durations (e.g. 0.01 seconds) and scale up if the
> initial recording failed to capture samples, significantly improving test
> execution speed on success while remaining resilient to slow systems.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> @@ -60,22 +71,29 @@ test_kvm_stat() {
>  test_kvm_record_report() {
>  	echo "Testing perf kvm record/report"
>  
> -	echo "Recording kvm profile for pid ${qemu_pid}..."
> -	# Use --host to avoid needing guest symbols/mounts for this simple test
> -	# We just want to verify the command runs and produces data
> -	# We run in background and kill it because 'perf kvm record' appends options
> -	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> -	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> -	rec_pid=$!
> -	sleep 1
> -	kill -INT "${rec_pid}"
> -	wait "${rec_pid}" || true
> +	local duration
> +	local success=false
> +	for duration in 1 2 4 8; do
> +		echo "Recording kvm profile for pid ${qemu_pid} (duration ${duration}s)..."
> +		rm -f "${perfdata}" "${perfdata}".old
> +
> +		perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> +		local rec_pid=$!
> +		sleep ${duration}
> +		kill -INT "${rec_pid}"
> +		wait "${rec_pid}" || true

Can this be just like below?

		perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" sleep ${duration}

Thanks,
Namhyung

> +
> +		if [ -e "${perfdata}" ] && \
> +			perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
> +			success=true
> +			break
> +		fi
> +		echo "No samples or report failed, retrying..."
> +	done
>  
> -	echo "Reporting kvm profile..."
> -	# Check for some standard output from report
> -	if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
> +	if [ "$success" = false ]; then
>  		echo "Failed to report kvm profile"
> -		perf kvm -i "${perfdata}" report --stdio 2>&1
> +		perf kvm -i "${perfdata}" report --stdio 2>&1 || true
>  		err=1
>  		return
>  	fi
