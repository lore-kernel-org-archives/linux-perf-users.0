Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE03366DDD
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102247; cv=none; b=UN/ul6xw6sWauzfci50NMB+5GtS/Ma6fi1qPfsYVKag5iJIWIUy7XM9ICoPiGUp4Iro4uoILnOvdZGuHCNfYKzdrgj5Q5HEeH514+gUc56WCnJznDAI4cUOEUxic3BO/vHwDG3L8ep5Em52v63S+kAzHqxeUPVMQl8fTycjaoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102247; c=relaxed/simple;
	bh=evG4RfQJYRo/3pFv7i+uMNlovxZnzcoKlntEeOtLbZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2lE3EancWComEWmOmJmWCkJcckeR8ilBOsr+fv3co/uFNwQkwU8U2MqzgD3vamo2LzekobywvWSI/62Q0f4gqhwi6JHXQIeb+XEZ9ED+DL8KN+Ikp1TdPnssL6VWTU8lP03qiMZNvD2uRmBA/aP53kSmKaDlyVezUbIDiaEwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNlHsC3q; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNlHsC3q"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c613a0ca52dso646971a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769102236; x=1769707036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f8NFYeC0VnU4tU7qZl9s2DqzXH53qrThNK5lEVTJREs=;
        b=MNlHsC3qaE1GVbj35qav4MydC3NQxLd90EiiBZhyVklseeaAMIBLs207OyoeAOpeEy
         EOBOz7TMkTUs0XtH2mcgbNz4Cb9eVw89iaVwLDQKRrQAy0DW88hIac0vLyC1E4P2GaMG
         S/6k71dVAoLblfOCEzkO4qr0pVesz2xwP8QOhAc19wn4sVm87O0Uq2jpKFW9Iv2Osixm
         tcUESPCo3lOtIwzsnxGNjsEMOs27MNIh9DW2zb0L01BTfb6qDtQ/y6C7mnXGaX8qrI/c
         A7INaGOIjAqm24++rZr7KUihONwNwAuR8Cfy/6CTY7wGU823iEJHscHwsW5T2ue1qETe
         k5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102236; x=1769707036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8NFYeC0VnU4tU7qZl9s2DqzXH53qrThNK5lEVTJREs=;
        b=K68oYzpkWczVD0L0uuu6xOhUwjFmqMJgDGOm+hMpnPOmylz+nTVvN+MLcOeYQxEzJu
         g4hTUW9MtDRHIKTM/acGzTTAqcLRcFct9hJm5I4kcNvC9/NJYW9eeqqFrHUuZnAwy8TX
         K+DRcqcOKMI8AEbgu2Q8IsIq6FunFh++vzs8+xXsSTLKSCmag1aEE48dGW2tD2lgUkqr
         p0+nDUgaZwQK92CmKsC7dLnqs4V7VM3x7wQy3CqGJR25NKd08VfrN1iXWX3y61E/KvUA
         akPAVa9QOtnTO5EZrFs7+NP/MAfKDiCB+4Ra/CbH4Na0YjNKiJ0TcDaRwfsXsh2sQ/nC
         8LZg==
X-Forwarded-Encrypted: i=1; AJvYcCU7KUwDmwWp/ozWfF6YDzPeg2WSMQzvJP5IWCKoAplar6PuB0x5qQ03b4dqdJKlTMjRZ1JTXMTKcMWk0ywQqvZy@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLorjiAOsLl3Fhhnv/84Yb6O65j0b7VD+vUArAT0wN16Lec9h
	WxX61laP7UC85RbknQws+2sHmt+33IJLIzEx7GZ2wFDaMX+nTfCTQg9eHyRmyg==
X-Gm-Gg: AZuq6aKxkQEZncLiL2jdnEuCcCdEyEQ2rStY8WTa6aogehyPoz6RATxo9ez00hnKvAY
	OIwmA1hr2NIAPNdwu7iwuvWxyrY46lC3l/DMQo7814mbBLUmWg8uUFciMel70lUNQN0CxKLpx4N
	gOlFpgldKwgFo12eXL5GToLgyhJ/gfp/33x58kDnYLNgAeNR4EqS1haDcSAvAvgP9avgBJjqxbP
	LvYbHp+jX+9ZfhGgVJUJlIn0oUTXYOWK2w1PQxtTO7LLbvX1AIzo6hCCBtEek5p90s7kCCl3gXX
	JO9HJ72MwAI+aubmL3DUzg77gSROYFT50UsDWXhpJJUI3xcikuSMCkTa2JgKV5P/2bEYnLYAk17
	WJkiEeTPrFUbTDcbLYnT2+UVmZvZ0gcCC4ea+dkvsB5x8eHMz+TeMV2y1uW6hN947d9DKiu0Nrx
	Dnp73DK+R3a0z9EoHDT9I=
X-Received: by 2002:a17:90b:1f88:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-353689530cdmr170446a91.24.1769102235826;
        Thu, 22 Jan 2026 09:17:15 -0800 (PST)
Received: from archlinux ([205.254.163.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354cdd03sm3005284a91.15.2026.01.22.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:17:15 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: acme@kernel.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] perf annotate: Fix memcpy size in arch__grow_instructions
Date: Thu, 22 Jan 2026 22:47:04 +0530
Message-ID: <20260122171704.142218-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memcpy in arch__grow_instructions() is copying the wrong number of
bytes when growing from a non-allocated table. It should copy
arch->nr_instructions * sizeof(struct ins) bytes, not just
arch->nr_instructions bytes.

This bug causes data corruption as only a partial copy of the
instruction table is made, leading to garbage data in most entries and
potential crashes

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 50b9433f3f8e..6faa9df8e373 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -81,7 +81,7 @@ static int arch__grow_instructions(struct arch *arch)
 	if (new_instructions == NULL)
 		return -1;
 
-	memcpy(new_instructions, arch->instructions, arch->nr_instructions);
+	memcpy(new_instructions, arch->instructions, arch->nr_instructions * sizeof(struct ins));
 	goto out_update_instructions;
 }
 
-- 
2.52.0

