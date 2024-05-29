Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90718167DA0;
	Wed, 29 May 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717010793; cv=none; b=BSOa0BCXokS7vrmczlfCuVnXxXeGj3SP6NSGWDTsp9yIVOrIWLb6HRjQ+VSl/HL4BmiibD2eBaIHx7KbZn34k1x8BPHQWWIYJl5+GeeNNe7/gOacY2WkrItHgsMNAzl9z0viUCS9B46j21aP47azQ3vTiWXFmBYrmAP7rMaMe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717010793; c=relaxed/simple;
	bh=LFUo1Fd3nkjarPzHQxVz2glEBQwUhVaszzWhF/EkvqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAwdZpIbR+EejwELqtJOo9WdC6XFNaRLWRFjBM1zGt1pbRHzXI9aoYcDxIJmh8Iqo6Un12yVZdcqnKFSWp3+40zZsvTXQkkS+twq6hmnWZJCCja6QJ06Sb198Q+xcmmJ08zO9WEYMnvivGEyaS9DvmqDlE+MmqvZ+WXXRU1fOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCdZLaxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCdZLaxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA5AC113CC;
	Wed, 29 May 2024 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717010793;
	bh=LFUo1Fd3nkjarPzHQxVz2glEBQwUhVaszzWhF/EkvqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCdZLaxJ5V1ahwuABCff6jyKZdgPfSL3oK91f7xRuEVchsQ3ytSs51L6v3zyxgukl
	 Dljt+pVODfp1qT/7qpNWNdcrus6KXwm700BYl3sv7ExNh2g17tW4mTbyoIN38nHykL
	 JYGxzpQE2IUEqF0GVz49iNotYex0FiuCHQZmZRBcEBMwBWb9+DCGCXvFR0qbHketK6
	 21omOdWK7ZfW3jeKrNjoyn6B8yPyq+ckNwbtMBErE7fKfJBXxcY62mn+RNNSNGNxzd
	 Ir1+jQhaczH3afNCK9rfwf6wLOFTukSn4KXl+HMMwJY6jwN36ScGyo11/ydbYZRNYz
	 /3FLDb8OTIiQA==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	irogers@google.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>
Cc: "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v4] perf list: Fix the --no-desc option
Date: Wed, 29 May 2024 12:26:02 -0700
Message-ID: <171701062468.353211.6199983200651676453.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240517141427.1905691-1-leitao@debian.org>
References: <20240517141427.1905691-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 May 2024 07:14:26 -0700, Breno Leitao wrote:
> Currently, the --no-desc option in perf list isn't functioning as
> intended.
> 
> This issue arises from the overwriting of struct option->desc with the
> opposite value of struct option->long_desc. Consequently, whatever
> parse_options() returns at struct option->desc gets overridden later,
> rendering the --desc or --no-desc arguments ineffective.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
