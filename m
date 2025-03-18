Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8C206F2E
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336104; cv=none; b=Nzbl7uamuaB4qIgp++nK+wJ/78PLFAOjNujw100aGRLVLFhffSFT1pXS4ZzCGMXttKlNJXSVw+1m2FG0AchI15JrBThJxbWB926vRRMV7Jwogg8AnfxmTFXFM/GSEcK7EufoggLj+iew8UmcU0wQ8Gvn21u3SvnCbZQO9u60+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336104; c=relaxed/simple;
	bh=43Ej9z5Ojm/OhbwP/uBJBlEK5SjjkYgcU4ivfBLfqAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROIZyYEFlugMCeQp6/xAR0+rHon2dhKwA6T55+qWuIoiScyBSuztNMb+y7XgEKXOGXkv8z8P+CwmqVyKcLjnVGkcoO/4assZoLVNGnQNTo6+Yf48pCJItDhhGkYuKhJicSmm9SAgYfEX2jQzVtHmM7er9RBKS3doMogEz2ey3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3RVE7Kl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3RVE7Kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k/UAkoyXYAAAj8ppLHSspsrG6Ksk9pE1Zj0H/JtivFc=;
	b=X3RVE7KlxSWJKQP+LZJamD6gQSVPAOX07RMAy0SB38ktIFkeYUqp0ryAgX9zi7xjRWbdex
	rdZdacuFeG+pPsI1F4oLGO3ONzuLM456CZs2CZxahxQChXd62sCp4eDObUbKEBz1nZI8DD
	a37nn0pK1rjpNZGnghmDiVxxxAlyfYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-vcpXVKL3MTG9vgbUqStKpQ-1; Tue, 18 Mar 2025 18:15:00 -0400
X-MC-Unique: vcpXVKL3MTG9vgbUqStKpQ-1
X-Mimecast-MFC-AGG-ID: vcpXVKL3MTG9vgbUqStKpQ_1742336100
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d01024089so30684905e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 15:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336100; x=1742940900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/UAkoyXYAAAj8ppLHSspsrG6Ksk9pE1Zj0H/JtivFc=;
        b=JUY0MtZZeo4F6T+5FiXoDccOXIxwzT3HaYa1zq8byXGYj/3bmHpZBUdtv3ygcqnZq9
         A48YVjlf1GLbzglkLRPlKcaEhF8cabRRhigQ5PYRoy3G53wAAusOXMwdDWPZ3/De6MGB
         jHjseAAQDsOxKPeXOB4M2He3jUu4t9b6uGgQMKMQMPSt9Viwyb2g/E6dRE+V9x92XXYU
         Yv3/NXNRipWLlH1HbsouAxJFcd/9hqn7rHW7wPdTTUYve3w9OISBFr44PWzJYR9+wJDT
         qP8BwcA9ACZ8poin0MEjznqEbSkYar2CaugAtu4Xf3Uhis8cX7h5m79S+TT8S4oFnBjh
         6Slw==
X-Forwarded-Encrypted: i=1; AJvYcCXEqk6jqQtI4AhTDcix83ZpAbuy8NVgeprESKEVS0O5kklTS3S5+vjZJ+X3OrCsRNYK04y2GkrbxklcoFLtBtvz@vger.kernel.org
X-Gm-Message-State: AOJu0YyinJZFwwWmY1qTNwmxX+e3ve8n2CQqBDl5Q4opnrrSA4i9Mb9S
	uHo6GZI5XAAewHpfI+53nwXshI7TJl7QP/3mxI+pmvZV/KJytKLmP1xaeM24KJpu6LGuYFtsXw6
	BYJp1T8m+PIJTdGxw02xyhjzR8W034LOMzbyN8D+l2PV50wp05rEMvUkJGFzi64x9r+s=
X-Gm-Gg: ASbGncuuNEIALLJ/BXAqo6kC9qst11zaEaXTjAy3obi0VwO/biqmfxUxiER6ayHpGWB
	wl9j5oe3Gms/yPgTegMKXJaCKtQKOWyfx5CjDjX+BHEPFbX+VGcjv2dzxCJBO/5OpAPHxMAnmHo
	uzZaWrDhc54eU6D+4hBkWaIHCR5NdECYU4D1OrKSnMvy1wC0U6lm0xUS6dTZJ8uHc+NJeOuccgx
	OkEDQMvNT0K1twVp9b+X0wFKJCP94+SujCY+FhaygbjhueN9ng3deuqpgcqCbIKagJiF3CsVJbN
	hYdTFwvJiUqh7EXZgrByE5TSY7nUA8lRvsFcxdD36wiZN2q+18W3h69Eo+720BRabFhSBZsSupN
	+
X-Received: by 2002:a05:600c:5250:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43d43781e4emr2289895e9.2.1742336099684;
        Tue, 18 Mar 2025 15:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4p4iEcIpIkoqdTFEFOZVeOZYDgFaQD/Z05qK3YULm0myWGBlzWfRjIZbHbmsiH0EHYYUrsQ==
X-Received: by 2002:a05:600c:5250:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43d43781e4emr2289795e9.2.1742336099275;
        Tue, 18 Mar 2025 15:14:59 -0700 (PDT)
Received: from localhost (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f556a4sm317825e9.22.2025.03.18.15.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:14:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v2 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Tue, 18 Mar 2025 23:14:54 +0100
Message-ID: <20250318221457.3055598-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on mm/unstable.

Currently, uprobe_write_opcode() implements COW-breaking manually, which is
really far from ideal. Further, there is interest in supporting uprobes on
hugetlb pages [1], and leaving at least the COW-breaking to the core will
make this much easier.

Also, I think the current code doesn't really handle some things
properly (see patch #3) when replacing/zapping pages.

Let's rewrite it, to leave COW-breaking to the fault handler, and handle
registration/unregistration by temporarily unmapping the anonymous page,
modifying it, and mapping it again. We still have to implement
zapping of anonymous pages ourselves, unfortunately.

We could look into not performing the temporary unmapping if we can
perform the write atomically, which would likely also make adding hugetlb
support a lot easier. But, limited (e.g., only PMD/PUD) hugetlb support
could be added on top of this with some tweaking.

Note that we now won't have to allocate another anonymous folio when
unregistering (which will be beneficial for hugetlb as well), we can simply
modify the already-mapped one from the registration (if any). When
registering a uprobe, we'll first trigger a ptrace-like write fault to
break COW, to then modify the already-mapped page.

Briefly sanity tested with perf probes and with the bpf uprobes
selftest.

v1 -> v2:
* "kernel/events/uprobes: uprobe_write_opcode() rewrite"
 -> hold GUP reference longer so we can see if the page is still
    mapped when performing the folio_walk
 -> Move anon-folio check
 -> Reshuffle / cleanup some related things

RFC -> v1:
* Use folio_walk and simplify the logic

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>

[1] https://lkml.kernel.org/r/ZiK50qob9yl5e0Xz@bender.morinfr.org

David Hildenbrand (3):
  kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
  kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and
    uprobe_write_opcode()
  kernel/events/uprobes: uprobe_write_opcode() rewrite

 arch/arm/probes/uprobes/core.c |   4 +-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        | 356 +++++++++++++++++----------------
 3 files changed, 186 insertions(+), 180 deletions(-)


base-commit: 40caf747267c18b6206e26a37d6ea6b695236c11
-- 
2.48.1

