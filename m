Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A535E1CC
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059619; cv=none; b=slkniBcbGBgdBl4btnur7Icbx9aU8Bg23c3qZ16H5V5iekEk7j9V8b4I5/3cONdT0XkrI5bSrhhk9QiJZ5+aWeyRiSUU8Xtm0pmNapHYdF4L/CLkTQNRx+95M4ON0+zlEuXomQHvuHRS7JeWPAz65ARcUFud2PezkvVUN8+YlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059619; c=relaxed/simple;
	bh=MGFVBQ+TrHTe9DbJ2aRmYU3aQGRxXPtwm3CTto3c1KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2kaaUOZMOpiEnP4WikItk6GY7eeHV948gzIpgRDW7qdxtkIwSbaqDFiRZqqMpGJk+EQuKrJIE+Yem6qXOPr1kwfgvGzTodSRlikaydAfkH/LECVeFa8jVWjl2+ekl7RuEy4cS6qjjnwH/gVfOayI77Tqho+UVnyrZ+DWOlHp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7AhUxMA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7AhUxMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790059616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SQccuqJyhP5fDCQHYD5pQI3YA0ykJFivdKYX/lD7ySw=;
	b=M7AhUxMARgU37coR4wVcboFMD1RrhAgSkno29x1Gxuttz2dmPPMj/9V+FpcQz9NeXEbbY2
	TZsLXgdfBXoyM5S9dyDkqAeksmeDeK/T6uIlxDAmEjGUrpYICqV/csHW3pjyL8uFlWvr7y
	jWrUmsHLnuqlspmWmRUXxKlUyBhvnD8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-Z4Lm0PUiPIWzKmAWxoTMWA-1; Tue,
 22 Sep 2026 02:46:52 -0400
X-MC-Unique: Z4Lm0PUiPIWzKmAWxoTMWA-1
X-Mimecast-MFC-AGG-ID: Z4Lm0PUiPIWzKmAWxoTMWA_1790059609
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42F1D1809C96;
	Tue, 22 Sep 2026 06:46:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A95D426;
	Tue, 22 Sep 2026 06:46:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] sched: Replace __ASSEMBLY__ with __ASSEMBLER__ in sched.h header
Date: Tue, 22 Sep 2026 08:46:41 +0200
Message-ID: <20260922064641.61120-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

While the GCC and Clang compilers already define __ASSEMBLER__ auto-
matically when compiling assembly code, __ASSEMBLY__ is a macro that
only gets defined by the Makefiles in the kernel. This can be very
confusing when switching between userspace and kernelspace coding, or
when dealing with uapi headers that rather should use __ASSEMBLER__
instead. Let's standardize now on the __ASSEMBLER__ macro to avoid
this confusion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This has been split from an earlier bigger patch of mine into
       this separate patch to ease reviewing.
       I also thought I had sent out this earlier already, but I cannot
       find the patch on lore or any other public inbox anymore, so maybe
       it got lost along the way. Anyway, sorry if you got this twice!

 include/uapi/linux/sched.h                         | 2 +-
 tools/perf/trace/beauty/include/uapi/linux/sched.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 33a4624285cd4..19ffeba894283 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -53,7 +53,7 @@
  */
 #define UNSHARE_EMPTY_MNTNS 0x00100000 /* Unshare an empty mount namespace. */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * struct clone_args - arguments for the clone3 syscall
  * @flags:        Flags for the new process as listed above.
diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/perf/trace/beauty/include/uapi/linux/sched.h
index 33a4624285cd4..19ffeba894283 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
@@ -53,7 +53,7 @@
  */
 #define UNSHARE_EMPTY_MNTNS 0x00100000 /* Unshare an empty mount namespace. */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * struct clone_args - arguments for the clone3 syscall
  * @flags:        Flags for the new process as listed above.
-- 
2.55.0

