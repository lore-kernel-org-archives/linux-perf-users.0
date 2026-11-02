Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637345;
	b=XzhxeRbyUl0hk4fou+7yLRTDXLL97talOrpaM+utffwjcR2ZEH7zvGvEQygwZLmjykYu
	 i9THBDG48qKrKdpW/fIwIIkFlWBu6X9J/vdlT76r/sT+0sRkcR4XdsYaaaBz8/dTagVBf
	 rCoF1OCQJ++6fVsCimabTNcoTIYqi+e/0iqRzHEw32Y5xIqpqxi5ioo1UguWeMsiVJnpp
	 ylTGz5Dkz1OZBA0nI5hm8x5Y+kNb40drusHEfPDQHd0Nanoj3XVk2wX6Dmxp6vur3MCA5
	 4gOXySrP/HYtI1EZqYd2O9qvPNHFBLT39R8LrIPYnLAmPtXksnARBMuR44AfWsXO1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637345;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=HcwaI3pW/80H6haxw0NcngNpoXS0R7BCzSXcfAhrIDU=;
	b=a7QAHXL5Y+o6sK9ZyWGHcZItVxmq3YypH17oFzXADwMIrOAgLB5CZ4V5ej9O9Yl8kG5Y
	 0rR3XA13F2LDuWn1fynf3Qn9xXXrr60XIJhRPLlV/dL5zbVsOzhFp+QJJ7dlY/k0begsO
	 +V5pf4aNAz5opCcgCXDo4Xryw+mnEBHU2A8cbw5jU+ijfYn7hfJHUCa/h57DxViYMItpT
	 5B37V1kznVduE6t2KpyOo/06MDr0NXHw4dJ22I12Pq91EykJQ35Z2dsgVifmjsQ2dubUS
	 YJmKpELBjA/Qsfqvnf5YYQLu4g9gynRrFAquVXpdDHYmKIh4+ls80lRcAvaFZvAtbrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="xU/AoOCF";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8bnDqeXu;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA49606B0F0;
	Mon,  2 Nov 2026 16:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA49606B0F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xU/AoOCF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8bnDqeXu
Date: Mon, 2 Nov 2026 17:35:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793637342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcwaI3pW/80H6haxw0NcngNpoXS0R7BCzSXcfAhrIDU=;
	b=xU/AoOCFrBJ15PVVJBmI69ViObjB++CB/yEAfN1yWlRzwYLhKo7BmRzYNPYBssmxv13M4M
	gQONHXowsfenN4yxEZLjIYWX0TAWqZnAitz5ReX7ym7kE1Km6VcptYzx80hpSyIfty8S9i
	Ius+rnm9W/eTYwwP6t/K+JjFpiyGYyHxBqcu+NCFZ0YIPEd3kFlh/1oAi55sWmRLS8A0v6
	c7IDGEtl1641adTXs3M3m1iuo0kS0JBZDTLdAABvXp5CuzeaoWedLyQTES7epgkaQ3atq0
	s8kwVSC2gi9p/bk7dQnapTuMZmi9LC5hybWEAXgte0EJjJW0zTRCsFlueGnZKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793637342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcwaI3pW/80H6haxw0NcngNpoXS0R7BCzSXcfAhrIDU=;
	b=8bnDqeXul1VM/geD8d3muGIQ8dthuMTSJ+51XIR0TeSbW+SjPjz/Ig1lAmFBJ6FUCe9wbH
	UgrqUvkQG5/89vCQ==
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
Subject: Re: [PATCH] perf/core: Prevent duplicate sigtrap task work enqueue
Message-ID: <20261102163540.4WF7hhhW@linutronix.de>
References: <20261031114520.642476-1-wutengda@huaweicloud.com>
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
In-Reply-To: <20261031114520.642476-1-wutengda@huaweicloud.com>

On 2026-10-31 11:45:20 [+0000], Tengda Wu wrote:
> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
> 
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
> 
> The re-entrant call path is:
> 
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
>           __perf_event_overflow()
>             task_work_add()

How was the issue identified?

Sebastian
