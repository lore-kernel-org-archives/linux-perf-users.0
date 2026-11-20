Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190508;
	b=47DhbFIolGPwjSKxytohlFATBpZEETc8YNpy2SCmWmIGDPKJ2kexFsPwEgcFfQkUJBie
	 lTpX/0LGkFVwQ0vn4/OiZqxBIf8p+DcuMZy/5GP8v8tMd1KFc6Up6kcmtJ80KNqQ0uyN8
	 r0ZC0xqypYxp9nDr/1G9ccktS4dRZMkZwZ05tpVhy7i2kVT/I+ltM4xlodnoLkWxZwOxS
	 G+Mb1bkp0p5LP48RFT1LOFKMC364ZfyzSrx/mdLTCsRHE1wUTR5P1HrDRDXftuZUrIUq6
	 amzwy2KOLg0aIRhp+pF5idQ8Ry8OBWz3/q3dT+55C5L2Ur5fT5gWJMEvBlFG2uV1TJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190508;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eg0MJ7mfocUUs6nbstPuFRJpCtZofG+Aejtg+Zx0uDk=;
	b=POyRj2MTK7jPxBOT1MryGlmKJwj8tkL6kGrYzk8mtyS2Trr2zXzi8czlytoypOf4nNHK
	 UQP+uWmUKMmbTmty+884SQHs3e/RbQ/NNEXraIXujrBVQBIKAorm+Tk2IKZ34eJ27X3Pm
	 LbIek5pd2kUUoH2jqoCEkrCPV3Ai3dQW/pOXh0WsyGt2hrNmFYxAvcbEFzH1nHEAO/NRH
	 NQjRPW9nqulpUjkYsTEMaDZX5ZflctcxZyYuobn0gzjUAZ6/yqjfY2qIvThGvmFo+rl8e
	 +dURgTt8AIZZhhjmwjMk+D0tzWEnRegZx3IkOTtiyecnHpdbx3llk+VRfjuWckTy6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="T/fXP91P";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9D606A336;
	Fri, 20 Nov 2026 16:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A9D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=T/fXP91P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eg0MJ7mfocUUs6nbstPuFRJpCtZofG+Aejtg+Zx0uDk=; b=T/fXP91PsDEn4tfmo9kJ5y0KZQ
	F+Tkj2oKCk4O38GGXSrw03lOmcbk6j2bV2gS2pCpv1/quX96MQZMa5Rj+CeJpnvSEt5YHPGzKjfMX
	X+MWvnqdaioUuqC24db3J37h7k1Sr6X0WKBW4AZHgeBl4XhPFeUeCF6hGi7XHLTJGGukDCy3j3ba+
	Laomu3NIWS/G4LlNQP1wEiF1oO2J+rgWE/6A/yi2F5Hdgg4eiHizLrZ1NO4Ws+5ZLqztZTQ9oCYYH
	cTeaT6NHbOaoUEwh1ObnvnZTmifxhj8f1YN/0BJCbnXrgPBaFTzKr7t4tJJRMvyvs2Hw+4JHQtNzN
	8+9Ig3rQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUR3V-00000007TtD-0DIK;
	Fri, 20 Nov 2026 16:01:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8CC8F3008D6; Fri, 20 Nov 2026 17:01:40 +0100 (CET)
Date: Fri, 20 Nov 2026 17:01:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
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
In-Reply-To: <20261120154959.zw08JC0V@linutronix.de>

On Fri, Nov 20, 2026 at 04:49:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-20 16:44:57 [+0100], Peter Zijlstra wrote:
> > Some key ingredient is missing here. Is this some software event that is
> > missing recursion checks?
> If you navigate to
> 	https://lore.kernel.org/all/29aa123c-36a2-460f-b76b-a8dfe1eb542f@huaweicloud.com/
> and /PoC then you find what I used for testing.

Right, it had to be a tracepoint :/ Let me go puzzle.
