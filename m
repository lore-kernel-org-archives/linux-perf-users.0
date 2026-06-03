Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69022E2EF9;
	Wed,  3 Jun 2026 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497387; cv=none; b=Fl+nhPX1sZaDSBcsLs0Gq6NxYZi/GIheUzTxx0ZsKsEtus+cu4qrbj5PX8BAunvylC+DgndyH3Dq39r/+LETRUUwo3Yobx3GOsbxX0WX4e9+J8ayKOcHXV+oZ6MMq9jxsvs8M9NMd2Fpj7TGI/aQHw36BPjB8kVcPALI310o7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497387; c=relaxed/simple;
	bh=sPSGraBaeCpqJ2GVM9kYYz4LqRqZqZOMNi/h+2mM9b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsf3pXMCu/ObmShVrHqJt99ir2Kd41Y/qUGcF6HVubaki1gTrpo7+s2vqbs56oNi8YoN+nOKWeqcxwUBJG3ekwDwll18KxtEGw5hYBR1Thw7y0/KZTrHS3y/UGDtkSyATAZ8Ny0yJSlNk8SvFRsblM74hlZNRTdVfkSuPldhrcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r09i9xMd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r09i9xMd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C0D532F9;
	Wed,  3 Jun 2026 07:36:20 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8C933F632;
	Wed,  3 Jun 2026 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780497385; bh=sPSGraBaeCpqJ2GVM9kYYz4LqRqZqZOMNi/h+2mM9b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r09i9xMdiczEUol6iK6QtGi10rdlibzEZwa5dD/BIoF//iSkgzew586N/oXicMAdl
	 Y8cyxSBqx6kmXaswQB+aTNwbx+BhoO9Jf/h48kbjG3jW23jiJGeDIQA89R8fG4Ktph
	 DGSjSNrd2CysihK0j8VtIviiKbMR/6WpzOdiL7/c=
Date: Wed, 3 Jun 2026 15:36:22 +0100
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
Subject: Re: [PATCH v2 08/18] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Message-ID: <20260603143622.GX101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:50PM +0100, James Clark wrote:

[...]

> +# Use exit snapshot to record 2M of trace to make about 80MB of raw dump data.
> +echo "Recording..."
> +perf record -e cs_etm/timestamp=0/u -m,2M -Se -o "$tmpdir/data" -- \
> +	perf test -w brstack 20000 > /dev/null 2>&1

...

> +size=$(stat -c%s "$tmpdir/rawdump")
> +if [ $size -gt $((50 * 1024 * 1024)) ]; then
> +	echo "PASS: Raw dump file is larger than 50MB"
> +	cleanup
> +	exit 0
> +fi

I am not sure how we can map 2MiB trace data to 50MiB+ raw dump.  This
is not to verify perf stuffs but just expect how verbose output from
decoder.

Can we simply verify the trace data is ~2MiB with the command:

  perf report -D | grep ". ... CoreSight .* Trace data: size .* bytes"

We might relax the check as the trace size >= 90% * 2MiB

Thanks,
Leo
