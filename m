Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE914D8C1
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Aug 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379722; cv=none; b=DMu6RTwE3TtBDZJx9ojtODZ1hYVX9fJbeNcEIMMCnEOJwoZueskwMhIl2vHliRykq6W5CO275fI7i3M9lE+a8x+0Hpvlx7DexYSEk/9vHNG+COjeScbJMtAp8ubmih1w6CrUovsGe8wNm9kzRYoy1eVvOfHTFT4SLL8evCOSZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379722; c=relaxed/simple;
	bh=8HbDmLL+NTBeeBc0mZ30qbLS+R+pE60UQRFzXh0Qd40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKZCd5KAT7OF0ctCv5yNpGUopncGFOh9RYr0UO+ouwpE39U9+/F9eAe6FazgfCvnTWbDWTM5U9si/YkecZSmIfIfL/cKTgbUpBo7cWMzQTvRvxUufTjEQAkGdZ9FC6PoETdQLXUkEVpbWS/TsL2lGkR+OxoViCORdyXAE+yA8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYOFdVh4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYOFdVh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723379720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHlXnDYMSxlvXOLG5yqCHeaThdF+GjL3IUfr75SJ08A=;
	b=RYOFdVh4Gn3i6AeimSIxoE8JewQ3lozLF3IaqOYp4bJgRLtewLEndqR6uZeBYaV4gIaB0r
	gXt3UG10h8MoBqvvvYDmEuoxTcL5HbaNBgvygSSd4TXJPfixXIfomgmmxMdjgjg55CPP5M
	PWFdnchnwr63yk3D3bMuWv6zAuoRpS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-H9lsxKNuPV-qWIxBFCY7Sg-1; Sun,
 11 Aug 2024 08:35:16 -0400
X-MC-Unique: H9lsxKNuPV-qWIxBFCY7Sg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ABCF195609E;
	Sun, 11 Aug 2024 12:35:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1F5A219560AE;
	Sun, 11 Aug 2024 12:35:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 11 Aug 2024 14:35:11 +0200 (CEST)
Date: Sun, 11 Aug 2024 14:35:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in
 __uprobe_unregister
Message-ID: <20240811123504.GB30068@redhat.com>
References: <000000000000382d39061f59f2dd@google.com>
 <20240811121444.GA30068@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811121444.GA30068@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/11, Oleg Nesterov wrote:
>
> Hmm, bpf_uprobe_multi_link_attach() looks obviously wrong.
>
> bpf_link_prime() is called after the
>
> 	for (i = 0; i < cnt; i++) {
> 		uprobe_register(...);
> 		...
> 	}
>
> loop. If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() just do
> kvfree(uprobes) without _unregister(). In particular, this leaks the freed
> bpf_uprobe->consumer in the uprobe->consumers list.
>
> After that another _unregister() on the same uprobe can hit the problem.
>
> I guess we need a simple patch for -stable...

Something like below on top of perf/core. But I don't like the usage of
"i" in the +error_unregister path...

Oleg.

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3486,17 +3486,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 						    &uprobes[i].consumer);
 		if (IS_ERR(uprobes[i].uprobe)) {
 			err = PTR_ERR(uprobes[i].uprobe);
-			bpf_uprobe_unregister(uprobes, i);
-			goto error_free;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(uprobes, i);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);

