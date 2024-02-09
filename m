Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C23611B
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517008; cv=none; b=sI678aqBuXLUU5iN8u2EMpOg6wtqErvecL5Pz60e1K3C3YTkL+qqseg5K8o6Z6IWnLAiBo+9vtcoQ5m9Qtmk5Tf0ZrUlb/NBNy+II6SPglIUYdU+MW+suriZ/bxcs4DUTwvtrKE2629EO7TjJFaYljxKILrLDhNYFO8nHnRDkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517008; c=relaxed/simple;
	bh=dlAbr4xUXhGEdynDOx+YIKbe0q3GVlsdx12RQre/f0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr4KdUVvcd/hXXWWuASt9T7YdnGr096ynSl0/qj9+CiFe5ZNnSqavQ4hvb16Xvvud+k8OqcyGZPSab2hgTf5j8pJoxpSbnFX4whBT1svzRUEZNwJsXveToQ7EYIKgyNnkwqpCpT2vxOp2nqQO6iQ/HEbMkGs3bjS5gk3Gjjznrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyvnMoOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyvnMoOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED17C433C7;
	Fri,  9 Feb 2024 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517008;
	bh=dlAbr4xUXhGEdynDOx+YIKbe0q3GVlsdx12RQre/f0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyvnMoOmiwScFVhneqSX6/sAiYrNMO+QWIARTzXmhHe99EBiQcs8271LwIJuH/xv6
	 2ngOFdVTFy7t0JGYrOC3tJUlCi+AC2FB1zqVtnKgQTA5zLqgWg0YT2aQG2BzXhMgNe
	 59zLDsDlaJL4StIt21GUW8gMa0bNMkqtwKchW+z5ja0q4GZvJdG9ZgZWgQ3gwQG/Lg
	 F3dbjmF9XNqJv1lw6o77DP1g6oI9H/U5XWcQK7UNprWW/jFplY1G3GpkwHkSvlqkLO
	 i09mvJxMtisIGFeNIoFH9jjbHQlmGPP5on9Ok04ic9ftB3knaICsApvEwazO/XayD+
	 WBa3FsHIwxsYg==
From: Namhyung Kim <namhyung@kernel.org>
To: adrian.hunter@intel.com,
	mark.rutland@arm.com,
	irogers@google.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	kan.liang@linux.intel.com,
	acme@kernel.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>,
	peterz@infradead.org
Cc: yangyicong@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH] perf test: Skip metric w/o event name on arm64 in stat STD output linter
Date: Fri,  9 Feb 2024 14:16:46 -0800
Message-ID: <170751693775.1169242.6949790751130648822.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207091222.54096-1-yangyicong@huawei.com>
References: <20240207091222.54096-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 7 Feb 2024 17:12:22 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> stat+std_output.sh test fails on my arm64 machine:
> [root@localhost shell]# ./stat+std_output.sh
> Checking STD output: no args Unknown event name in TopDownL1                 #     0.18 retiring
> [root@localhost shell]# ./stat+std_output.sh
> Checking STD output: no args [Success]
> Checking STD output: system wide [Success]
> Checking STD output: interval [Success]
> Checking STD output: per thread Unknown event name in tmux: server-1114960                                                   #     0.41 frontend_bound
> 
> [...]

Applied perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
