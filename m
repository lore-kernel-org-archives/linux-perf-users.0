Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1201D9A5D;
	Fri, 15 Aug 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282483; cv=none; b=Ej+d4XYNOaNlCLwOnenmwd+gReIsUWIENg8E8rESZjFy2dOHi32g3U4CdxNcqQCys6c7niTFkQzQQZMbm8XtvIAkMWbVpRrUAoVVDWCisjbpVahODXgmYKTgKZhgIq7Yove+/GWezC42eJbKcdljohRr5nUfYCycx8lS/HUHJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282483; c=relaxed/simple;
	bh=WcIeLS4ZXXoXdwDG9ZrZOy7xFIgwGO4Az7+RoIiV7CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gq9n3Y67qiKegRpX+GjRxH92wsoGQwQ3iuQUf4Cq8VPhipFauXFpVAsrZIyx0+NnNJPSUbAaMkt55oojAlXVO8N7+vkHmGTWuVBsBt9p6eV1sCDHa7oQG/R2TT7t9iAz+N0Ce8w3UrxffarwoGjNYyY6NUEBDoFE1s2Cy3+TotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acct5J4R; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acct5J4R"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47174edb2bso1609785a12.3;
        Fri, 15 Aug 2025 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755282482; x=1755887282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRc1fd64O4J1Onrw7dVFQU3zu1pxcaQiGTVN2LS+H5M=;
        b=Acct5J4RuqPDHQQ62RwBYC0WedB2zbP9rNuCGMv+mVfFKaUqEusdj5Ax4Wjg7sGMZV
         n+7qCMQbsVb6vowkoR2EGQJAbRD/7jQm5uAvX3FtHrVLI5TLiQyT+edaswkFVWabyh1y
         uQZy7999sb80XOEBMzL4hnojOfMC0//pbyf2Td9ymxJ34Uxg2tHjrHr0h7HrgET6QX6A
         HYOQWuSjUtrxZKXylqrtC2761NN7SPs4VGjm6WPOYUyr7iUm1MQQCKJORZwukz8uYuXB
         KKTpz3EJgzRMCxPjNrJTbV5gaeplKh82rD0Zjnlw0joBboWzzE3Xmxm5otFx0RXfiZrQ
         dZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282482; x=1755887282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRc1fd64O4J1Onrw7dVFQU3zu1pxcaQiGTVN2LS+H5M=;
        b=aL3HHYALYbebX8z3wk61qHdVTkXg4L/XvatiDFtz1EK3XECTZEJqO9Yu9q0huFzyRF
         1AuYjq9IDsR+MMUEryt6TL3OTTOfnASLGysztWqF8eOioTssKofhGOQlq5nsFtFCY9dS
         F6O9L8NYnMpojdD6DDBG18A/PcMa0CLBtHYoN2EEQSbdUygzAqJMVy5T7wgUo1CGvdvw
         UrgDGEx8JqlcpEC9qYPY7pub3uldv1hpm4DTgTE+6FbR3aFKjJ82F8b1KdU8fCe2JFD7
         8q7fMlP/Q9gIqqP7mLkqrZEdhs+H0OCEFg95nS8YVWeqbNAUQFG6nWdsVt8ZLklxgtMC
         BexA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWmB82ncA24sGJFAjCzMxUP0CWd1tjpzTMOzNHLmMcC348w5GrqDdNLWWC5Ly3uXJu+l/VG2kgptn@vger.kernel.org, AJvYcCWhgls1xzTOhvieU+fk0wNVlUwfGoqrevQ1XwbEu/IJsZFe+6U1ZScLDvqL6PK8DiDxX4w/JfjRUzfjM6LaWYQkmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lYUCAy18h73tcynTRq8bcuVXhK9KIfq5IYKXyDNbuhcqC380
	TEKyHCZmWR/9rUFLQqkSIS2123/8ZEu5Q5OTUXG/e7II+O30JcF0636JION+5hlAYq8=
X-Gm-Gg: ASbGncvBO7o1yZyKXYnEQCjwL2EcwYue4oLaLteW1xu7Qa5MSMXJffh0EouyA39i5Hp
	M+mHqK3hVyupVP9ItZCxq3DP2fG8bpZeHb4Bj6TTiNWUhj3NQmYL3r3f60clwpCkBmG2T7uC+Jw
	OfebRuCzNavEahe168RTE0ygQ5YkjQAVpLHRG8CLHiWcxu7PooyPm33POs1Rftl8vPS8/XEyCx9
	DmQVN6FCP9zbjQd0rrPPjrWj3QoT6qTJVKYYHLUoEMK0HBU33WfXe8ABBD7GBLcimU2yEhosY1A
	1OSAxQ975ByGJDdShwgAc1wUhfEqhpG5qkYkggb06BH49xcXcbV8KC9mp+sX82DCMg/k0Strh9h
	KirF4VQf85LbecUejmG74uu5YAirpF/u5
X-Google-Smtp-Source: AGHT+IEHD1GjcrbAdBd7la+otQhbrqDF5HpTciQ3G09/nn/3VnQgMLKqhY0XaiQcIXJt9SZb1N/YZQ==
X-Received: by 2002:a17:90b:3fc3:b0:321:4765:a423 with SMTP id 98e67ed59e1d1-32341ea7860mr4878289a91.6.1755282481580;
        Fri, 15 Aug 2025 11:28:01 -0700 (PDT)
Received: from archlinux ([2401:4900:93f2:6a91:9b6f:8f9d:11b:d64a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343994891sm1791582a91.8.2025.08.15.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 11:28:01 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
Date: Fri, 15 Aug 2025 23:57:42 +0530
Message-ID: <20250815182742.45541-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the fixed definition of TYPE_STATE_MAX_REGS with architecture-
specific values for better accuracy across multiple CPU architectures
including PowerPC, ARM, x86, RISC-V, MIPS, and others. This change ensures
the type state registers array size matches the actual register count of
the target platform.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/annotate-data.h | 45 ++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..0dfb12a8f1cc 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -189,11 +189,48 @@ struct type_state_stack {
 	u8 kind;
 };
 
-/* FIXME: This should be arch-dependent */
-#ifdef __powerpc__
-#define TYPE_STATE_MAX_REGS  32
+#if defined(__powerpc__) || defined(__powerpc64__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__aarch64__)
+#define TYPE_STATE_MAX_REGS 31
+#elif defined(__arm__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__x86_64__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__i386__)
+#define TYPE_STATE_MAX_REGS 8
+#elif defined(__riscv)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__mips__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__sparc__) || defined(__sparc64__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__alpha__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__s390__) || defined(__s390x__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__sh__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__nios2__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__hexagon__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__openrisc__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__csky__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__loongarch__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__arc__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__microblaze__)
+#define TYPE_STATE_MAX_REGS 32
+#elif defined(__xtensa__)
+#define TYPE_STATE_MAX_REGS 16
+#elif defined(__m68k__)
+#define TYPE_STATE_MAX_REGS 16
 #else
-#define TYPE_STATE_MAX_REGS  16
+#define TYPE_STATE_MAX_REGS 16
 #endif
 
 /*
-- 
2.50.1

