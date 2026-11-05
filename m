Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920738;
	b=QMvXgxQ+DsDVsrVhnunJMMn0k9emRNZOPueIen31nbONdMqLonXkIK5m7A31IFBWloVw
	 XhC/bLiakXo7vBAh+30kNJ9ycYTt0FiPbR9v5fFcPgCrvNqX9gG+Pg+/3+sKZVxieaxiV
	 f3J89RFTzemYzNaiJufSOgraEB9nokPIZlXYpPc3tFhuV7sWkb/o7RyBShyK/KuCOmpsd
	 xGPvneeIuxqJ0DUza1jro2gGDaIrvJOfs6c5ZWy5sKQ8uQzR7tXidmpTRacSOuKX5TMxF
	 hOGrUKPnTS9H+HZVMjmU7JWLNhJf6qPAWOTOVH1SoFdcvQCXx7GF5EG+yFb3BR3AAWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920738;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=mk9jqojNulChiWcD8JJ5p7BFBGVqSZDlleZYxFAx4OQ=;
	b=GtaXW893XzYLUO1WewKPMVUs3urrGNC50YMALFYrly5mnbxvDHQ8fFVNlfX0qyzmuicR
	 yaSFK7XXU1pvUEU4+3FAZYMX1JNCaEi/qzi+T26SfvRXhfVsqYesOnWb7ZvKDe9RJiQS/
	 ykR2/NdhTY84Up3X3dWf6wL7WMVwwLvfE4cEVwbOzhKSIwNijyaYGM0wH5BF7y2BWFriI
	 rhqQm8LUQlZVz62xgyvu8lePUytaNrCvKc2HENGaHUxQkMLlj6EYeWZvnUfkqP45OBHxm
	 LH1BVTrqNWzRDD9PFB9ghJlEumURMIBpgIw/WzAi4PQ/HZKwFJY+OmRyC9W9pA0OTJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrWeTVSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46D606A31B;
	Thu,  5 Nov 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrWeTVSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE9F1F0089F;
	Thu,  5 Nov 2026 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920737;
	bh=mk9jqojNulChiWcD8JJ5p7BFBGVqSZDlleZYxFAx4OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MrWeTVSqZDNF4KVgUyK3Sq63fTIIaVu3H9M1EMVMOjj4+B4JBGXxWAA9Ls+YMBUCt
	 IggvD5XEc7FtKQhcVJ/RnHIND1mv9hlFzJB8mZp2Rr/8P4LdaM0Ush+I86HPxsea7N
	 j+ajGnuGijHG0gw2W5+kW5oyk2VU1BP0/M46zZsmtoU5Ly7+tpyOGy5oaZF3DUAYvO
	 TWPJKv6BjVSuz2YWj4wN6Zso6o0uOUZp4fLZMBjaO/KtTYTsha+1Xgp4/oLng9OhC0
	 GMNh5+ViK5sgzo3dj1CKRTRT3gRBMLmNbYaakJxIMnbsIVUa2HXSmOqNGYFYpdz2wk
	 KhbtxIrh/7sQw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Chun-Tse Shao <ctshao@google.com>
In-Reply-To: <20261002054832.64980-1-namhyung@kernel.org>
References: <20261002054832.64980-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf stat: Fix aggregation of cgroup events
Message-Id: <179392073692.4004918.5084074052430143304.b4-ty@b4>
Date: Thu, 05 Nov 2026 15:18:56 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 01 Oct 2026 22:48:32 -0700, Namhyung Kim wrote:
> I got a report that perf stat with BPF and cgroup is broken with
> aggregation like per-socket or node.  On my machine, running the
> following command shows the problem.
> 
>   $ sudo perf stat -a --bpf-counters --per-socket -e cycles \
>     --for-each-cgroup /user.slice,/system.slice  sleep 1
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


