Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A218A6B2
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112937; cv=none; b=CeQuWpI1G/42FRRQdm7OpTMGeI+qYKX0hYjvUaIJvX8SQJe/AvPT4ekgx4yDmGlA03vLjSb7fnUSq8uRGWZgZ1GQ5C2yOtVkms0kf6oUhS2ebTyhKy0HcFYX1AQZaWcqMMEpFvgWWZOeGgUoVKAlH6sUcPxVJ5I/Yktstccmr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112937; c=relaxed/simple;
	bh=4uEa+812lSqYwj5RnyAM0Mq1iA1qCM9VCy3pwBVz9n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPDf2WCxBg6fwKTbtnNRTeoWMwGQAaguFYd6nS1A2xQ0sTmPOYuelvfR6d/kkZiDpQ6J/LQaJAgRfNw1PDZXyz7SCiqYcffb3uj6aas2cPTKAvIp6yoUDmTqpD3x8kRm17k6fsWLowZbjumWC3U4L/7JvCCJ7cPq6Xgp5AWEvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9B/f+W0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9B/f+W0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723112934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqff808lcKfY5U/qgJUHTq9+9GeyxDW5MWmHOf7xqPA=;
	b=C9B/f+W0XD1Zq1yxn8ghWWAa8O56j2IJV5a6TbX4Ih2s3gB/DdZ3naIClRO5h7H5SFUShk
	Gcdc06ibY5bpJ/CIQc01Hv3F5WcLlUDRWMJB0I55OKx2kYF0/YFq1Cp76KGlZAWbhmB80z
	qNEIC4BvYxQazN5kCsYE2BbvVmrgm68=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-U8GN3sdtPmeuyYsLfHUaXQ-1; Thu,
 08 Aug 2024 06:28:49 -0400
X-MC-Unique: U8GN3sdtPmeuyYsLfHUaXQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40A371944A97;
	Thu,  8 Aug 2024 10:28:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D0A761956052;
	Thu,  8 Aug 2024 10:28:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 12:28:44 +0200 (CEST)
Date: Thu, 8 Aug 2024 12:28:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
Message-ID: <20240808102837.GC8020@redhat.com>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
 <20240802092406.GC12343@redhat.com>
 <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
 <20240806172529.GC20881@redhat.com>
 <20240807101746.GA27715@redhat.com>
 <3bb87fb4-c32e-0a35-0e93-5e1971fe8268@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb87fb4-c32e-0a35-0e93-5e1971fe8268@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/08, Liao, Chang wrote:
>
>   - pre_ssout() resets the deny signal flag
>
>   - uprobe_deny_signal() sets the deny signal flag when TIF_SIGPENDING is cleared.
>
>   - handle_singlestep() check the deny signal flag and restore TIF_SIGPENDING if necessary.
>
> Does this approach look correct to you,do do you have any other way to implement the "flag"?

Yes. But I don't think pre_ssout() needs to clear this flag. handle_singlestep() resets/clears
state, active_uprobe, frees insn slot. So I guess we only need


--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -2308,9 +2308,10 @@ static void handle_singlestep(struct upr
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(current);
 
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* see uprobe_deny_signal() */
-	spin_unlock_irq(&current->sighand->siglock);
+	if (utask->xxx) {
+		set_thread_flag(TIF_SIGPENDING);
+		utask->xxx = 0;
+	}
 
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");

and that is all.

Oleg.

