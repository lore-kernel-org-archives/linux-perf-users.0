Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE618A6A7;
	Tue, 23 Dec 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513870; cv=none; b=GzSUxPvFkuFXBXYkhXY05OuS5/RafFXAzQv+50B61oFBKyvjHva1FMzg/griyCpYEeYYt/Wok/fmEWGDiVOWiW/RLSfFXZtdEL2uIdclKnTbGMHoCJW8DZGuI+KENYtpwSs0ZmrycS1+VfO4vhJRnQG+tWeuRbEy701/jnDpglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513870; c=relaxed/simple;
	bh=MUm97H7mJSYQN5B31+H1xf1fp6sieW8EkBVcfmWx8ns=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mBHsk7VsONYoyUptxdsTmXJ2woMz97oxwl1vNYW2N94eUP9tNsQGqDcDLyi+c4MbjxibYtxxyWDEorS881tspvQLs0BR/s75GLt6T4hG08JYWxkjPRzNvvEf5jTV/voxu+WlJs/aQuUPP2mH8DTC3/xprersVS7ZnD4hjr6Kegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFAvXKWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFAvXKWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A492C19421;
	Tue, 23 Dec 2025 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766513869;
	bh=MUm97H7mJSYQN5B31+H1xf1fp6sieW8EkBVcfmWx8ns=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=KFAvXKWtdoel9lhv3fjgg4zbwRG76a0o7xECsdmVwLxDoyoHc4JL7T2/e+NYghntq
	 K9YpEu5lQajbIo/7x9aY1xpUPGYdKlnCVZAynGRK/VuF9zhoxi3g2axYdPgFFhhOwC
	 MOOr2tCgKWAL7IZYXvEn6lNVfCE32eIkRV/bBIN2uZtQmSNRsuBa8Q8Gg9MKxrNFkA
	 no8CNfm7d8CYiro9Q0FQKO5R4G7wNdiymOnXgzywhq+6dHJswElG9e3M8A7WiH3pDk
	 I58mAOKV67EJOCq9AJZOqVQLSRCF5hSQCC7lw3DJy5MgyKkk+8c8aVfZKM4vj8o9ZI
	 XGocv+BkW9oDw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>, 
 Haibo Xu <haibo1.xu@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251207022345.909535-1-irogers@google.com>
References: <20251207022345.909535-1-irogers@google.com>
Subject: Re: [PATCH v1] perf symbol: Fix ENOENT case for
 filename__read_build_id
Message-Id: <176651386912.34483.44621848769631733.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 10:17:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 06 Dec 2025 18:23:45 -0800, Ian Rogers wrote:
> Some callers of filename__read_build_id assume the error value must be
> -1, fix by making them handle all < 0 values.
> 
> If is_regular_file fails in filename__read_build_id then it could be
> the file is missing (ENOENT) and it would be wrong to return
> -EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
> reported if other errors with stat haven't occurred.
> 
> [...]
Applied to perf-tools, thanks!

Best regards,
Namhyung


