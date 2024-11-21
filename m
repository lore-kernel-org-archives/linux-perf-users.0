Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D791CCB26
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197279; cv=none; b=mH/DFIcwFSVqAQdj804yJGegKYemsHhVteqodhkaKxpBjLHlByjonVGlVVT0lStNGwwDr+BpDm0JTxhJuG9DBeUMdxzXH848nbMVwc4/lerZKwj1twxkddxzZ8m5cdT++cGGHW7OJc57OCJDezGtcEor3C591SF+wfYpzIE4DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197279; c=relaxed/simple;
	bh=ckGDtWQ7xnPCKX7UWVOjOwW90B8HXxkyhckrW2lzimM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=mvwcSoNANH1qQpsPA7/zAUc/8VBehBY7wTqhOyDwqvFeiu/1EmRPfDN9B8hTEpb5+p2c687fy3CAZaq8FqAtJeqLsnVEYLFN6gDfZGCYrB/F43muuUU7H1V0I/EFwKX5wYlyFjNN25PthPJolg3bRBgHGT814fCKySjXP7kWJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrYtNzp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrYtNzp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732197275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=admXrOyUiaUIuKv1h91NOlEOC+GPwsnY8taZxlBKTEk=;
	b=MrYtNzp1VbAOqqICA/xsUdDOGGtjoGW6FIXRIn/eGO1PvAWy80k68F6KxLrqn4s2IhMP+E
	+QBF1ktgZTDJMy0QtGhmdFxAArqcZEr62eYGHzJu8FlnE9V0Pmiajt1umLKodtqzVWQolY
	R1GTC5zPRLlphOjZW6/gW9HvWvy0A60=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-20J9uDJhP9GULz7y-FRaog-1; Thu,
 21 Nov 2024 08:54:32 -0500
X-MC-Unique: 20J9uDJhP9GULz7y-FRaog-1
X-Mimecast-MFC-AGG-ID: 20J9uDJhP9GULz7y-FRaog
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ED091955E88;
	Thu, 21 Nov 2024 13:54:30 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08AB819560A3;
	Thu, 21 Nov 2024 13:54:28 +0000 (UTC)
Date: Thu, 21 Nov 2024 14:54:25 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: rostedt@goodmis.org
cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Subject: perf kmem --page stat and gpf_flags translation
Message-ID: <87be5f7c-1a0-dad-daa0-54e342efaea7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Steve and others,

We have found out that perf kmem --page stat sometimes fails like the
following:

# perf kmem --page stat
0x2aa28 [0x8]: failed to process type: 68 [Operation not permitted]
error during process events: -1

This seem to happen on s390x KVM machines.

When we tried to investigate for the reasons, it seems that the problem
is caused by incorrect/unexpected translation of gpf_flags for event
kmem:mm_page_alloc.

# perf script
perf   96553 [003] 100299.663963: kmem:mm_page_alloc: page=0x1a8f9 pfn=0x1a8f9 order=0 migratetype=0 gfp_flags=0x500cc2
perf   96553 [003] 100299.663995: kmem:mm_page_alloc: page=0x1bc3f pfn=0x1bc3f order=0 migratetype=0 gfp_flags=0x40cc0
perf   96553 [003] 100299.664001: kmem:mm_page_alloc: page=0x1a9d9 pfn=0x1a9d9 order=0 migratetype=0 gfp_flags=0x40cc0
perf   96553 [003] 100299.664011: kmem:mm_page_alloc: page=0x1788b pfn=0x1788b order=0 migratetype=0 gfp_flags=0x40cc0
perf   96553 [003] 100299.664023: kmem:mm_page_alloc: page=0x17993 pfn=0x17993 order=0 migratetype=0 gfp_flags=0xcc0

On another machine to be compared against, we get the gfp_flags
translated as following:

[...]
perf 1440545 [007] 37432230.091272: kmem:mm_page_alloc: page=0x10d876 pfn=0x10d876 order=0 migratetype=0 gfp_flags=GFP_HIGHUSER|__GFP_ACCOUNT
[...]

When we dig into the translation process, we get into libtraceevent (which
we have in 1.8.2 version), we get into:

     4796 static void print_str_arg(struct trace_seq *s, void *data, int size,
     4797                           struct tep_event *event, const char *format,
     4798                           int len_arg, struct tep_print_arg *arg)
     4799 {
[...]
     4876         case TEP_PRINT_FLAGS:
     4877                 val = eval_num_arg(data, size, event, arg->flags.field);
     4878                 print = 0;
B+   4879                 for (flag = arg->flags.flags; flag; flag = flag->next) {
     4880                         fval = eval_flag(flag->value);
  >  4881                         if (!val && fval < 0) {
     4882                                 print_str_to_seq(s, format, len_arg, flag->str);
     4883                                 break;
     4884                         }
     4885                         if (fval > 0 && (val & fval) == fval) {
b+   4886                                 if (print && arg->flags.delim)
     4887                                         trace_seq_puts(s, arg->flags.delim);
     4888                                 print_str_to_seq(s, format, len_arg, flag->str);
     4889                                 print = 1;
     4890                                 val &= ~fval;
     4891                         }
     4892                 }
b+   4893                 if (val) {
     4894                         if (print && arg->flags.delim)
     4895                                 trace_seq_puts(s, arg->flags.delim);
     4896                         trace_seq_printf(s, "0x%llx", val);
     4897                 }
     4898                 break;

Here in the for loop, we try to apply all the known GFP flags to the
value and if it matches, the flag name is added to the resulting string.
If it does not match (line 4885), finally a fallback solution is used
and the hex number is printed (line 4896).

The reason why it does not match any GPF flag is because the values seem
to be incorrect, so while val == 0x500cc2, the values in flags are 0 or 1:

(gdb) p *flag
$53 = {next = 0x15c3020, value = 0x15c34a0 "1", str = 0x15c2dd0 "GFP_HIGHUSER"}
(gdb) p *flag->next
$54 = {next = 0x15c3ce0, value = 0x15c3740 "1", str = 0x15c3c20 "GFP_USER"}
(gdb) p *flag->next->next
$55 = {next = 0x15c32c0, value = 0x15c2e30 "1", str = 0x15c3800 "GFP_KERNEL_ACCOUNT"}
[...]

which is obviously wrong. On the other machine the values made more sense:

(gdb) p *flag->next->next->next
$133 = {next = 0xee5630, value = 0xee57b0 "1051842", str = 0xee5930 "GFP_HIGHUSER"}
(gdb) p *flag->next->next->next->next
$134 = {next = 0xee5c90, value = 0xee5690 "1051840", str = 0xee62d0 "GFP_USER"}
(gdb) p *flag->next->next->next->next->next
$135 = {next = 0xee5990, value = 0xee5270 "4197568", str = 0xee60f0 "GFP_KERNEL_ACCOUNT"}

...

I am wondering where these values come from and where they are possibly
incorrectly set.

Any ideas?

Thanks!

Michael

