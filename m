Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3BD1CA693
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367597; cv=none; b=BgMX613qzw5B9T7lP7BNqOYbMkY6DxK0O2R+T51kmhKXiW9vfAOOmN2653wQhqjhFqlNy1KfwEB0aM5ZTkVhw9Al+ZptuQX/APqp6XCp7af9oJkIiESav30tuL7+SEd3aZuhlWmABYRx+9d0JlIvMe3CEy8Z0AF4ceQTvZuOOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367597; c=relaxed/simple;
	bh=Rlyxtlo5hzI9N3YYU1nTTHUB+oS3mO6LVjK+srmICQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh/HVfBj/2wT9jHSYHHHOVWTpbTd7uHoPsKAvKJMb/aCkz8hydqL4OwAGuIU4BYamlSAZJy5X+AIISle802LNXFInWLyrBcmPqXnEH8gO8onW/ZuIMRwLazSiiWq8T++if/g2/Vhv6n4YjHSvud9bdNRzaTsWB/dahz8/41IHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZtMPNpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZtMPNpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725367593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixgiDmvar1tWfYl+K7VyNawCctRA3Ge+tCMoawRgM90=;
	b=VZtMPNpavK7qBqLA/Phs3iiYDUJfm8HlBq4loR+hYn2xiR5Umv1pyouHafAy1Xi7e65jtk
	Ad4MKwUKWgl6qB02XyH4hyjXdpq6o/jPqsLQcbq/llk28stGQlMSp2HnVUqeNgFhnfo4KV
	QNbve75Ynx1bx9w5BMjU54EIexlqOng=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-Ows8vTQyP96DVRLqnAUn_A-1; Tue,
 03 Sep 2024 08:46:29 -0400
X-MC-Unique: Ows8vTQyP96DVRLqnAUn_A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F9F519560B4;
	Tue,  3 Sep 2024 12:46:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DE32D1955DD8;
	Tue,  3 Sep 2024 12:46:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 14:46:14 +0200 (CEST)
Date: Tue, 3 Sep 2024 14:46:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: use kzalloc to allocate xol area
Message-ID: <20240903124607.GB17936@redhat.com>
References: <20240903102313.3402529-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903102313.3402529-1-svens@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/03, Sven Schnelle wrote:
>
> To prevent unitialized members, use kzalloc to allocate
> the xol area.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Acked-by: Oleg Nesterov <oleg@redhat.com>

and since this looks easily exploitable, I'd sugest

Cc: stable@vger.kernel.org
Fixes: b059a453b1cf1 ("x86/vdso: Add mremap hook to vm_special_mapping")

> ---
>  kernel/events/uprobes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 73cc47708679..50d7949be2b1 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1489,7 +1489,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	struct xol_area *area;
>  	void *insns;
>  
> -	area = kmalloc(sizeof(*area), GFP_KERNEL);
> +	area = kzalloc(sizeof(*area), GFP_KERNEL);
>  	if (unlikely(!area))
>  		goto out;
>  
> @@ -1499,7 +1499,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  		goto free_area;
>  
>  	area->xol_mapping.name = "[uprobes]";
> -	area->xol_mapping.fault = NULL;
>  	area->xol_mapping.pages = area->pages;
>  	area->pages[0] = alloc_page(GFP_HIGHUSER);
>  	if (!area->pages[0])
> -- 
> 2.43.0
> 

