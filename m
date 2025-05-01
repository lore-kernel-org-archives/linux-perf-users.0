Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8471E5B68
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746082826; cv=none; b=ozbIW0b7IIOI+qQLFexY1x44i0OWzWSKW4yAljpjvaM1Z69m7POK9+Qc6xElMa0GcwRour5ZVpSyjYS2lXkPno4wFPeShdxsfyASWx21zcwS2qtpQfvtWahZAMWndMCAwp0CUXlTlAVqpNXy1QkodbKUOUJWnfqTrezDsYoYQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746082826; c=relaxed/simple;
	bh=c8IIHBKOqP/8zRONOTaQ8sX55xLc+LG986tLPWZhOiQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jfzJ/nYTMWKACtOlkrI5YkMQAr0qG7gYWOjbOQGtfDzapDvxLiWBcZraCdouEVNrN4aW6AVdoy1Auv/JvnExDZV80Uu7up3eCtET2EXx5IQQMUI3AzhDEBSTvNNOvCxAUM1irPJucQ54nw/ESu8lbR7o6DXLMJa5EwPMPneDEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBXWG/Rf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBXWG/Rf"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3087a704c6bso738790a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746082819; x=1746687619; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O4YRrIcRlvenOuksykoyHqCdG2wzhEYXKqU9yvMfzTc=;
        b=nBXWG/Rfgz1ItKBJ8V8iVRtat2gp+1NU3kklQuOgXhxE+Cg6hRi7+/KpotVGL/Buv6
         lUEqyOi74XFtLVRMs47REoSEDFJG2PA9+8+M9kabm8tg5EZ8jpA1HReNncBLb1usSjAr
         b+8yto7+Btg2YLDkpAWLnxO1dr3WV5PAE4DHAcL1NPRkeqX8+xQa69MfjGGqBYglTvrR
         O7q1lRLmUTeNIydJUpsAPtgihezul8oc7XHCK+0tCXQ8o6i9qlcUDYeBMUyK50vMRL+y
         +Vuq5CE41TH+ofGVBsVcs8RYe1KbMqdJQ7iiaJhusvOFYxeAZiT9ifEOeWOHKsh9Mokt
         VeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746082819; x=1746687619;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4YRrIcRlvenOuksykoyHqCdG2wzhEYXKqU9yvMfzTc=;
        b=Zr0RpZqG+FkTe3/2MgZ0zwhyCyRyjpRm+1yQejYx8oet09WMSCcXATNeMOrx/HsKWH
         qYBtKcIeg1ImU27UhMWKImK+1IUX6H+5vQps1ZMQeAa6H2ZkIP/CFz5ntRRPVkxiVlT1
         KvvMrg8gKeVOV5F78rwR1edYplTQTcrCB0rVpk4/qZf9p+tC0uLggI3O/snQYtkGAXVW
         RAWuaz1LLv/w5aW/9yoNy/IVW6czETryyN0hQf3/HyudkJiaA82QTwZzD+J5Oc0butvW
         r4BxdCAV59/KjxeZZmyeDD+wzejIZW3WDOnkrnBcXgJIPU+zNeNztCE+JpM0eUXAQllJ
         0oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPdP93NJFRGsTv+3vM1GAz1B1PUPZdugI24JVUZdFXlN+aIg1ZUz2sQypupaE9+4I9+IstiypHc2eX9NNck+Qh@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5kNHNa4y65UqGLTOFOBWyeSmmtNdx2NvS2qSqsnfuSXh4x3t
	W5XL4BCGJJ9c6FSOOIsYgJRUbnuRePM0x1VLLol3kEzHWDaEX84vOhJaDcOzSIqetG8951I3bcd
	KT9viqw==
