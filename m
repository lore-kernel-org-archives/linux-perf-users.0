Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B0345724;
	Tue, 16 Sep 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032304; cv=none; b=cjWLhjRszqghRcW9xe0d3CIvwWzYRCcUdW01ehfzUupQsAkDzGJ3zlBUsSZPwq2pjxueBrxtQl7hR1YbA5CkFAlth9+wYJ1UJqIm7tMXp+5IAYW9zfHritnfIfEBWO4Bm7Ky1fLN6PZ7e4t05894uouvap0KV5YLvLltB7+mEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032304; c=relaxed/simple;
	bh=eqK4d+G2NOIhzzGaMqoXVh5YuTyL3wC3hknNUwYzKeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boNQcD266IZXC+VUwFC9uGSSeYV70piKe1pdDRhuawr3uB52Adlr+tzmZXNswInN9uv3O989Qu6X5huAYKL590ACujcVDeYxq8yLaltHhp//XBwfNH8W7ZAAep/D21GMChwVjzikkNxZalin4tpGc4BHXmuYd0EZYKTWaFQ9e08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oZuIufPN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZuIufPN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YdFZdtYONbOUHd6TcI51QatiXFVH3+hJsrSaEoyT4Xg=; b=oZuIufPNTQ+oVJYCz5z2VFFymi
	3XQ43Zgx6TPjrSkrKaYzIRhkq3IGXfmVaA9tPB75z9st5ZQrF4cD0vfWCsATrjsIcEApaICpWJ1u4
	CqiKmr8hJSUNzIAt+Py98QJ43bKCN78A5vgQVvF1lLNVYzLFTls0kE8W4w/trcJxkIfv8FSl7OFGt
	iIw3Wl4vrmAlKgPQ5x6a/TI0A4t9myJtnK1EOcye8PVDEInXFaFSHrCvPZohOkbK8BtC2brR6IR/+
	pqN1sAveL2L7jtkXo7efs9bop5MEapfuy3H1NxoS4nXZ1CBMPFahG/iQYOeQr3KyYGXAn6vN1h1aW
	1j70sJmg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWVY-00000007DPQ-1YUw;
	Tue, 16 Sep 2025 14:18:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0EFA300328; Tue, 16 Sep 2025 16:18:11 +0200 (CEST)
Date: Tue, 16 Sep 2025 16:18:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Yuzhuo Jing <yuzhuo@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/7] perf bench: Add qspinlock benchmark
Message-ID: <20250916141811.GK3245006@noisy.programming.kicks-ass.net>
References: <20250729022640.3134066-1-yuzhuo@google.com>
 <aJDDfCKFXFQOJ134@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJDDfCKFXFQOJ134@J2N7QTR9R3>

On Mon, Aug 04, 2025 at 03:28:12PM +0100, Mark Rutland wrote:
> On Mon, Jul 28, 2025 at 07:26:33PM -0700, Yuzhuo Jing wrote:
> > As an effort to improve the perf bench subcommand, this patch series
> > adds benchmark for the kernel's queued spinlock implementation.
> > 
> > This series imports necessary kernel definitions such as atomics,
> > introduces userspace per-cpu adapter, and imports the qspinlock
> > implementation from the kernel tree to tools tree, with minimum
> > adaptions.
> 
> Who is this intended to be useful for, and when would they use this?
> 
> This doesn't serve as a benchmark of the host kernel, since it tests
> whatever stale copy of the qspinlock code was built into the perf
> binary.
> 
> I can understand that being able to test the code in userspace may be
> helpful when making some changes, but why does this need to be built
> into the perf tool?

Right, I think most of us already have a userspace version of it. I have
a thingy that has TAS, TICKET and QSPINLOCK wrapped in a perf self
monitor that I can run on various x86_64 to see how it behaves.

IIRC it also has a pile of 'raw' atomic ops to see the contention
behaviour. This shows that eg. XADD is *waay* nicer than a CMPXCHG loop
when heavily contended.

Anyway, that lives as a random tar file on a random machine in my house,
I'm not sure it makes much sense to stick that in perf as such. Rather
specific.
