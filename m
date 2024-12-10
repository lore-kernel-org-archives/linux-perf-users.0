Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771392343AC
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849658; cv=none; b=pKB7iLsUqtRNa3AZ76ngy0K72kudpqYSkIH+OFCX7mcefcUCKmP6Kp/t0b0SVwIaNxAKYCVyfKq2raz0HR34YHvMpGNw1Eog1yZD20ijvDU0U1EL3/NLOVibBmfXdR+n/k0fSiksYQZ4D74EwiFLlsyny5sXzq1wqMj/GjpN574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849658; c=relaxed/simple;
	bh=3sn7QlcYPVrIalne+GpOHpJwfF0reHhkLV2yJqlqG7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u86bu7yQPfXl8GnD3KdEsd5++fONY7twQMXy3scQjeeHkmohUyvlg1I1+LWo0SBeWPLOcsqnhnhSPLn3ZsU2c4GyCY9F9w43he5eMxjNYEb5SebH8QsA+s+fm/Yvtt3RLR4BAeUM+vk/0wxAArrqq3E9DZn5UXICk3xk2U9cGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc5lygAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc5lygAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYgy4fScGjSMekKKz7zapMxNc5WYY7jYizVCi92CPVg=;
	b=Cc5lygAwY6QqdUkC5RT/QSpveLB245B5+T0fu3u7Jcz7ZWprtJlydUCA+3RmJeCStO1BQ6
	wUhC7OKoYa4WJH1SBxrmECKCzjMqd3kwzWp7DQ9IdTrgUVJRrP+wDoOouxB4Z7PgMoKH74
	MrHmRYU08OPXuFazMI/NIJ76KBmyAGs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-Pcjwg3CCMr-5zOAySgSt3g-1; Tue,
 10 Dec 2024 11:54:10 -0500
X-MC-Unique: Pcjwg3CCMr-5zOAySgSt3g-1
X-Mimecast-MFC-AGG-ID: Pcjwg3CCMr-5zOAySgSt3g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3AE11955BF9;
	Tue, 10 Dec 2024 16:54:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F15341956089;
	Tue, 10 Dec 2024 16:53:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 10 Dec 2024 17:53:43 +0100 (CET)
Date: Tue, 10 Dec 2024 17:53:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] fork: avoid inappropriate uprobe access to invalid mm
Message-ID: <20241210165334.GB31266@redhat.com>
References: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I must have missed something, but...

On 12/10, Lorenzo Stoakes wrote:
>
> @@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm_init(mm, tsk, mm->user_ns))
>  		goto fail_nomem;
> 
> +	uprobe_start_dup_mmap();
>  	err = dup_mmap(mm, oldmm);
>  	if (err)
> -		goto free_pt;
> +		goto free_pt_end_uprobe;
> +	uprobe_end_dup_mmap();
> 
>  	mm->hiwater_rss = get_mm_rss(mm);
>  	mm->hiwater_vm = mm->total_vm;
> @@ -1758,6 +1755,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> 
>  	return mm;
> 
> +free_pt_end_uprobe:
> +	uprobe_end_dup_mmap();

if dup_mmap() fails and "mm" is incomplete, then with this version dup_mmap_sem
is dropped before __mmput/exit_mmap/etc. How can this help?

Oleg.

