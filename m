Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF21C0DCC
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008874; cv=none; b=egjrJKeG4QgT3taMzktgsLENJW0tPUzsulZadgsvQ6n+ir/LIN8yND7gI3LOWeaYWD+bm9G2Q7qfiimzu5RRTzBACJmfucXwQ0CbDCt1NttMM6CAHVaoyRITii9UiNeYH3D/qAhrn0OQXnaYEEtJUUj7MyGo9g3rPCg4aC3AypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008874; c=relaxed/simple;
	bh=vJl9tQ1Pqf9QGonXEZ2iQ0jeNMSCWZFnU88m6CXe9t8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LV2pu39+Q2q37iKfgpWkUxMLs+WuYLg4Em5IQ9k8Uuyl0T+JPmllQLdqsWOOWXv+S8q2cbVVGa4IPrV5cDLng7mZTdnNr4dfXikR8DmJxUbjn6zSC964o82jcNqowgJdWFyjRHypWSGjQYUw2bj+f54XKIDi96m9JJX5py32T6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B7t1zk4w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B7t1zk4w"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421140314d5so576525e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717008871; x=1717613671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=688BMYms93lIkdSUxmL3fbJu+G2/bRYi5WNxrC0uGt8=;
        b=B7t1zk4w+lS+6fejmWMRCnqIqLH+yDS/VC3D3KnHm37scq6XHxH5qT/r4oudrL2b62
         y0txXlkoOmkbhKNguBGQboAjQqx/q5aDYEMYOAXei6xEAwCo0X3HYCZ3egLQIj6QrOxJ
         AjFC0HLielbh/z6mHRrdIwikD6mNrdDH9tUXvJhGunfUlS2L0AvVr6KVjoClkAs+C1cc
         K6DitnoI19YYp/NXX79oGrViR2KSexj/eRNVbsw53alWIqOTqv9CKPQpZun3I3mgtODV
         t53WiPPHtQE5oasYrHspszZgqCJB0S8bhRdYiGZFNrVt2abPULeo1i/6bc12gFFaFSEb
         L8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008871; x=1717613671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=688BMYms93lIkdSUxmL3fbJu+G2/bRYi5WNxrC0uGt8=;
        b=udgNGyHYWJCkbPwOtTy4yeU/cHt3iqPCZoIqOu1ih2evwsTUPpN1ywcIVKIcOrEfuK
         J9OcTOkzej/1YLxbMiqb5bQPWAKPmivg2qE2/mRQYiGcgwq1ycLJrFqXGa9vZXInQ/TP
         xOW2+40gtvcOW8K+l2Uai/DDJ4x0iuiBTfb2AllSDwZtd8Qto5L2/SvJdFftFyRmzRtf
         xQ0vhwJM0Ve6dRBiINf8B8gVyugPeHb4VgWd4w3dPA2ZiOPrJGIe8KpDoygJBOfQthVK
         cEwEydG49ilJV43K66K0SlzRBc7XqE0WvTxVvG2sLnKfIKHljP+78UzlXRdL9Ww2Bkf0
         em3A==
X-Gm-Message-State: AOJu0YwxrdLAQhoUBR/w7TE/ffd2iMedbqFeI0+O8SmLGJ06/q+gBpZl
	ClcTsC5OC6nJQ0JfHvEyocpk3uI+wye6C2d29yOEZRMKJkaPFj1SqGrhpxoOxmk=
X-Google-Smtp-Source: AGHT+IFXjh/sO2hf9fpunrpzb5/Ur0BabTosyM0Or0Urw/4lUp/bZLnXNorWqgLPv7xYyl4q0uveYw==
X-Received: by 2002:a05:600c:4ed0:b0:421:22c4:db60 with SMTP id 5b1f17b1804b1-4212781b273mr404635e9.23.1717008870867;
        Wed, 29 May 2024 11:54:30 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a23csm2787885e9.27.2024.05.29.11.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:54:30 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
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
	tech-control-transfer-records@lists.riscv.org,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH RFC 1/6] perf: Increase the maximum number of samples to 256.
Date: Wed, 29 May 2024 19:53:32 +0100
Message-Id: <20240529185337.182722-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529185337.182722-1-rkanwal@rivosinc.com>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
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
index 527517db3182..ec12f0199d46 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2254,25 +2254,32 @@ static void save_iterations(struct iterations *iter,
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

