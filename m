Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218289460;
	Thu,  8 Aug 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148901; cv=none; b=cwrVXaGEoErF6pvA+fwXA9GZJcrFdPnSgueh1Nwk2EVIj7MwSJhQ5z7o6+yTdGVKmiNQagDzBpJiRsUI3JsaUPE//QLBarO88D/9psQx6NjaB9ocxR0hr9Ib8HL/bqccD/8FR6w6Oj7nogdSLk0P8ccIuP9JG5l2vcMBLr2KY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148901; c=relaxed/simple;
	bh=xtTZEW5I7TuOaEuBLUqLGoRetoaj4yFeUqX8YLjj92s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjZZoGjr4PS2N7sAxbgEYWrUss6IY8kM2wxMX+MY79wa9GFdFzfWp7RwkDVmG8n+nCAi9FVnS3WsS3Mnk717pSQiHKgQ/wVeP15vwUPjg8VICOcAiZ0NMzq2+zyjGbwX6QgCVM39KW5+DcKWtCfz7hHR5WXz6IDZzvzmZHTfPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFoN/6dH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFoN/6dH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFDEC32782;
	Thu,  8 Aug 2024 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723148900;
	bh=xtTZEW5I7TuOaEuBLUqLGoRetoaj4yFeUqX8YLjj92s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFoN/6dHn0EtxQROrl5L9fEYumgNQd8ld6rUM/TVOem9rF1bbKMAAoNonKSJAsFrs
	 h78EfmYvq0zPtluYJ4+Ab2D8VeUnvC12sHyjbfNJ5TKrBzV6MYaTPR8xxof+HOw/nO
	 C8H9Kj3/uSeLWnS7X9FcP/L4jHr6WmB/Uty2ruC0Dy7Bv592ESgc+R8MUNyLUD6aho
	 hsiiBktdiuab1gaFgdTBnYYg+xQNicOw2Rd/B3q/rheBH6dkr9J+jvFVNyEKuD+2bm
	 7ZAkptiO2a+M/duvdhUAllB0oRklxudDHMQ7BoJuq/Qn8rrtSIv9068e5NsILa0wnS
	 OcS0fwGrk2RhA==
Date: Thu, 8 Aug 2024 17:28:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
Message-ID: <ZrUqYbwbiURGDVJB@x1>
References: <20240808054644.1286065-1-irogers@google.com>
 <20240808054644.1286065-2-irogers@google.com>
 <ZrTXftup0H46R8WK@x1>
 <CAP-5=fUq+yNNyg4Xn6aOoEBiXwJfO6CNCz8JhaA2jAxQg+MKKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUq+yNNyg4Xn6aOoEBiXwJfO6CNCz8JhaA2jAxQg+MKKQ@mail.gmail.com>

On Thu, Aug 08, 2024 at 09:00:49AM -0700, Ian Rogers wrote:
> On Thu, Aug 8, 2024 at 7:34 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> [snip]
> > -if [ ! -f /sys/devices/cpu/caps/branches ]
> > +if [ ! -f /sys/devices/cpu/caps/branches -a ! -f /sys/devices/cpu_core/caps/branches ]
> 
> Adding this lgtm, thanks for testing.

Changed to the one below to address a ShellCheck warning/suggestion.

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index ead87b731898d70b..32314641217e6db9 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -4,7 +4,7 @@
 
 set -e
 
-if [ ! -f /sys/devices/cpu/caps/branches -a ! -f /sys/devices/cpu_core/caps/branches ]
+if [ ! -f /sys/devices/cpu/caps/branches ] && [ ! -f /sys/devices/cpu_core/caps/branches ]
 then
   echo "Skip: only x86 CPUs support LBR"
   exit 2
