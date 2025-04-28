Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B1255233
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745831259; cv=none; b=roAhkU93IPoWT9/BA/ZXXKK7pjBVolsrE2PLU1x7pWY27B7laf9YHez3cm9pliKTrnIglqY6mUHwaaQ0wrx0K7/6d/UbyN7aaSfdM/uyNejdAXConkGcCzyD/RHFkW04bbhUWfmQUivbtb3bnciRIMqDkRppNZYTlVCS/pe7Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745831259; c=relaxed/simple;
	bh=UybRkzn8WVqdE1THG5SNswNLOWS8DckJhCs42e2ygxw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dZu99sDevwIMlaZdE8Psn/QtbyNMA4b0aDj6Lx++n1ZbwGtBges/zsqxZugWkgSo4KJmBe/1wh62rO+PEMUoeyaVucRIT/UFvmmm65s3L175111GsmQ8qin82sNcf/Apa6/AHohm6E1er6uZOthu1tBJaBlQJi9TQldObbaCRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASzDjqxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASzDjqxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745831256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=U83a+nTlEFAKC2Rdyrq3VHyIzU428c5fHiV27cVYo1k=;
	b=ASzDjqxwtqn5JqsL6g/yyqDfHbt5eQaUNrh6X7YoTBWPtvhaJ+m3krrDHNor+5yLMa1XO5
	/V5VCumCsxC1ISU8bcqWvqt4ie1RxJKBMfa42SgH6OytGx8aPtlHX43hUIRY2P5sG8PbE9
	q9RXOHaqdKqG5q4DG572l7yl3uJ72rE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-UykiFHDCO66cSTmTiyHiXQ-1; Mon, 28 Apr 2025 05:07:34 -0400
X-MC-Unique: UykiFHDCO66cSTmTiyHiXQ-1
X-Mimecast-MFC-AGG-ID: UykiFHDCO66cSTmTiyHiXQ_1745831254
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac28f255a36so309438366b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 02:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745831254; x=1746436054;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U83a+nTlEFAKC2Rdyrq3VHyIzU428c5fHiV27cVYo1k=;
        b=vbe04n9ZtV/txOI9Pq3l908rSO6ZCj2HTa/RPyebCI6rPzCNOI+AMbBKaz0i0oEpmg
         Gl+t3oWGSAFjF2eKcbNCD0D4e33uVt6Fw8Hy0sUGwe+k61Lv7e0XQdf+8UJeth2UIm+W
         tntR+jzpoWXs5l94l85MVjicLv6D86SJ4RoAWYZHgWaTpBnz/aGc2SwYSyJU5byi9+UQ
         +r3ZQscPZRHZ9Frlw630LNRNW0i+y/btpHf4cwPov+aHhvhtJhqDNc+wO7Uyc9Zu+2Ur
         EuvSIcYnWwwZpHJdBRqjEyNzC31M0ZbcNzgUpLM8y+bn4XbnVFIrcyuh9+11qkxRJvvu
         wNrg==
X-Gm-Message-State: AOJu0YzczqPVaSuWWhF5Ug0TjWDjGxkegTfydaudpgiTuWjRzlwRUAmg
	vmnFVpBD1U7zZ+J5CUaF8duXnEYS8ltZh0kqiovuIj9UXovqYFB4wo2vxwDvVyQePo1tSV9CU4p
	0fMaMbhYYLADy8b7BMvE5go0GMskemYWEfZRWgaBnj67NmzC7QwwN9U1Uvo7frmQTRKsL6c5YXH
	YMpzwDx7G5wn45FaxPpzaUCg2RO37aC6usNYQPsZ0shA==
X-Gm-Gg: ASbGnculdtXmzfftNDvdO2KImmySDyH+dSQBXOyNlOyYdzlQziSe5i+viQ09WAtMvPY
	+XK3tqHLQtAmyZJIWkXBDE5Fi7yJw/EzNPx0KfVjOE0dSIKWQzz1w5jhkZZgLbZHJZ5Cd/MgI0H
	LxoX1em1EWeSvvMUyZezELFvE=
X-Received: by 2002:a17:907:1b22:b0:aca:a687:a409 with SMTP id a640c23a62f3a-ace71098d4bmr1075264066b.17.1745831253629;
        Mon, 28 Apr 2025 02:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgYwmPlIC7YgpE+PSFxKMe//ba9PVWCueXky1f4Hyp24q1RjJNcmUjYtJUZ28R0eTkQQ9mALmDyYJsqSo+HHM=
X-Received: by 2002:a17:907:1b22:b0:aca:a687:a409 with SMTP id
 a640c23a62f3a-ace71098d4bmr1075261666b.17.1745831253261; Mon, 28 Apr 2025
 02:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 28 Apr 2025 11:07:21 +0200
