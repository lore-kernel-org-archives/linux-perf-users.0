Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CF19923D
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553276; cv=none; b=p/niAI2f5fbJme5HDZPOmyFJuVl+t8O4CLPHdhmIhBwA0GoLiSWlEfsZqsBXcHhxo9oqcJnjxHfrOZ7nkQiTdXYt1e4NWn9KCjHYj9tnEtRDyKlIh2F7AtR/bexrOSkFRv31x0e6zPAjaVmulsCv9LcIWMVUE8d7iCEJw48H8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553276; c=relaxed/simple;
	bh=0KWhrcU0YHbJiksdyGvlsjytVHRYOXJJLdmQ+/bgpig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2is0/Rw1yv3zRQ9o0+JPkDG1tZzBPhnQ72qi5uGaEu1neQfu7g2j8mnnPqrQxEP+xA7QJkF25zR3K59ELv2wcHh4rcrHxsv5xrAJZhuuXTkIKoskXZ51ZFw+Z1hwkB64aaGL3iiyULbu2yxMwmgC/0aO3yhtflUOlx0BYjQ9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CT0Dulfu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT0Dulfu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723553274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XjhAxPmiM++L3njaRU1wOJhxoxtQOjrtQvzpozAwi8=;
	b=CT0DulfuxgFB9gGQBdfwM9QY3QRKaDIUW2nfDQcuYDRNzYH/W1hS4ngTddquhKcXoJ2Kyf
	f7pNUErxPw1hQlv1OG0eq/hCYktbpXj4lKbQgnnb/cJu/wX4ziKec38aoeiLDUcD5UWkSR
	/r3T2zPcCbIc9u6W9tecftHjUEquesw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-9cj9z-qYMRa2lP7hsRm5jg-1; Tue,
 13 Aug 2024 08:47:51 -0400
X-MC-Unique: 9cj9z-qYMRa2lP7hsRm5jg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 329EF1953957;
	Tue, 13 Aug 2024 12:47:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB21F1955F66;
	Tue, 13 Aug 2024 12:47:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 Aug 2024 14:47:45 +0200 (CEST)
Date: Tue, 13 Aug 2024 14:47:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-ID: <20240813124737.GA31977@redhat.com>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-2-liaochang1@huawei.com>
 <20240812120738.GC11656@redhat.com>
 <2971107e-75e7-8438-c858-b95202d7b5ea@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2971107e-75e7-8438-c858-b95202d7b5ea@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/13, Liao, Chang wrote:
>
>
> Oleg, your explaination is more accurate. So I will reword the commit log and
> quote some of your note like this:

Oh, please don't. I just tried to explain the history of this spin_lock(siglock).

>   Since we already have the lockless user of clear_thread_flag(TIF_SIGPENDING).
>   And for uprobe singlestep case, it doesn't break the rule of "the state of
>   TIF_SIGPENDING of every thread is stable with sighand->siglock held".

It obviously does break the rule above. Please keep your changelog as is.

Oleg.

