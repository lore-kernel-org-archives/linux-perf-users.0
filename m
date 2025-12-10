Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB6212B2F
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393313; cv=none; b=huv3lDueo16kPWdoYDfcFQN612UvYXvEFn72xoJ72tP+r7gMjjOQsJd+Qqq1gmZGdKbIiZiJoatwhPUyYh8W8O8I8tthhB0as7PzRlvCGkPR+LVnOWMAH1achGtMj+JoJ71s/KU7VvXLuPZesLY4Jyxbfpc3Gi75TA8DUkiO+rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393313; c=relaxed/simple;
	bh=FxNVjac5sB3JjXL+1wgtJAhWyvmK12EXQVV5PnQnf08=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R/piUJDsxBwrQgK6Mg80yQBIung/yuSugzudsMdlplZV4h3Cx5qf/Np1g6iG3E4rkoW3BoUPzl5YRTbzwfiEfcnk1Uf4aJuXSTzJckmYCoGOxksLi2ikqweggtYYcUDsRrdP6oYdGFeiq1d4GG5YHHJ/ADIn6KIaW50b1j/kyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktTuXPDf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktTuXPDf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29e921af9easo3105085ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 11:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765393311; x=1765998111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iLa8rbDVYJxy3GTYWmwoFT07T52idAXSw7nQeoKmZ7o=;
        b=ktTuXPDf7i6sgma8FnACmk2c5kNWKC+3Czw9VY755BV4EgUi4uUrM+II+2ZT3Wcgjw
         WYZB3mBcK7G2U+x185MDSB4WsXL316WZeVCin2ADrP7hezRPFQfpvhShVbAYDhCs4sFI
         /Oq7hS5cbD/yZAQ75uInGji8dVHqgvjQW1NArL+0GePiqUFlQ5f/MZqssuzcOJsr3fdj
         PTt7OYsSuUrpaVCA+VH2sdLX77sxZTM1qVvWAj0n+tetzw65PqbD6LDaD6j2Bd573Ivn
         b/iif23PrQvosn08t5lkihf+83EghJ0jNPVgouGSOCXUo3AM4T4vSXVXBwZ+TFuETenJ
         Ircw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393311; x=1765998111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLa8rbDVYJxy3GTYWmwoFT07T52idAXSw7nQeoKmZ7o=;
        b=jhallUjTQJ+Q+qXeUd3g8sUjPlDs60cKQlJ+Rc2UvTnPHxfEp4hrTaEa+K+uuBr1WN
         5hw5oHrCSfj+/ldgascTSv7bZONieA1OZGyHuSiquZLllBOFJtHXjJbVluS3T/4b/5c5
         4MIp/rXhvPYYK9NyowEmst5VK4gPW5diqa6jVw4N7TtCNCEQdvNJJwwlhZ2czmaLtgiO
         Bu+bK3HbFeUW5VNnu04TxeKZdWU9xBcAN3w0OfWqLBjzPzSKXWks+rXrgyJtHTucEtUC
         FHtt6sqfE0q+UqeMWLrPkFZdFYBMgXX8pmQnDeYEqelSr1hdnCI6hJh2h2dEt226CPK6
         sR1w==
X-Forwarded-Encrypted: i=1; AJvYcCV/Opd/fZmiI1ab2fJyIu2vfn9TQHRs4plYNQMGs9o0emxOyd0hPGQxwYM655Kn9v9vur/+5Kv+Fy3AhbFb+KcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZT0OcFBamidk5VmUk71ZbwdAa//dzY73dLGJImhqjCNQT/eSO
	Zscd2vtQNGlsJq8BrFe8pJA/f6s2SGd1aeaQhcdr4UY2Aj6fvamibRrQ1W84HrIWv26ispg73EL
	WoXCxNUcQ5Q==
X-Google-Smtp-Source: AGHT+IFUMM43jqyFl0EA8WmiAVdoWHQ6tN/4gYwlT+U0jftpvjSLwyJ0JxD21DBDOiOzidtFl5XvkJA32Ftv
X-Received: from dlbuy1.prod.google.com ([2002:a05:7022:1e01:b0:11d:cf32:5409])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:221d:b0:11d:f462:78ac
 with SMTP id a92af1059eb24-11f296cb3f5mr2290936c88.28.1765393311182; Wed, 10
 Dec 2025 11:01:51 -0800 (PST)
Date: Wed, 10 Dec 2025 11:01:41 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210190141.12725-1-irogers@google.com>
Subject: [PATCH v1] perf tests kallsyms: Fix missed map__put
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Issue was caught by leak sanitizer and the test robot.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202512101502.f3819cd3-lkp@intel.com
Fixes: 34e271ae5538 ("perf test: Add kallsyms split test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/kallsyms-split.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
index bbbc66957e5d..117ed3b70f63 100644
--- a/tools/perf/tests/kallsyms-split.c
+++ b/tools/perf/tests/kallsyms-split.c
@@ -148,6 +148,7 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
 	ret = TEST_OK;
 
 out:
+	map__put(map);
 	remove_proc_dir(0);
 	machine__exit(&m);
 	return ret;
-- 
2.52.0.223.gf5cc29aaa4-goog

