Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8E77113;
	Wed, 22 May 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348973; cv=none; b=tS+xRqOz1LuHHE18nCZJzuGhNsYDcwa/5dGWVsDwCXdx1HnXFEY34BWQfO0wUNenzKiXmQ5Y5B/MJFMdCUoGubmyokVyIjL+OD5I1O30UiE5qz7Pte65ZloF1U+DnvKdKqHsTLlVtvxn4UdKgXw+mIlfs5/VBBSEPRJ4rGIPKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348973; c=relaxed/simple;
	bh=Xkb858840JSpgt73J/+K8NkWTXhVSsceTUY+W6NiCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRj6qDyM8l7OZxAGrRVbjkEOr3P4n4JmYCgRyXhCJenmD/AxAZ51Om7TbnRvtwn2a3OTB416ce6tw+IgTJZ0fR/DpOGtf6yKQSlLap9CNCEyg/SUtjQVK33f4yFtVafFUJ4bpmu2ahsuRcr28RnWi3ahXToI51JxLEX2E/OPR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VkcP22P1Fz1HBl7;
	Wed, 22 May 2024 11:34:30 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 097201403D1;
	Wed, 22 May 2024 11:36:02 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 22 May 2024 11:36:00 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [RESEND PATCH v3 2/2] perf trace beauty: Always show mmap prot even though PROT_NONE
Date: Wed, 22 May 2024 11:35:42 +0800
Message-ID: <20240522033542.1359421-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522033542.1359421-1-changbin.du@huawei.com>
References: <20240522033542.1359421-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

PROT_NONE is also useful information, so do not omit the mmap prot even
though it is 0. syscall_arg__scnprintf_mmap_prot() could print PROT_NONE
for prot 0.

Before: PROT_NONE is not shown.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2979231 syscalls:sys_enter_mmap(len: 4220888, flags: PRIVATE|ANONYMOUS)

After: PROT_NONE is displayed.
$ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
     0.000 ls/2975708 syscalls:sys_enter_mmap(len: 4220888, prot: NONE, flags: PRIVATE|ANONYMOUS)

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 915dcd258002..919a462a7cb5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1033,7 +1033,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 #if defined(__s390x__)
 	.alias = "old_mmap",
 #endif
-	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */
 			   .strtoul   = STUL_STRARRAY_FLAGS,
 			   .parm      = &strarray__mmap_flags, },
@@ -1050,7 +1050,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 		   [4] = { .scnprintf = SCA_MOVE_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
+		   [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ }, }, },
 	{ .name	    = "mq_unlink",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
@@ -1084,7 +1084,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_INT,	/* key */ }, }, },
 	{ .name	    = "pkey_mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+		   [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ },
 		   [3] = { .scnprintf = SCA_INT,	/* pkey */ }, }, },
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
-- 
2.34.1

