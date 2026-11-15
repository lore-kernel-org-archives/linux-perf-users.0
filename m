Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755710;
	b=rbU3lxWoyCoG+C5LS5uAB4We4lSh6P8W27XbKSKjkQF0Zo3e8vEsRcRGdee1MX79MqGU
	 /LXlc3uleoWqrzOehx9ahODrBKWRSFpTM8Yc5kzfQmTMo8Z4Q59LR9YEq4u7BnrpMTqQ3
	 VCkTfP3lNjf1aTvX/l1S4pJhkhY2915zu51GC/3UeJvgqZLf2uzMVdxDx9OsQZ4ZtqYo+
	 fflJ8NOCs6ruQKWCsW/5gtlI6Ufz/5qxqN77uXfk6ffIF4ycro4r2+EnDI4DqPg2sOGMa
	 vuxgeJj+jJm9jW3UV6vnKi6xjxfKqJzNqwwegSGBDs6eIWsSd7v+7gLuv4wYU78txyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cZkFsjybWyp8PjTu67kBKwCmbR0V30VjwyOw+3AeO7Y=;
	b=ZeDVFX6eohUm1yYi4cUZ7Qcruhx3Fk5u/74f1gL9mA5uilyF9IetUN2FsbyQ/DqPgGNm
	 EcBdOUV9FQCXBwvR8o7+ZtCg2b3m1XSA7xsh5eecZTNn/EielvYGiDlbJICiLi3V71VFC
	 VNF68qIR3eTjV1cXPrfb4mQQfrjQ0jX1TG5SgNB5Eh7Mm800mliMQTKLUBSLWwtCNH02H
	 9DhwX2qhmf5Y/B0ZRdRpxAA2IedGUljt0krpcynu0GFlcU45RCBPat4+WwBMUbDn4kQdz
	 +8rb77w3WHUi1wsimZTWtwAXvWW12BHJ3YQSi4805PlDsEwHvKS0ZF84P6PvQFtz8Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6lgTjbT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F6606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 15:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C6lgTjbT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso29899305e9.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794755708; x=1795360508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cZkFsjybWyp8PjTu67kBKwCmbR0V30VjwyOw+3AeO7Y=;
        b=C6lgTjbTuFvJPGz8jzpXUUJRfmN9NSfXOISzs+mHebQZT62v7AzFvnXxNtqcPaGz54
         ZI5GWWr+rFmAcu25SHHkptTUgknZ6BW1GjiQqJmZrW53OZRZiqnYEdZPPVgI3lUFXHD/
         llWtXnRCZCnDavH1+HRDZLEbC9q6CTLKN0mx4XDzoy6nxQaUpl6bhmB9ijx3qdhutPf8
         xJ7kgcY0n+TEq0S3P+wt9xpXtbElr+47EoMjMgZRHtu0BR4zWcT/HEBAohLlV2BxF058
         s7eOwREPNIMHus0kE77EfOY6bOfz0zXuzBtgUn1ExS1vrsICJQYgYQGcgelF8FjP511S
         0yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755708; x=1795360508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZkFsjybWyp8PjTu67kBKwCmbR0V30VjwyOw+3AeO7Y=;
        b=BFoGcnpV0vDn4v7QhMENCxJAJVxHlSHkfKOf4WTziKS9NrLhQoVOMAKcYkFOzQThUE
         nPo5oxRGoU5vaGkiosg5x1WQiW1l7sHYp/WrgGUjLyVp9qtpzyh8GMP4RDAPHCIe2ZzO
         YzbZ7sMyoZPPKM6YvdsR97T15dmCI9/qzy6P0k+SXQ3G9S1OBD6OaKhj4TFoAQ2I/eiD
         BPBFxZNdq3y/b9ZiQk7FL3U05QHa7dQJtuTZE90Kqc/ZVkLiUXLy91M/Cts6AwRsEG+I
         S22qDs87vTXeW2iCfzy7DHhWUe8C4ZjGxzp+Uc8dumz2CS9QAvUM4OG2LZn96uXbFgRG
         TacA==
X-Forwarded-Encrypted: i=1; AL+hErFaxgJ/YUTe5Te84TDUFbqRgvfMTqDkipLVElX73YIAgNE2wTh4ErTAPEYHHkafcahHtwuCDTw2VQhhUYqLitTj@vger.kernel.org
X-Gm-Message-State: APuU4Z9TCWdhPJWcO1H/1WrYcJ8mr+HYZHnZjbbMOkBs3KGyOyfmbYOn
	EHNMACg07PSi/PzJMwvAea/aE4WuQ032pJQZt0t/idvACe0OM8b5pfqM
X-Gm-Gg: AYBFou2WaG19HCLhca7aY/tLcykiyKrlxSTXr8vMGlKddisNZ1w6lLzNmGVZTCCK8Fo
	s05UWociOK8RW6BqyzMxAE5kIji0fGW3UVVxWEAZz13tCnU1Kx1sTo+9xDaF5ea3scTv4i2JKi6
	oLHBXzs9FkmTtbW94PtVIFMlCLgCRz0Kf7SbiTSpxSwNn5f/a+h5FkC90jaCqmSdH9LCsyiJrpt
	qxRhF43r3savPiaw4x3MyPy4sy9Hd5NBjPjEGOa1n03zIIqOALtywYv/LJ/5oXDhB2wjvhr4nzO
	V57vpuNza9sQSPF6De1xSoS9AEgKwyx0G8jW9HmDLWSdj4Ds+Qb9gBA0Ws0BlaL7GHYCWe90Q9l
	Okox+ghfHEJ1k0Ycous5LnYLTv7gP11oDGnekh4LZxOwVIwbWboZl64OL9ZHop8vO8s1zyLBUlX
	XAaP43UIfPBnRUrGI0AU9klIRmlL39iko1NOzCrybCheLdZRJ4qLhn0/O0OJNNWmBoBoiZFRyl5
	nuR/iGITPwnDTdf5IOxlf431PDeyRQAyzRRTUjgZPHt0PvcdQHDcVTPLpr0ck3ELK0YUz0y0wqP
	r0UlBp2OB65hEETo96lnoTMpEvXFmT9zyA==
X-Received: by 2002:a05:600c:3d92:b0:4ba:e7:ef3d with SMTP id 5b1f17b1804b1-4bb559f7044mr167377585e9.1.1794755707706;
        Sun, 15 Nov 2026 07:15:07 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:474b:1700:f61b:bfec:b5f1:a453])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c0e31sm14556419f8f.19.2026.11.15.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:15:07 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: peterz@infradead.org,
	namhyung@kernel.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Accumulate lost samples in inherited group reads
Date: Sun, 15 Nov 2026 17:14:58 +0200
Message-ID: <20261115151458.258097-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`__perf_read_group_add()` accumulates event counts from inherited
child events, but overwrites the `PERF_FORMAT_LOST` fields. A
child reporting no losses therefore hides nonzero parent losses
while it is alive.

Accumulate `lost_samples` for the group leader and siblings so
group reads preserve losses across inherited events.

Fixes: 119a784c8127 ("perf/core: Add a new read format to get a number of lost samples")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea7142..165eb55608b6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6163,14 +6163,14 @@ static int __perf_read_group_add(struct perf_event *leader,
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
-		values[n++] = atomic64_read(&leader->lost_samples);
+		values[n++] += atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub, false);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
-			values[n++] = atomic64_read(&sub->lost_samples);
+			values[n++] += atomic64_read(&sub->lost_samples);
 	}
 
 unlock:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

