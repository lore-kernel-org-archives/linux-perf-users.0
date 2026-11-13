Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567936;
	b=JGgmiz/Tk6rvDgZnkD/WiGHrqZtYTIi23CY8cV5xfw+Minv+RcGb9rNZykxT0go+U21f
	 NeO/JKQ86UefTWZh2U0pW6HEShANvq5WPCr7pQzdXQqHOC1sqRIda60StmmIFqsj0SAe7
	 fQMA2K7S62A3uLphToUrj7kTxc0j5TB5mURdWj2+23sc9wdXr9oyGTyCCau+y6eh7Rfnt
	 KZ8neIepF+B5KFurlA5w0F+E9POhW7cq0jSKAATxQZ9X9XmCBVY/eaS7MKpAtac2ct0MW
	 tDYcVLGIvNZhW5WKnM9pHs7HfIEZVi9ltA0mOYE4HzAFHHtTkRvPJN5MaBtVZG0f+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567936;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=hDulsKUXTiaWl7ljBHKiX3WkjYxWKjQtrQrwS29EqM0=;
	b=kPJ8L6pEh/8dfLGS3oP7ARoDdCX79mzl1/k2BPpJMkPBfFggV63Z2c9OW+bFx8KKeqxP
	 WbIamKz6OfbSwhruhZXSlU9Z7wd/UdpLaISm2lQev5pEShkbnwT8uI1apAKnFNUv+5uRU
	 9kX9qZGnX7ZHsX8LYDksNCBP+ydLGpW6cq9mTj8bay3QjHWbLYrocqL6pd5ie+UBARmqE
	 TU4lx3lXPXsKJlmWQ+pP3IZfJAAGkXLyE5f9V0XWGn35YR9xrJo4j68nuhsm3eXWahIyv
	 uAUaKKuemGFCgf+IVR7OyljXaaK1edwmvnZ0cp7mQ9om8PEgJ8DgtA/3P9FzAeyBpoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXuEPWHW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF9606A337
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBEF9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XXuEPWHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794567934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDulsKUXTiaWl7ljBHKiX3WkjYxWKjQtrQrwS29EqM0=;
	b=XXuEPWHWyTbdA6UB2JG+A9Xq+tH0yShUWf0kae4HuFOmy4bYDniuaxIeDjzhFpDOtxbdQ/
	QLgyreyGVksDpTLhNowhKZGQKd802ihUXDUnLDHCh4qqKQn0+PL5J2Y0eaX70WnllrX+KR
	o3Tt8oacgfvYT6BkFrQkgUm+459fRzo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-RwV99ItdM5y-209Xr24W6Q-1; Fri,
 13 Nov 2026 06:05:31 -0500
X-MC-Unique: RwV99ItdM5y-209Xr24W6Q-1
X-Mimecast-MFC-AGG-ID: RwV99ItdM5y-209Xr24W6Q_1794567929
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 560A1195608B;
	Fri, 13 Nov 2026 11:05:29 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C94E1341;
	Fri, 13 Nov 2026 11:05:24 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Fri, 13 Nov 2026 12:05:29 +0100 (CET)
Date: Fri, 13 Nov 2026 12:05:23 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] uprobes: Use flexible array for xol_area bitmap
Message-ID: <avbu0HiCiDE9AVHs@redhat.com>
References: <20261113052948.2668076-1-rosenp@gmail.com>
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
In-Reply-To: <20261113052948.2668076-1-rosenp@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 11/12, Rosen Penev wrote:
>
> The XOL slot bitmap has the same lifetime as struct xol_area, but it
> is currently allocated separately.  That adds another allocation
> failure path and a matching cleanup branch without buying any extra
> flexibility.
>
> Store the bitmap as a regular array and allocate it together
> with the xol_area. The bitmap remains zero-initialized, while the
> allocation and error handling become simpler.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Oleg Nesterov <oleg@redhat.com>

