Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CE1D514F;
	Tue,  5 Nov 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809475; cv=none; b=Af6A2glyoL5Az++DjpcLZYSiGBuVQWNu06EqS65PgrQ/Zo/UpbgylvfZRtyrAUVu1ILEfcQZx6ex/EP1UC1WCz/C5VcVqt/Wlyd3i/trV7qCLa/WWv5ZMgjv3Y9p5GaHNie7J5ghlaO0L/I2wEmABImgjJEh55qT6xBPnVIa58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809475; c=relaxed/simple;
	bh=jMWTjfSOyCX0vrUu3o8ZZlqSwKOd9wgA61R6qFZN5uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNMiIVWwr2bzWaGPsWcobU8AkQJcb5q2G8s69DOnl/+FTnR3L7SvjVtSmaEbdt+j2DJxr5yY+dabE8W6oRQU7WxLK0F3SnajpfrRgwpA02RUCQJcNxevoQnY3CAw1zLfMZNbvctwNkmxhhKmCLuuPTQWYAJBPGVVWdi+7yXVfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vOjhiQl4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vOjhiQl4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RhUrIAI/1i86k5bor11f5iDkU0M1CAv0v6o50442/1s=; b=vOjhiQl4o3pTL7h/ltb5nKkH1i
	L4HyeFfsZNjU+/nRIcqeJScMugbVUPCj8v2MfEsXeiwme8+FewH2HjQtxd8WuDRKKd+dzvVxFgPld
	4XepR/l6exWKZgKZKvNj3LNmo2wTBr2jdEPZK2uXxJYf9xwjhR9WxVMEgdc0QHeGuP40KnCJ/DNoY
	YOuUP8wCB4L8OnHWnKbR8MAAFfNOKB4/eSEPn+AxwV/z26tfEH5KQScdI4XvMAbawOuqTIGWPERSP
	/oRLRVEMuI5XK0jyy8HZKyuSOsqB0XBv6mrL/qoFe+Gup6woONrUiWaBefRtGcb4czNlDtGHfElTJ
	8NB3Nizw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ibe-00000002oEw-3t9Y;
	Tue, 05 Nov 2024 12:24:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29A2130068B; Tue,  5 Nov 2024 13:24:23 +0100 (CET)
Date: Tue, 5 Nov 2024 13:24:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: Reveal PMU type in fdinfo
Message-ID: <20241105122423.GJ24862@noisy.programming.kicks-ass.net>
References: <20241031223948.4179222-1-ctshao@google.com>
 <20241031223948.4179222-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031223948.4179222-2-ctshao@google.com>

On Thu, Oct 31, 2024 at 10:39:44PM +0000, Chun-Tse Shao wrote:
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add extra attributes which would be useful.
> 
> ```
> Testing cycles
> $ ./perf stat -e cycles &
> $ cat /proc/`pidof perf`/fdinfo/3
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    3081
> perf_event-orig_type:   0
> perf_event-attr.config1:        0
> perf_event-attr.config2:        0
> perf_event-attr.config3:        0
> 
> Testing L1-dcache-load-misses//
> $ ./perf stat -e L1-dcache-load-misses &
> $ cat /proc/`pidof perf`/fdinfo/3
> pos:    0
> flags:  02000002
> mnt_id: 16
> ino:    1072
> perf_event-attr.type:   3
> perf_event-attr.config: 65536
> perf_event-attr.config1:        0
> perf_event-attr.config2:        0
> perf_event-attr.config3:        0
> ```

First time I hear about fdinfo.. How much of an ABI is this, and why
this random selection of the perf_event_attr structure? What if someone
else wants something and then we change it. Will this then break ABI?
