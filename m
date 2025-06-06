Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91376BA38;
	Fri,  6 Jun 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232325; cv=none; b=L8CRtthlggktV1lj6UzD2PoOaSrlsmhZepoTrqBFwtZ8ftxSP9fl70B4MVG21MTZaRghVAzcbGJVSIwaQO4OsXTY0xeQ7IGQj8XqhPC8ig7VPhf+bz41xvrz8JCI0BJyvfBdxRCGOsxsTIQ9wSgFnP1IPHEj8Rmg4MuS73luE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232325; c=relaxed/simple;
	bh=ZBxaPeLZ+NMirTXxZsy0pLoROXjQTt2mCUR/DYPua+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZtu9h09k43kbISbhh+5FAh0CAw0UIMaryDu01DLhv7ICiQy2mDeYIw+rQUiPHYrfBcdbGVIuScjmKbs9WijnX0EMG2ztHtSK/q4jlvrYxjJcUo4GCOqWoS+pVm1Mzv3MYLa+rib+xF7iY141airsdGMYiXMCbhzXxl4dyq38io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umGnpJES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umGnpJES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F020C4CEEF;
	Fri,  6 Jun 2025 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749232325;
	bh=ZBxaPeLZ+NMirTXxZsy0pLoROXjQTt2mCUR/DYPua+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umGnpJEShuZxT5wROi8zrRiQpPoqHBJQ5MK4M3UI+GTnNVdPJTFWzyiSuCNW7NTlG
	 4DltS2yqxbbXIf1dZ3dAOq4lUxHuShPbH58Hp4SQ440I7W1OXKPV+pKXbemGeQNWY0
	 h8YIrk0fcweGRcXJy49CfIvFCSRV1Y6LEnvUZ2v68bp/VYJT6h+jWNecWhmTnXiAAP
	 HmFY69ZtMoCsWcP8GQvbqrxr0Vk2Fb/27Vlejrg9XG3PKdFS5p4VcDEURet9KhQc75
	 oxmKzEuGNEcsmibLW4Jw/yyZ4WbtMpJGGSSBD7tOjEvTKz/feG1C32q+3/voBXdPXj
	 TQVy5wzOBZ/lw==
Date: Fri, 6 Jun 2025 10:52:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 v6.16] perf test event_uniquifying: Skip test on
 platforms without 'clockticks' events
Message-ID: <aEMqwmCmbyAlb1Y1@google.com>
References: <aEHugAPinlWLuTAS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEHugAPinlWLuTAS@x1>

On Thu, Jun 05, 2025 at 04:22:40PM -0300, Arnaldo Carvalho de Melo wrote:
> I'll add this to perf-tools for v6.16, please check.
 
Plesae see

https://lore.kernel.org/linux-perf-users/20250521224513.1104129-1-ctshao@google.com/

Thanks,
Namhyung

> ---
> 
> This test assumes the 'clockticks' event is generally available, which
> isn't the case, for instance, on AMD systems such as:
> 
>   root@number:~# grep -m1 "model name" /proc/cpuinfo
>   model name	: AMD Ryzen 9 9950X3D 16-Core Processor
>   root@number:~# perf list clockticks
> 
>   List of pre-defined events (to be used in -e or -M):
> 
>   root@number:~#
> 
> So skip this test when 'clockticks' isn't available.
> 
> This should be improved to find other events that are available in
> multiple PMUs so that the intent of the test is achieved in more
> platforms.
> 
> Fixes: cb422594d62066a5 ("perf test: Add stat uniquifying test")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Chun-Tse Shao <ctshao@google.com>
> Cc: Dr. David Alan Gilbert <linux@treblig.org>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Levi Yun <yeoreum.yun@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Weilin Wang <weilin.wang@intel.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/shell/stat+event_uniquifying.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
> index 5ec35c52b7d9651e..20498b6eadb57702 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -49,6 +49,12 @@ test_event_uniquifying() {
>      uniquified_event_array+=("${uniquified_event}")
>    done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
>  
> +  if [ ${#uniquified_event_array[@]} -eq 0 ]; then
> +    echo "'clocktick' event not available on this machine"
> +    err=2
> +    return
> +  fi
> +
>    perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
>    $perf_command
>  
> -- 
> 2.49.0
> 
