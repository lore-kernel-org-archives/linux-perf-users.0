Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960C359700
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608269; cv=none; b=HrVnRkSVkoDkbEc1g8DKy4Fd/pKcGDBlHcjA87vkETd/xe8u6m6KNnNG9daD+RvBfZKGA2eMyRficlwnHPEd+ryVY4H3ARpNVej07dXzChzrCoaVC5cwfKQCxDcMf1jAGjd8Shddxnk0YOTR0apwQ0K84R5zX+JNxY41X4qm4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608269; c=relaxed/simple;
	bh=1KlpPwn83e+LajM42ZpDpgBNVKsBxMbyCrQG0f9ReSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOVZ3i8LHa/3I7bCm2FtNDV/zSxvO7zV/O3KpRdT6yJ4v3hcKlZLBY4cy/Whpe1MlgSNtzlKRqonOP52fsJEEii6psxIuifffn/x2we3hj2bJ7/7GruBUc++efCJ841lLG72iGQqQc3nt5cws1X+RFFFrgTxgCUxQYpKNuHv1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEkgvZ8d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEkgvZ8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769608265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sm7I4MbFbi1h1/VGos4meITNXWHUCDkuO2ezjqcp5c=;
	b=CEkgvZ8d9ZiRSiewsL5YKOTrSd5Vadl3qulkRGXFkkutOqikZTwJm4ln7m5l0lc/N5dLJk
	YjWVO8WxbF37keCA9dh06FYyjk23MQE+fyM4MpIKSA2OaPitBtBDnY7Vb0fgMZJEUlmLJO
	wv9lLn02+VGRGyw3+N2fukqfmKidfs8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-duDDmRzgMiGz_2u1MmKs3A-1; Wed,
 28 Jan 2026 08:51:00 -0500
X-MC-Unique: duDDmRzgMiGz_2u1MmKs3A-1
X-Mimecast-MFC-AGG-ID: duDDmRzgMiGz_2u1MmKs3A_1769608258
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 559CD1955D84;
	Wed, 28 Jan 2026 13:50:57 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 44D1A19560B2;
	Wed, 28 Jan 2026 13:50:49 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 28 Jan 2026 14:50:56 +0100 (CET)
Date: Wed, 28 Jan 2026 14:50:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: fix incorrect lockdep condition in
 filter_chain()
Message-ID: <aXoUOEhDfncEkC-f@redhat.com>
References: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/28, Breno Leitao wrote:
>
> The list_for_each_entry_rcu() in filter_chain() uses
> rcu_read_lock_trace_held() as the lockdep condition, but the function
> holds consumer_rwsem, not the RCU trace lock.
> 
> This gives me the following output when running with some locking debug
> option enabled:
> 
>   kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section!!
>     filter_chain
>     register_for_each_vma
>     uprobe_unregister_nosync
>     __probe_event_disable
>
> Remove the incorrect lockdep condition since the rwsem provides
> sufficient protection for the list traversal.

I hope Andrii will recheck, but looks obviously correct to me.

> Fixes: 87195a1ee332a ("uprobes: switch to RCU Tasks Trace flavor for better performance")

This commit just change the __list_check_rcu() condition...

Perhaps
Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")

makes more sense?

Acked-by: Oleg Nesterov <oleg@redhat.com>

