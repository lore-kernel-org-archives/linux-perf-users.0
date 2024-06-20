Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2E1AAE19
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879872; cv=none; b=PVUXnFXFYZ/j0uG7Z2DsE7GtSxrp6+fw2/stK+D+KuAz5q7YfB9gxk19mAREZMz0dz9xBQwPlmfzA9pSvr77FJP432Uog94sQjTfBVpgg1hSWJdTAC/3Mr2GMWF+UnjKLtzbQXKSUqyemuC6q/PGUvweGYFeFuDLYwh0SQpdCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879872; c=relaxed/simple;
	bh=fjCT+vC9WCmYZJSsbTUGXVqbsk0mxJMwSWRAQaj7ft0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/V//ED+d1cGEr8e35V4rnm6JPO+cYqnQHrs9Y5ef1eRpJzina3FxJn79NgM0rcggk7T73bu8AlXjz7dy3hdsPSjMAQKiwj/QwvKf8lpCnwrCGZbaBfuAon0Sb9vwVuvfKcrIPn7j1nNFIYOYf+dRCBxG9lL9jtFXmcLM++GQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkpOsPHd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkpOsPHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718879869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjCT+vC9WCmYZJSsbTUGXVqbsk0mxJMwSWRAQaj7ft0=;
	b=UkpOsPHdQqktSUg+l8ad4+hw6he+Fxn+InNL2vsFarl4eS4B2fOp1YrInOuREcX7xURoO1
	QHDCh43TKk03Jv4Nr2jEIIBZELPBCzlB4fxzT8mbi3g+A6JOxqLgNc/aYKb1OPJnCW3RGi
	Y54RxFUWJi4sfFrZ7FJo1q2xnot7b2A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Fd1mNQJpP9-7xMIncwIweg-1; Thu,
 20 Jun 2024 06:37:43 -0400
X-MC-Unique: Fd1mNQJpP9-7xMIncwIweg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A3F519560AA;
	Thu, 20 Jun 2024 10:37:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E32BA3000218;
	Thu, 20 Jun 2024 10:37:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 12:36:08 +0200 (CEST)
Date: Thu, 20 Jun 2024 12:36:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
Message-ID: <20240620103600.GD30070@redhat.com>
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
 <20240619151524.GB24240@redhat.com>
 <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
 <20240620090807.GC30070@redhat.com>
 <93d96e55-c180-444a-9b3f-f96db5f9e37d@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93d96e55-c180-444a-9b3f-f96db5f9e37d@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Again, I can't really comment, I know almost nothing about perf, but

On 06/20, Tiezhu Yang wrote:
>
> On 06/20/2024 05:08 PM, Oleg Nesterov wrote:
> >
> >But to me the very idea of arm64-specific and "kernel only" member in
> >perf_event_attr looks a bit strange.
>
> I noticed that there is a similar arm64-specific change in
> commit 09519ec3b19e ("perf: Add perf_event_attr::config3")

but this is another thing even if I have no idea what .config3 means.

If nothing else, what do you think, say, tools/perf can do with ->bp_priv?

What should sys_perf_event_open() do if bp_priv != 0 comes from user space?

Nevermind, please forget, I leave this to you and maintainers.

Oleg.

