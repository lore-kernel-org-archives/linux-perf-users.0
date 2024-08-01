Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1613D279;
	Thu,  1 Aug 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525619; cv=none; b=NdLsinIGOZTu77GiuDF9T0u35hoXdIZybzRrbOQu3GLGRR9SpyHu8R5jP3TgSH5AzDphJC6lxUp4YhKldcMKJC9nArwVTqzH0JoVEShb3IqDKdLCxgLUFR1yPeusa55FiCN05Tsf0Wl5v0/Rul5s9XKESfqnbGmX29vY9bCH59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525619; c=relaxed/simple;
	bh=KTmdwLSd7dG0FEIjDwyIROa5WuqsjKzs6JJZutABvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDJ3u67dkfALKdMO95IDwFmhmb17zQmhb6T97AE2OmKHEIeghMp7yZdVNT4HGrZ6ZiGxawB1PL4k1mJ4Ct7+J2zIkOUQFtZ3GpkjrFQgMJrnYEYDveZTALlUGR9RmJb5B/uLEijOM5eg4JzrWAy7rSQ8le/hMHzl/GGZPeqWvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Fc2OdP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Fc2OdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A75C32786;
	Thu,  1 Aug 2024 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722525619;
	bh=KTmdwLSd7dG0FEIjDwyIROa5WuqsjKzs6JJZutABvb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/Fc2OdPAAOE/HtjfNseosj8qB+goSB4a7trP4gniB5ey4TPseUMMQ8vv4xALywaw
	 FFbSMlvYIvg62/jVPFzR/tJAmnw3FtlEwN8DX4+n8v9lugYc17Yxv+f/gbpEhbi6Mx
	 wNXMpdjBGL276oJPUZzDD2rZXmUyPm9G7GKR5vfTLOiLstYOwd9LpTSO3JbTuldBRZ
	 E/br7tTv9Lo/zeHvGYJr0JnV8YgDhqC1YADGu3c3AvQbcKGOFAKgPmErWsdErPDBc3
	 aHat4ktdRR3RP3VvN7NfLR88/FtrdrMfDWNsZtgI1EebyT8fOznPSMs465HB38JCzu
	 /FWh+qI8+95/A==
Date: Thu, 1 Aug 2024 12:20:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/6] perf mem: Free the allocated sort string
Message-ID: <ZqunsJNSeBSldZBB@x1>
References: <20240731235505.710436-1-namhyung@kernel.org>
 <20240731235505.710436-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731235505.710436-3-namhyung@kernel.org>

On Wed, Jul 31, 2024 at 04:55:01PM -0700, Namhyung Kim wrote:
> The get_sort_order() returns either a new string (from strdup) or NULL
> but it never gets freed.

Applied and added:

Fixes: 2e7f545096f954a9 ("perf mem: Factor out a function to generate sort order")

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 863fcd735dae..93413cfcd585 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -372,6 +372,7 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
>  		rep_argv[i] = argv[j];
>  
>  	ret = cmd_report(i, rep_argv);
> +	free(new_sort_order);
>  	free(rep_argv);
>  	return ret;
>  }
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
