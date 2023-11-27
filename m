Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3032C84
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3qqa5GY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3117BC433C8;
	Mon, 27 Nov 2023 22:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701122775;
	bh=hT50ThkIvKWMJVrWm5ccSiYE90oywa4kHmvXT/ms/N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3qqa5GY3lSoS0P3DeGmJvvogkW10LRRbZt+Pli9oQHWDti5bqKe8S9eYPQXCribx
	 I1gE25n/Q6Gh7dmSbIjfn2U0ID9mZIsBXj051FsBebrvTHEDDYymA0Cf2Fqzh83xp7
	 2BNEW0BtttYDbolnD9F3kEj9kWYp2nbEUVt65tz2iwDn+wgbEarwKRiYOc1cpO46N9
	 ZE/JxRT1zio6t1CkrO/9KvPjSPJYZFx5NMusCeYG+KiZrCwMCYgQyUwcg4xbVMwfXZ
	 O/3I9BAibMe6xUub7hnWsywvMO1ps0HM+ARzk5maBynKTFU9OHi/MhTixt8Ty2dxUr
	 agAYtI9sY5WsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0984940094; Mon, 27 Nov 2023 19:06:12 -0300 (-03)
Date: Mon, 27 Nov 2023 19:06:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add --debug-file option to redirect debug
 output
Message-ID: <ZWUS1M0HM7WZXwML@kernel.org>
References: <20231031105523.1472558-1-yangjihong1@huawei.com>
 <ZUEhJrXUWHyv959i@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUEhJrXUWHyv959i@kernel.org>
X-Url: http://acmel.wordpress.com

Em Tue, Oct 31, 2023 at 12:45:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 31, 2023 at 10:55:23AM +0000, Yang Jihong escreveu:
> > Currently, debug messages is output to stderr, add --debug-file option to
> > support redirection to a specified file.
>  
> >   # perf --debug-file /tmp/perf.log record -v true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.013 MB perf.data (26 samples) ]
> >   # cat /tmp/perf.log
> >   DEBUGINFOD_URLS=
> >   Using CPUID GenuineIntel-6-3E-4
> 
> Ok, reusing debug_set_file() that was introduced to be used in the
> 'perf daemon' subcommand.
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks, applied to perf-tools-next.

- Arnaldo

