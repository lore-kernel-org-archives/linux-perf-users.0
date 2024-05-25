Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E124200BF;
	Sat, 25 May 2024 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678135; cv=none; b=e3sDLO0KmzI1+TYby685KWEQyiHDMBjopX1fi4qsmSVG4/YxEHcpAeOKHIVlRAiTiBp17v8623yVTLfuThRi9Q8ICQVPv+RsaGg4LkiYvfD6hoB3ykamnrlGBnvI6yd3eBxhbszFc1ksP5Kx9yuvv04zaoPR3P56NcqpPuf6JU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678135; c=relaxed/simple;
	bh=32TpEg7mbtsP22pyXmQOaEALFdcn0NvGD121juI2+lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luim2H/fZR519J2syv76CuWncA+3+hnEdkQNTxUPGkWszswWPsVnumc6oFqlX+Kc2Pp7PA0OVWwJiwwPdmigCDAygLCu3f39PbMoyJa1DstJ/mHsaPtbt5p/AZEtCA5duj6BtNU5i3XX6Y1BtOtuOG3qfyu4i3PjqR8AQ9CTjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxObI9HO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxObI9HO"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f47dbc4b36so87845ad.3;
        Sat, 25 May 2024 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716678134; x=1717282934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3PCNm2PrVqSXiwVAkw4KJLtfDypumGImUuknWeBpCc=;
        b=ZxObI9HOF/GiSzmwL/9f2nPmQ9UUOtDkfy9Fivxh3c22p4qTObopJ1R14+gY3Euxhw
         99mmybeGgZPZzb5JwD/Vp5gum3WSWPuAjZLQFb7AzcV8kLqQQ3GHKk1Elit7UKodcEv7
         gcNUZ12AQyJLu7cL5KpjPfRMsQAXpEQUa/8rxm8ovWWF+kGmM390zyIGGCp8u7QlOI5g
         TSvRCXwzfiHxaAA5GaYLnxrB6bd+w/PDyK8CMde3f31ZfsZvT9lUhAoTWP6aEwGbUR1+
         l9raUq0wcwBqWFuG/MaO9QclPIsJ1OTsNm68E12prAYNGr3NNadYap+1C8TuwMNZPxPf
         VuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678134; x=1717282934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3PCNm2PrVqSXiwVAkw4KJLtfDypumGImUuknWeBpCc=;
        b=cva7UJRagl2NgA7H38TYsstYzEnjOpv3Brfq+CzL9zBSG4OPmmfa8fmDcuf/WJv5DA
         r/2HBNSUWwhpP+rS4dNvpwZ6ZVpwKoEyWZbW4gMm6qHVSuSGY8v7N81kIVrxR4YE5Ciz
         vWpsgquKTXEhIreExLjrA3Yaq9bm/KIupR11pktO8P13g5Pn3FBLV16uiFkQUOVbmFuE
         ZCbsX4P4uFonw6HddGZ8SE6/jJM1dAh1w59GTdQpPoKH1BbLXkpG1ThY2v76703ePELW
         ACyH6qD1aSuvVPTnwNSilZ3fei51obgZPwLMZ5mNfK+5jmvEB34HobdRTDHFCjHADlUD
         iqQA==
X-Forwarded-Encrypted: i=1; AJvYcCVLYgZkM8TiD08Rbj6JPQ6HjkM2Y6E+Oy0m/ZbmfUDT8ytf7fuE7a4m4wLHHRPRbWh7xzSc4KhOtnKCpTpHbp4YNdgS6XCPrw4dWRC21MtWBKGaZAKBq48pWtXyAoArcnY1D3p2/HhCj9kZVQOrqw==
X-Gm-Message-State: AOJu0YzaYt9rBmDVPOS24OJHcwwJczM07gNajYvTfmTaLzp/ekuS78Bl
	OIu2FZSPI1z1KQAWbmf/zRwB4sAw78WHMBaqn05jg0z0mZIegTrw
X-Google-Smtp-Source: AGHT+IES9C0LpZKNFRzpaeAwHmQYCfeHCSkheSxdZpzmjRumDi6kIVTkffhg2CshSGHqC4TnndOQOw==
X-Received: by 2002:a17:902:d503:b0:1f4:81ab:7574 with SMTP id d9443c01a7336-1f481ab85b9mr9250355ad.5.1716678133658;
        Sat, 25 May 2024 16:02:13 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9e43c2sm34717035ad.308.2024.05.25.16.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:02:13 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] tools/lib/list_sort: Remove redundant code for cond_resched handling
Date: Sun, 26 May 2024 07:02:06 +0800
Message-Id: <20240525230206.1077536-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since cond_resched() is not called in userspace, remove the redundant
code in userspace's list_sort() implementation. This change eliminates
the unused 'count' variable and the associated logic for invoking cmp()
periodically, which was intended to trigger cond_resched() in kernel
space.

The removed code includes:
- Declaration and increment of the 'count' variable.
- Conditional invocation of cmp() based on 'count'.

This cleanup simplifies the merge_final function, avoids unnecessary
overhead, and has no impact on the functionality of list_sort() in
userspace.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
I've also Cc'd the maintainers and reviewers of the performance events
subsystem because the perf tool is the only user of userspace
list_sort().

 tools/lib/list_sort.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/lib/list_sort.c b/tools/lib/list_sort.c
index 10c067e3a8d2..69affa251fa7 100644
--- a/tools/lib/list_sort.c
+++ b/tools/lib/list_sort.c
@@ -52,7 +52,6 @@ static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
 			struct list_head *a, struct list_head *b)
 {
 	struct list_head *tail = head;
-	u8 count = 0;
 
 	for (;;) {
 		/* if equal, take 'a' -- important for sort stability */
@@ -78,15 +77,6 @@ static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
 	/* Finish linking remainder of list b on to tail */
 	tail->next = b;
 	do {
-		/*
-		 * If the merge is highly unbalanced (e.g. the input is
-		 * already sorted), this loop may run many iterations.
-		 * Continue callbacks to the client even though no
-		 * element comparison is needed, so the client's cmp()
-		 * routine can invoke cond_resched() periodically.
-		 */
-		if (unlikely(!++count))
-			cmp(priv, b, b);
 		b->prev = tail;
 		tail = b;
 		b = b->next;
-- 
2.34.1

