Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A36383C64
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622993; cv=none; b=SaQNb06ZXDMWMsgUGljXLVv9QBSt5gSg9Sy9g6arDIA6AQmSxMbYQ0BZsLn/2oJJGKnvJDar/Q5HBL87YtUqT4AO650uKunyQDe2ULOGx6sSE9XrVy4d+6ftUQwpTAQ3suhNKtrBqgy2V++xzjEASeEW3CfvX91z/ZiznTJZ1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622993; c=relaxed/simple;
	bh=lZQ5R82Go8EjmhEhW2KVTtlL6ZFkouEuVxK8QJhRkE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tW7wKBq3L2BTAQhgFL42paAAjAxh0+Rrh6SLUW1R/XJLjzNV83knMDNDR6Pv8M0b1c5XhqIKTYeAe7C/SjIoeyQ+dh2VvTNz1J6qgQUj3IzppnNgqC1c+lY2UtieErNSgDJ3BTciJJ+ZN3blTlHcitnUep53iSBSEOv8ULMN9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxdBluAE; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxdBluAE"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5195656eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778622991; x=1779227791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DkxCYoF3euI1RKVY7jskhywtHHrXaSIyAdGraG5hGHw=;
        b=MxdBluAEDVnfpov6EVkNplS6zZJBYIFlSaXgLDydjXSgx4AUVBO8nfBOYqqfVpgCxY
         7DkgDs6WLiOnHsmM80J2eCtSe5uPItNOPZRimzXu1+vuzgmezmNh+zmg7w4/II916Hvp
         UeMjEK5z0VsHxk0mgDg46pbepNLjq6FO9cWWem8XCJdNnSivIMIQsdOfVhC07vtR1YL2
         H2F0pdXX65EMqgg1wCEY3VS0xRxQ2ReIeYAJ2/P22Su/O3QXG/Y01pje/5UmPEP0t0mP
         WLBHJoPw1ry0+RljI8OafTY39LLasBmSv7xU6rdE5FC7SmVU+3YzWJuME7NgK+12ZOPq
         R3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622991; x=1779227791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DkxCYoF3euI1RKVY7jskhywtHHrXaSIyAdGraG5hGHw=;
        b=sXllMOYk3gn0jM5QoISh9nTcP+/pcxkPiGi78P6c9iaMU7S7dhq6btsMhYoURv/see
         /nu53jVHiRmhV1atD0iwqKFyR8q+Sp32UCiVnX2j21VF8KcYiHM7OP6q2K3vFSmPKFyT
         l0XBFMA8P/zPSBgYDM+qfV7aDplWPGN9+iLfQlLyUPEksVFgLqy1WrggjuijPBJwPlQV
         EMSSH8gIa0RRx+18VVA0nSaVpXKSli4Fwk9B+WHRkA+7IgK+0MiPcjyW166C/QaVcWJM
         31GGfldfNoauGuQgca1/hyRaxDJn5/3tWxG7bVJMwswkuAMwVKWIvS3z4x2oR5UFAfyx
         96pg==
X-Forwarded-Encrypted: i=1; AFNElJ9jdCGWtgz5mJ8y/qSaItFk5UA43+Fy3APyrd6iCv+zhqVlP8zzmdOY7TyhQn3eSys251g+TYHH7+pXW0NsV6pq@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiUkEok23zkusPG/sQSpb1ox1LCp/5Irp1sIkA3Z/436OEb4X
	1Q6BGL8YzHXRxCqwOnu3T+k2lJVZGTpzYWIaEGX2/6lgVxOMgU1Dtxm5jZn0FF7hRgIfOYvSRB0
	VtJ2DzY2RQw==
X-Received: from dlaf15.prod.google.com ([2002:a05:701b:240f:b0:12c:b3eb:b31e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4586:b0:133:12af:9ce
 with SMTP id a92af1059eb24-13436baaf07mr403196c88.35.1778622990600; Tue, 12
 May 2026 14:56:30 -0700 (PDT)
Date: Tue, 12 May 2026 14:56:20 -0700
In-Reply-To: <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512215621.468685-1-irogers@google.com>
Subject: [PATCH 1/2] tools build: Add libbabeltrace2 feature test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, derek.foreman@collabora.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, mingo@redhat.com, mjeanson@efficios.com, 
	namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"

libbabeltrace2 is a rewrite libbabeltrace from 2020, add support for
detecting it so that perf builds may prefer using it to libbabeltrace
which dates from 2010.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature              | 1 +
 tools/build/feature/Makefile              | 4 ++++
 tools/build/feature/test-libbabeltrace2.c | 9 +++++++++
 3 files changed, 14 insertions(+)
 create mode 100644 tools/build/feature/test-libbabeltrace2.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 2f192d3bf61b..5425430582d2 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -114,6 +114,7 @@ FEATURE_TESTS_EXTRA :=                  \
          gtk2-infobar                   \
          hello                          \
          libbabeltrace                  \
+         libbabeltrace2                 \
          libcapstone                    \
          libcheck                       \
          libbfd-liberty                 \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 704c687ed3ad..9cf00d3fbefb 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -49,6 +49,7 @@ FILES=                                          \
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
          test-libbabeltrace.bin                 \
+         test-libbabeltrace2.bin                \
          test-libcapstone.bin			\
          test-libcheck.bin			\
          test-compile-32.bin                    \
@@ -311,6 +312,9 @@ $(OUTPUT)test-timerfd.bin:
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
+$(OUTPUT)test-libbabeltrace2.bin:
+	$(BUILD) # -lbabeltrace2 provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace2)
+
 $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
 
diff --git a/tools/build/feature/test-libbabeltrace2.c b/tools/build/feature/test-libbabeltrace2.c
new file mode 100644
index 000000000000..0c964994a34e
--- /dev/null
+++ b/tools/build/feature/test-libbabeltrace2.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <babeltrace2/babeltrace.h>
+
+int main(void)
+{
+	bt_graph_create(0);
+	return 0;
+}
-- 
2.54.0.563.g4f69b47b94-goog

