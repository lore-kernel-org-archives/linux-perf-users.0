Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189803;
	b=gaPx+f5uEnhv1zogSHcPNLjb/MvAeClzime/g8acM6wVvudmigLJ8L/PPKOdiMDTOvS7
	 sjZI8wmdRGY+e0gHa36eQJU9eu8or+9yBH3U2yohmmZbA0h9SDJLHOYSEjNCfAkV+iwF5
	 Q/hZ+hWSRV21DSSmVGV3IJcUl783EjQGyv2w7xZZDDEFSgO/WvjPvkM07NnSGTSvBNRck
	 wP8ohiwTd6EcPVPRuZ3PDMV6O1BsF32bCETqDdJQFv/sH7h9g4BVjbZr0VFwsM/8E23cN
	 vi9VSfV0e2jmErexaeA7iC2cU4BU/jBxIOsAWOcYUU7ZlRXsMHTC/t3AmYHQU41v0jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189803;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yExTCY6nHkC6ZYDgvaCfKm5pebEaEPCvwgabu3jSyPM=;
	b=o0dCNTAbghZyGHMvvtaJRg9HGnDeMaOhu1s0qKzYhaUTtBaE/VESb0S40QIfcNrqiCg6
	 wJH90iC5uaDe3PaitYHFeLE1RbtFWmnBy/+D3v2jbQw/eHZ6dx9P98PW4Iqzizb/DzWsj
	 DchGvT0S7XYmXOm31XAATgQhzp6tj8dkR2uv04udDe41YeE7RobO/52ddWK5evPVH4Gv0
	 wIukHiw/Kznj+JL9gNVzIf4Rbd0DOD/2wFECgabDXEr+BZCyn4hkdNJchYqYNiRfq/yhn
	 FosT+z1ZeliErld+dLm3wwkK8TbrfUjPAWxMNRMpIQVHdgr85+xobIRfQZAq/5yOgxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=h6S++WXU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ICx2TOCl;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668D60A2602;
	Fri, 20 Nov 2026 15:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5668D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=h6S++WXU;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ICx2TOCl
Date: Fri, 20 Nov 2026 16:49:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795189801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yExTCY6nHkC6ZYDgvaCfKm5pebEaEPCvwgabu3jSyPM=;
	b=h6S++WXUUgycPePW+aJ3mGkxe/lu6GvcPHrKOQTTlipC8cuNJm/xWTzj97s9wODlhVEaXs
	3e2MuH1jwvoAwPEsxslWGGGhb+CmPH704PL/VphTJqda2ClZfOl3U+hdc/Nrzi6cEcDZ7b
	hvR2zsLWXA7dCoExYqElbrCXRqlvm38xv40NktzvlfXGeO9UoBt/zh22D+zPbLu3sblC3s
	4Xs0xSC2C+ZjsMY4Lg1ksp+k0vL2SZzOrs43pX/rEeqXRTKK3MAM7039zRxTGMBjtwDid/
	LvqfwfqrHKUPs5OQwXdx3UjJNPpipILx9e5MmbGg4q62Xm99iz7hd9yy1KvQww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795189801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yExTCY6nHkC6ZYDgvaCfKm5pebEaEPCvwgabu3jSyPM=;
	b=ICx2TOClGAyAITrXs9i6wBvgj6s6eicLIEixw1nxc3qJofR6xQFB/F9GJ40NEud8mF6m1E
	tLwK0ADdjpQfwYAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20261120154959.zw08JC0V@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>

On 2026-11-20 16:44:57 [+0100], Peter Zijlstra wrote:
> Some key ingredient is missing here. Is this some software event that is
> missing recursion checks?
If you navigate to
	https://lore.kernel.org/all/29aa123c-36a2-460f-b76b-a8dfe1eb542f@huaweicloud.com/
and /PoC then you find what I used for testing.

Sebastian
