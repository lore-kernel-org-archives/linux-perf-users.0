Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832142DF6EA;
	Fri, 17 Jul 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310397; cv=none; b=h4SSad0ItPdGhsYV8DG/pQn67S+hPg4SYgkhK3PymIUSagKPBMjVcy/akOOrlgLIJIb4QSXZqlNP4EkMspYrS5dUJpfvcakFgjeDWOl8/pJ1l3NylU8/2Wo2yTeJaVKUl+G28FjaJfbbQKkqpa7i7GVLv1l7109WohQWytD8uzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310397; c=relaxed/simple;
	bh=uyLHfCpBfdQ0pWb2s9sC4brFdQq+hy2HhajhDDgD6Ng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ic5NFTjUq3crTugG4JLU9XSc8OrnHORqD7oJCwxlcF+s2DyLTRjVqE1vy5n3c6GudCLgMXi+HUVEwis0d/CqFe7W0eNWgVZBH9DhBRGTB8GD1UD5NfaOkHc4sE0BwXS4+ZBvVHnQtGFLp9IGlhvrGQ05ZccARhaF8qINfagqT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmKLARf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmKLARf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9991F000E9;
	Fri, 17 Jul 2026 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310396;
	bh=wOb/I7XieCpghaMgzH3BFHZw/1NcOXxlMoh0ZElAiCQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QmKLARf43f3EHDCuVJ7IAFxqUx0195rIzLWVUPOCM/SxAxSlFQKbfkv6clPOVAh1X
	 GZeTSsxsq8AHqljpoY3iJnz178Ij/G3cxCMxvLXhK0IrkfxWsjKIkz3x4tmPHQ4gUT
	 TdjBvs4Ar2k9D+RYGDbKtIKAeDt3DLYWHchnE7QgEj/EpEVEQCODTap6Zwa/kvN8C1
	 gnw9C4v6xWhbBBjxOE+9vkoeycHI6E5OnHwmYFcPhoaJ0IQKVg2/z8I9fsLQJnM+nX
	 crdj4N+dpGoogocHNxvDHRXqIgmuKlw0PEbCYFHDLvfWj9ZlHLQo0dnYHkDa0TubOF
	 hDwAqTwIB7aIA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260711000419.1949161-1-namhyung@kernel.org>
References: <20260711000419.1949161-1-namhyung@kernel.org>
Subject: Re: [PATCH v3 1/4] perf stat: Fix duplicate output with
 --for-each-cgroup
Message-Id: <178431039584.131573.14862617725213302410.b4-ty@kernel.org>
Date: Fri, 17 Jul 2026 10:46:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Jul 2026 17:04:16 -0700, Namhyung Kim wrote:
> Currently it produces following output with duplicate events when
>  --for-each-cgroup option is used.  It seems perf stat adds them when
> it handles default events but didn't copy some fields in evsel__clone().
> 
>   $ sudo perf stat -a --for-each-cgroup / true
> 
>    Performance counter stats for 'system wide':
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


