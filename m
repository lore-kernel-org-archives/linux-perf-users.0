Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EB320CD6
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214679; cv=none; b=uWNU5FZ5L7DQbwwWrSxGI9/IT1eCAsb64bGnBeMbZ3RKJNiAI13aBU2RV5GeJg7iP//fMCcbUIf5lXdAVPgyCoRQMNIPJ/jJedDbLwL/2541w+qyWzmwLqYHCaaCzaMvqwchvDqkiIUvqaHEyJAu4qQ93xPI1aHxYxYzq8vykWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214679; c=relaxed/simple;
	bh=rsaUlilR4zlx14pPSiGgEnryXMhb6poZxT3Su5zDMT0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=l39806s9XqXEc3vALlgS4TvOSS0+7mlMN6Pi1hwKRLLdkmW2R0htnUG9pX4ZNGQSbOctBDSwwEac30fnRBVymvtWSCwjbdrB44gsyjxLFpOi2/c7j5X9/4tT5hip9w84L5YXb7ROOwTkll/PT8BiQkWFYwDIClScIVlwAtzyEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SS6xPvnd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SS6xPvnd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e1cf9aedso97284285ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765214677; x=1765819477; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=plmdT4T309mL/O3d0Ofdm+hZ9Zpzq3B1rKSl3iyAnfA=;
        b=SS6xPvndJqaFlTH9KBCbIhmDwjfVF4OpXUcgx8lOn6coXl/zb8nFSO+OIigi7rFxIr
         NEJDMHgFmLAXd6daglhddO/POw2LSy6psndvJF+xD1+/KgLylp4NyzUxSmgXMr5FfLxh
         j0PAxiKMeDvbukAdrEzYrJNqqcZrXmcU/wr82botc2iw/KbQ8mhn47IP/2jGejQYob74
         i/eAkkhirjgN8hrUz1jfk0g81T3dHyo3Eg50sL1WB0UUF7ZtdTnfQ1/k+/iEAyt7IPIV
         ql2iqvH/pDePX9n7LvhQMC036OwqRbDGRCs394NOcWIsx89T3qm7KWMjm4bNce13hUv5
         zIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765214677; x=1765819477;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plmdT4T309mL/O3d0Ofdm+hZ9Zpzq3B1rKSl3iyAnfA=;
        b=O7TofZxRiHSkTRiIWrSNoCkF2XFLHeBEoOzYSP1mUqtA/ECJ8/zlDlkYpBqrHnDgUY
         GCi4l80e0hdAlWLNJ+ob+K0dNiRURSCsfMolWKB163kML6kcl1eNZPTem+2dTWxInBbN
         x3xLFN1wx+ET4jJGcdpvDuFYSY+kvqf7E5gDQNVqj8b0n2XCTURQ8It1JjOAbrFmBBUo
         qbkVqamZUfDYjaBcN+gJRlht/zah/Krt37DyeFPvYIwA0b5CFHCGHdOS4rKrEofEP535
         z+qN3IV4BoTn4zOxenunAIqA7nVuoeTXMwZvSZDJ1VYrANq6PozYt/jYAMWrZqNpII+H
         UtJw==
X-Forwarded-Encrypted: i=1; AJvYcCV0GSX75BlMzdIIC4FIJij5TminOaLZUjmxP8gByUX7y5pyun+hmnFILNmwcWIn9DaTxcKwZm+2xpMD0G84uUIj@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFtSWeHZY7k/gwLVTcJwTyaz0lJZTpK/7ZvFvEpa8nj2bQuHp
	79yLF9ehohKKvh4+Qp73VRhBFD0zn00YhSWnWe5w/gCOM29kv4D1DpU0wkfb3MS0LT8iSVc+zsI
	EdZNiqwSy4A==
X-Google-Smtp-Source: AGHT+IHnfbpBOYqgrKr1qf5mGnmx6aJYnheXiYX+tnP3ZodmtB6au6b5imfXxW1kemaKk7EYjgesaJr+bf5s
X-Received: from dlb41.prod.google.com ([2002:a05:7022:629:b0:119:49ca:6ba7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd07:b0:11b:89f3:aaf8
 with SMTP id a92af1059eb24-11e03166321mr6500028c88.4.1765214677266; Mon, 08
 Dec 2025 09:24:37 -0800 (PST)
Date: Mon,  8 Dec 2025 09:23:39 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251208172339.1445817-1-irogers@google.com>
Subject: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd names
From: Ian Rogers <irogers@google.com>
To: Sri Jayaramappa <sjayaram@akamai.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test is based on an error/fix poseted to linux-perf-users.

Reported-by: Sri Jayaramappa <sjayaram@akamai.com>
Closes: https://lore.kernel.org/linux-perf-users/20251202213632.2873731-1-sjayaram@akamai.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/subcmd-help.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.c
index 2280b4c0e5e7..9da96a16fd20 100644
--- a/tools/perf/tests/subcmd-help.c
+++ b/tools/perf/tests/subcmd-help.c
@@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct test_suite *test __maybe_unused,
 	return TEST_OK;
 }
 
+static int test__exclude_cmdnames_no_overlap(struct test_suite *test __maybe_unused,
+					     int subtest __maybe_unused)
+{
+	struct cmdnames cmds1 = {};
+	struct cmdnames cmds2 = {};
+
+	add_cmdname(&cmds1, "read-vdso32", 11);
+	add_cmdname(&cmds2, "archive", 7);
+
+	TEST_ASSERT_VAL("invalid original size", cmds1.cnt == 1);
+	TEST_ASSERT_VAL("invalid original size", cmds2.cnt == 1);
+
+	exclude_cmds(&cmds1, &cmds2);
+
+	TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt == 1);
+	TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt == 1);
+
+	TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "read-vdso32") == 1);
+	TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") == 0);
+
+	clean_cmdnames(&cmds1);
+	clean_cmdnames(&cmds2);
+	return TEST_OK;
+}
+
 static struct test_case tests__subcmd_help[] = {
 	TEST_CASE("Load subcmd names", load_cmdnames),
 	TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
 	TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
+	TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_overlap),
 	{	.name = NULL, }
 };
 
-- 
2.52.0.223.gf5cc29aaa4-goog

