Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110965;
	b=NVLgHDdy6mY+a/v+z2oD6cxO4dtlQwwyZfUOH4BRllP0JlEmfuAOcMedF1HoTtGS+O3o
	 YI01RKjOaXYgeSvnFM6qOJ5QMzAdU1Xot8SQyzLckXkjtP+2wL1Sr7JJ8kV5yT2NN31pP
	 hwTW+IuP+/glAbHSCOuK2z3ErZmPFF+ykGIGFL80u5lPeA0NfDNCG5FTzFPddLpr792ke
	 v6A/se5Qi0W0MlbH4G2K+ID9UUFFOZgyzYGHr4lfW9c33z+C76YE8za3kB/to5XsccKAg
	 HNdMs2T3d2ZsnhVb/iOn+PugMULgEZAttc2kk91xu32VZjW32Q+gleq+Ouzp7tUumbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110965;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=LBYGglAXsWqGzAhxvwDBy4ayECCRJnBwxGHaVjrpRew=;
	b=N0H5oFkMqKTAeQddI8Skrvh0GAKVv6P21w83dQA1KVQySpgFhUdy0W1Nfj0m7WKrRWNx
	 quNGyMVfPd9HpArod8MNg85E/bZsZnf4WKbw8rex7oLiH0LNbjYUiNlBNUo9CESn3xmxJ
	 i8VnJvohq5PX8mVhiH+R/h3U03X1zWHCRiLYHCYHsrmsJMNbJ41nAFTtB5pUICaHTyWUX
	 sd9JDNdtnjbCIvdODrDwRUDmwEr740e2c3UTEKc3u2X2FYojtWAwDnh4hdSivDCfGlg6Z
	 m4i5FGLNwrldEIGrxlPhm41RufZagZ+uGyHaDfv9zclRPcB9bppd0E1BUTXfwtQPT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=oRIOUBPr;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C73606A324;
	Thu, 19 Nov 2026 17:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C73606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=oRIOUBPr
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 783C81C466D;
	Thu, 19 Nov 2026 17:56:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 908DD2002B;
	Thu, 19 Nov 2026 17:56:01 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:56:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: JunYoung Lee <ljyoung04@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Require kallsyms permission for the .function
 filter modifier
Message-ID: <20261119125600.2c121ba7@gandalf.local.home>
In-Reply-To: <20261119025941.87102-1-ljyoung04@gmail.com>
References: <20261119025941.87102-1-ljyoung04@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: krgrzdytxifsio89r4efe9tdfzue6yqn
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 908DD2002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+mYDDFPZcibBeUc9E+pXzRf84b0dO8kIw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=LBYGglAXsWqGzAhxvwDBy4ayECCRJnBwxGHaVjrpRew=; b=oRIOUBPrWo3OyyyXKxwoU6pzG65Zw7HXadinSCiE7VSfRUJ4AwpXh6sytDz/DGZcFQ291I9L3EXC/EexuU6OxdYzbpoQ6VlB9k97XopeMDD2jDR7UPJ3E5OnHIO7cHWdM49X4gyS7VZBlVNnBqGMltdXwrK4abxH4EAGoEZecjw=
X-HE-Tag: 1795110961-521887
X-HE-Meta: U2FsdGVkX19NXP8itin62zZDNyf2JsmiTEODJfJEmva8Z7iqdXSaMfWtjXctMIQ3/S/vApq3wkrcazaZkXzd4e3+9T12F/Kt3TqnY3uPIX9EBymkptdUnNDem1C76dZRNWTd+3SYHHC95zp4XU3fiTmxTG4FUudrku3qflX3oskajmcJrteseY1WOGu52OTCmwEVeQpvAUXIf8i9G3kvlDcepC/dxGnw8x2p1VOOwwGHJ6A/mgAOK40OI4JCHG7Zyc/tD9TPvObcojRKL9rHHBlTvBJjdnIo1aOvwlm656tlvzhyNwLeaLy5ueZiWQGVBAUBEvwV4FUyWoZrcoO6Wx0gohOlc9kEd4xekVeJ3JagqLjOVyPMGQ==

On Thu, 19 Nov 2026 11:59:41 +0900
JunYoung Lee <ljyoung04@gmail.com> wrote:

> A separate issue seen while testing: as root, a .function filter on the
> perf function event (ftrace:function) crashes the kernel with a NULL
> dereference in ftrace_function_set_filter_pred(), because pred->regex
> is not set on the .function path. It needs CAP_PERFMON. I can send
> details if useful.

This part already has a fix in the queue:

  https://lore.kernel.org/linux-trace-kernel/20261119080139.131834-1-devnexen@gmail.com/

-- Steve
