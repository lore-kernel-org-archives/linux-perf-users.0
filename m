Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AF18BBBB;
	Mon, 12 May 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067889; cv=none; b=NJqQd7TKDCc1a0lDTrgGDsExIOq5YJ5mFPnmQ2hoDLn04whyeaPJ2crBrvZ4RrjHT50+FSybst9vQwOXbKK+7caCMx6WeUgp5wiA74ge8REAurwZf7WevXx0jOJrFaqVbuBqjnmqRgX+6Lmb6i88RlRoeCwtIk2mbhqfwJmik58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067889; c=relaxed/simple;
	bh=RnMPIEuptinKtXBm6r83Xwd6jpAeUbGRgUV7y4MJ4tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyBklMqSiBUl7Du4nh0aP/96olS0tDoxVK7gaEM/7hj1d9VOmN6+x3FJkA9UQxnJEp8VFYq1dKBqgjbYcmuINwTGlXBtHfkeOd29zBxKsLU/5wS9yFTrjE/eGjtlMlMKbRJSUOyyMp2RipBPhabnECdQ28IFDvxcXzwXN73eON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbOL8Np1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbOL8Np1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48644C4CEE7;
	Mon, 12 May 2025 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747067888;
	bh=RnMPIEuptinKtXBm6r83Xwd6jpAeUbGRgUV7y4MJ4tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbOL8Np1eKv6TORiATvfcYBeJd6J1sv6olX1TfpN/ja3eza+q3NOHNKkIbEWrSdRw
	 jTnDIPRhGW4ABaNW1+Nsj9h+HqWEPuUVNPySieYz38yBn5PRIKE3ZETJObEM0X6BS3
	 sgtvokoHisfM67yrZGo7PrvwgiSiHsEBZYvDXLXaGsQrOvCW3KlPC48+We0aKhXtQc
	 qdR6g/rCg9WGyOVPZSrNbkYfKg/AgC0GYCizArkF6LNVuW0rTqIwzsKHtBoUxWvPPZ
	 2504BkZ9SCgGC7Oqr9RK2bibkSNkeRC0CAb7JZNvJTm9ipN2nAsbHWOVRsaWdPGCOt
	 Gp8bE6OHBYvoQ==
Date: Mon, 12 May 2025 13:38:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf intel-pt: Do not default to recording all
 switch events
Message-ID: <aCIj7fggPPbu2xgV@x1>
References: <20250512093932.79854-1-adrian.hunter@intel.com>
 <20250512093932.79854-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512093932.79854-3-adrian.hunter@intel.com>

On Mon, May 12, 2025 at 12:39:31PM +0300, Adrian Hunter wrote:
> On systems with many CPUs, recording extra context switch events can be
> excessive and unnecessary. Add perf config intel-pt.all-switch-events=false
> to control the behaviour.
> 
> Example:
> 
>  # perf config intel-pt.all-switch-events=false
>  # perf record -eintel_pt//u uname
>  Linux
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.082 MB perf.data ]
>  # perf script -D | grep PERF_RECORD_SWITCH | awk '{print $5}' | uniq -c
>        5 PERF_RECORD_SWITCH
>  # perf config intel-pt.all-switch-events=true
>  # perf record -eintel_pt//u uname
>  Linux
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.102 MB perf.data ]
>  # perf script -D | grep PERF_RECORD_SWITCH | awk '{print $5}' | uniq -c
>      180 PERF_RECORD_SWITCH_CPU_WIDE

Thanks, tested and applied the series.

BTW, I used 'perf report --stats' that shows the number of PERF_RECORD_
events:

Committer testing:

While doing a make -j28 allmodconfig:

  root@five:~# grep "model name" -m1 /proc/cpuinfo
  model name    : Intel(R) Core(TM) i7-14700K
  root@five:~#
  root@five:~# perf config intel-pt.all-switch-events=false
  root@five:~# perf record -e intel_pt//u uname
  Linux
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data ]
  root@five:~# perf report --stats | grep SWITCH_CPU_WIDE
  root@five:~# 
  root@five:~# perf config intel-pt.all-switch-events=true
  root@five:~# perf record -e intel_pt//u uname
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.047 MB perf.data ]
  root@five:~# perf report --stats | grep SWITCH_CPU_WIDE
       SWITCH_CPU_WIDE events:        542  (96.4%)
  root@five:~#

- Arnaldo
