Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49941FE473;
	Wed,  8 Jan 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358939; cv=none; b=O8A8raNsP43ems9YURIEZhNP8RqEPRnroVfVF0ON6YxsS958btW4zfH8+Ex+pqoHFQtq4oDiPEMqj36Pg+Bb4yAnbZrolJBHlLupD20/vR9rON+7Hu9kEloxpm6Pu5ZMxPzWZW+MnXyJZU6/nUZrd3TzBuIn5EQyIWQEmFNECJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358939; c=relaxed/simple;
	bh=ebdf4lXYyLJgX2oZyqnBtcVzXPyg85SSHuzX5p+lX4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnMI4CMwiAkq5oVrsXFF0x3QSbx4ViJoNH8qqgL0ES/W1tNbhS5fbqbpfJlmVnX15M8W+JSxRQRQ+JX4XQDKW74X9yqKCVArXakI+mfBp0tixq35XJQM74SO79z04V5QIO5Y5fu25ZMGbhaUoJopdkPTM+jd+SVRy/aEYUjpfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXMt+gRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXMt+gRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094B1C4CED3;
	Wed,  8 Jan 2025 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358939;
	bh=ebdf4lXYyLJgX2oZyqnBtcVzXPyg85SSHuzX5p+lX4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXMt+gRdCFw9ce0IoXMLk5/kIzZ+9pYxkP0Li41+MiCzp0BfLpLnj/L4vHRFhq9vr
	 2MpY5OclGf3R8boOpkW0mfYoPWJITIkovSLanA5mgB/7XMvoPswNhrhhMn1ajhz0bp
	 k9YjfUqV6yTW8aCNq9lbT657YCLb8X9v+eC6wylJwjFM4INZ5tYtVVsOb1UgOnlCWv
	 MqJsAraXxgnDu4to/TmGD5ml8jt6lQR/cHT9p6Z2mTPif9deNi27sPN89e28ad4n2s
	 GMFtUlrFLf1knQ3dhib7jZ/ASrsfLXTOuEXQlqEAc2uGz0pCbHs3V++5orSdTmdP1c
	 DIzj/B+LQAtZg==
Date: Wed, 8 Jan 2025 09:55:35 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Jiachen Zhang <me@jcix.top>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf: Fix a wrong help message
Message-ID: <Z368F9OnLGzluA5r@google.com>
References: <20250108163658.1793072-1-me@jcix.top>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108163658.1793072-1-me@jcix.top>

Hello,

On Thu, Jan 09, 2025 at 12:36:57AM +0800, Jiachen Zhang wrote:
> The wrong help message may mislead users. This commit fixes it.
> 
> Fixes: 328ccdace885 ("perf report: Add --no-demangle option")
> Signed-off-by: Jiachen Zhang <me@jcix.top>
> ---
>  tools/perf/builtin-report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 048c91960ba9..a286d156510a 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1422,7 +1422,7 @@ int cmd_report(int argc, const char **argv)
>  	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>  		   "addr2line binary to use for line numbers"),
>  	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
> -		    "Disable symbol demangling"),
> +		    "Enable symbol demangling"),

Maybe this is better: "Enable symbol demangling.  Use --no-demangle to disable."

Thanks,
Namhyung


>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>  		    "Enable kernel symbol demangling"),
>  	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
> -- 
> 2.34.1
> 
