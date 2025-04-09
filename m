Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F33278156
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224004; cv=none; b=NZiVogrihINIlqkYP5cZwgz7bXFOzfffMIel5s/aKYQGqB2PE/l6ekzW95Lb9VyzmbTjA4Tys1qDjD/Vn/NOpSDSSf6nQEKtSa1XE6od9PfA33pNh84Gmg95J5crm5FV27ujlka2sfUWPTGOswkAa2IqUVWMUIDfOcnAAXF7uB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224004; c=relaxed/simple;
	bh=YByLGt5IbqoulT7McuNVKx1lx1ehCr8GvBpOhQdoaHM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PbCh2D+tWV3ejtOKJZjfoXDoZOQwskqXtPpKbWJwFlz5Abcxcte70dw8X7WruZlXBLED8qbz+A9lh9c6sZe49rVzFlVANw0J3ZqwlVFLWYGvOK+K9Vhu8XiIdVMqBRMpBu96CeLaCkt65tzui0rixy8kddqdwHCsYon7CEa4Dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5THz1oY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5THz1oY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a7aceeaso67070715ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744224002; x=1744828802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z2A0w1cSwfGcyN3wePDGb03110dCs4MMvwp+DVzVxCo=;
        b=V5THz1oYWOKQK7pSBO1ynAJeVfQyStfK+G+PwM/NyyZlwFfM6Y1gK/FqvSGuXJ6HRZ
         N/DmGOCXxVNK8w/c/N4uR9jKU6fAW304q5K//LGq1QTUdHS3QqNfluBMymmgu+VyLDiZ
         FZrlWCaScVEZkab91qt1LMSCJDUZiiMKFpjJ/Fw5wKYdRvXegAT5SU4y5IK+hWMas0+X
         y5lHKkJTBQ7by0Jmpfl0po9P+LDmMmam8MJq8XIC4gEFnK5KtLnoLYGSsWqSEEkYL5TB
         yYIuNaQr0NdGEd1+OLTwYDQ1UoUWgmCujxKG3BP2veTqt4+dGzrZAiYE59O+wwyAkV2+
         4Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224002; x=1744828802;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2A0w1cSwfGcyN3wePDGb03110dCs4MMvwp+DVzVxCo=;
        b=LIVGSdXmCrkuPulNRCFaCCoHBvmv6B54EAcFE+o3ujDVTjhSyD+3fS/fHpM3DqEHj0
         xQaBvmHeMw3PewFsiinWWqylKuqI/8gFfgMkYlZeA2F9UZA6pFVyN3lW1uuArdD/hsA0
         4N1V5vA6HXdRoA4OY6T8PfdoPRD0lqrZcMJPjEN8aVl8xycanSlsGcPKSQzjM8PSTOJS
         27HcTIU/XbTbMjObzf6s4bld/vpCAgQhPJy2haHkr6Mn2jw78kpEKPbrM01ZKpRZO7No
         JrBvGhTJ5qBUt0qnOYqVw7mAJ/gDPHEqeWDKL4KdM4l769iYyFF7oW7Pjk+11F3PyqcZ
         v5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWraoUFx6XYiFXcJg89KoxGqqr2+4NjpSSDLgljQSMUSnyqaTJCForIgtuLYxc4WBNtLaJzjbo2gQlDycCFZ55w@vger.kernel.org
X-Gm-Message-State: AOJu0Yxszc9bBJNL0+pdCLKLA7KnrnRdHC2BoptOX7CZbNgXQF3mw1vq
	zcTRBMXGJzVrJaLG30Oc4MBmyeqoV/K1AJwm9nP4mCC5dbI3X86w0gCTBIShpPaDMoqjKQZWaTU
	0Mw==
X-Google-Smtp-Source: AGHT+IGb8sdlEq0WoN0OnV7IFDWAwCfVL3+wiVZXB8wDjM3cvPrWZregl/hVgJRrnfqNStxYzSMa0kfA5zM=
X-Received: from pleg18.prod.google.com ([2002:a17:902:e392:b0:223:f59e:ae50])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60e:b0:223:faf5:c82
 with SMTP id d9443c01a7336-22ac3f3222amr45795565ad.8.1744224002399; Wed, 09
 Apr 2025 11:40:02 -0700 (PDT)
Date: Wed,  9 Apr 2025 11:39:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409183958.1540709-1-ctshao@google.com>
Subject: [PATCH v2] perf report: Skip unsupported new event types
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dvyukov@google.com, ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`perf report` currently halts with an error when encountering
unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
This patch modifies the behavior to skip these samples and continue
processing the remaining events.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 60fb9997ea0d..b4c7973c34e2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct perf_session *session,
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(evlist));
 
-	if (event->header.type >= PERF_RECORD_HEADER_MAX)
-		return -EINVAL;
+	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
+		if (!PERF_ALIGN(event->header.size, sizeof(u64)))
+			/* perf should not support unaligned event */
+			ui__warning("Skip unaligned event type %u.\n", event->header.type);
+		else
+			/* This perf is outdated and does not support the latest event type. */
+			ui__warning("Unsupported type %u, please considering update perf.\n",
+				    event->header.type);
+		/* Skip unsupported/unaligned event by returning its size. */
+		return event->header.size;
+	}
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
-- 
2.49.0.504.g3bcea36a83-goog

