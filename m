Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0A473C61
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677987; cv=none; b=QMC1Esl3yQUFMvtUvlN3K5qVZEEdaNLOSHp8xVuF0jk3iMeEfcYCQKsvBTPQYSN3JrY2WHy92qtqKL51T3xXaixdcUjnlQUCeRgoqrudonDOUkUClXezdax+PzUmpCmeviHX33aan8pdEk3Y36zxV1yzNylRrdZA+YvPC5pbGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677987; c=relaxed/simple;
	bh=QVBzXFZ+m+PkDD6qLVSNfdTw6jXGRoWG5ySf0zcf6Co=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGDCY8NsAqFid8tBTWbkaZeb7gjtoA5vSgMF/DssYjppF+p6l6EEtDmhIuoqwEWvBdt48RAfONNcOPouF/vZFHpD8q9FGltu5hz4DR7Bz8j16/3hPWjugCV0AGhXn7GMs64f8b6bV7t+G/K/G+jM3dUGrPHgyDAaPtbOvAecl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyLuaKM8; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyLuaKM8"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9c26587e67so6023184a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784677985; x=1785282785; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmfaatJPVa3SJnEw9FgvQrwsrNHQ8Yb7V+zeXCvk3Jk=;
        b=LyLuaKM8SQz8Xb+gQxIbQ5A9JW2VIdD4VGSCHVPXVwz0ZWu6uDYpl4bealwsJJ/ZpE
         aV+zkDAIXNMiNk91Upvd3DvwFBi+IEyf/jlGJR0fwsK5+a9weK3vhgai9GMyC6PtXxe/
         PdYS2Knkmks4kQV4RttNvRTv6nWZYvxdBNUTkPlbQgoWWGkZimn8SnAwyJYog5v2OHpT
         bN5ZJOCeXy7g6ZJpfFtajinfUEqhy2GW/9f7kPVqgRih3i8oLh67rEkRB7FqzxJsEn+V
         7d8jIpBFlO5ElqkRlxUyco7GI3FhMk3fBzBhPewcLLzVqtgnVeEvQw4quyJU3n/F3Dic
         epSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677985; x=1785282785;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmfaatJPVa3SJnEw9FgvQrwsrNHQ8Yb7V+zeXCvk3Jk=;
        b=hA72s3JBAQiU+aKv7aGD0o2bwo4x5jvUmZqa6VayCukUzg9+YBq40fGBtVeqaCMrZZ
         mW+9xDW8ow3THHT2zuU7clwxRJjpUf3ZmhC6v5Gu+tscx43DTKqaolxnYMAyq+pU20FU
         EmOJTIA9nzGJN643tOjPh7A4Sl51L3MoOnix6jK6il2oFdXxq9zgdp66gjg57x7aXEQ1
         wiC8HJ/eh3iKC7yggsDxzj84SsQLMsnIkUAI3iq2R4P43caIUlR43Tf9mF823kk5LLbk
         LhAkrlraNLLeBRTyIVaT9giXL+rxrLcoTQbzd0UP3eLYwh5keDnA/auGXbsZAqI9Fde3
         iF8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrGRVxPbXf8w0XEdNrcaWlWojlR9m+51Sdqazld7/nm2z30N7GxsoFfinxNJtbkykh6oShc/2L6XjmGJW/OxAyy@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbdlw+T/33DFrXp/J0CH6SbHryGIaPXER49XLaMbt1IxqJAvK
	pjq2kAyax41TPCJdhuzYviduE90tIm2ckauWmFnlPhVDiMIBj3k9IztlKJEuF1RmTE2hg3PyC0t
	GVEYFxUcj/A==
X-Received: from dyos40.prod.google.com ([2002:a05:7300:6ca8:b0:313:cf74:cf85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a06:b0:3b3:a66e:3911
 with SMTP id adf61e73a8af0-3c429455fabmr1514232637.19.1784677984795; Tue, 21
 Jul 2026 16:53:04 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:52:52 -0700
In-Reply-To: <20260721235254.294053-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721230952.267754-1-irogers@google.com> <20260721235254.294053-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721235254.294053-4-irogers@google.com>
Subject: [PATCH v7 3/5] perf synthetic-events: Fix stack buffer overflow and
 bounds in cgroup synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Fix a pre-existing stack buffer overflow bug in
perf_event__synthesize_cgroup() where an in-place null padding loop wrote
bytes past the end of the cgrp_root stack array buffer during cgroup tree
traversal. Eliminate in-place path mutation, use PERF_ALIGN for path_len,
clamp raw_path_len to prevent sample ID header trailer overruns, and use
strlcpy with combined zero padding for alignment and sample ID headers.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 832b74ffb4db..05075840707c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -635,15 +635,22 @@ static int perf_event__synthesize_cgroup(const struct perf_tool *tool,
 					 struct machine *machine)
 {
 	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
-	size_t path_len = strlen(path) - mount_len + 1;
+	size_t raw_path_len, path_len, max_path_len;
 	struct {
 		struct file_handle fh;
 		uint64_t cgroup_id;
 	} handle;
 	int mount_id;
 
-	while (path_len % sizeof(u64))
-		path[mount_len + path_len++] = '\0';
+	if (strlen(path) < mount_len)
+		return -1;
+
+	max_path_len = sizeof(event->cgroup.path) - machine->id_hdr_size;
+	raw_path_len = strlen(path) - mount_len + 1;
+	if (raw_path_len > max_path_len)
+		raw_path_len = max_path_len;
+
+	path_len = PERF_ALIGN(raw_path_len, sizeof(u64));
 
 	memset(&event->cgroup, 0, event_size);
 
@@ -657,9 +664,9 @@ static int perf_event__synthesize_cgroup(const struct perf_tool *tool,
 	}
 
 	event->cgroup.id = handle.cgroup_id;
-	strncpy(event->cgroup.path, path + mount_len, path_len);
-	memset((char *)event + offsetof(struct perf_record_cgroup, path) + path_len,
-	       0, machine->id_hdr_size);
+	strlcpy(event->cgroup.path, path + mount_len, raw_path_len);
+	memset((char *)event + offsetof(struct perf_record_cgroup, path) + raw_path_len,
+	       0, (path_len - raw_path_len) + machine->id_hdr_size);
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
 		pr_debug("process synth event failed\n");
-- 
2.55.0.229.g6434b31f56-goog

