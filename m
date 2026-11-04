Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825971;
	b=k0+0MGanRZopBzAvaAY02aKV+KvfmjGnfI56Eb56j7Z5SCi7NyR2OiR/o3UlOfU0dod7
	 ELeUXIvI49ZjAz22xoXsttD/o2OBFWAxkZD6+0KJKaIWAp2ySdFJ364XGKvkYyygzREUT
	 aOkG7hmaTs3+wI1upDE4DWtniJDj5L8c/NTKtCCNkD9ZQ+OB3IPs9bQtoYtCDSZgxyJNQ
	 wXuORMijrBVvCGtAOJF5i5G2dDu1GU+Xd1tfg2tIgM9MPmYlsIeFzMBS7ROipeg60UWcP
	 8xapnc/S91wbVL6GVqnyMi8z9PzQ7R982QS05EeePvDjWiUc+R+6T67K8BPCV5J7fSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
	b=smyI5vunNdokZpXVxCbKrFmpxCEsK8WvXVjli1SCnmJ7Y+iCFCEQE7eeztLx1CKoCtyh
	 qkAQm2uaBQMORu7PleAB5J/yRoP4hlrtKxFnDNYrkSMexxzVPPOBKe4Mbn2Zv2SyybP5+
	 v6Pj5zy35zDcPvOHl6pdBuuVDTGh+9aN/OrC7dQur66fA53M+zX4f2F/33agcmZriZ5UG
	 oXsQjUOEROBcdTXQv2d7Zq1UZbk6njVq1eGXUp0iwi34sOtuunx3ZrEqbPiyViI/dWclc
	 sOzmBMdO5W9QcnNPVLAYjuJdddYYbFgBAXYDz7OvTylVeBhRRQwxY9EZn507e18YJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T3vMVKSd;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEA606D17E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DEEA606D17E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T3vMVKSd
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36d69ab3c2bso827230eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825970; x=1794430770; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
        b=T3vMVKSd5ZsM5hgIKPp8icPhHbFw++ZgYVxPBnXCxlyMRyNuij8osWSgeUrDlcJKOE
         kNbkXqhC8enTVdGV5IQjrtyUNC6IigNrxhGiwGtVySzFImZzrySYDLrcd2anm7VfAOjn
         6uiVDk6gzfiqdYpPUqsCn++c5iZxno3Clw0mq76OOnnLVKHLwvK0pSq0WH0EFh9DzRcf
         UzPbumOE5K38sS/5tIZT17+BjXnZtpUDyuJ5GamODLhC5+dQWMi/YB4YbaNKpzOTJ0D8
         mZ3eDS0IHSAEfeIybnik1e5fmV1yqu0oJgNikAzp0o3X5uPmsxdmr64sr2cIFMBJjtj4
         nDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825970; x=1794430770;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlGmy1iETR07VpwAF3gSNr7L3yDUEizC6SlTALxKZy0=;
        b=bcG7ybC0jmDht1sho5elWAUuotAVEowULU/7vglkn5YH9x6/81PDis18dgxnweWfoh
         QdGfu6vcnfQlV6L0Amv1jnAfRsLdUwiupSLG0+mLc5DiAVgksIvBNQmUrC2rqmNIwCnA
         ycEgUWSz9qgzL0jPn731tSaAWqv0NHf3K5dchENkouXstErSevmGeoLMOYwqzVQv/hVz
         C9rlNVuj5d/lVb+8XsTtBd9CvYi1wIu31hS4LTE+614Uq8yooxUymM+vPXDSVpmKw6hm
         cUVNaIekLzAoac2so0uTvEa9xXIuYJfxGZSvgk+v1UoA5BFVHppF+939p9bDvucRPcHr
         DjUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuGiLw2Rgg+49YhPgqcUVU6ahWbJo9C+W8myjngatwY6WqYJabm78mpANZofsGJ8HtF9gg7XB7z+rQUjsFfLsR@vger.kernel.org
X-Gm-Message-State: APuU4Z8wHPn0PivadpmU9Esyru0vuXD2qegxGAmrJdZ+YNiQEQMRdgOk
	CkBfGBZaLeuxHhXejpapmlVeTkV1ErCaI610nDeHn21CADCP41alTnvMqJPVoY2On1QhrPbLhkH
	r1YLcWt49bA==
X-Received: from dybml13.prod.google.com ([2002:a05:7301:150d:b0:35a:3045:15e9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6381:20b0:36c:d1fe:84ce
 with SMTP id 5a478bee46e88-36cd1fe8f91mr4237665eec.33.1793825969426; Wed, 04
 Nov 2026 12:59:29 -0800 (PST)
Date: Wed,  4 Nov 2026 12:58:56 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-7-irogers@google.com>
Subject: [PATCH v9 06/19] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 6343a3c9debe..9fc4e91a36e9 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
 
 static struct comm_strs {
 	struct rw_semaphore lock;
-	struct comm_str **strs;
-	int num_strs;
-	int capacity;
+	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
+	int num_strs __guarded_by(&lock);
+	int capacity __guarded_by(&lock);
 } _comm_strs;
 
 static void comm_strs__remove_if_last(struct comm_str *cs);
-- 
2.56.0.455.g6c5a503b38-goog

