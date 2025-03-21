Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66613155753
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557041; cv=none; b=ZfTLq9uxBhq6PZBBjo7ZDRcD3+CF4ou6I6r+SAmgzEjuNXHUBWwmGyVGBkYby/K6xo6iAh9Z9X0/aPxNF/bscxuV3r9Gc+1NsbKIze/3CgQEvbrDxxas6DoAfQ64EASsr00h5Dnn8WgAyjJy297R3TTuWAC5h2IwmTBRh7uVGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557041; c=relaxed/simple;
	bh=giZf/ZqxDThvabf1JZYnln3QCcq9MlMPQorYaLv0RmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9UgM3eV04Eh81X/GKzv0nztQYjqSPIIVkQpiYq7h8osEiQiZL/ULHzyIIcv4bT7saNJrffc9UZj59xWTjF3B1QnBDUn6yELwyZPjGEGyR6tG4bVQ2UWKxbqWGzCeLglgbWVRxR2w//TIDwTFMbdsKNpKGIl/XNgN+najSd1Ma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0ZEyXj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0ZEyXj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x+mJBPP4OyRbz1YPHbK6SqYX7BZklQ1ziSixoz9Cwdg=;
	b=f0ZEyXj9OL3vuaiftWhQU6VeXkYKGIWuxYavxXD6au+h4fDjl3oRy7CNZ3XkeEbXwFuwI2
	N3SvD0ypZgp5uPj2oHA6BVP0u2jdTKeL709FNt8seegV2WV3frQAf/2rUsV2JkDYXWBi/d
	0GvTuTWHMCRRktY7FjBL2JtyWxPFi6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-eMuw0GNXOdaq2hdyEuCwQg-1; Fri, 21 Mar 2025 07:37:17 -0400
X-MC-Unique: eMuw0GNXOdaq2hdyEuCwQg-1
X-Mimecast-MFC-AGG-ID: eMuw0GNXOdaq2hdyEuCwQg_1742557036
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so11904115e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 04:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557036; x=1743161836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+mJBPP4OyRbz1YPHbK6SqYX7BZklQ1ziSixoz9Cwdg=;
        b=akioJoIjirTRyoikD2Ar7T4opycG+zzW9fT0HFmVpzRujQSc01ZGDj4hLnNRZJGYBW
         17XDx3oEyN5xfUjEO3CxyB05ARTvXzjUp6xvM1vbq2mSJWODDw2bDYotsu/2yJ9+IWut
         F9jUjiX7baDDpHSYK/6P1Tw0qhhoK7yaWcUi52QIn57TFEFHja+TB0t+RQq6v8RwsQd/
         dn1CJzA2wmAegGOQCSXD1eqwFp03S0TL1O/FlwkHQnBx3YNGNlK0krs4rPDXS/00RxeG
         JgI5iObXj3oCJTMg9PzBfWFm/9a47SQPXy3UTXCCOBDZ2zArGH4zAncxtJyJXRSVS8U+
         aOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXj+oGEt/kT0bNwPXZykK47EjFKOz45KgcxWg8+/3Bx9IT0sYwOFp7mgFf3fbNmaSS6KTmtLLZWd0cvBYO7Cq5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bvRBwt1YGBJZPCqunbx+Ad6JEQ34PlP2rJ1JqbFPK0ASO4c2
	rp+tUm2G5yl6AIAwFsW+FY0fDq0E8qYBEKvBhiKiN5S63krYW/JWbLXPxt0cN+gon7j3O/+n2jI
	P7jHrg2F23dqPKogdlqNMYBua7ruZvZ9FsffGCbvCMfpqIi+6O4wdJ9rmW6XX6bez1Nk=
X-Gm-Gg: ASbGnctHbhXJ3NM9iI8kpQs1N2Y5XcCDSsm2mzaDv4UsaEtwh4hIRtggRQJVrnHu9oF
	3kNGk3/bS49hP00OikpGpKpkNpGpCpTFo7br0umfYkqLIh1fkg4oM0ul+kIvsy2aqi91TCzqyKh
	Rec5pxWnwp76TLDze6C347DG5bRJIasDY2wqmXeea9cbrhwLDgjA7J+1UNGwiW4+To/9vTH6ZFy
	8uEC1N7wMWLuBoDzbM/OmxpN828cx3nqUQWumZzTE7MNZbHCM1RadmH8khFFukclyKyWWqDvI7p
	aLy9OtYnlUuTsQ6q1vy/nSZHTpF7jCGFmqDYPoj9ByhpoPuhg1d7ANT7PIU21FYCb37WJAQB8zt
	O
X-Received: by 2002:a05:600c:46d4:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-43d50a3c727mr21486075e9.29.1742557035827;
        Fri, 21 Mar 2025 04:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8jWRwes7cQo0FozbXH73O1PRogEZobnhjyiHSnZdwP0RxfnyF5j8N2/ON0F3RDDPu3SAvoQ==
X-Received: by 2002:a05:600c:46d4:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-43d50a3c727mr21485595e9.29.1742557035319;
        Fri, 21 Mar 2025 04:37:15 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9957efsm2174115f8f.14.2025.03.21.04.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:37:14 -0700 (PDT)
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
Subject: [PATCH v3 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Fri, 21 Mar 2025 12:37:10 +0100
Message-ID: <20250321113713.204682-1-david@redhat.com>
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

v2 -> v3:
* Fix missing folio_put()

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
 kernel/events/uprobes.c        | 357 +++++++++++++++++----------------
 3 files changed, 187 insertions(+), 180 deletions(-)


base-commit: a150906197a12c7b0f3f5efd844443bf98453efa
-- 
2.48.1

