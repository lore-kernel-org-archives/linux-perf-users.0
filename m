Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D623D288
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874699; cv=none; b=dORhL1Ak6QGBALBHoMuS45zROAf5TASlC3EeLLIb/jIEJTj+1rNqb/arOst/p5Img2+67vcdDx16iXvDTLt/8homEanAeqi3AUPzgmgwGmXLxeqDXQVuh9wq+JIxuMTlsq3Rk/LIi5qNQb8ovPjPL5Rfq9gYOcYBjtO8NuA3Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874699; c=relaxed/simple;
	bh=6UFG4+fViSeESuEnKM2lAgu7VSmoW0Id/xL/ZujVnrs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Nqj6Zn7dCwxR38m8Ib2Poyl5cpDF0Dfjgl33exfCtp0Y6cKcVRcqnMkQamfwDkoeBIIVJjdYqdPlbtf/komRkC0JZ5Ug8f9m/fgsYThDyrmS+GAOJlONldkTkliki5+rfr82MvahMY/4kY2Zos/oAZwyqGhC4pdaJLZFMhbJq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EdXbVEOj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdXbVEOj"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e372d0ee6so435648a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874697; x=1758479497; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0HLF0l6sKrn/QwWnrA3S0LQAY0Lo5116W81vJMiWo4=;
        b=EdXbVEOjtVwQKx4FdSIqlrMSVmAvdE2/KG/kguc6n9XrO32E69zus5H91dbReMFjBD
         tb3DV0MTvueGFqLigqpMQkr+bJFpRUv3geKOdfO+3VypF0U3ZIxRcvMX4hjjCEdd5Onn
         VMABLVGRk9ZcSt+r9cPHGTwqd2c82OoPSSgrri3sNJeIHA3xoRwHYzaC59xakS/67ZHI
         m5HxGzgmmWhDx0lRxDHpQ0V64wpXajU+QMgbNFY3avvn2t23aejk3KSefLf8A8qlvTa7
         jxUOUxm1iAbup4ucAzHRfvEqQrdh2Dd4PjrxTwOQIY8P4N7bIRIqDxkdGO0fwu0eTe/B
         q0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874697; x=1758479497;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0HLF0l6sKrn/QwWnrA3S0LQAY0Lo5116W81vJMiWo4=;
        b=sZVDBkzXkhanDoLn7V4Qe5tNUeMAkXYmGYnORcMO+A4d6OEmCTXpHPg7Cctus3rhdW
         pALR9Vbvjoxq7UzvD1VztBzN/wPPO/4FpgwXkA4vXV+sGovCQj4/Rc3e4ujkwfrddBfI
         NC6+lZsRDLlm0gFiQ5QfFlLbfrfqwjeDrQXyD0OlgZiuowqJcdVDhUk5gNaPLH4tV+sz
         Aw9tgQsAnlg/0g3pD/wsjV25H1L53IlyyAwA0YhyNLb3T37aHygREOM51a/1AjQ029Kt
         ULvaRqKfJLBQ0exCNYItmUT6HgcYzfK4miV7k177I121G8BI/cVgkLn40a5/86M8JMpQ
         ivGw==
X-Forwarded-Encrypted: i=1; AJvYcCXgvtOctdsn5Li1iJ4aJXS0nNffRvD2kWaokGFVE2YgPyoy1InS+M6RsmYAfpxLicinNZMPCdus6dm9iHDJDVaK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh17CI4ovWosjHLAAZ0dhfN8hEP9O9Jo5OdIW/mFdh2i624a1a
	3NfiW4Q6tnnK/ktDVCrdC/3w8w3O4mI0C7TVuEcjOSL+HR4McC32P5m7GyPN2MT2e8tRqVDzy4I
	JVST1eqFhMw==
X-Google-Smtp-Source: AGHT+IHknLGJwo1dZZlB1b6P3ynSOQKzTXmXy62zaLKX4wDxFaEBVQxKejLei4la9mohWs16XOWfwXwEAsj0
X-Received: from pjbnw4.prod.google.com ([2002:a17:90b:2544:b0:32b:65c6:661a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c2:b0:32e:3592:5807
 with SMTP id 98e67ed59e1d1-32e35925d53mr3068756a91.26.1757874697522; Sun, 14
 Sep 2025 11:31:37 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:31:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914183131.1962210-1-irogers@google.com>
Subject: [PATCH v1] perf symbol-minimal: Be more defensive when reading build IDs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The note_data at ptr is read as a nhdr but this may yield
out-of-bounds reads if there isn't nhdrs worth of data. Be more
defensive before doing the reads. This is motivated by address
sanitizer capturing out of bounds reads running "perf top".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-minimal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 41e4ebe5eac5..aeb253248895 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -42,7 +42,7 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 	void *ptr;
 
 	ptr = note_data;
-	while (ptr < (note_data + note_len)) {
+	while ((ptr + sizeof(*nhdr)) < (note_data + note_len)) {
 		const char *name;
 		size_t namesz, descsz;
 
-- 
2.51.0.384.g4c02a37b29-goog

