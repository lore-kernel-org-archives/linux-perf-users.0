Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195715;
	b=pCMlDbuDZZCE0LZAkt9E0geRoW6VWWB5IOYWESryq322wORP0D1bb4HZ+ByOJw00kUyl
	 nIpfKUSHq4RLkyU2rvTsgTctOaXXNbfVWcjwojO8QcOny0vKbNZ+WM+DmeHcNkhHMWACH
	 7HlcUyOCZsrL0t4kXW3TWNvzQsovTsGI3AWY9qvg5s25hvkc0rKZ8vk30rHEmcamkTrQD
	 M58zHp9giQG0wwUCX2BM0jPXeZJ16/z7M6nmf/bSZWm7NrLRgmLvn3ms/RNAWoudKUJai
	 aNjHOaNl7oYkUGKLF8qgDxlNMosT4kxFyczeDOijDmLGlaDK1SC8g4M2Q4aM/y6rHPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195715;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=MT11De3eJ/mCifLtxaegXdMwhAaPiwFRNSfsdok0nww=;
	b=eMzvYjw6sbVGgEQ9dopMSUf5HNGMnDnCmeR1WOa3c0+WY7FtuSEuCr1MYRylIuD5sPVN
	 MpxQyk9BwRA7mA+AfkJgdPHS6ZrMeYs0JrlQe8IcIPI2oVv47yQht1+gRDKAUXr+booN3
	 YkETvd0RmyXAgR5NV1SQeg5h9PaH09AVyRhj7sbuB6VumRITBxEP+d9MECtaIpw45VI6U
	 Njw9qAYewCusIorOdbRvJMN6gVUmiiyREe8CPOdF/i8p3dF7FMI6K+WFkSbVNSSuUfBhu
	 vMSDpFVJ7sw/ztTDO/oVw5nP2rxst/2v6b3mIe/D9RSd6TG4LFN0SN7XRDO1ig7TPFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eOo8Xv2U;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=czxZPmke;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A2606A320;
	Fri, 20 Nov 2026 17:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC0A2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eOo8Xv2U;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=czxZPmke
Date: Fri, 20 Nov 2026 18:28:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795195712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT11De3eJ/mCifLtxaegXdMwhAaPiwFRNSfsdok0nww=;
	b=eOo8Xv2UtRkvpukG2J5wz1MT96Lx9bfPTc1rCMpIY1HO8tNJOdwi82lM1LwFgRuQBp9XEK
	4bcUsokgQU8v5XnHx8gsjLjAEFihHkvLF6DEwVycRAl2eFzODS+VBjS+YrGwc9DMXuNPzj
	k2EAoDsHVbKddYouSbmFfkmTZxsO96J4V+sVKJLKcMZw/VkoVTAFR8+63iBZ/KszVpsdqo
	dH0qN112AMps+CTLruD4B1WywbHJoQzvYhmL9cwNJ1VeJcbj5vs48fr+Nrxq8GC4MFVuIc
	RVwkWB/0zm1TeU9NgLH77qTQbHPlUiFLhV+CB1M7i+TYpY/+b68jyqnfV4jNlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795195712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MT11De3eJ/mCifLtxaegXdMwhAaPiwFRNSfsdok0nww=;
	b=czxZPmkej65ICo1WwNY60LJTGFGGgli3HvJq4yigbfPE92FfJIzQN8HZ6kkzsrGeo6LYms
	nrLRlAXAqgyK0oAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20261120172831.5XwELZY5@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120162604.GL2669272@noisy.programming.kicks-ass.net>

On 2026-11-20 17:26:04 [+0100], Peter Zijlstra wrote:
> Also, sending signals on software events seems utterly insane. But I
> don't support we can go limit that now :-(

Tengda: Is this an actual valid use case that you have here or did an AI
figured out that this broken?

Sebastian
