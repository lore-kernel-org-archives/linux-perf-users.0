Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59603812FE
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215775; cv=none; b=blbslfDu1prlTNc4RmBvsHsFSNiupx21JGrIdnp4ZE7gQYlU8k9lAnrqojqbVemYyw7HuWOamBIdPTIynGpnZEniv0sWPRzwc5Uip1zsPN40JkU4cmCyHpUvETWWqfcY4oo7/1ZKaJJwxNv7dV/Kr4z5XgfZzgE+bCpVcAz5bS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215775; c=relaxed/simple;
	bh=/azyC5haL/dW3FyM5Jqt2igHjHSKZJUmmyQs5uzvvOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vhh1PCucPAEg1mtNbfaZbKSi091H3bmc3WwDNSalbcC57IwB5LgIDRPJdWX08IavvDEspCN7rwwEl4aB193btBWGmY16IKwktF1GdBq+3iHbuc8q1lmEH+fnoVnNS356+AiD2C6EN0u4toprb+YOXeW+ha5FPKNhluiXm4/cXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3CPSt31; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3CPSt31"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304efad654dso6216269eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215774; x=1780820574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=K3CPSt31hRs0h3hOIxNFxccivnUjVLUATvtG3GQcy6S4rY8Ph4H6EQ30WRophVMq6S
         1Y4NRwFkHKWzZ3DZ7rmX/ShioqpcL5LheNGQRnrekWimSkzt83l46qSHWXT5XVDCOf/J
         v7TkHpTHYqrEUiNePWGIyoP2c+eqsg+NZKqzYzYPDCNO86wS8dKuCzwV96Q1kB7aCYD5
         uOlnplJj5JLiUwsAxpLqmIin0OXu6yUHcNsTY/s8UzLMfIQxRH6wPxxLujsaAzQ2N/Kg
         I/wyZnsxaNM0/g8OgLwRteKbl7owk5co1PFTnz/MHCxlog6pAuau0a3TMORAxTYsI5w/
         XJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215774; x=1780820574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=ARzd1yP6l5U+9WzmQXFuDsVvU29HL8qufK2tiJyJzom/7oGWuwAiuTFODwFWbVJNiT
         gpNRSe71aMlTxokjQFVLsmJn3R17QADtocpd9oxM034ix+Kuh0masLRshwIg/Blh9BLF
         Oi/ILfV/UQ8k1LuBSBV+tQL0u3UCAYA5QpUZfizbuzaJ4GXGGG0s+P17eK5nFeFH7Awe
         I29ngDwv+RW6TUIoNmHS5FEHejq0WHZyVngyH62jJbPcu51+tEcL282GqCISM+yHn9f8
         ToSbj0kN2JqdD9rvO2ML7jdmNHFsBS1MSdONVUvyvJp0fauo8KSExQ0IBP6bXKJXJqWZ
         k5/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/BxJ0jdmLMQQa/57szONzhKO+kSbzTq8UbeJ/QEt+o2ZQrUr8SoOrUFaq+ZPrqzjtrm23J1wNwh1iZkTExeRq6@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1S3UKK6o/39huz7AJB1ysBak1PJYwq6i7LDN87VKs2B16K64
	DS4ZB2vdiRTXz45n0LasXxD9fWfYyNiE52kie2OX/+Znevtbo/JMHYTlghHWy5vr7rGqHF1nEE6
	C5jvpauUiSQ==
X-Received: from dycoi10.prod.google.com ([2002:a05:7301:da8a:b0:304:e0af:c9aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a44c:b0:2ef:8b91:212
 with SMTP id 5a478bee46e88-304fa589a60mr3088796eec.14.1780215773609; Sun, 31
 May 2026 01:22:53 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:23 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-4-irogers@google.com>
Subject: [PATCH v4 03/15] perf test: Drain pipe after child finishes to avoid
 losing output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel, the parent process reads output from
the child's pipe. However, it might exit the loop as soon as the
child is detected as finished, potentially missing data that arrived
in the pipe just after the last poll or before the loop terminated.

Address this by draining the pipe after the main loop in finish_test.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index f2c135891477..7946878195b7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -483,6 +483,16 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		if (err_done)
 			err_done = check_if_command_finished(&child_test->process);
 	}
+	/* Drain any remaining data from the pipe. */
+	if (err > 0) {
+		char buf[512];
+		ssize_t len;
+
+		while ((len = read(err, buf, sizeof(buf) - 1)) > 0) {
+			buf[len] = '\0';
+			strbuf_addstr(&err_output, buf);
+		}
+	}
 	if (perf_use_color_default && last_running != -1) {
 		/* Erase "Running (.. active)" line printed before poll/sleep. */
 		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
-- 
2.54.0.823.g6e5bcc1fc9-goog

