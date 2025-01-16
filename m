Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3922FAC3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069032; cv=none; b=lC/tPaYV3wiLkH65srQnZ0Fda2jMtq9zlQeRzwv8i4nX+PW1cX7zwgYQU5191uO5uaGADXISjUEYYqZ3Gxyfp7Old94Na8Dk7i2Fgu9IfxkAOuLX0gRBwhzdlKl5PNljkpybc1ecpX86Ua/CYJykRnvpbXnZHt/At6ZqV0PaEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069032; c=relaxed/simple;
	bh=bF/cdbPvyjz0FfZNx2ey9irVZg4a8yyfWpE7AZtnRxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4E2Hzzq9AZFLCCGngxd4c9Xw5ZF6KzZ41xIcUcoo9XDKqGwJHsumkGs4CKcE2LL989SyD5EI58JK7AY0AlQT1ILh/WjIhNvmu6Y7jMghJH6tF3GEege7OHXWpi6dBA1rr5h3LeGbqsifgTtU0eZ4ilKz5EBP4B9+wV7Xp+KilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BpGfvkRW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BpGfvkRW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361f664af5so15764055e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737069028; x=1737673828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih0D7I8XCBuUn8cwCzLwA9EVpPglV1xp5bSahtqmwB0=;
        b=BpGfvkRWn9kpf0xiC6LnrTpHJCPPft5iWuctLPwOPCconJJVRoQxJNEOk5Nz3LN9nm
         QfcRK6C3G3My22pjoel2v/kkeVy08qsfRPrAAAvnaW7ypHM8fStIqGe+8Taabu5FHHN8
         4ysAGmUlTpAX60CrSe/K3f0BflhltF845bpHF7dLY3IYLLgSbp+Gnvsx4fydS7IcENbl
         pjqbG7TyC7tYmQ3ZT5YJ0t2zvv86hEgGF6CrBa3fI4vtWuRvtoGB211wm+TjuzPyr1iZ
         VyNCpaZU1ybG/5Wky5tGE5UgkUJV9kdOfDyf7qYiTkk4pt+sDBOg/RzYn9OhJcjQTkUX
         dzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069028; x=1737673828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih0D7I8XCBuUn8cwCzLwA9EVpPglV1xp5bSahtqmwB0=;
        b=eREkvA0BMzF6q50BSXpIDTuBggEhMQUTennlVgRd8za3ONnMSy4oI/0wJnmtvnZZ3s
         zjG5/CrtTFGnLSInzdDra5FqOuEwcMgITiclutkJltkyFblxfSKw0Ujn5WDB4iEqfg+A
         Mbxy4zWLRi30wa4ZZl3o7oPQpfuSJtgk8QqnUszzTlOAmogAuqfQeTZjf+OrrI2C8uxi
         fwyY0l7HLkdUprCMwbnCj0E+xEQf39ivoacwV0i6ufpB1mLj/g3lwa87jPQxPFgwJzRU
         QWhMSOsUolxlkVTWqFAeFBeIkho1hYx330BuTP1XfdjBTwBeq+YZym4qXKGVcw8xeTHl
         3SJQ==
X-Gm-Message-State: AOJu0YwwGRNX/JcWqKjydsrtvKUL5jkYhuAK9Rpdagaa9gJkP6G2Kgu8
	QGedLSnwnRG3Kv/bPpzfe4kE1gQueAPf9elWOjRTuBsdsKeNepwYsQQNgLleYmw=
X-Gm-Gg: ASbGnctiLTXhWzQVolv/8DIU0sCu6XX1j/J2zlvYym34HXg0CEpKus5IQC+RRNMn5DO
	kWUMehpveIUu/Q3XbDUlZK3eLlbKdtmtmRExNaGJ1EvrryqKrRX9ood5cSXTwji6hDtQs9sW1Dr
	vLQ1Pt8s+MyY15E1fwusT16TFzRL+T00CzqY4XZp+VHQyVnV4/dM3VSvcJNb2Sb46i7+EyMZiE5
	12Zp1v6YaHS74tATABd/S7Wn1fuljlHfK99WMTzjSX3rKI3kSkH08gAtRwqIqK7nbhHLNOmoQaW
	ICkZtf6JREgNcOeD
X-Google-Smtp-Source: AGHT+IGZkSeIeWLg78b7QIySnUPbuLbB0vhAavzUj7u+Y4mZGnlfT+raQ/EoGquZ508s9+cVypWC2g==
X-Received: by 2002:adf:ffca:0:b0:38a:88e2:e6aa with SMTP id ffacd0b85a97d-38bf56745bcmr243859f8f.29.1737069028398;
        Thu, 16 Jan 2025 15:10:28 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([2a02:c7c:75ac:6300:b3f2:3a24:1767:7db0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b337sm974991f8f.59.2025.01.16.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:10:28 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	vincent.chen@sifive.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v2 1/7] perf: Increase the maximum number of samples to 256.
Date: Thu, 16 Jan 2025 23:09:49 +0000
Message-Id: <20250116230955.867152-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116230955.867152-1-rkanwal@rivosinc.com>
References: <20250116230955.867152-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISCV CTR extension support a maximum depth of 256 last branch records.
The 127 entries limit results in corrupting CTR entries for RISC-V if
configured to be 256 entries. This will not impact any other architectures
as it is just increasing maximum limit of possible entries.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 tools/perf/util/machine.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 27d5345d2b30..f2eb3c20274e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2174,25 +2174,32 @@ static void save_iterations(struct iterations *iter,
 		iter->cycles += be[i].flags.cycles;
 }
 
-#define CHASHSZ 127
-#define CHASHBITS 7
-#define NO_ENTRY 0xff
+#define CHASHBITS 8
+#define NO_ENTRY 0xffU
 
-#define PERF_MAX_BRANCH_DEPTH 127
+#define PERF_MAX_BRANCH_DEPTH 256
 
 /* Remove loops. */
+/* Note: Last entry (i==ff) will never be checked against NO_ENTRY
+ * so it's safe to have an unsigned char array to process 256 entries
+ * without causing clash between last entry and NO_ENTRY value.
+ */
 static int remove_loops(struct branch_entry *l, int nr,
 			struct iterations *iter)
 {
 	int i, j, off;
-	unsigned char chash[CHASHSZ];
+	unsigned char chash[PERF_MAX_BRANCH_DEPTH];
 
 	memset(chash, NO_ENTRY, sizeof(chash));
 
-	BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
+	BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
 
 	for (i = 0; i < nr; i++) {
-		int h = hash_64(l[i].from, CHASHBITS) % CHASHSZ;
+		/* Remainder division by PERF_MAX_BRANCH_DEPTH is not
+		 * needed as hash_64 will anyway limit the hash
+		 * to CHASHBITS
+		 */
+		int h = hash_64(l[i].from, CHASHBITS);
 
 		/* no collision handling for now */
 		if (chash[h] == NO_ENTRY) {
-- 
2.34.1

