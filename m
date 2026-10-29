Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265110;
	b=HyI9oMmY1hsYHhqjpuuO0iodfAGikLxdq9AmSEAD8rRT4kpNuQOaAOvfxJxc2yvK1dlI
	 VFSYR0ggDMucp8Wp0RG53XCMwq/2ho+ZSrAx2CBnJTJo4p3+b4AQCKolRZx/Mpck75ZRr
	 +6zpqfHUVaovxboaG85RONafdXKI/SdL92ry8YIPnqVu1TunAt/Mo6Y6zrxqZvevvNMji
	 lw3ffFzWR2DbLWQuXuID13OM8OHW0AOnJhM6/ULuTTj5YvAtBJq+5AOd+HqQHXG/KhNnH
	 D+18r5pNmoNogGUcIU4hy2tldcCWnQfgIWNiSk88tZpfVhC03SVpV3bcYV3UQTPVW6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265110;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nVGF9duES+9fB49cpyOWp9tosy1i7wv8q/sahpSrBB8=;
	b=1pCeWRBOfzRsP6bEksw3tuvWY/LFmDmdT9UZecd9g8soUi01mWvzKvG5jKPHUexDQu3z
	 HpZQ3EFE9y9OpAOpxaLE5SAhikSR7dxx1zZgDWZY4BoNVQmtzGNvWdwiRSfICoGXRUqvr
	 MndfxzujGmW3rS7yyxpcXeHRalc23g8MTGzZHyin2Cux3joKdZ60XDNLQ3hB1j2iphXrN
	 ZFZQaXFEZQYVNtKeuKImR6uJQ4p8A8uHdcglyN1IQy20n11LDE7DjajNZsL4VY2V7BN+e
	 xtCfOPR1+WJaD8iRRqBzoyUFXWUg++XcNWakO0itB9AROpxviKbn9Fh64U041eJ3xJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=JFodSFw1;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730A606A31C;
	Thu, 29 Oct 2026 09:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4730A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=JFodSFw1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nVGF9duES+9fB49cpyOWp9tosy1i7wv8q/sahpSrBB8=; b=JFodSFw1zO5piOH0gPmQOJri9N
	M1O5oLsp5FB9kZezITLco0/xVVPqjjyx/4cG4048S+TaqGu6daKORv3xlduL81TFbV+mxvM8ziwbl
	FGcWHWBPIsssGzq6BLlEfxHqnhqbUO4b2tkZ/4IZwjp3QuDNSCQykq6WZTzuSYDIRD+BeCEnycs7k
	n3IM2K9bRxXO0M5CjYaAiCFFsfX6gwapQlt84OEcutSZAoyZBNh0wRnnYvaCicUjZo34mUx6q/dWT
	l2Cm00h2Al45gll7Gktdaa0xUnGEY+5BgGWOAEm6zji3SEISHxCm9XuLtqkOQY79BfgXYsd24EGQ/
	ZLSI1XiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMMAg-0000000GoJ4-2tyA;
	Thu, 29 Oct 2026 09:11:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25CBC300329; Thu, 29 Oct 2026 10:11:41 +0100 (CET)
Date: Thu, 29 Oct 2026 10:11:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/5] alpha/perf: add ProfileMe sampling
Message-ID: <20261029091141.GG1779021@noisy.programming.kicks-ass.net>
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>

On Wed, Oct 28, 2026 at 02:09:29PM -0400, Matt Turner wrote:
> The 21264 from EV67 on, and the 21364, have a second performance counter
> mode, ProfileMe, alongside the Aggregate mode that the driver uses today.
> An Aggregate mode sample reports the PC where the overflow interrupt was
> taken. On an EV7 that is anywhere from 15 instructions before to 12
> after the one that overflowed the counter, which makes perf annotate
> output close to useless. In ProfileMe mode the CPU picks one fetched
> instruction, follows it down the pipeline, and reports its PC along with
> what happened to it: whether it retired, whether it trapped and why,
> whether it was a mispredicted branch, stalled before map, or was killed
> on a wrong path, and what PCTR1 counted while it was in flight.

Isn't this the thing that ended up as AMD's IBS?
