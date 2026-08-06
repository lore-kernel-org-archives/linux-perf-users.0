Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D232E143
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989670; cv=none; b=D8l5RDojiVWhHnBrD7GoiM6pX8ay4IBdcTJKDPCBkCiYkkchvtYej1k4eMwy6GOB+aa/XNtau41yPYmYTWFcnYu3oWYrpKZ9L6IbTdZBL7D6DUoGG5MHnwceFWQXccZPLG56TQC0D6P5UZP2hyN1BH4n4hji5ph064xxSkqaADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989670; c=relaxed/simple;
	bh=iZPeBgLnOWluHySgECX5Z9pOvjpbIHDIZlcKBk1CwUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoBELbvP9YAgVGNiRXMOeCBAbhaNiUjISbC+mzhsCsUABS5j0CVqqbLDZv0gbQYO1KCNPMv1ZhdgK0JUEyRrzv9s7btzDvoNmFy+X5A8FwMr3gUtuxhix4KMFEWrRAcwEobCGq1/mh8DyFeKQgxX8QlnRaN56cqnIxe9Qvq5o1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RU6hUEx4; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RU6hUEx4"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso2209127a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785989668; x=1786594468; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGNBxIMbjF6ue7QVP0Xn9VPejnBt+3k4MwG5g+tGNLI=;
        b=RU6hUEx4YoB7gONWRglLpJGzD/1hPEoaZxMvkVS2gmfFKxW1/fylrboNGmuDY1bBhu
         k2Im+oqGTjXg5hgZVVYWqeD7/Zmiyr0Km7q5IgsYd/HG0JpD9aDzg72F2sBkjVbSayAc
         miUb5IqZYVWWi69vAcb4WGDIIcW8uyMzwYKA7itLoG07IEfmY3C8HybYMBORlCdhledd
         SPECwag5x3a2f2pzrIiY2qW3ji1kXKYjwvYeoSyWQvc+Crip1CQJc8Zz49Tg53P7O9WZ
         C3YgPq6PXzuA4z6Rnj3BmvV4z8/p3Pw0lpUsiyAPpMMB95C34CCDm23d7+NwXw7N0PbL
         4PuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785989668; x=1786594468;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGNBxIMbjF6ue7QVP0Xn9VPejnBt+3k4MwG5g+tGNLI=;
        b=o3bgu48py4NMARZ/qD4zq63ZZbr2pPEqmYW9mEmt7ZBsbRWvW54HRncWjc+Ww6clGz
         THalER3iynDcfhTZHP0++CJTxFLEsuDb6ko0ZtL88TDTiprcbp7V0J64xmKaGx9+3i96
         MJIlW/8MbsQa/bZaVI8q0hdt37c1NOTm6O4O5zZp+MN+IiYkJ24CbWm1jjZ1cmoGRqUZ
         d5MJgtNqHDEg6xQeuS7PR+/Zt3CYd57wa/oLygMO4kiuaAu89anPlRluFx3S/P6yKDtJ
         2fCJfqUvXl6xudtDXCpTcy0ZdCNWdEq+ng5Am4IikiziFNJGYJzxHgTYIO9vs6Wj7e6g
         b/Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rqc9xOqy2xSZa0JLcq7hAsQm6iP3RIEfpcw3SY42n7qYKwAGJYv5rbwKxvM6ay2k08sSKIkK/DCJ/bLXVao4XHd@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJ7V+boQUtVL0aSlOeetDsmn0h/h6psIz+zA+o2mn6sJfSK/D
	JU/PYaCcx83kQKmyrT0FKhT7vFUnNngKkZBPYqB/jrTLyj4TBGsviuyQXzGOFBD1ikHkrb/RVPd
	SeOUWvjYKmQ==
X-Received: from dlbeg24.prod.google.com ([2002:a05:7022:f98:b0:13b:76f7:a531])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:520a:b0:366:10f1:3d91
 with SMTP id 98e67ed59e1d1-3903c54adbamr11877174a91.1.1785989668073; Wed, 05
 Aug 2026 21:14:28 -0700 (PDT)
Date: Wed,  5 Aug 2026 21:14:14 -0700
In-Reply-To: <20260806021038.2291417-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806021038.2291417-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260806041414.20327-1-irogers@google.com>
Subject: [PATCH v2] perf evlist: Warn when 'sleep' workload is used without
 system-wide (-a) option
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tshah@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

A common mistake when trying to record system-wide profiles for a given
duration is running commands like 'perf record sleep 1' or 'perf stat
sleep 1' without passing '-a' / '--all-cpus'. When '-a' is omitted, perf
defaults to per-process monitoring of the sleep process itself, which
does not collect system-wide activity and records very few events.

Add a warning in evlist__prepare_workload() when the workload executable
is 'sleep' and system-wide mode is not enabled.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index eb7c0d7be064..b3dd097fbb2c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -11,6 +11,7 @@
 #include <inttypes.h>
 #include <signal.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include <fcntl.h>
 #include <linux/bitops.h>
@@ -1562,6 +1563,20 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 	int child_ready_pipe[2], go_pipe[2];
 	char bf;
 
+	if (argv && argv[0] && target && target__none(target)) {
+		const char *cmd = strrchr(argv[0], '/');
+
+		if (cmd)
+			cmd++;
+		else
+			cmd = argv[0];
+
+		if (!strcmp(cmd, "sleep")) {
+			ui__warning("workload '%s' specified without the system-wide (-a) option\n",
+				    cmd);
+		}
+	}
+
 	evlist__set_workload_cork_fd(evlist, -1);
 
 	if (pipe(child_ready_pipe) < 0) {
-- 
2.55.0.629.g250fe7f194-goog

