Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103D79F6;
	Sat, 16 Nov 2024 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785458; cv=none; b=R+IibcXFV52+tOFI4TxKNDfAyaMJO8d/eYPI/Wr0Tn+beRjDqcU2kvhY/ewq0sDDeyJo1VoCu8B4pDBBWySrxOuMv8ztjm2SmyW/64PJ90EQM/+tATe5zMq3VXEIfDyPE9RiUwuR2ne4GKpOG0c9sBraM6+nnl0cTtmS5gxWvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785458; c=relaxed/simple;
	bh=cg8Gv+oBz3pTJka3tGs3aChfdaq+iHlkq15MrnkGI84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPVqmLDr8yAnjZzF9G5LM/r/QqyNpw6ZCKveakpqzCdruVOB63FQOhCtLsIFZaMW9SqVmiDXP1ezuf3mkt0pIBdR+TdjpFQ8PNlkm+rEVc34RKQIgrvnmbpHGuFiIVEmxa0AjWUM0rUVej30V80Oz7BvF7Rl01WtPoqaRDl8oew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7O9q5C/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7O9q5C/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050A8C4CEC3;
	Sat, 16 Nov 2024 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731785457;
	bh=cg8Gv+oBz3pTJka3tGs3aChfdaq+iHlkq15MrnkGI84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7O9q5C/OXg6uBCh7GYhe8lnwLcMRwVUdmX638Dq3ftLQ/ujchQnIUHnVS5DC82UA
	 07aeiF4iMa7QZ0+ZXunxB5WyOY2mehfZOoz6d155BhQzQqMbajgXDqJrRePzn+9bwC
	 N3hnQcnBW/XghGO4y7oYYAy7+FUs4dHIO0kyDoh5taGQnbp4QYU0fyGz30myzcKHua
	 GEPx6mg/qQ4rJ7uVkQLboR+LJz6ZDFb9gBQShS6eWeekI9atHzRNii4hlaU10w0s/e
	 herOzehGp6PGdahUdwaFXUvvang0Zn2xMvaZP55zBO5XEX0zSeM0WkNhpr8cSRJglC
	 CVb/FHXwtlU6w==
Date: Sat, 16 Nov 2024 16:30:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Benjamin Peterson <benjamin@engflow.com>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] perf test shell trace_exit_race: Use --no-comm to
 avoid cases where COMM isn't resolved
Message-ID: <Zzjy6rIVHtmeTb_c@x1>
References: <20241115153634.314742-1-acme@kernel.org>
 <20241115153634.314742-3-acme@kernel.org>
 <CAH0uvog6oxyuQT4TOhGtbK6n0NhFc-JCDZmrK7JztPd4mE7cYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH0uvog6oxyuQT4TOhGtbK6n0NhFc-JCDZmrK7JztPd4mE7cYA@mail.gmail.com>

On Fri, Nov 15, 2024 at 10:36:45AM -0800, Howard Chu wrote:
> perf $ ./perf test "perf trace exit race" -v
> 
> 110: perf trace exit race                                            : Ok
> 
> Tested-by: Howard Chu <howardchu95@gmail.com>

Thanks, added to the cset.

- Arnaldo
