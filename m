Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F426059D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788312; cv=none; b=aDxwl6VCE6dTMDJNWXIuqcqVMunb957oY+R0NUOedbcKPhJC9HH86206puyINW/e9O7sMVBqvdukA7wNrEAhbtFq3TucaS3pyH3ku6tQN3xAzD07G2MDIOH4CByxpLbs1/io3LxyDB1MDdJOqoZpiftjHguEA3ILnrzxJ0f/9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788312; c=relaxed/simple;
	bh=asmP0qeugLU/V1JRT6RRfUReFv9YHoje1JUYz2LfwqU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ucWHtNNgvN0V/c8bQx9tvo2A5R8NAaUfGVrJNtC5uqURuiWQyBeYNjD7QS5AppmN5K0Nze7smnRKBRgQaz/uv0/u9CEXH0h9b9E6oP2cFi8euGocSQurWt2vztI8iVL/qjIGXXL/c9qeOhncTIzqsFMD1ySG/GNxmFiGBdQgl3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lu+7Xk3x; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lu+7Xk3x"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba728aa1f9so9688455eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 21:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770788310; x=1771393110; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=beRb2TTWipjbQS+uGdF7qNhcs02FsUxfsSX1I2AUdlY=;
        b=lu+7Xk3xmQfUD3Bb9hPhTmXwbv6ZSk5dlkvYBsUlPVdXz9lyY8xuYZZLefZTHz478d
         OR0aY74fErY+mhmLf4++Un1XvoIHqV4sUaKYwW/x8w7DQRbxJWa0HKI7tOa7VUNmhm/g
         tWlKFptXna5jwQKYAwQmFsV3ODoewZWBykU7/ViW8LzVJtYW3T8PV7Y6g9aCP+mlI62p
         uKFBUsGfS+1uKbp91RZiZJwqC3N6630vTbyZLEu4cSN/W/W8i4VLs515cUAf60jTUVu8
         Lvs7qOVKxyye5GhUfrNSaW+x2KHWTe7HJRRb7Nt2MKE0Jxdv68WB+trvPEMCERXyNxL3
         XMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770788310; x=1771393110;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beRb2TTWipjbQS+uGdF7qNhcs02FsUxfsSX1I2AUdlY=;
        b=Qeig3AO0plRC0seJHCRfEfkR7ZJr/EUR3jrPUlgZQHyJVLWQm1P5vgvNvuApdJ31kw
         uSIMKeyNJaQBbRZIYuEzEz3GyPjgjybMp/ria4edJrwiaMFoO8sMxIqf6KvsKaSx7mIC
         QBfNLB5B8adMsrs183ne4LXBC8KT+HEk0eTwOoSt9BgR6sIsUufSwDVI8pTEBTl4PAfQ
         /l5bbOJOG6TcvaLnVjvTSVbF8sAr5mEWI1l1Ab9wQfRIenUZQ35+C0v19envFwCZD8EB
         JW18Eaaf6Qr7Bfufh/tPKwkBissBhhbQjYvVwPmeYP11GyLsvNMGpQ5mUKqt0i+zV4Kz
         I/+g==
X-Forwarded-Encrypted: i=1; AJvYcCXDMO7TNyT/n61qLK/CJeygH3hKMPqz8pji+AUGH0VDxcnguT5CFC8t5cOH73OvOssuAYeIfnpP9y3tOyQng70U@vger.kernel.org
X-Gm-Message-State: AOJu0YyysaU9sD+nre8tkvzfSNKkV6XatEsxfhbGpeiDamy+s1/3yx8U
	X08iQ1sfHgv4rWBnSWulrahRGYBJTWilvoYTOti2yqRl5scH/5ouSXXLzrkYWoHCpnjAOUcoapx
	GD6XBSQ0How==
X-Received: from dycpq7.prod.google.com ([2002:a05:7301:fd07:b0:2ba:66cc:afc1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a189:b0:2b8:30b8:58cf
 with SMTP id 5a478bee46e88-2ba9b437263mr614633eec.8.1770788310286; Tue, 10
 Feb 2026 21:38:30 -0800 (PST)
Date: Tue, 10 Feb 2026 21:38:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211053827.140534-1-irogers@google.com>
Subject: [PATCH v1] perf libunwind: Fix calls to thread__e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the missing e_flags option to fix the build.

Fixes: 4e66527f8859 ("perf thread: Add optional e_flags output argument to thread__e_machine")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libunwind-local.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index ecf0c01fe51f..5b39ce21e333 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -584,7 +584,9 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
 	}
 
 	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
-			     perf_arch_reg_sp(thread__e_machine(ui->thread, ui->machine)));
+			     perf_arch_reg_sp(thread__e_machine(ui->thread,
+								ui->machine,
+								/*e_flags=*/NULL)));
 	if (ret)
 		return ret;
 
@@ -733,7 +735,7 @@ static void _unwind__finish_access(struct maps *maps)
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 		       void *arg, int max_stack)
 {
-	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine);
+	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine, /*e_flags=*/NULL);
 	u64 val;
 	unw_word_t ips[max_stack];
 	unw_addr_space_t addr_space;
-- 
2.53.0.239.g8d8fc8a987-goog