X-Google-Smtp-Source: AGHT+IFpl0+qcuf8ZtvMi3OotBvFMEe8ZOS4gDGfUKf8XAHd4j6NjjQqvkCBYrVSm/FN192i8J9X711d5Aw1
X-Received: from pjbsv3.prod.google.com ([2002:a17:90b:5383:b0:308:6626:81c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274b:b0:2fe:a545:4c84
 with SMTP id 98e67ed59e1d1-30a41eb5a8cmr2109230a91.34.1746082819308; Thu, 01
 May 2025 00:00:19 -0700 (PDT)
Date: Thu,  1 May 2025 00:00:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250501070003.22251-1-irogers@google.com>
Subject: [PATCH v1] perf symbol-minimal: Fix double free in filename__read_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Running the "perf script task-analyzer tests" with address sanitizer
showed a double free:
```
FAIL: "test_csv_extended_times" Error message: "Failed to find required string:'Out-Out;'."
=================================================================
==19190==ERROR: AddressSanitizer: attempting double-free on 0x50b000017b10 in thread T0:
    #0 0x55da9601c78a in free (perf+0x26078a) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
    #1 0x55da96640c63 in filename__read_build_id tools/perf/util/symbol-minimal.c:221:2

0x50b000017b10 is located 0 bytes inside of 112-byte region [0x50b000017b10,0x50b000017b80)
freed by thread T0 here:
    #0 0x55da9601ce40 in realloc (perf+0x260e40) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
    #1 0x55da96640ad6 in filename__read_build_id tools/perf/util/symbol-minimal.c:204:10

previously allocated by thread T0 here:
    #0 0x55da9601ca23 in malloc (perf+0x260a23) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
    #1 0x55da966407e7 in filename__read_build_id tools/perf/util/symbol-minimal.c:181:9

SUMMARY: AddressSanitizer: double-free (perf+0x26078a) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a) in free
==19190==ABORTING
FAIL: "invocation of perf script report task-analyzer --csv-summary csvsummary --summary-extended command failed" Error message: ""
FAIL: "test_csvsummary_extended" Error message: "Failed to find required string:'Out-Out;'."
---- end(-1) ----
132: perf script task-analyzer tests                                 : FAILED!
```

The buf_size if always set to phdr->p_filesz, but that may be 0
causing a free and realloc to return NULL. This is treated in
filename__read_build_id like a failure and the buffer is freed again.

To avoid this problem only grow buf, meaning the buf_size will never
be 0. This also reduces the number of memory (re)allocations.

Fixes: b691f64360ec ("perf symbols: Implement poor man's ELF parser")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-minimal.c | 34 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index c6f369b5d893..d8da3da01fe6 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -147,18 +147,19 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			if (phdr->p_type != PT_NOTE)
 				continue;
 
-			buf_size = phdr->p_filesz;
 			offset = phdr->p_offset;
-			tmp = realloc(buf, buf_size);
-			if (tmp == NULL)
-				goto out_free;
-
-			buf = tmp;
+			if (phdr->p_filesz > buf_size) {
+				buf_size = phdr->p_filesz;
+				tmp = realloc(buf, buf_size);
+				if (tmp == NULL)
+					goto out_free;
+				buf = tmp;
+			}
 			fseek(fp, offset, SEEK_SET);
-			if (fread(buf, buf_size, 1, fp) != 1)
+			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
 				goto out_free;
 
-			ret = read_build_id(buf, buf_size, bid, need_swap);
+			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
 			if (ret == 0) {
 				ret = bid->size;
 				break;
@@ -199,18 +200,19 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 			if (phdr->p_type != PT_NOTE)
 				continue;
 
-			buf_size = phdr->p_filesz;
 			offset = phdr->p_offset;
-			tmp = realloc(buf, buf_size);
-			if (tmp == NULL)
-				goto out_free;
-
-			buf = tmp;
+			if (phdr->p_filesz > buf_size) {
+				buf_size = phdr->p_filesz;
+				tmp = realloc(buf, buf_size);
+				if (tmp == NULL)
+					goto out_free;
+				buf = tmp;
+			}
 			fseek(fp, offset, SEEK_SET);
-			if (fread(buf, buf_size, 1, fp) != 1)
+			if (fread(buf, phdr->p_filesz, 1, fp) != 1)
 				goto out_free;
 
-			ret = read_build_id(buf, buf_size, bid, need_swap);
+			ret = read_build_id(buf, phdr->p_filesz, bid, need_swap);
 			if (ret == 0) {
 				ret = bid->size;
 				break;
-- 
2.49.0.967.g6a0df3ecc3-goog

