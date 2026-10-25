Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965313;
	b=E5sFTYSt9E0Bwrkrg0q/s72nrPnzOoTIuef1u5kZYr7anZFvBiV9jJvxXMHe+gmFqU8A
	 Sc3yHT3I6IQPAo6fzacWofZ+6+RFeQub8pU9+nLld8v3tPVsEzZI7b0aKlrLK4rLGr3q3
	 x4ZluXnJKmwbXgVu9ScFih4hPl5PUe27riYdITStuKCQODk7wGzlSzeAQuh4Nlhv1QCNr
	 O2K+zZAyqV7rofvUg68bsv57ZFeUPVCgr5sKH4AytNvcHCLbXpGDGMVSaJsZowqY5cl+2
	 S7D9a3mculBf7j2/tcU3uBtvYHYpqzEZ6Q3k7oLVqUkdhQbKqaSKLNeSzYIVj1B6FyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Content-Type;
	bh=Zt7QpncNg8RgMDpa8gtNEv/aMDccF33cLy1R11uT760=;
	b=yqQWamWINraK8Kz6Mggzqv1sBhAIlVqD5W10hAlZovNRaGU14jMm/e4EAw+atLKH2XaX
	 fXjCa7t8BLlv4BdGODuNJpTK8r5aWnsoPj7uCkAKoZFNhaXiZN9xgVnPqpvxDbTgeA2t2
	 I5OnKwa+Kca/eOxQr5VFisrRpwOdfxUHA8vf6X9uNccXgkjRGVAUZDWN87rGiVEX2TVcq
	 L0E3WkuPJKq6VLpsz8dah+/9Y7ePgR+K4lIRkiqXDFUiKLRSyZ5zuIcIRJ89FRZO1LBkH
	 AWRE2xuMlGgco77YLvlq9W0G716IBKxIr743Q9rBc2PcxkgvJJfvvmlsFt6PxZdlA5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EBL7BMDM;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77916606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 21:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77916606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EBL7BMDM
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35cbea41088so3826436eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965312; x=1793570112; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zt7QpncNg8RgMDpa8gtNEv/aMDccF33cLy1R11uT760=;
        b=EBL7BMDM8qK5AC8Ruwgd+bBlnWfa0sHgWhTuxq+tKAsCo0IMoayWpO7q72uc91IJxt
         0g4SdgrCKJ8aHBCleF53D1O49oi3SVWuMxfljxZlLnB7GOTqyIMw17s+TkTBD+DrQRrp
         SL2mcxenF5slkIJvqBAbGECjD8Bop4fSzRUh5uhQSvf6Gz4iMUVziQ3F/yz573vfCQ11
         v7X2tTKr+0EFDvILsv6Ml/pCEbcsGEF7wpictU7vH9t5lPiuMCD1eEwZXJ0Ljnaye5Pt
         N+cX6YExLQubWd0n78kX7g6YshXpL+Jyh5TJtlZdzFUTYGLaKQ5SU9YJ27WlXIGM3bJi
         OSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965312; x=1793570112;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zt7QpncNg8RgMDpa8gtNEv/aMDccF33cLy1R11uT760=;
        b=MHFG+RSlJW0wCWoGIqAiGkLKJVV0gGkX1ILVkMssSanpjfQnxPseLy+xISlhOK60Px
         MErayUgioiMtviwu3NGVtYw7tnLD5EqZfS9FrxGSBW87F7zaqUVn7crpK9vX5Hb8hrRK
         +sXf1BS5cR4Zjth4ycr/lSZ+sqBNZYZ8dSd0JfV/g97qum//8uaB12853cCLzmQudzbp
         x4fJuY59x8qpKCe/wgsMX5KJU2NpVJlzZ+QEDXbdqt0AEm6l9YfFxwcmCzTpqpUvIZiD
         P01+frAzVjmbRJ2GCRlSf8+IgkNVHHQGriKUDlGtXoVOm9g2Ajuf4ozNcaXEbkpYe6Ze
         NTeg==
X-Forwarded-Encrypted: i=1; AKwUvBx5c4LIk5VgPwLtFjiQ4l3aPcDvUJt2uMx9xeF867QCM0WMJv0Tvjz2+1ZlyehT6F4JysR1DSvOef4UUeyi+m17@vger.kernel.org
X-Gm-Message-State: AFq9FYJhNpRIoZIaiRWMv+zqRfG4yPMG+2GfNB8D1sOT2aWCE5YmNbBt
	NTATjSLAYR3WEBflK+KDI+iIFaTmGYusVNPqPE+V3qrWh2mkqZj3NDND9bmHlQvgIsPNxaxtGv0
	4sXu/jAz+ew==
X-Received: from dlbou3.prod.google.com ([2002:a05:7022:1103:b0:19b:4a9b:8cc1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e803:b0:16e:4723:5f86
 with SMTP id a92af1059eb24-19936a60764mr8643547c88.29.1792965312166; Sun, 25
 Oct 2026 14:55:12 -0700 (PDT)
Date: Sun, 25 Oct 2026 14:55:07 -0700
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025215508.1237480-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf/core: Include attr.defer_output in is_sb_event()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events configured with attr.defer_output = 1 receive deferred callchain
sideband records (PERF_RECORD_CALLCHAIN_DEFERRED) via perf_iterate_sb().
Include attr->defer_output in is_sb_event() so that such events are
attached to the sideband event list even when no other sideband flags
(such as mmap or comm) are enabled on the event.

Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c4217c996f5a..b43883a42566 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5347,7 +5347,7 @@ static bool is_sb_event(struct perf_event *event)
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
 	    attr->context_switch || attr->text_poke ||
-	    attr->bpf_event)
+	    attr->bpf_event || attr->defer_output)
 		return true;
 
 	return false;
-- 
2.56.0.307.g5fe7bd680c-goog

