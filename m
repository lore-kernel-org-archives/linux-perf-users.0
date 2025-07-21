Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E52D29D0
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100009; cv=none; b=ZQ7vcoN+mDvIa6ZWj5fCO+iGHdtZODurqPHVRXeOT/8Cr5YXxpkVS8oFhAgwLkHgbOvcpTtPWHw89iBX9Vjx9KhMjbcdbFcsz54M0atqIH5qpMCgsCpAkipf7IdEjSAAX2ntT6PVjX3+Safgnkuv+KGjdZrZdS9zS+hFWiPzDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100009; c=relaxed/simple;
	bh=yitnVELvPZrl9kJzEJ3evpeFvAyCI1qpZpqh8TcgpK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur0vY3ZXvy3AturlzamVN/4GxeDzBTD/aNDOj3PGkz9yGYhCV+LAV7xIr1yCB3lbb455w8/U6tCyhJp0triucPBLgxo8mXSi2zeHp6G0Fvme4kzL9fk6mdtTvN1wTPw9heqNxFzgvTb3JMP7tBENJtffJTcKoS7eVXlkRp00HEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Stb6bYqY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Stb6bYqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753100007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ta1/ZRWHT/l8avUYx5LtTpB/ZV0kiQEs9bubnUIR0Y8=;
	b=Stb6bYqYcX5aRhf2XJWpO81m3mpUb+JrAAokaoyVq6Ha19q75AvkNjAswhtrSnQv8vtIkg
	cEpQYZ4nzoiRqzg8rQ3rOzVuXpr4ZNsrGJZL/ieI1Gc66gMR+rbYYDuIGcFnpFUjRwZhDr
	RZgL/HrDLFdz1JbCsigBjFjFK/hGcB8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-qrWwy5AtOp2t3mK0UwxGnQ-1; Mon,
 21 Jul 2025 08:13:21 -0400
X-MC-Unique: qrWwy5AtOp2t3mK0UwxGnQ-1
X-Mimecast-MFC-AGG-ID: qrWwy5AtOp2t3mK0UwxGnQ_1753099999
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68FB318002A0;
	Mon, 21 Jul 2025 12:13:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C45A19560AD;
	Mon, 21 Jul 2025 12:13:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Jul 2025 14:12:23 +0200 (CEST)
Date: Mon, 21 Jul 2025 14:12:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] uprobes: uprobe_warn should use passed task
Message-ID: <20250721121208.GA16561@redhat.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-9-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719043740.4548-9-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/18, Jeremy Linton wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -121,7 +121,7 @@ struct xol_area {
>
>  static void uprobe_warn(struct task_struct *t, const char *msg)
>  {
> -	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
> +	pr_warn("uprobe: %s:%d failed to %s\n", t->comm, t->pid, msg);
>  }

Acked-by: Oleg Nesterov <oleg@redhat.com>

