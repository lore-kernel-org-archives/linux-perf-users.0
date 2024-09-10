Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F99189BBA;
	Tue, 10 Sep 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979781; cv=none; b=QMLmZx7MS9WGe8d0dD60eP2zG2EIjlVaMgDXJY8ANwgalzRvDCrTyeDu1OpjJRf5gBUuAgRG1jJtG0V9yWvL1vyOgVnSczc11tVnLC97lw0NgI7wMDMF5rqeOd0BpGkZGYXG5IJPMtIBJHzoIiIXpgmVwfd6UkgRRH+lnGbeBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979781; c=relaxed/simple;
	bh=cn5Vt4PhzbHhk1eYT0hhNWaKEelECJKhDWEuZoTksso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaOiZGGtyQ+x6euf8IpBtNTIpgZzqDOP32uEcfoLzKXR3v4fMQ1CuyJg2fl5HrCkCxxA132JA2Yug+Tu1TpjGrVXnk0SCezRraUlfH64q/8gvopGv9UEs8i1tb7+bYxnjd/PiDt7UTzOJRHMZ4tBHZAqWHrqOpV9Nl8KKWIcmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsWm2kUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsWm2kUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E07C4CEC3;
	Tue, 10 Sep 2024 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979780;
	bh=cn5Vt4PhzbHhk1eYT0hhNWaKEelECJKhDWEuZoTksso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsWm2kUh6t4J/13juA85VpnFx9aFMqQ6SUL+CJMG390TCJ6Sb3pQ0117way9X58Ye
	 b1RviskB1gceY1Wjk8oEXsO1KROr0ZFaS48Pt6iO08jCirYS0wJ0XStqkggImatwWc
	 iy4FxKAAg/S/gNYTCTdqu3IC6a0RoAnRa0CKwVCge8l0a67im7vljTBFE5OUyzordP
	 JwpPYU7x0rHznaj0BvhJaJGOfLgkiQYdXsFi+BalOB1hfYtutmUAxE1zIyHQmTI33E
	 iNs7lNYdCSCqfJIcSKhAI5xoGQpnxbzabboWE4tWf6oRd4/Ab4H3+oXR2Q9i9Zk2bj
	 KQ/jlIps7VCyA==
Date: Tue, 10 Sep 2024 11:49:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf annotate: Treat 'call' instruction as stack
 operation
Message-ID: <ZuBcgRi8ERab0WNG@x1>
References: <20240909214251.3033827-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909214251.3033827-1-namhyung@kernel.org>

On Mon, Sep 09, 2024 at 02:42:50PM -0700, Namhyung Kim wrote:
> I found some portion of mem-store events sampled on CALL instruction
> which has no memory access.  But it actually saves a return address
> into stack.  It should be considered as a stack operation like RET
> instruction.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 4990c70b1794d7a9..1a347a711dcf5c62 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2474,6 +2474,7 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
>  	if (arch__is(arch, "x86")) {
>  		if (!strncmp(dl->ins.name, "push", 4) ||
>  		    !strncmp(dl->ins.name, "pop", 3) ||
> +		    !strncmp(dl->ins.name, "call", 4) ||
>  		    !strncmp(dl->ins.name, "ret", 3))
>  			return true;
>  	}
> -- 
> 2.46.0.598.g6f2099f65c-goog
