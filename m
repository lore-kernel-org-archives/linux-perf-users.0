Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03728C029
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199658; cv=none; b=mJ0Vf58mhqNDrdaE+rUNdsKBa6ydN7uXjOWYVaZw9ZBTq6jnSM2KG4DV/WfDJQ9sT/+/nFR8jiSQROv4vaUuZD8nhZ1dpniUdPd+R53bAkcm5FF8RbZUzlO23wnJbRszQRtmNNNgyKjebVP3GsrdxvdZgn+dGePTvcIXpp49XX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199658; c=relaxed/simple;
	bh=iPhLrwxUZHv2wX6yaulHFVcQvRgI68U4Jl3CtCmOLTk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=L/2TuElf0sQErZct4LObwLg7LMmd2gRqu9F+QHg/m5GtknT3Hdcm3WpLgHjhFkSpoAfgp9ffriYGTBrVhZkCFoFVn8KDprpiNEyVQo6fFKpygpM2c+bAPTKRw8uj0C0QiXLbFYg5XQOxYZbeXd/GSwInm8jYq/5brm9/IXUz4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25poyvlc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25poyvlc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2349fe994a9so44186855ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750199654; x=1750804454; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M8ZbK17Dj2geGvK5GO30EzDPP51WioqEngR1yRrimxo=;
        b=25poyvlceR9oed0K2aF9CtzLxWYxwdcDUnsm8BGfB0hz/gYIPFss5sUPUGlxKczsYs
         071OePMFAlTKdSvuxNg6R+PcaPzAMGQL98mpiW9KxwgUwdUFovQ+QOvzzeEZ2WStYjQ1
         gWvJ4ELXrtUKSekYPbYIj0DJg7rebpVs+F0gHSCt3okfZQRszT423X9wwO+Z1wFAMFCJ
         QdT3ejiaZA4OxjFX58JNXKA9wElVonKvEsbCgaZAje08eL2aze86AeSUDOh6cdYPxWn2
         v6my9CU9nXqRfV9uDF72bCcR10cL7w95TvXIzxPqoytcjdGCyP5Lrk5JmTcrI6R4CLnx
         mQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199654; x=1750804454;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8ZbK17Dj2geGvK5GO30EzDPP51WioqEngR1yRrimxo=;
        b=brg1HPF45p4fDbDM0ZP9HF7vuYxqHMFMvp94w7VaBDyIHJYHHt/20mzK3DUezu/hVc
         6hNovk7q0UI/zbEfIQp2GObeCsIPFS3qYzRSyDUjL82e7cPVWdyOKWuS+oLi9oKUvVnp
         OTswECZZnTwiro+CK5g9v7fHGkQ04NW4quaQ8KW+hI2+iWe+6+nY/w19tE3k/ExJPR3w
         XwBkYjpzFjNxU/zfFGEBvxISNxvqB3AQpPL4HEug/b/okxzN2neCbhfrcC78rntaEUrF
         cYnaHXaJvM0BAgy3HkrdUyuooofV9f0sd6pxmxD93C3zfwuZ7VM878YkPpUQtlwh4gwX
         QwDA==
X-Forwarded-Encrypted: i=1; AJvYcCW0rZkU0q/Aii53R1ZEJJ5iM4B53L7HM75y1rGNQS5GaeW8hBTMbvitmbAzXsondNknNTCbWlELDA3WSrnChi0Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyVToxsxXfO8g6Ui1n3cXN/AFGYel1fHd5j96e/2yfZGmS801r1
	no/HsC6aau0OuG6x6xKVexIcsggzj/SKKMlhWET935IdgY7al5Mk2JePKFwH5crds7HdRi7seai
	LW00EvEe3nw==
X-Google-Smtp-Source: AGHT+IHn5vHmNdo/1OE/54rCEFOwlR9N/3j9Z7E5HOyKK03PBDryeertL6DY4l2/hbLegD+O1+eWlsl+i8Wp
X-Received: from plkj9.prod.google.com ([2002:a17:902:6909:b0:234:908f:4e22])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:186:b0:234:f182:a759
 with SMTP id d9443c01a7336-2366b13c87bmr258940175ad.28.1750199654477; Tue, 17
 Jun 2025 15:34:14 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:33:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250617223356.2752099-1-irogers@google.com>
Subject: [PATCH v2 1/4] perf test: Directory file descriptor leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Andi Kleen <ak@linux.intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missed close when iterating over the script directories.

Fixes: f3295f5b067d ("perf tests: Use scandirat for shell script finding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/tests-scripts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 1d5759d08141..3a2a8438f9af 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -260,6 +260,7 @@ static void append_scripts_in_dir(int dir_fd,
 			continue; /* Skip scripts that have a separate driver. */
 		fd = openat(dir_fd, ent->d_name, O_PATH);
 		append_scripts_in_dir(fd, result, result_sz);
+		close(fd);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
-- 
2.50.0.rc2.761.g2dc52ea45b-goog

