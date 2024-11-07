Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31121766D;
	Thu,  7 Nov 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008505; cv=none; b=TpiEBcJmQGe/KH9YM6ObTBdnhFKuBPdcLqfsdEEzid/k968N4ZnOYZzOtm92gDe/nAqSLdyGTNA5gonfaSOuusF2Q8P1BRCxesxxiK+bBBlfW2qDGRfxA/jAjHQLpCwt9RQnF3bhWtSW725Zuzjn7yLZZyJWE7odplINjuK3J54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008505; c=relaxed/simple;
	bh=qcXWjoNzolLbtObYn6+ZbtXzLxRdeRg5xkYwUA1E2h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMVQ+ygAe4OHtB+xCL2pLxHmu8HN2mbN2GQLnAZxpY6JYQrUBZ2dsrVvnxdoG7wWSbo7LZRlZKk1KeMbq3gzzPDDXFuoELNtx1nW4GX6G65hvFqrzIADvKmWd5yf2QTEgPG0yI7Sn6VDTsirxZDVXn1PuIelEDks+xOaoez5mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDClY96t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDClY96t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A77EC4CECC;
	Thu,  7 Nov 2024 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731008504;
	bh=qcXWjoNzolLbtObYn6+ZbtXzLxRdeRg5xkYwUA1E2h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDClY96taUjBA/B1xEplac6Y9OGo/BZau+uQ1goeRKI4nC3WqCNZKjm11ARmEZ1iC
	 GPnRsQ/ECF4vxm4w/E6BcJCCOO5CdsRLeBy2B33Dg5Zqqpb4btrUZ997XL4IboaiKd
	 rE6ijed+Phw2GnG+pqwgsLMV+MOGoUJSlNidsbcuwyATsnF9VRJPNMxLaFkR9YmK5+
	 940U5VDcrb5IPDh7i7ZMfuwZ052fBL9I7tg0hbr+5B2B6gUYneUNr0UsaAPyFIkwVj
	 hgDa4b3S3/tn7mnrKcGSaGPeXjcS7LigG+RkNBjvAVkwvQeDt9f3qBF9S7dFYC3vJW
	 78IQU9J3L1jNQ==
Date: Thu, 7 Nov 2024 11:41:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, sumanthk@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] perf/test: fix perf ftrace test on s390
Message-ID: <Zy0X9kz_tmjNue5D@google.com>
References: <20241107123343.1580616-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107123343.1580616-1-tmricht@linux.ibm.com>

On Thu, Nov 07, 2024 at 01:33:43PM +0100, Thomas Richter wrote:
> On s390 the perf test case ftrace sometimes fails as follows:
> 
>   # ./perf test ftrace
>   79: perf ftrace tests    : FAILED!
>   #
> 
> The failure depends on the kernel .config file. Some configurarions
> always work fine, some do not.

Which test do you fail?  ftrace trace or profile?  I don't think it's
gonna be a problem for ftrace latency.


> To achieve success for all our tested kernel configurations, enlarge
> the buffer to store the traces complete without wrapping.
> The default buffer size is too small  for all kernel configurations.
> Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB

Actually you can use -m 16M option for perf ftrace trace and perf ftrace
profile.  Then you don't need to care about restoring the original size.

Thanks,
Namhyung

> 
> Output after:
>   # ./perf test ftrace
>   79: perf ftrace tests     : Ok
>   #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index a6ee740f0d7e..742d6b8f34d3 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -80,10 +80,21 @@ test_ftrace_profile() {
>      echo "perf ftrace profile test  [Success]"
>  }
>  
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	ftrace_size=$(cat /sys/kernel/tracing/buffer_size_kb)
> +	echo 16384 > /sys/kernel/tracing/buffer_size_kb
> +fi
> +
>  test_ftrace_list
>  test_ftrace_trace
>  test_ftrace_latency
>  test_ftrace_profile
>  
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
> +fi
> +
>  cleanup
>  exit 0
> -- 
> 2.47.0
> 
