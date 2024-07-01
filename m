Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CDE36AF8
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808964; cv=none; b=IM1DJLweHpBENSVi5w8/075P1Qiyy10dGzhkEnQcqWjzZ6TnB8yNu6S5z39UP0noYeDKpQei9RDpamAQbrq9Ah0Idu+iLHB3MHk0X3hedRhG94/sC1YWWAkBQWnbU3FdmQRew9yr6syrodmUSnwnSHDC5Je146vD4soDt/DUpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808964; c=relaxed/simple;
	bh=3WSw+LzwDfsuTLO07J/Gfgu67U+bggq7nxlP2SFbdkc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=grj8SrB8DhtLG/sAPjegjes5O3JipgrBAK4cLPenMVq78ItS3zPFp0QuZyEBArvAScrRnL/UKbngvGBO7xC8/dIy+S+SsIGXU77n+nDv1tCVj1AldowAf0Acnm3VgTuD7Gi+r2PT4M/Eol/YeksYd/Y567uMsxe/OyWzsUlRAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWQpvF4T; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWQpvF4T"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-72c1d0fafb3so1749028a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 21:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719808962; x=1720413762; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJaevJbd0eQTHDa7xn1OIMkQuKnrhSd1AMXiSY5R5Xk=;
        b=cWQpvF4TR0LQ91aZUrUG80AKl+7sQa9kdkGKiAH9uI16gpjdBczaRLIsJ9rSJgkDzx
         KEckuB61p3wpyuCfIms4QVx7MOsHmey8LfY53Vc2aMEhPlNxaHJldMgcIML0RrELdHtb
         qlli5PELIJbUWRviMItJREKEIRgrfMqXjABSMTECSHbPWjvDUW5Pldeio641SielBE+l
         cmYtdAZGELWhdSKVNxq64wiNfIesX7/KjcbnBopigwYEeEkqhGPtP8y42pio4KKvtc6n
         eZLwBte1a5zsAUqmKDA/xzEF/G8qtwEZsnOkxxZatNAk+V3VjwTMxujfsTcEHGUaXR6J
         fpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719808962; x=1720413762;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJaevJbd0eQTHDa7xn1OIMkQuKnrhSd1AMXiSY5R5Xk=;
        b=HR2R+AMeLdFbTMdNWHprCrhhLGnZavAZsT0Iwkqe8Ap1e6YpKyAdhEkKJDQb6L0DNx
         4554/Day85jo8Y1/2qBlqW0lTwwuJn+8jLuTZmEhCLswmEshIROZOL3KJH17mQULBcZD
         FJXmd2f+Bz1u5nS3nUKZgbQCTFLBwApKlN5VCPvBi57DKE5ciXznekISUuzu/4lpgtlb
         VY3jgVVkhf6czmMQ2vj9p1slNG3+F5BKyio/kh7LPJ2+Ymrtb1iHzfblvsZ9TmvKXPNg
         pSaQGGkbbRCSGLXh4V3CpKNu4GFsw9bM8hBpr6m6qzFVCRmHgNp09twZYhdDMFoyLi3r
         dGkA==
X-Forwarded-Encrypted: i=1; AJvYcCVYJANFjjpEBgo/RCzeFsJy103iEm15jHxxObcFsgEXjw6uIahnHNVW0q1DFtmmFhPKkPbLrL0pMZapjzFBeUY3Hu1C15yV5L7TI3roRD5XQQ==
X-Gm-Message-State: AOJu0YzDvVoyKzxdHHNZScJWgkIued8jmLnpYLN1ROe7SphCCTTSDV0M
	DGZMjXM8ML9dMQO8Mhv9UdjV0RUvZEokODNzJyztkg9U01Sqt45DD3vcHh0Nw2oHVBXJe6r/GYa
	16iExng==
X-Google-Smtp-Source: AGHT+IEIzUWDNM21Dmwx3C1YCGQLf5z9VbV+vSSee8+oDr/p/4o0NWDbt/9UqSMxCfs86165f3MQN29AeBtQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7bcd:6ae9:263e:82ff])
 (user=irogers job=sendgmr) by 2002:a63:77cc:0:b0:6e4:d411:7c64 with SMTP id
 41be03b00d2f7-73cf238df43mr12182a12.3.1719808961796; Sun, 30 Jun 2024
 21:42:41 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:42:35 -0700
In-Reply-To: <20240701044236.475098-1-irogers@google.com>
Message-Id: <20240701044236.475098-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701044236.475098-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v2 1/2] tools subcmd: Add non-waitpid check_if_command_finished()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.45.2.803.g4e1b14247a-goog

