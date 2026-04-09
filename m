Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A643AE1A2;
	Thu,  9 Apr 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753179; cv=none; b=Ue8iXb6wocrkdIWjOmSkjdUyBIOm4Q9WvrZ03K52VrRH3lawhKsz5ACQ1TzpsBdd833e9zATyBWPIvsjN3Yyh/0e2K7NtYl5DOP3X9RhLuqkrcBJndQbz5NceWbZfWz6roynqOzLm/9bx8YNuKUxwAcvf8JQNGdEt4GsjgZxK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753179; c=relaxed/simple;
	bh=tKQVxgdXF2RFuY/fVHca3yrRuAloPmHBZuIHBqeJwFA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h+GS1AKNf73X7IPC+dpQ2domw37B8vt0V5lZVvL5oLed8QYDQjoFk4l0EuiacqPBkHInv3r/Za70S9OQwQflVRgWf67N7ojttuZ7oQ0GzAFInbSsLa2LZsTk2DBC/oPElxP3/ZVrrrCjcvNSXNLLtLhloXPnPnQdC87E9Wz5if4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXdaVkEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXdaVkEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A32C2BCAF;
	Thu,  9 Apr 2026 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753178;
	bh=tKQVxgdXF2RFuY/fVHca3yrRuAloPmHBZuIHBqeJwFA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=tXdaVkEFV51LZQ+n4aanCm+EqWfRVqY2rEDdCOHdacWormQ1JGbrWs+Nrak7lm8nN
	 O4PCFbW8nBTM+91pcTNMqdqqXosGNlPqbdknTukWbP223mk2IWBj+w6qTEAhoB8cHZ
	 3+27t8KpBDRF3cCH34NtuPdRYLy4Y5P8o7DABpMDOOSAEGuZ1bP5Yo5s8P6qHTxoMY
	 +2WsY2BmRUFROUKEoEJazYAmRX76WAzzk/KDSK3bmPgocmPVpe2aBtdyQfYTkY7a94
	 yqCsaBUJqlpbF2dVTc5J4UF36FecJ5PfYvhUrgXEEaZywUEve28hwcCoKBv0tn/WnE
	 E1QzrhstVzHyQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20260408203858.100855-1-irogers@google.com>
References: <20260408001416.101493-1-irogers@google.com>
 <20260408203858.100855-1-irogers@google.com>
Subject: Re: [PATCH v5] perf data: Clean up use_stdio and structures
Message-Id: <177575317842.128404.2482986120241211182.b4-ty@kernel.org>
Date: Thu, 09 Apr 2026 09:46:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Apr 2026 13:38:58 -0700, Ian Rogers wrote:
> use_stdio was associated with struct perf_data and not perf_data_file
> meaning there was implicit use of fd rather than fptr that may not be
> safe. For example, in perf_data_file__write. Reorganize perf_data_file
> to better abstract use_stdio, add kernel-doc and more consistently use
> perf_data__ accessors so that use_stdio is better respected.
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


