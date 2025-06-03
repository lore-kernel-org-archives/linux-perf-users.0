Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3C1CAB3;
	Tue,  3 Jun 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955064; cv=none; b=eI/AlOqzKdBRcp0HuW/B3ROrlRG7j+o0LjOCc+HVKwNTcOpJsbhPF3yCadcybym5vPQEsGX8PLn13X0pDOCnR3smK2kdCLO/h/D359ZHNlIkctlIhRXxqBxvUOp3LWDal4lDGaO6iI3YDrTuee6lW3ELcsI/ySHH/y4Jy/eYqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955064; c=relaxed/simple;
	bh=luj6+UgpZPIqwG3c84F/6ySlF809YS7dy78DYQr01Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFfu60JIx0h29CNDd+2Z7TRou6/xnEvOE86TAKGX6ZaUzzh9N1mRbgnLa7KPjguYir1nSLmQ1zS+BeE6Q7lXg8vVxaXl+Xfwe8RfYfsldTlAgb0MJhqo0flv6fN/0vODTq6/YGWWRNwOnnshdhOevO9H5HVuimpjf7UTbQc36JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3BKAqn1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3BKAqn1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GEUDjIOXBUnteEfDddfkPq9lorpHuM/OZXzN4XOb7Ho=; b=W3BKAqn1fgMDoDkCTYNdFqsWek
	hQjifa+agyQI8Zvnfzp5B36pq6aYQ/PLpSXkhvTgYS0ijqC0XAEnpNNICmktddXeNtZWJhpmO/jXE
	z3Ht+iMHRXyb9Ty7L2prRi1DWLuCLqcT4wSA8bZnHW024svTFwhEkFAGbIEs3WhkC6mpvCCrvfFCH
	n8gHr9hfMIGrNgmtc7wFoAHPdc2KX8iLF126n/UWsNaZqE0FdTHf6ox48x0/UWsPKIb1nI9bWJU2/
	lcl8kcB0P9TyWX+M2dirxZkZ9qTvgXJzQbFRcb5Tc4EED2xhUeyeeLpmfcJycMDzfLLjnbMYo2YZ0
	frlwmx8w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMR6X-000000021qA-0nHI;
	Tue, 03 Jun 2025 12:50:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C61243005AF; Tue,  3 Jun 2025 14:50:56 +0200 (CEST)
Date: Tue, 3 Jun 2025 14:50:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Wang <00107082@163.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mingo@kernel.org, yeoreum.yun@arm.com, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: restore __perf_remove_from_context when
 DETACH_EXIT not set
Message-ID: <20250603125056.GI39944@noisy.programming.kicks-ass.net>
References: <20250603032651.3988-1-00107082@163.com>
 <20250603083304.34132-1-00107082@163.com>
 <20250603091352.GJ21197@noisy.programming.kicks-ass.net>
 <2633d43d.ae30.1973564f5e5.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2633d43d.ae30.1973564f5e5.Coremail.00107082@163.com>

On Tue, Jun 03, 2025 at 06:44:58PM +0800, David Wang wrote:


> (As yeoreum.yun@arm.com pointed out,  the change in perf_remove_from_context() made
> perf_event_set_state() happened before list_del_event(), resulting in perf_cgroup_event_disable()
> not called.)

Aah, d'0h. Let me see what we should do there.

> My suggestion here is to confine the effect of commit a3c3c66670ce only to call chain
> perf_event_exit_event() --> __perf_remove_from_context()
> 
> 
> (But this v2 version is totally wrong, should be ignored; it breaks commit a3c3c66670ce)

Right. Because we moved that state update earlier because
perf_child_detach() wants up-to-date timestamps.

