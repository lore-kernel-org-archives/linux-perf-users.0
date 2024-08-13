Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2F19EEBF;
	Tue, 13 Aug 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560784; cv=none; b=PV+ZbDg6+VVn+lLQGRwhownbdgeCa9qBIgJFugCubaIbl8e9XGZFhaMML2VtQpqO7D4SA8u4I65j2Ey3XQDAcAEhiG7O2UMvi7h/x8V8k71B5lhDZZkkRrBfTmK6RTRpK1GQvJkRYcUYe5+y4jYocltG/7t7veuGmDlhIjsfWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560784; c=relaxed/simple;
	bh=/MRnrBJN+s6hXfQu4eOdfQB6o0pHiA6EE2c+56zuQm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af3Pm9LEwyD27i2NH0zMytQhZqoXjk9bGnI2MjDX1jHqa9UWNYFozqtzFhwyKLrHlg8c0wPN31gUeoCcRIc05wSvO34kCBYxTJv+egNaEV2+n+9g09OWrqAs7vAMl0/oJ+HRdCTFXg7j/GYPhbcWyA7RdKEelIIbJQKnFMMLjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psKxmXfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psKxmXfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B64C4AF09;
	Tue, 13 Aug 2024 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560784;
	bh=/MRnrBJN+s6hXfQu4eOdfQB6o0pHiA6EE2c+56zuQm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psKxmXfkJw4n2Y0RDHfWGFOWGM9b69bT9tCX/bd7fOY8ZzTYwTs05pIWVAdtzjc5e
	 e1b5ilNQrH7TBh0+JfsXKp9+OrMxsATfb0RDvnrocySgLJgHeI5MRuHGmr30KIkjCh
	 Z9W8u11+KlUMZfTbFZI9+uE7AHNXSQtcH2zA4nUClYq1JqdtsdDFgZ/Yo/01ZaWESq
	 0qs1UYO/9ZnvHbd8gytnKwT99v3LTZmnzpDxBfwFuMwZX4KfOOCCK+Du/BhOJ64klk
	 w6APjJ9rtxvTRjPD8ecqktpMEKbVJ+AIWnaze/C/yFrvyoHZ0xMGWIl7BGRGWWXkP1
	 3G0a+SH67bBhA==
Date: Tue, 13 Aug 2024 11:53:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
Message-ID: <ZrtzTTHim_vGX1ma@x1>
References: <20240813040613.882075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813040613.882075-1-irogers@google.com>

On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> lock__parse calls disasm_line__parse passing
> &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> lock__delete.
> 
> Found with lock/leak sanitizer.

Applied both patches to perf-tools-next.

Thanks,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/disasm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 22289003e16d..226d2181f694 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -566,6 +566,7 @@ static void lock__delete(struct ins_operands *ops)
>  		ins_ops__delete(ops->locked.ops);
>  
>  	zfree(&ops->locked.ops);
> +	zfree(&ops->locked.ins.name);
>  	zfree(&ops->target.raw);
>  	zfree(&ops->target.name);
>  }
> -- 
> 2.46.0.76.ge559c4bf1a-goog
