Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DB214A71;
	Thu, 20 Feb 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075975; cv=none; b=ThStOca3MAXuvHZYeYrGEsMjznmcdLP9XV94yDoJAenT6f0Nh+I/FnFjcV880RIW3lH7zcCg7M8IQd5ptUIEMU43MbT3FItp+9gxGaZ9C6bVz4KTcpgLqrYFkb1Tc0e3gwMem7uCocwRpQLgQXiFgzTQYux1Wf9Cj9WrLP1JgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075975; c=relaxed/simple;
	bh=SYWFo6V6sWIo4bQMq6Yrpj6gdNHq1inHo19j38wPS50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jBHDjjr+oy2PrHGMOKTWEd98xveqCVX29Es/FSf/tfXcRH9uL3mnKoYxH+mcmJnyL7jft7NU3CKqsvtN9c/NKoFeHeV5826YxCvj3E7FkyiEfvY0ro//pdxNaB187FApseG8TIQpzYuvDhYgreYkp5cvqeB+u07UA3DZMMx3iWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWZCJ6sN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWZCJ6sN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2503AC4CEE2;
	Thu, 20 Feb 2025 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075974;
	bh=SYWFo6V6sWIo4bQMq6Yrpj6gdNHq1inHo19j38wPS50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lWZCJ6sNR2Xomg91dngCRFZ2QtShlgFQP650nwOXY5CE8+kYljWOswd4jOmYBBHIP
	 7dY7ugoK9Cpd4e/0SxvtAdiUJMMn6nYW6os/l2r9OtowQQrWR1wyd5dLlgy7Q+l/RV
	 6mqye5oq5QuZFQYAfPJzNsxGjWVlhM9CJA3jP2z0aurlhnu2i2+z4If2ca70hq41N/
	 1JGjP3SwEm4PKAVv7Z7JBZr4kkBpLTIYWh8xuYowXjyQTSu5fJ2dhYJNV8z/rFvz84
	 3Q95+MRukRIOj9enUsec7jmH2rgi3dIpLgPxsYGp4G3Eyq2tn2UDcBk/4ridqSWbfZ
	 Su0XcXHLmx5eQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Dmitry Vyukov <dvyukov@google.com>, James Clark <james.clark@linaro.org>
In-Reply-To: <20250211060745.294289-1-namhyung@kernel.org>
References: <20250211060745.294289-1-namhyung@kernel.org>
Subject: Re: [PATCH 1/2] perf report: Switch data file correctly in TUI
Message-Id: <174007597411.1790567.6153686194745932876.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 10:26:14 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Feb 2025 22:07:44 -0800, Namhyung Kim wrote:
> The 's' key is to switch to a new data file and load the data in the
> same window.  The switch_data_file() will show a popup menu to select
> which data file user wants and update the 'input_name' global variable.
> 
> But in the cmd_report(), it didn't update the data.path using the new
> 'input_name' and keep usng the old file.  This is fairly an old bug and
> I assume people don't use this feature much. :)
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


