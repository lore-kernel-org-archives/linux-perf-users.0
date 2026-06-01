Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0BEEBA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272364; cv=none; b=QxPeywvC2oDHcOL5GTvjMi8n2FoYKTJ9Wynh/xsaj3rHgpoHWfJxAEnRyzTd/gR8tbgRz3GAyPLdRYo2MBCniPPjEgUPB+L1+pp3Sz3DB0y8joPdjJDoZJumlfWGIkStXFu5zxC9aDs73jLEh+MDBIVXUTs6tZJjhDh8Q8y0ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272364; c=relaxed/simple;
	bh=/azyC5haL/dW3FyM5Jqt2igHjHSKZJUmmyQs5uzvvOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsAKH1h09jT/fbBdrEl5OhWBp/vVJZ0pQGcHtF0MfXYLIVHhReIaF/AvikuiEpGt7QtPQMO20rmazkHCZbnxQ0pBAtVqzf1yvGwJERmDRIt5x4n62YSepvXTOGH53jTjfpzcsNSN0mkaYLOuv4CtRPaZe4n7yaNgg4UARyjKm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMx1HpTb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMx1HpTb"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d8613efbso4164046eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272362; x=1780877162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=TMx1HpTbNHtXKF4ZnBgNz4nJhDSSSHyzQxR+ww4l2n3krq9MYuTNTOD92BntHL5yB2
         OTDqGPQzYizV4uwjARS/8rcu7C2jjSE5BhTmBdpqFJ0I988T9ArbnxVXeCMwt/9SfLEb
         8wGPqoB0/EMbKpFpGJJrfVSllxaMZbgesK/fFy5uLUQ5NTXQDaJItswpG1zn+uhh882z
         SRW6G+Eu27NBXaCysjvCDJRs8p3VFS3qTAcZZArhzJTgfFeQEzQe+SmNRmbzyQweDCOJ
         0l4pVIWNJlVl0nJ2LuISv+SLMMGpiQA9ceTkvKvncQcQqk5FdgZqVUCuvPtMKona2k9J
         awzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272362; x=1780877162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=RF9UaFV3n49RlUVw9rjrwrOuRPsQTyh2R+FszXuqdo2KvpnhUj53MflQcMAjcdQ6/D
         kPx5oaA6xriB+/P4d8GbP3QvvL56Cb/GHxrV3bVS72oeKP7nxcMmJhOQRAb7eB5UZsNc
         biZxQQZWV3MO4GlVkkRMjaVq4Zc9HvInyBj6Pby/ARSRW0z4RALTjBxBx1SwNsz6FJ1i
         VH/PqAIYEF8Uv0x2P5YohIAxWHzBx5XxDpSoblx1qQLvQNh8kDrz3GOfUmwmWKtPCiSB
         Wwx3Sc0XiwhWlXn9RcJCUYHoqL1QX3QenjQBrLdb3zImPRNWO2X+Bf/SOv/4WyzdFAM0
         I8Fw==
X-Forwarded-Encrypted: i=1; AFNElJ/o4yUifZdbvwMun2qlFXg6W/fo00fjcfxVdhzJ58OszNBkrEF7R3s9AipwKhu9v/5eifWpMjE98/BrQjMH5Gzl@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJ3VCzHq0JNtvCpPl665BxUamVP0NYbAgpeaIdeLusCcdgRoT
	kItnA6izGfbqOJ+s62QSEZWA1DtlSIzqgB4XcXDkN766y5GlZuZ7rV0dK8gxunJKGEkYDNNDzDS
	oj95taAad4A==
X-Received: from dybmt7.prod.google.com ([2002:a05:7300:d587:b0:304:dc2f:9939])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7495:b0:2dd:8ac2:9f7a
 with SMTP id 5a478bee46e88-304fa54e972mr4013073eec.11.1780272361644; Sun, 31
 May 2026 17:06:01 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:36 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-4-irogers@google.com>
Subject: [PATCH 03/15] perf test: Drain pipe after child finishes to avoid
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

