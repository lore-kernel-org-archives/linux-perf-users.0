Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43D25A2C9
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824754; cv=none; b=dPrg39HRAt+eb17abqNmF09s+AOIjN2w1VDIjEGob+Ts4N0NDJe9YPzlT6sYeRev4PfNc3TFR8hA/iBrzr2HPz2LRLjzI3KmgXKbChAnaTybPWV0tP6jLflkwfNMf6T+Km9ObkDDaKtnWy4FwnXvFsQL3xX3QzDhgVnohk3CflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824754; c=relaxed/simple;
	bh=xAFg8zgkKdwLH4pyr1GKk3ex/m6Sg1pSmTB5DU4tkvk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ccGUxQECzQJPdpXZNThbKADPO+8tvObJ9uDNmoSHhagOVE6IEMoMJ8qd+NVePJ0Er2zgWrMlZKS2VeM5qmCxHwmjMkV1S4prp2U0JocTS0HGnhBN4xqdWgGhaTBfeDBZOSVPJsxOXWpmAjwo4Oj82uKJbuZTUMScO6JyvPhrFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yMVvU7bG; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yMVvU7bG"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2be2f742c46so18878506eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 11:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772824752; x=1773429552; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=28NLJG5tyekf2B3gw/YpvMmeB6EaLfZh/gYVw4RvfY0=;
        b=yMVvU7bGdsgcjsV8KR9Y74fVihi7V5pqNudcErLoTszDbzEaanpsWqhdGoJFKCOD9O
         edOPuyAZQCR1L9Rs6aUVaXdiotkA5jehFIQDY6MqEPkRYJR/MzR1yrHuA7R87D/+FzNu
         pfmR/OCe7wTx5fMRlLh9lvw/6Yqg4b7DAyAHy5DE32MprJS8soexwz/Z+0PaMXkz+HEQ
         60hUi7wZzLB3F70TMqxw0RULHSphI4DYMhMR1MqpCX+FBHxUm1CsE/yeFl5IgMC9yyYy
         byRzBzQIM9vEaAtluT1weCCQSzwqAxQ8DYCn+h1JgJE6OpHNzG714gBIA/eLcL4a8QmX
         egHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824752; x=1773429552;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28NLJG5tyekf2B3gw/YpvMmeB6EaLfZh/gYVw4RvfY0=;
        b=fu5vrekMIjRX8jNtG1mJ2dx8xyqE3IbHS+piqu35XpX8TGE7jpCQ58mhLYd4cw7qkE
         4MN5XI042KSXhz76FkhQxQ7TxUSXmnQSZ+ywQbR0g+FTFwpwd1Bfjuxj1C6krSAGNmHz
         yA210rMuGOzkffYe2WvaPi9zr+7tG3ZU5yuYCdKUYcJArALLAY1+2l7qwBqD2TYMZMzA
         2r6JgW6lLvZ9emzVbYjOapfchEGAmKBqf91ZlZ4HV0XMzh7L+Jeb7zP9KDW+jWADSIEO
         zA2Ha5nv3iWuXdJ3rSdGEUW0ldm3e+QFXAhi9XgvxRn4yQQvZp8RE0OEoCRWxn7yQRFQ
         V5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVCPKPx2fuJQedy2T/Qmuvm/eBmuSkTO5K2eo1bxb6piG8KFbJj2woUM+Ms2JTkCJS2MyPBulmqLvp/b9hevnc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkk6Fr+5v7IYMo1QxDcEadno3rzFrfX3nNsmv/sBkOhLjBXJEZ
	hgdPcne8gBmVFYPUyxf0ZCu4UJQpCIFIGYep/mEIbRbVgZfzSvK8ZAa+yKtOtGtJE+cOZxGSbLV
	T9uwG/xpU6g==
X-Received: from dyax21-n1.prod.google.com ([2002:a05:693c:4195:10b0:2be:3b4b:b1e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d17:b0:2b8:c1b4:9cb7
 with SMTP id 5a478bee46e88-2be4e02b8a6mr1339040eec.22.1772824751332; Fri, 06
 Mar 2026 11:19:11 -0800 (PST)
Date: Fri,  6 Mar 2026 11:19:08 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306191908.2065682-1-irogers@google.com>
Subject: [PATCH v1] perf build: Add -funsigned-char to default CFLAGS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") made
chars unsigned by default in the Linux kernel. To avoid similar kinds
of bugs and warnings, make unsigned chars the default for the perf tool.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a8dc72cfe48e..3820bdf73f43 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -349,6 +349,7 @@ CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu11
+CORE_CFLAGS += -funsigned-char
 
 CXXFLAGS += -std=gnu++17 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
-- 
2.53.0.473.g4a7958ca14-goog

