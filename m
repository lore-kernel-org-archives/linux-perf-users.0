Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719901F37D4;
	Tue, 25 Mar 2025 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932172; cv=none; b=JZ+KbWT6pR1uc4AJ5x9h79hOUIl6dgixNOKQs3uRNUonv8KYscpEVEmIuF7KqxEgitgXwE/vSSu3gUKMEc6VopcMUjWbYjRGiynvAPaW0GbrbKjdVuO3gE7bd/swJnxkQLUe2j0Mck0VB7b9HcOQ+8XUYjwBD7O5n2Nxx3Pe/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932172; c=relaxed/simple;
	bh=WN/vIZnTAni/Kcv320+OOiwXIbkEBKtVO+kineL3pMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cZhrTydGKth4Ozj+vM9Qr+jSTOMUBHCoeh0JvsxwO57LuNztEgIVa1D4PcbNG/xhjsk2Rrb9ysNy6ZgeK2d1AcAskGx5xMJhjmvQPlf4qJBWz1rl7ELgxSVyJ5PEfquv1EqRH48ib1gz0sf+48yq8SB5yQ4L3LQGjSLyjPLZVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNnitOg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNnitOg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EA4C4CEEE;
	Tue, 25 Mar 2025 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742932172;
	bh=WN/vIZnTAni/Kcv320+OOiwXIbkEBKtVO+kineL3pMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FNnitOg3ypdMqo0HLIK7ioS6vHg5zowNTg8FXYWT9gQ7YDQ805apMkrfyXiszLx/g
	 sm60XlYn+l4AAmXT5ATSE71WueShOQ1fqeV6kh1ytvNxNvs42HiAFNj8p3IQOUmFwn
	 UJj1KqQiDUAGW2z3ux55FOIk5851rD9EO7yQ13ESvWvkcZnXT578siEl4KxtnAsY7B
	 5i7i+rNprzol1zhShI0BF/DBX22rTMaaZl0SsDlxGt/0gYxi436LdU69quq+FtIGEU
	 7xg15K528byLWBBM+oGgNaKZEeGngeQfWwne7fzEk/pKrlPOx4mq2Y8+9YrnvWbvzS
	 u1WXSXxWDLDgg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250311000416.817631-1-namhyung@kernel.org>
References: <20250311000416.817631-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf report: Fix a memory leak for perf_env on AMD
Message-Id: <174293217194.2401011.17122687947274846781.b4-ty@kernel.org>
Date: Tue, 25 Mar 2025 12:49:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Mar 2025 17:04:16 -0700, Namhyung Kim wrote:
> The env.pmu_mapping can be leaked when it reads data from a pipe on AMD.
> For a pipe data, it reads the header data including pmu_mapping from
> PERF_RECORD_HEADER_FEATURE runtime.  But it's already set in:
> 
>   perf_session__new()
>     __perf_session__new()
>       evlist__init_trace_event_sample_raw()
>         evlist__has_amd_ibs()
>           perf_env__nr_pmu_mappings()
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


