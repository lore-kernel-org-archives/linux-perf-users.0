Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042661B29C9
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435170; cv=none; b=dwCvoDdREj7Vga0W9c0/lXxqIvocxghSqOtXa3wnua4Bcoqn/JKPB6bmVqzNS5zOJInyLl/UrS3MonB14ptvJdDTuN+TuoQSWLidqYbqQR+46X6hxAsPWewgc5axOJHrFP7cHvEmyygE3cHFc3EaDTMjcwNB8ipcl3JCy6JfwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435170; c=relaxed/simple;
	bh=Zz+2JU1gZn+RJNksX9qA9JVoiTKdjSe1B3qxuuo/L0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtHghn1C1a9QUxRulFyQ7QzI3GA7K6bkF4Wsu1giLuhJ+K2LRmU6R3Ts/kG4FRtry3LrYk1QZzFuG5rLfhs/9bkfn6I+TSohcnwhjGb9affq6TBwn6TS5GPdCWD5/f+zqn0Jn2fMuf05s06H9FkVNbpnIK9CRO1ZYlcqdw0vZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEKM2EiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEKM2EiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722435167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=geNpHNcR5/qllA/FEF4u0Jq+w/nr4b1yAQe+s+buY6s=;
	b=OEKM2EiOGg/MBn5N5rLavvByGUNnVtewNnKUoi07Im0MAzRdbeqW/qUmA++FilpBIwjM0b
	XPUbbCaWPaLC6mWO8qPxleo+b1HlFIF63MZ4GoZIWIW9IHbOlQCQhDmHOEA0zegzMeAbVZ
	WU0qx5ZqYVFfh1KE6wt0J84wF7XZWR4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-DmNa3MIqOWafNcde4BQbZw-1; Wed,
 31 Jul 2024 10:12:43 -0400
X-MC-Unique: DmNa3MIqOWafNcde4BQbZw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A631978F5D;
	Wed, 31 Jul 2024 14:12:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4B5031955E89;
	Wed, 31 Jul 2024 14:12:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 16:12:38 +0200 (CEST)
Date: Wed, 31 Jul 2024 16:12:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mhiramat@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant spinlock in uprobe_deny_signal
Message-ID: <20240731141231.GB16718@redhat.com>
References: <20240731095017.1560516-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731095017.1560516-1-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31, Liao Chang wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>  
>  	if (task_sigpending(t)) {
> -		spin_lock_irq(&t->sighand->siglock);
>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
> -		spin_unlock_irq(&t->sighand->siglock);

Agreed, in this case ->siglock buys nothing, another signal can come
right after spin_unlock().

Acked-by: Oleg Nesterov <oleg@redhat.com>

