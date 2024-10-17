Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5AA1D0411;
	Thu, 17 Oct 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196913; cv=none; b=bTrcZKJHi+ankczkINqXvrhGdWSpqe9vAp7e2B+nLvAmXoxiSebAenjAWryt8naGMU+JHaQcT7yYRgi/AoHkV0ncFc6ilncExxj5q4Is5dVd7ISO6k+aLAv4a932kb4Ea6/RY3ZerG1wsmb3egS4f9qiZmfwchIliAHYreLOo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196913; c=relaxed/simple;
	bh=tJ4rJNhg/4ydmSmPq8aVI54R0C/xVla61sQugEFmtoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtwOGNaVXy4lxHgeKyoIeuLglDuj6Gdw3SQ+Ee4tsCYZJoiEMv7cSP7YRfpsZUvTIrNR18DnG50oMors1TiHqLQy3U8fjKmnk3X9FxY6d4HIbrRQFn5REOc6WHeAPQYDCvX5y/eDeiVFI+GLG9FGmKJVokqZj2JCKuV2SKz5zXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teTVgDz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teTVgDz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE1C4CEC3;
	Thu, 17 Oct 2024 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729196913;
	bh=tJ4rJNhg/4ydmSmPq8aVI54R0C/xVla61sQugEFmtoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teTVgDz3jXSmApFXLpt30oa+aQ36jXc3V+LL3s8IUn/IQbO94jElZS3gN6TsseiD9
	 rcp3Vfm25JCfP4IutO6KyMKWyR/vFAYZqMeMkISwg6Xcy6UOYrmBWelBhkuiutKnGl
	 jKtfr53hyk/szWOUqnRtnjn5is4C0HvZDtbjmI7Y81TM5HmBEyiB69v52m87a+rEA2
	 F6yV3JgKiUl5bBclwpFvA5fueMcSx5d8MMC2qZ2icdRFb3ZMXLv7Cvnv934NODgzYR
	 WIdmHWsVxCR1mF6F9ppRdQuZU9VoFzIUFco5FS0LMeVSBO/uxsASAjyBXjjo/+AflY
	 zcUlASFf59X1w==
Date: Thu, 17 Oct 2024 13:28:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix perf test case 84 on s390
Message-ID: <ZxFzb7LEu9n9piVG@google.com>
References: <20241015074726.268029-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015074726.268029-1-tmricht@linux.ibm.com>

Hello,

On Tue, Oct 15, 2024 at 09:47:26AM +0200, Thomas Richter wrote:
> Perf test case 84 'perf pipe recording and injection test'
> sometime fails on s390, especially on z/VM virtual machines.
> 
> This is caused by a very short run time of workload
> 
>   # perf test -w noploop
> 
> which runs for 1 second. Occasionally this is not long
> enough and the perf report has no samples for symbol noploop.
> 
> Fix this and enlarge the runtime for the perf work load
> to 3 seconds. This ensures the symbol noploop is always
> present.

Hmm.. but it would slow down the test quite a lot.  Can you please make
it conditional on s390 or something?

Maybe you could add a fallback logic to increase the period if it fails.

Thanks,
Namhyung

> 
> Output before:
>  Inject -b build-ids test
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.277 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.160 MB
> 			 /tmp/perf.data.ELzRdq (4031 samples) ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  Inject -b build-ids test [Success]
> 
>  Inject --buildid-all build-ids test
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.195 MB - ]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.014 MB - ]
>  Inject --buildid-all build-ids test [Failed - cannot find
> 				noploop function in pipe #2]
> 
> Output after:
> Successful execution for over 10 times in a loop.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/tests/shell/pipe_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
> index d4c8005ce9b9..02d9ef27c8e7 100755
> --- a/tools/perf/tests/shell/pipe_test.sh
> +++ b/tools/perf/tests/shell/pipe_test.sh
> @@ -12,7 +12,7 @@ skip_test_missing_symbol ${sym}
>  
>  data=$(mktemp /tmp/perf.data.XXXXXX)
>  data2=$(mktemp /tmp/perf.data2.XXXXXX)
> -prog="perf test -w noploop"
> +prog="perf test -w noploop 3"
>  err=0
>  
>  set -e
> -- 
> 2.47.0
> 
