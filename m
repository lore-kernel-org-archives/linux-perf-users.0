Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049412E5B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164226; cv=none; b=CiDoHl49VyEIQP8W4WmBi4ghYkLirKCzHQOJYaLRiZA5yrKus9xUV9yefxEJQs2Homg318Fqn5FqL+ml1g1NSCs+5p6oEZ+16Srads7IjxURIdtfTNjaiLH2cO4WCOGK2MnCwaV95Otb1H7S/na8u8iXQCLIETRKIw1iWdR5om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164226; c=relaxed/simple;
	bh=OhSWmWXP2uaD0O00jUY8HYyAlZyRHhdwKauRjsmZSE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBqy2SGB6RkYU/+py3XphrvcKjNBy9wz1+9MYSfFBSeCCBaROX6BxRj1m0pJukROU9c3uv3ReWwr+TSHpiZLSfwiYKdnrYV/UEqagO4EA96ayi9eHK1U6cG7eYPFo8iz6basXijbEqGQeE31dqY+7ZpVRGIhz+Gh1srvjOfCQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P//FuczV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P//FuczV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724164224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8LusOgz8Q5Vcit1THkmHm5dyFGoPNQpRq9rxAnuUqk=;
	b=P//FuczVIk8OgBKcUx/tAtmBjawPIYQHDgSJpAXrDf8rcv1uBl8oaN9LdUWk7vHbSkPEIi
	QlnrZ8WbippYlnRbDxLQGp3Oew4NG0fzw9gbdq4/YPDPByiYYLn4pVaTGMLYhNuzdYYwss
	/9mbvIVizsyyhLvMGFz3yBc/bnJztLE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-z0sCsKhPNXOQLNQr5QzbJQ-1; Tue,
 20 Aug 2024 10:30:18 -0400
X-MC-Unique: z0sCsKhPNXOQLNQr5QzbJQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C58AA19300FC;
	Tue, 20 Aug 2024 14:30:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.99])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 17B233001FF1;
	Tue, 20 Aug 2024 14:30:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Aug 2024 16:30:09 +0200 (CEST)
Date: Tue, 20 Aug 2024 16:30:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] uprobe: fix comment of uprobe_apply()
Message-ID: <20240820143001.GC12400@redhat.com>
References: <20240820135232.1913-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820135232.1913-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/20, Zhen Lei wrote:
>
> Depending on the argument 'add', uprobe_apply() may be registering or
> unregistering a probe.

...

>  /*
> - * uprobe_apply - unregister an already registered probe.
> - * @inode: the file in which the probe has to be removed.
> + * uprobe_apply - register a probe or unregister an already registered probe.

Not really.

See the commit 3c83a9ad0295eb63bd ("uprobes: make uprobe_register() return struct uprobe *")
in tip/perf/core which changed this description

	* uprobe_apply - add or remove the breakpoints according to @uc->filter

still looks confusing, yes...

Oleg.