X-Gm-Features: ATxdqUGbtYEpyFOd5glkWz-aR-UH1QxYr3tYPCWdrrc_cIW_rAu4Jj2afo2Hfp8
Message-ID: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
Subject: [BUG] perf segfaults when combining --overwrite and intel_pt event
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Wander Costa <wcosta@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Dear maintainers,

I would like to report a bug in perf I ran into when trying to combine
--overwrite and intel_pt on latest perf from 6.15-rc4:

$ perf --version
perf version 6.15.rc4.gb4432656b36e
$ perf record --overwrite -a -e intel_pt/cyc,noretcomp/k
perf: Segmentation fault
Obtained 16 stack frames.
perf() [0x59aab7]
perf() [0x59ab97]
perf() [0x41a9db]
/lib64/libc.so.6(+0x1a050) [0x7f7fc2e27050]
perf() [0x61bb16]
perf() [0x55fee9]
perf() [0x54a790]
perf() [0x469c92]
perf() [0x46a09f]
perf() [0x46a317]
perf() [0x54ac83]
perf() [0x41c61c]
perf() [0x41c92c]
perf() [0x41cc65]
perf() [0x41ff41]
perf() [0x424015]
Segmentation fault (core dumped)

GDB gives the following backtrace:

(gdb) bt
#0  0x000000000061bb16 in auxtrace_mmap__mmap (mm=0x7c9fa0,
mp=0x7fffffff9008, userpg=0x7ffff7cff000, fd=7) at util/auxtrace.c:136
#1  0x000000000055fee9 in mmap__mmap (map=0x7c9f40, mp=0x7fffffff8ff0,
fd=7, cpu=...) at util/mmap.c:312
#2  0x000000000054a790 in perf_evlist__mmap_cb_mmap (_map=0x7c9f40,
_mp=0x7fffffff8ff0, output=7, cpu=...) at util/evlist.c:825
#3  0x0000000000469c92 in mmap_per_evsel (evlist=0x78f190,
ops=0x7fffffff8fd0, idx=0, mp=0x7fffffff8ff0, cpu_idx=0, thread=0,
   _output=0x7fffffff8f10, _output_overwrite=0x7fffffff8f14,
nr_mmaps=0x7fffffff8f0c) at evlist.c:527
#4  0x000000000046a09f in mmap_per_cpu (evlist=0x78f190,
ops=0x7fffffff8fd0, mp=0x7fffffff8ff0) at evlist.c:620
#5  0x000000000046a317 in perf_evlist__mmap_ops (evlist=0x78f190,
ops=0x7fffffff8fd0, mp=0x7fffffff8ff0) at evlist.c:679
#6  0x000000000054ac83 in evlist__mmap_ex (evlist=0x78f190,
pages=4294967295, auxtrace_pages=1024, auxtrace_overwrite=false,
   nr_cblocks=0, affinity=0, flush=1, comp_level=0) at util/evlist.c:977
#7  0x000000000041c61c in record__mmap_evlist (rec=0x764de0 <record>,
evlist=0x78f190) at builtin-record.c:1310
#8  0x000000000041c92c in record__mmap (rec=0x764de0 <record>) at
builtin-record.c:1359
#9  0x000000000041cc65 in record__open (rec=0x764de0 <record>) at
builtin-record.c:1413
#10 0x000000000041ff41 in __cmd_record (rec=0x764de0 <record>, argc=0,
argv=0x7fffffffe0f0) at builtin-record.c:2492
#11 0x0000000000424015 in cmd_record (argc=0, argv=0x7fffffffe0f0) at
builtin-record.c:4285
#12 0x0000000000461133 in run_builtin (p=0x769260 <commands+288>,
argc=5, argv=0x7fffffffe0f0) at perf.c:351
#13 0x00000000004613a2 in handle_internal_command (argc=5,
argv=0x7fffffffe0f0) at perf.c:404
#14 0x00000000004614f1 in run_argv (argcp=0x7fffffffdedc,
argv=0x7fffffffded0) at perf.c:448
#15 0x00000000004617d7 in main (argc=5, argv=0x7fffffffe0f0) at perf.c:556

Further investigation shows the range associated with userpg, to which
the statement at util/auxtrace.c:136 attempts to write to, is mapped
read-only:

(gdb) info proc mappings
...
0x00007ffff7cff000 0x00007ffff7d80000 0x81000            0x0
     r--s  anon_inode:[perf_event]
...

Compare to a run without --overwrite, where the memory is writable and
everything is good:

(gdb) info proc mappings
...
0x00007ffff7cff000 0x00007ffff7d80000 0x81000            0x0
     rw-s  anon_inode:[perf_event]
...

Let me know if you need any more information.

Tomas

