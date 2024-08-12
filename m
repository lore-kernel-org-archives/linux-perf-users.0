Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B580C
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456848; cv=none; b=X3trrCaiqbIYs13j/dHEs/Evii1uOhSoH8GZmOuqLREDQ5o+Rox4lVKYu//a1wEkgTCdOjBnO5Ggo/dqzW5VICuw66hiiEpnk/+itbiyEgwGDvhfZH3f9Jur8Su9mq2bPqc27fxlY5wpqL7OEFizKbtx2e5V6E1ntkcQ8SFKGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456848; c=relaxed/simple;
	bh=1ScUciWogHjmKRVSwQmXQGyugl3YVgp7XQoDiei4zcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgvC+rleELOGqrwZS+xeeu+8Fppb6MPtBMW4URplT2pWYPlCGjanbqS91HI/yK301tyFuKcGXDAnPKkBRPbpqFE61SnjdKco1604UglQx7QFHpiS3bcQR+pGBcBnJZhQEQG8jau6ThN9rWTdjDi2O+zv18IxDCV9Oq5dTn767/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNgH9La9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNgH9La9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723456846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f81rvnkheDUqXD/+ZGX/tQ13uHZx0W8+/XahKIlC0eU=;
	b=XNgH9La982QjBNHNseMWSFv/uTyvTcjHL7oOjZzI1ZC7blq4m5MWA/doOXl965dfqVYSqp
	MiuVZiNDfVtM3pAAdiWmrLEcHZU6Q59xcY4T2Ap/eibgc6kaSd3gHMr9VH0nb9jP93c4/Y
	9RuTB7DXAZet5T52J1Duw2rJhe7+cwk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-CP-IX_DpNxGWY2QmQJbCSg-1; Mon,
 12 Aug 2024 06:00:42 -0400
X-MC-Unique: CP-IX_DpNxGWY2QmQJbCSg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA87418EB230;
	Mon, 12 Aug 2024 10:00:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9161430001A1;
	Mon, 12 Aug 2024 10:00:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 12 Aug 2024 12:00:36 +0200 (CEST)
Date: Mon, 12 Aug 2024 12:00:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org,
	acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in
 __uprobe_unregister
Message-ID: <20240812100028.GA11656@redhat.com>
References: <000000000000382d39061f59f2dd@google.com>
 <20240811121444.GA30068@redhat.com>
 <20240811123504.GB30068@redhat.com>
 <CAEf4Bza8Ptd4eLfhqci2OVgGQZYrFC-bn-250ErFPcsKzQoRXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza8Ptd4eLfhqci2OVgGQZYrFC-bn-250ErFPcsKzQoRXA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/11, Andrii Nakryiko wrote:
>
> On Sun, Aug 11, 2024 at 5:35 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Something like below on top of perf/core. But I don't like the usage of
> > "i" in the +error_unregister path...
> >
>
> Wouldn't the below be cleaner?
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cd098846e251..3ca65454f888 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3491,8 +3491,10 @@ int bpf_uprobe_multi_link_attach(const union
> bpf_attr *attr, struct bpf_prog *pr
>         }
>
>         err = bpf_link_prime(&link->link, &link_primer);
> -       if (err)
> +       if (err) {
> +               bpf_uprobe_unregister(&path, uprobes, cnt);

I disagree. This code already uses the "goto error_xxx" pattern, why
duplicate bpf_uprobe_unregister() ? What if another "can fail" code
comes between register and bpf_link_prime() ?

See the patch below, on top of perf/core.

> We should probably route this through the bpf tree, I don't think it
> will conflict with your changes, right?

It will conflict, and in this sense it is even worse than the "#syz test"
patch I sent in https://lore.kernel.org/all/20240811125816.GC30068@redhat.com/

Because with your version above the necessary change

	-	bpf_uprobe_unregister(&path, uprobes, cnt);
	+	bpf_uprobe_unregister(uprobes, cnt);

won't be noticed during the merge, I guess.

So can we route this fix through the perf/core ? I'll add "cc: stable",
in the next merge window the Greg's scripts will report the "FAILED"
status of the -stable patch, I'll send the trivial backport in reply.

No?

Oleg.
---

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e391daafa64..90cd30e9723e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3484,17 +3484,20 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 						    &uprobes[i].consumer);
 		if (IS_ERR(uprobes[i].uprobe)) {
 			err = PTR_ERR(uprobes[i].uprobe);
-			bpf_uprobe_unregister(uprobes, i);
-			goto error_free;
+			link->cnt = i;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(uprobes, link->cnt);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);

