Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D803303C81
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764888929; cv=none; b=p8KdQCIhIOg6o01UQ1b3nrVa57koXAhQ/pAn3+aavpU5NBXIMqcjUhfvYuO7PzvJDmG9YvXVJyJ5l896igU1EZbhJaELIL4Se6REeQ/BWXUTydyp4ehKWqPItvmku61kQpNTXZo9ETAJBtO5dWEUYW29K23QHpzANzteH/8TlMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764888929; c=relaxed/simple;
	bh=G7pNIVhA1TXObmnFY7+cd5kvUOCU2C28ebfuPdpleTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gwRS5qssU5agLGtUhNxYl19Y5NWZuJZGtkcubKNVHNIY5au+eaPZGLw9A/uoeqbmO7OpI+UapwOVALzu98vENMmYNJBxXHJJgVIqubBckeleJvnxx2ZXc0/LUTs+t/DZxHdnpMMSt4uBLQVDpPN1IfMs9ZwQqvOcj5kg6riNHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aG46mUQQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aG46mUQQ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bf493d248baso2363766a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 14:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764888925; x=1765493725; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7czelWahvvfZQW+IquXER+uuj/HdN565wv3OdCn5dY=;
        b=aG46mUQQVayGeL98QawNrSwxmV2JwtvJ9ZIJy7ZDpkdZQnDTxMNBS6YBx6rFdU5piI
         lVP8mWbZknodWiRb+yZtsgLu2T3gHCLM3yU1eEp3WUPHMftAjqY+/H6NT8rf7yzs7pka
         0Y4zLuSAjhvOYWzPmRscmZDlxCeMUsfjAxABiY8bLQlqxnERpbKHDCjqjmpWROG04VM0
         1aSTpDHirR+ACfTLdii/szMdGTHI0Fx7wqh7Vr3YYxtSv+V5n24XaGxb0ObeEKir+W9C
         Uu85maWYjDGooTmKWnvcx4xZ9IlIv1slLpDeHsSysdbDyiyaI4dun8pWUvZje5Cxbfuk
         ZZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764888925; x=1765493725;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7czelWahvvfZQW+IquXER+uuj/HdN565wv3OdCn5dY=;
        b=vTs4cef9rRYGhdvcKe82zJixxhQ6FKC3rs+cbbrO7clXbgGHJ2fBehgIHqgstJa0dq
         c6zMdkENmQwdpJxbIfLn31oK7M1stmLtdENiLGozhowdu1iuFUKdNiQRsMZo9w1YMebA
         2vztdHvIyx85GCCBEIThmghfXBj76xX7BcJ0VOOcWPsk55YlSkVNd8DPf8GTK1X4QWv/
         Iwo3oPQwsidnmn5DqrIPbSamJMbkocq0fVnvhl8ou+DNUQ9HCuefH/YrCktOdx1KU/Le
         epsdmWen5jNO/w4838X6lq2hyCt1P+gkwXLhWbEZBPHXcvpYjih6tly9glZ/aOU0zfrE
         cg3w==
X-Forwarded-Encrypted: i=1; AJvYcCXxB89cKm64b8VbP0r8dPJCeEqFZoVZSUqei/hKvFTWWCkrlJvAyRi/4biDJxe1JeuF1gxG1j29s12KWApjPMGC@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYI/p/whdfmIEmnLVgtovbXwjQJa93fM+hoPRtRrviEXKHroZ
	LSyNtlQXEKg/LJuui8gaOGCr1PQp9bpuyaYUZI3Q9/KXoCgCBe9B3D09K+QrvxsdXdmxGUCWvek
	rV2lfDJdSXQ==
X-Google-Smtp-Source: AGHT+IFxsVk1sW9cjUulSOztIaLSd39e7TdMm+r1aotcotXO7b3lEV0XaciSXdvu8cMA9M0vfVhVHWzKwQ3L
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:2a4:59ce:b584])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4283:b0:2a4:3594:d54a
 with SMTP id 5a478bee46e88-2ab92e3a972mr4367342eec.23.1764888925427; Thu, 04
 Dec 2025 14:55:25 -0800 (PST)
Date: Thu,  4 Dec 2025 14:55:21 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251204225522.648456-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf tests kvm: Avoid leaving perf.data.guest file around
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure the perf.data output when checking permissions is written to
/dev/null so that it isn't left in the directory the test is run.

Fixes: b58261584d2f ("perf test kvm: Add some basic perf kvm test coverage")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index 2fafde1a29cc..2a399b83fe80 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -118,7 +118,7 @@ setup_qemu() {
 		skip "/dev/kvm not accessible"
 	fi
 
-	if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
+	if ! perf kvm stat record -o /dev/null -a sleep 0.01 >/dev/null 2>&1; then
 		skip "No permission to record kvm events"
 	fi
 
-- 
2.52.0.223.gf5cc29aaa4-goog

