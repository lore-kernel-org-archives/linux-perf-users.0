Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41B20A5ED
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632178; cv=none; b=ee8vt1DULkvbdjB/dCGJMUXQXYvJ56oPqQ3AO6SypMARLQ0REIpKQzacfv1uri7m+rnjQuW/D3rudhcpc7hG89gahtAWy3uigbNORvb3YflD8aj72dyV3VtUUtva4ad7xm6uNKybuXqumvcwRg12dTmZqEKXDQMDLIeZK08l0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632178; c=relaxed/simple;
	bh=SmpiIpnUWYoiRCYzpyrD0v+faU3GRnHg9tc37AXmxqY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ah5Utzc+jQKUIofAbe11+Jcr8ARCRSPe2fYQh39MsgnRJMsojP5dBgXaVQ5w52SisfJ4EsJ4SLy7EjMizcz7WthhdseY4372+tVUKR+xNpgI/iNaAU/LvQKzAkfDi5VWjo/HnjktJoQrBBBhltM+55l0V4Jcf44uEFhCLCJ6Gzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHEOXQX4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHEOXQX4"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so32158197b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632176; x=1729236976; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTikmnLZHT5WgNcn9pW7z+UTTTWWWy5CFH/F9nc3UAE=;
        b=YHEOXQX4p+C9eHbWzHSyzy3VRrQmCRLd04vwVT9JoZLGTDAB1i5ZtQziurpB+Z2TTR
         j43AcB9Zgi9WTt7zplJpSmuh+rB1i3xGpzUIt9/rLApdeNMpKALuAISgntaSOEL1MB5h
         jc1q7cjaLaM2w4no3VvRyK9PGtwLeDYiLxsYRcihbwwCe/yrOgLG1vlSB7uxw6FaDszS
         qUfV4wujfhyDYKWvCsToHe7DUcd7ldTlP5oWXKdTP3La9epFh/8Ns1dTrp777yQu5dRr
         DrhmVwkqJGAGhE+pzesjXc08zsbwND4jCFIWnZSPFNXhfnVTX6TOkDy1JUMr5RhYGQIq
         fgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632176; x=1729236976;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTikmnLZHT5WgNcn9pW7z+UTTTWWWy5CFH/F9nc3UAE=;
        b=j+aWYWlQ61UNkmWyyu/xxFuERP0pXrsxfBCqIwhVG9+hEKBTuGEptZDJhykMUUwk5E
         m0S96cV4hZTrJcKKkPPzTWYzx+OBoy7Xn3/qHS++jEnQKkeh1tFM5ncQrYKdJDhGPX1E
         F0kwLrLbo7/jC6LiPVfuMHjbM9mjGsByVN4QkWvxsksAGwr3HfzxfeWfMlFHD4VaD2IP
         QQcmBAo2H0PTGHaMYhwCvWErgI/a/c0OJRk1gazIBpkQHOJcs2pa2ypvyqvD+YDxwjQ+
         A5nfpdJQgzUT1xfZQdxM7jwDYyXvIl2p/RvHCKMb/T0S/UJfH7JOXnOn+Oi26TKOo5yp
         8/cw==
X-Forwarded-Encrypted: i=1; AJvYcCUbVuMTppB/os4yC5+tSLXa5Gqo4mYCOi9clvp88uOBaLmY5DjCQ6BH0XmlMkJ2K6sXyceZ64Itd6p2Va/9bzk7@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcjeo0UedEXxgWL6KI1unk3lcjVP59rM8q7RdNppHaBzU440w
	jZK2UPV2VRyiLK0y0/TEVPicWwc3ak+4pQC7FzS/gMdBTYHQOUVj7xlq5LXiO+8kmQUafwJbqF+
	A0KZGgA==
X-Google-Smtp-Source: AGHT+IFO3vGSve2BHEqIsjtIYtblvU2ArE9I3x6DOBoXg/VkFfGLTy08MldXB4ghZvHmDIsfNIHFvI4K9D4Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:4982:b0:6dd:bcce:7cd4 with SMTP
 id 00721157ae682-6e3477b4505mr701737b3.2.1728632176121; Fri, 11 Oct 2024
 00:36:16 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:52 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 1/8] tools subcmd: Add non-waitpid check_if_command_finished()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using waitpid can cause stdout/stderr of the child process to be
lost. Use Linux's /prod/<pid>/status file to determine if the process
has reached the zombie state. Use the 'status' file rather than 'stat'
to avoid issues around skipping the process name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 4e3a557a2f37..ec06683e77a0 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <string.h>
 #include <linux/string.h>
@@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 
 int check_if_command_finished(struct child_process *cmd)
 {
+#ifdef __linux__
+	char filename[FILENAME_MAX + 12];
+	char status_line[256];
+	FILE *status_file;
+
+	/*
+	 * Check by reading /proc/<pid>/status as calling waitpid causes
+	 * stdout/stderr to be closed and data lost.
+	 */
+	sprintf(filename, "/proc/%d/status", cmd->pid);
+	status_file = fopen(filename, "r");
+	if (status_file == NULL) {
+		/* Open failed assume finish_command was called. */
+		return true;
+	}
+	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
+		char *p;
+
+		if (strncmp(status_line, "State:", 6))
+			continue;
+
+		fclose(status_file);
+		p = status_line + 6;
+		while (isspace(*p))
+			p++;
+		return *p == 'Z';
+	}
+	/* Read failed assume finish_command was called. */
+	fclose(status_file);
+	return true;
+#else
 	wait_or_whine(cmd, /*block=*/false);
 	return cmd->finished;
+#endif
 }
 
 int finish_command(struct child_process *cmd)
-- 
2.47.0.rc1.288.g06298d1525-goog

