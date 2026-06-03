Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14C1D95A3;
	Wed,  3 Jun 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498460; cv=none; b=r9z8APTNxUWMFD9/9qGFq0Chpcdutjl6R8yO/yb/inDhr0grFG3mgm/zsWN2AOJBLs2EWP12dKFSI9ncYabYgiII+Wnl+SrBr26UWqv4AgNStKFFr9w+ODd4XFYup/XvHprsHHnWszm6OIdxqj9vWYinfhbPEnXMMqDrMe1tYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498460; c=relaxed/simple;
	bh=NPYcfKH5FZ0+KiGgSFy5Uhm4u5FfmkmhDxHJnb6AYxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q10KVL1Js/VrJqf1Pc/gpYqE0TQj7K59otEX6b3IU3yUNnH5BB9unWLtvcxdcuSIVeopmjUTelS+Jh/lqRnupQWLGmT1ishaForC79SoRtfCRsf+hUHCF/+l2Y0tlIhNDkSn/euAc6VihKmd/yeZHIBelaWzIf/lS1Q9Borgsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JRjJ7DGr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JRjJ7DGr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E1A32F4;
	Wed,  3 Jun 2026 07:54:12 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627AA3F632;
	Wed,  3 Jun 2026 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780498457; bh=NPYcfKH5FZ0+KiGgSFy5Uhm4u5FfmkmhDxHJnb6AYxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRjJ7DGrNd0px823NkqFSR+FWMWeE3p9sspZL8ooYjywClnhQasno46FluIpO0OHt
	 88Ip1lSKrivLAdOEuDiwstoGeoGb7bmW7Ynup0ptvdA/TsWqwFvNvrqgUBsOBufBrs
	 0cYtcrYlL4Mgo78umljXaS27OLDSTLzcgxbe/uow=
Date: Wed, 3 Jun 2026 15:54:15 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 09/18] perf test: Add named_threads workload
Message-ID: <20260603145415.GY101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:51PM +0100, James Clark wrote:

> +#define DEFINE_THREAD(n)						\
> +noinline void *named_threads_thread##n(void *arg __maybe_unused)	\
> +{									\
> +	pthread_setname_np(pthread_self(), "thread" #n);		\
> +	for (int i = 0; i < iterations; i++)				\
> +		named_threads_work *= 3;				\
> +									\
> +	return NULL;							\
> +}

> +static int named_threads(int argc, const char **argv)
> +{
> +	pthread_t threads[MAX_THREADS];
> +	int nr_threads = 1;
> +	int err = 0;
> +
> +	if (argc > 0)
> +		nr_threads = atoi(argv[0]);
> +
> +	if (nr_threads <= 0 || nr_threads > MAX_THREADS) {
> +		fprintf(stderr, "Error: num threads must be 1 - %d\n", MAX_THREADS);
> +		return 1;
> +	}
> +
> +	if (argc > 1)
> +		iterations = atoi(argv[1]);
> +
> +	if (iterations < 0) {
> +		fprintf(stderr, "Error: iterations must be non-negative\n");
> +		return 1;
> +	}
> +
> +	for (int i = 0; i < nr_threads; i++) {
> +		int ret;
> +
> +		ret = pthread_create(&threads[i], NULL, thread_fns[i], NULL);

Just curious this can be simplified to a thread function, like:

  noinline void *named_thread(void *arg)
  {
        char name[16];

        snprintf(name, sizeof(name), "thread%d", int(arg));

  	pthread_setname_np(pthread_self(), name);
        ...
  	return NULL;
  }

Thanks,
Leo
