Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B93603CA
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585411; cv=none; b=rxzQ/KfCFbFxptnOP82vRkmPEcAF9Ec7rdLVPWAi+Mi6cHqFE5acN990TUQLXyHUnTBwDfQ/cLdOA0I55oh/S2ZTSOMgjWpPdsQI/JcgVzOv4QOOiJM8cLg2HxIXS4SIX8kgQ/m5mDWrXf4CsZUKK3tPNbG6HgSLPlxoQ6wCuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585411; c=relaxed/simple;
	bh=lM1CcdXIUZTtJd4wZl4zoovzSD4rqy0onFjRndXcZIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZxDUCjH3m1AqzzC/uI4NnPvEcVDDgvR/EZ6ArAoZBndBgtqWNRvuZFo+KlQtR3+89X3QQgyT6YCPXQYwiDp8MGXQedV11MQLBKbv21PDoUfaORG+ItpqWXaDWW0UZez6LoDC9EbTZFzdLauA8qA2WoJgDoGG9BKSc3U7mu1IJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJTWlsnx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJTWlsnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778585409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11LimZiaodqbqx6pl+x8MSLqK/EFDg1Rt6laQG1tW0A=;
	b=DJTWlsnxkmyfMHp5zmaVfycU0/i6cYCXgaEHy53R0saANg+dWyBe/GlTkxze8P+aX4+s7a
	v0qkxdsLi+QQbwjKy0A1mqhd/LNmEAuoa3w7dJAESxk0ZZ77PK9fBMRV45i8Tf30573tkY
	K/W1bnULAFFvQJKe+vjeTcOVBTdNQ70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-hls4LN72OROEOFJQSHoivw-1; Tue,
 12 May 2026 07:30:06 -0400
X-MC-Unique: hls4LN72OROEOFJQSHoivw-1
X-Mimecast-MFC-AGG-ID: hls4LN72OROEOFJQSHoivw_1778585401
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 950DA1800359;
	Tue, 12 May 2026 11:30:00 +0000 (UTC)
Received: from fedora (unknown [10.44.48.223])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 52D5419560A2;
	Tue, 12 May 2026 11:29:54 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 12 May 2026 13:30:00 +0200 (CEST)
Date: Tue, 12 May 2026 13:29:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:UPROBES" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] uprobes: Use flexible array for xol_area bitmap
Message-ID: <agMPMAnsCH2ZRhf5@redhat.com>
References: <20260511225648.27886-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511225648.27886-1-rosenp@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 05/11, Rosen Penev wrote:
>
>  struct xol_area {
>  	wait_queue_head_t		wq;		/* if all slots are busy */
> -	unsigned long			*bitmap;	/* 0 = free slot */
>
>  	struct page			*page;
>  	/*
> @@ -117,6 +116,7 @@ struct xol_area {
>  	 * the vma go away, and we must handle that reasonably gracefully.
>  	 */
>  	unsigned long			vaddr;		/* Page(s) of instruction slots */
> +	unsigned long			bitmap[];	/* 0 = free slot */
>  };
>
>  static void uprobe_warn(struct task_struct *t, const char *msg)
> @@ -1755,18 +1755,13 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	struct xol_area *area;
>  	void *insns;
>
> -	area = kzalloc_obj(*area);
> +	area = kzalloc_flex(*area, bitmap, BITS_TO_LONGS(UINSNS_PER_PAGE));

The downside is that kmalloc will use kmem_cache with ->object_size = PAGE_SIZE * 2,
almost half of the allocated memory won't be used...

But technically the patch looks correct so I won't argue.

Oleg.

