Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24592343D7F;
	Wed, 11 Feb 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828267; cv=none; b=UCYV8w5Or8kqXJ5vpi5eUWqaLU3pt2Hap7WgL909XMujht7ZG8rSw7E8SERWdyOZwvxj2zxV5s6971fZNv16pVnuVdppiJcd9TE/NIUIXBWJP7ybLBZ4cno3Yn9hhBbggASuwgh+ivLZwaJ7Y7fnh5uFg41O33im0wFPeONK0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828267; c=relaxed/simple;
	bh=bcRXHQ09pcx0XHc0dcRK2TjlZk5KXeg8ugI5B63M4LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAywQExNQYnFmWv+NZ/cgjqaSU1m6X2gItyVZJvofx9dtN0PjB0wZ5a2EpkekiB/If8WxRG5E0AVLII/KUrH04tlFPn1+Jt5HoaAvFkkQnsZyOgDOw7CQBg+wAp1TMHQabFfPdhJvys80zB2odnO8X1ZJj3EBizyuZ0rLWDx9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEtdPHv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEtdPHv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FE3C4CEF7;
	Wed, 11 Feb 2026 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770828266;
	bh=bcRXHQ09pcx0XHc0dcRK2TjlZk5KXeg8ugI5B63M4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEtdPHv9RUTxj9fiDHaWiTIz+rxu3dVl5wCY3aHSabyPOMWadCR5Cosc1MTgSA5MP
	 IUEWImh+J6NlZpHS75b9FZQbAzH4ciXkvfVt1X+F/Z2DleNpMvnOOdULiAFKSPVqOO
	 vMlaQbqtzA/Vct5Xk5oziY7KWsqBmkZHz/qCk0ZBgpWefPKxnxzaDGkGui/TZIS6A2
	 nrPcVgGaqXDk60qbiwxV/YKcrINDj62rSfTSOyNpd3w/tkquFjKrrTNcl/2xvVM7o2
	 Felx9fxhC6RbaK6W7QhajVDg/COaj+DjBngui8hxEaORrb7waeob63739Z/aRnMf+i
	 13qQgcoJ2ytog==
Date: Wed, 11 Feb 2026 13:44:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sandipan Das <sandipan.das@amd.com>, Leo Yan <leo.yan@arm.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf script engine testing
Message-ID: <aYyx5i62BAShcOcS@x1>
References: <20260209202208.2027001-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209202208.2027001-1-irogers@google.com>

On Mon, Feb 09, 2026 at 12:22:05PM -0800, Ian Rogers wrote:
> Add tests for generating a script and that the basic APIs work. I'd
> grown concerned that refactoring patches may inadvertently break perf
> script engine support, particularly for perl, and this does something
> to prevent this.

Thanks, tested and applied to perf-tools-next,

- Arnaldo
 
> Ian Rogers (3):
>   perf script: Allow the generated script to be a path
>   perf test script: Add perl script testing support
>   perf test script: Add python script testing support
> 
>  tools/perf/Documentation/perf-script.txt |   6 +-
>  tools/perf/builtin-script.c              |  24 ++++-
>  tools/perf/tests/shell/script_perl.sh    | 102 ++++++++++++++++++++
>  tools/perf/tests/shell/script_python.sh  | 113 +++++++++++++++++++++++
>  4 files changed, 239 insertions(+), 6 deletions(-)
>  create mode 100755 tools/perf/tests/shell/script_perl.sh
>  create mode 100755 tools/perf/tests/shell/script_python.sh
> 
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
