Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8163D
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075367; cv=none; b=PlJTnDHOArZJX+VRHbIa1ibA5I5fAxcYfiD8wXs4zFu+CJuKb3fMw4k2TkItFk7Ca+ZjA/DXr8I7OVjn5agHUXqqoxRawBxPwN8yAPjOGbCUpChQ1jBKE1KpbMrb6SaL8rj6PZJ+YPqrqzyuJb+41nOw7b3+DrOQa2PSkfncr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075367; c=relaxed/simple;
	bh=FXzXJ8puJjRyzaYQf/myhvlspm+dHOOl1FmtKrgxWKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfnvY407RowXIzU4UsKS1jKClTa/M3eZtp/VoHgmdwCAtEPAfWJMbm7iE4bMF44PC26XWXpCBzt46ztxNhUhMQ0SGmhNm4HnC0fBrO1j4FpeIJjlUYZKwvHb9P3CRWGDsrDn6F91hWsRZCt+NscIG8A5qXxh2hDqIpCOlcvZZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=edtpsP8l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="edtpsP8l"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd65aaac27so10499435ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Aug 2024 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723075365; x=1723680165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVEM398nfKMPG00719+LnI2T0zzUH1B6VC8Z8aO8SnY=;
        b=edtpsP8lBsuDbYcLCvNeFe+wollUJWuVAlwxg5A6ulLGV9gNOt3dyLpJoK2/KPA2A4
         3msPExSNjpH89B7Io1g11oFhMUR/zybdAJbn9KeppxMmg54Pag3DmpdUUre+aNei7huf
         G2V86sbhpDlhVbIE+SEsjlHNSzTqWXdiAGv9yZDSeccEtMNbbI+n1cUZrKwcjODOHgzP
         v00gX3RKu2J4HXXDbYMy61u0NVvEkX4Fka0mML3dDxNbkA9Y/6ZxZ6ip6O/gikX0+c4T
         v79FAo4M7sUtjKI4ReUeo3ymNJJ2eGNnwydXF3na8r3+k0l6B1J3WcwArvphl5cEj3u5
         rV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075365; x=1723680165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVEM398nfKMPG00719+LnI2T0zzUH1B6VC8Z8aO8SnY=;
        b=MzaC84wT+KAAf/kz0sou+amwt9yzyjxZbU3DoopcVbYF8iOuPo9p7tWaREefC+7OMN
         pdTqB4nHhJBa5T8IQ4h2QocN7wP7ngw4sm3OVR4o+fU1Yja7pp5PNH9N1Gge8D9KsjB5
         UEVF7/F/0asvcVWzc8ISSpkHmlyPWpyjpS3DYnYSf4fGHDLvSTFRdWrxt5z3CjESsgkt
         SGtYp82eJNKOwBR1fgm7FCzxN0c3iUzJPbM9WgOObsiSE/sKs18PluoztXN9AybAXc5a
         fF2030Ynx+4/Xwi7D0r2AOl3N49j8Yhv3MlWXJI2qKkabBu0b4ZpuW7vtZA+TUwZWTYg
         U4ew==
X-Gm-Message-State: AOJu0Yw4tW7TeaT3NjDypGMgwKkGFceJx1oTgf1zixd2KSYHJTryNvOw
	U3RjBde0F/WvbAT5tv/dYYlJHGV8o9n/30X0yI+zH+kAE0b3nhhw4xoBAVNm2zk=
X-Google-Smtp-Source: AGHT+IHNeWL5cfiLNEiUw9iYprrQkJwxXnC1ihODFnCQg2Ve6vzN72yDdaGjq2g1HAKVsa9e7SNefA==
X-Received: by 2002:a17:902:e5c1:b0:1fb:2ebc:d17a with SMTP id d9443c01a7336-200959a8eb9mr2828215ad.23.1723075364871;
        Wed, 07 Aug 2024 17:02:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f586f7sm112867015ad.90.2024.08.07.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:02:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 07 Aug 2024 17:02:41 -0700
Subject: [PATCH v2 2/3] perf: Document PERF_EVENT_IOC_INC_EVENT_LIMIT
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-perf_set_event_limit-v2-2-823b78d04c76@rivosinc.com>
References: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
In-Reply-To: <20240807-perf_set_event_limit-v2-0-823b78d04c76@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723075360; l=886;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FXzXJ8puJjRyzaYQf/myhvlspm+dHOOl1FmtKrgxWKo=;
 b=zxkkEMsw1fY3iXS14KmuJbEETHUB2sYYNZ4YGRtAubtK784e+Rwc2ub71UN51Qt6C6UAr2WLz
 4rd2xDBV/x+BnyByKWEeHW2ZoFdgx1NQfDOnDMbQsgsQ9c47n7VdvL5
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce PERF_EVENT_IOC_INC_EVENT_LIMIT and explain the differences
between it and PERF_EVENT_IOC_REFRESH.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/design.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index aa8cfeabb743..1626ae83785a 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -439,6 +439,11 @@ Additionally, non-inherited overflow counters can use
 
 to enable a counter for 'nr' events, after which it gets disabled again.
 
+PERF_EVENT_IOC_REFRESH will increment the event limit by 'nr' and enable the
+event. To increment the event limit without enabling it, use the following:
+
+	ioctl(fd, PERF_EVENT_IOC_INC_EVENT_LIMIT, nr);
+
 A process can enable or disable all the counter groups that are
 attached to it, using prctl:
 

-- 
2.45.0

