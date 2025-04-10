Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44B20469E;
	Thu, 10 Apr 2025 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269027; cv=none; b=CR6GaESDktoUhbSn4IWxrWmggyO9oxMlq8qBMzAn6Evd3TgsvSKyJbBFdaeBJAqjLDSoX7qiVaTN233e6UnoFYChe73VOAztl7N4NjhIWHNEi/H9T5H78puilZAAVNL5Olw3TCIU65kM0tyFPmTW/RFYz4TTQKH6fTj//fN/f00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269027; c=relaxed/simple;
	bh=cAXlf8+JLNj8vmclw+acYaP3/q1dAkul7j9DW/B7cK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r57HHmvn1li1Qbpduz/UFjzW9AD6GXFXMA+JWG/FmVxJH7alqocfJWH4p8cRbnIAL4BtT2Xijd0iygFOqxx2dIN2VOOMnQytOMJypb5WwYn2cwvRf6FR0higNSjRSHct/wVwXn+fXukTIuc+mOP8uFVhoKZUuPvWQUYHjEAqCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE+EXgki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE+EXgki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEAAC4CEE3;
	Thu, 10 Apr 2025 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744269027;
	bh=cAXlf8+JLNj8vmclw+acYaP3/q1dAkul7j9DW/B7cK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IE+EXgkisnaaFEIDW6sv85RrzxK1LT+SytPFz/mFzO57r6em1gxM99uAX3j/W1+px
	 Xpdp9MIbk9ywiceWS8qr4wYyQvQgW4qp+1Tb4QjPB4fZIKhAiVLHTdTaps1Sjnpn1h
	 lQD0mI/B8rx7mkw32PSVwpQgEmkC3J+UK0X8fs15aMCdmJad4SnIF1K/RtrV2Xglaw
	 uLIAadCeM+uurybv1KoRR9Cc3AG2E1UmKCFG0eH5hdCtNqPO1dwOSTwyMf4xVERyzJ
	 23ZQ30VWaGCl9u5jyPY2wAhB/W7UmJ4GyXehacI/qCyy+pDMMza71R8ccgkkeuZdhl
	 F38XgacP+OAKg==
Date: Thu, 10 Apr 2025 00:10:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Remove the temporary trace record file when
 the test fails
Message-ID: <Z_du4e4X1B8Ib_xN@z2>
References: <20250405014757.3447393-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250405014757.3447393-1-howardchu95@gmail.com>

On Fri, Apr 04, 2025 at 06:47:57PM -0700, Howard Chu wrote:
> Even if there's no nanosleep in the trace record file, it doesn't mean
> the file itself doesn't exist. Remove the temporary file since the test
> frequently fails on my machine and leaves behind many uncleaned
> temporary files.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/trace_record_replay.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
> index 6b4ed863c1ef..555537dc6cfa 100755
> --- a/tools/perf/tests/shell/trace_record_replay.sh
> +++ b/tools/perf/tests/shell/trace_record_replay.sh
> @@ -15,6 +15,7 @@ file=$(mktemp /tmp/temporary_file.XXXXX)
>  perf trace record -o ${file} sleep 1 || exit 1
>  if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
>  	echo "Failed: cannot find *nanosleep syscall"
> +	rm -f ${file}
>  	exit 1
>  fi
>  
> -- 
> 2.45.2
> 
