Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0A35200F
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407084; cv=none; b=vA2yAa43py2d1TYlssTQuhKauhkkqcK7X4H94YxWJ5kvGP0Ymn0ysuWCF/YF5c3mRMoSE7t9+eMnJOfTsaNR8w2se8EYZaNDIaMKPgiL7OEsP7p74b599RvKu+C4BOcZF14reDhbppQHwtWjmjDk8pZD7vauhNk6YEkuGGUMrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407084; c=relaxed/simple;
	bh=J4nB9Al3uidABUjksxa6XMBj/oy8WmJTTsqBQu++jtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDgOLZrV+A84wjqzbf2S+67GCgZDtv0ZCocP8ekZyykeIOOnw5Qvlb6nD+fCTCRQDYH/QupQ3rw1GTyrRiZe7J4jkq0hEfHtLtDOV++PSClF4VDWt81JjPJLB3m7rQaDDOxWel6Y9vIyh9JPc9NFTkaa6zyl/sXcDf0HD7TgBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuC0k+SC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuC0k+SC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792407080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izaJnKxTe0eZ1TUwO9IVgWRI/sGQVVqPLpbyYjGGUVA=;
	b=OuC0k+SCuDkThWnNXH6s6XJ7hDKCI/NFRdoac8PZ+ZHvLGUMKUwauTi8108zrhQjudGvae
	Zf0JYtrCwPoNDUk61qlp0uq8xetFLoW73Mfe5vqljhfXmOfTUzRkaoYZUBtXW/9XBHZSA4
	cfXfVKXO4lxGM3M2Y6C4Ag3ZvzWkADg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-02ITIMlBOMmX2oHJJzxmSw-1; Mon,
 19 Oct 2026 10:51:16 +0000
X-MC-Unique: 02ITIMlBOMmX2oHJJzxmSw-1
X-Mimecast-MFC-AGG-ID: 02ITIMlBOMmX2oHJJzxmSw_1792407074
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEE9C195BDF5;
	Mon, 19 Oct 2026 10:51:07 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8FF5741B;
	Mon, 19 Oct 2026 10:51:03 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 19 Oct 2026 12:51:07 +0200 (CEST)
Date: Mon, 19 Oct 2026 12:51:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Binbin Deng <18983559317@163.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	andrii@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
Message-ID: <atX2FsqHIkOvhrLy@redhat.com>
References: <20261019080709.477548-1-18983559317@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019080709.477548-1-18983559317@163.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/19, Binbin Deng wrote:
>
> consumer_add() publishes a consumer on uprobe->consumers
> before assigning its session ID.  handler_chain() traverses the consumer
> list under the trace RCU read-side critical section and can therefore
> observe the new consumer while uc->id still contains its initial value.
>
> The race is reachable when an uprobe at the same inode:offset is already
> active and a task hits its entry breakpoint while another CPU registers a
> second session consumer.  handler_chain() may store the stale ID in the
> return_instance consumer array.  By the time the function returns,
> uc->id has been assigned a nonzero value, so return_consumer_find() fails
> to match the saved ID and the session ret_handler is incorrectly skipped.

I guess we don't really care, this doesn't differ from the case when
consumer_add() is called right after list_for_each_entry_rcu() in
handler_chain().

But the patch looks "obviously good" to me anyway, so

> @@ -1032,8 +1032,8 @@ static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	static atomic64_t id;
>
>  	down_write(&uprobe->consumer_rwsem);
> -	list_add_rcu(&uc->cons_node, &uprobe->consumers);
>  	uc->id = (__u64) atomic64_inc_return(&id);
> +	list_add_rcu(&uc->cons_node, &uprobe->consumers);
>  	up_write(&uprobe->consumer_rwsem);
>  }

Acked-by: Oleg Nesterov <oleg@redhat.com>

