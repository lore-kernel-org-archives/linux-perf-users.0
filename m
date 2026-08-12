Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC12F8E91;
	Wed, 12 Aug 2026 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529606; cv=none; b=Nr93ijCe3p0AHURplu3z0ouYXMJHEIm8YbbRY/HWpxOfqU2s4zN3ZQyWEBYjjuH0kvKbTbkFdTnuLB/fNYUooTEaPLeiOcLa4lcTz8nEuF6sqtccxTGchWHMMeSToE+oVsf9HQxf+zk1BN1RCig1LLnelr4jxjjaDdTQB97WZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529606; c=relaxed/simple;
	bh=WNaITKw0dAOSRetq7dMc0+dL6CK0M5DqAsiehfEV+Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTISSQcAy//3+E33+EAUGGtoSrRNtKptJd/0kTrbdeT3cNCTh9n1YqdjxeWn97LX8nyDjWl+CktmeWiQVmzd3cPcXnw1D7dBV07nPmhCFGiM3FL1/61TkMoEElxqeKiJouFk6a9aomrGmjosChKoaHZfPuGGJ+7eK6lKqzlQJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ONtjrOni; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ONtjrOni"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WNaITKw0dAOSRetq7dMc0+dL6CK0M5DqAsiehfEV+Ho=; b=ONtjrOni/HxPFm3XmnK7sK81Lp
	wCdSfXLLY9IfG4Ms8XkTK22wjEyYCxcVLUB5nLPDyFIdwao97E37pW9a4V4OxXp8r7b2x9gEK/+hb
	Nq4NnnUhWpqUbnGhz22E9tj8IILMwni+XiDYMtbNBUOm0IeCSSL/XrUOI2Q3ET90rSxrZxbKOaBnR
	sY2o7lGECjH6B5p7qaWOXVyG62heIB5UnZJVWA4D237OapfmQa19r3AVikLlazQaAY3l1amm+g8te
	MlRWVsRsjgBC05T0R4JQrLj3UjEgWd7KuJ24ajRUXPHHYtxWPPpJmvbwPudGZOrtfCJfQIa685q1y
	uvqDN4Zw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wu5x9-0000000FI9S-0bhN;
	Wed, 12 Aug 2026 10:12:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7FE413012AB; Wed, 12 Aug 2026 12:12:53 +0200 (CEST)
Date: Wed, 12 Aug 2026 12:12:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
	emil@etsalapatis.com, kpsingh@kernel.org, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, me@kylehuey.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Subject: Re: [PATCH] perf/bpf: Fix data race in __perf_event_overflow
Message-ID: <20260812101253.GD776954@noisy.programming.kicks-ass.net>
References: <20260811235331.10044-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811235331.10044-1-kartikey406@gmail.com>

On Wed, Aug 12, 2026 at 05:23:31AM +0530, Deepanshu Kartikey wrote:
> perf_event_detach_bpf_prog() writes event->prog = NULL
> under bpf_event_mutex, while __perf_event_overflow() reads
> event->prog concurrently without any lock protection. This
> causes a data race detected by KCSAN.

IIRC perf_event_free_pbf_prog() was supposed to be called after the
event is shut down, so there is no possible concurrency.
