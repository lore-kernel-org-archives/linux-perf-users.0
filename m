Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FA330D50
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349850; cv=none; b=r53HF8iLCIyhWuN6NgWiZhIB64EXvnFgJWV92Zsz33PyAE9eXGuf0rUC7hx3LQY0OET4SS8OheM5Q03B/FIIWNZKCrybaxw/GK0zk9NsSjZuULlCEh1Pmn8cklcbmgXvk8K+s7rM0kUH2sHe5cC4X9z7nUOKMASNeJL/NdRmGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349850; c=relaxed/simple;
	bh=r+SSnBI5b37+jAMfBbpQKjTvolK8TUDdZyMLSQFt2fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdQ7SSHKsxXsoGy8+E2jFKjzeQJhTcCy7stm9y1TfL2P6wzzUfGLquNgfUJSov5BNdKKZhd8wP8TYkZzbyQ3SuH+RYYep9ETpE/fYTuM1s2CBTKRJSNVkW77g1DCdJgH2FoG0IdLpxeAQFYtPVqedLR2ZfPq6c36Ru0TWLNa/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UggsTugs; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UggsTugs"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so11617355ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 19:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770349849; x=1770954649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mW/EfJpQhsdTtrBsXN3a2TdnMMqaf3m3vrLFSZ1aNSc=;
        b=UggsTugsgxIpoXh3LQdPkbUHiYo9z4CdXx2l29bwa1TXLFknX9WYVJ/4GBQTosfWim
         nXBzFEyxJah6Tx1SmJ2sEtJ2A2V3G447Ah5cQ5h+eV4yR4UeYnlUQx7f0HzG49P3rck3
         lJSKONmr0IDBbfP98emjzTcm0msBLizM6QTJjR/svX8e7ME01sDPn6SBoIxpInRpf+/S
         iLsEUVmiatNWrZ6mSzFHMQqiYQOO4+oWfBwIyJ8mFr53Gia0nGLZpRlcPBiN0vBrQOtX
         JbGTKhA0QwWyIKdd1MAtM3zrgFKzxtsIxDaUPcfXrlBOjsUL3EV8GXZSI0kdJmfRDg6Y
         rSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770349849; x=1770954649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW/EfJpQhsdTtrBsXN3a2TdnMMqaf3m3vrLFSZ1aNSc=;
        b=KkEHrAbf6uHU+3cCDg6cSBxmKb40A4z4gYjFRNbDRTNBuvMewk4n+VLnXYV/cEk7pp
         rX8xNHpq9m/+jGao1WXgvDfwjQj7q+otPmXYNoen4L0xsPa1VNApt22Y7FBH6GiokuoG
         jcAlhjTzxPy8JUuU28yDNO6E8K7mxZPWVi+2Qtm5fbEAdJnciczRKZuseL0FKjqmVf4c
         pO36ibRcPjP6h/mA83l5rO2q2XLMRkA7UIgUYcG3qJ/Ow+ssxoHfZsqjQjWB+4A9KpBc
         n3psywSMGosy2FE184xy3LoYwY0t/htQLfc6XqVTKIxFG+RzaElVWhQlorZCoe3Fh8K8
         2QTA==
X-Forwarded-Encrypted: i=1; AJvYcCWI3jWK5SA1uJGES5e8pXJhO5oCwGIdHpl0+MpYx2b+wJHlodCPvIG+2LKMAG17Uhc5tXAz/jORHWX8SAyCwjXg@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQ3EqpDZwDUAIoaIHYP5+gtdrKm5mP01169zZ4OyB3vj54xtX
	OejAW+gBMznubIjXmTQRj6FRG2OJMs+r/0nSGF1DfjFlrXOe564cXkgt
X-Gm-Gg: AZuq6aK+V5UPzwGHH4aRTWJaOcehrqI/hWSHVxzNQHBGht0eNrNqIEm1KljdoEF61NB
	wobCiC4VapB96CvtEiS6TNRMD3ehBJPnYYjlXyc5WYdAxc6uAz3N8qxoppYahuRxLLeuQTReltt
	gD/rBJ+vGGSfyZVAL0aqikMkAWKal5h1IhfLXosajFaS2ffgj9dq/BUfca7XGFD8wIcpuZIIczj
	RQpnW8sOXuNAOAYPl4/pYVE7v7rqv5/bZAKh3DVipE0cZvBjQWuS73l2aqElBft+V+gERq+T3+5
	lvzxxh5GddiZHNROsTjT5OrRsPf2PLY6aT34oQsVreM3fTC9AZ524oTRWbNHlO9X5jA9hhGkrPq
	eCSHKlRSy08Bz8mDwnVcJZsmrfLOQJEdRKB40QTxcKXTNKMv/5lqfr8w3KyqsxiUqxgPgB+3xCt
	x2FcVirIhRj12hbSZ2dmDHwL5GUwN0fRThoJsC0tE=
X-Received: by 2002:a17:903:11ce:b0:2a7:5ee5:ec50 with SMTP id d9443c01a7336-2a9516237f5mr17121575ad.17.1770349849276;
        Thu, 05 Feb 2026 19:50:49 -0800 (PST)
Received: from PC-PF4KNQBS.Xheart.com ([202.46.41.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8605fsm8915925ad.31.2026.02.05.19.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 19:50:48 -0800 (PST)
From: "feng.zhou" <realsummitzhou@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [QUESTION] ARM DSU PMU: 32-bit counter assumption and handling of 64-bit event counters
Date: Fri,  6 Feb 2026 11:51:38 +0800
Message-ID: <20260206035138.1377-1-realsummitzhou@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will and Mark,

I have a question regarding the ARM DSU PMU driver implementation in
drivers/perf/arm_dsu_pmu.c, specifically about the counter width
assumptions.

Current Implementation:
======================
The driver currently assumes all event counters are 32-bit wide, with
only the cycle counter being 64-bit (lines 69-71):

/* All event counters are 32bit, with a 64bit Cycle counter */
#define DSU_PMU_COUNTER_WIDTH(idx)	\
	(((idx) == DSU_PMU_IDX_CYCLE_COUNTER) ? 64 : 32)

This assumption is used throughout the code for handling counter
overflow and calculating deltas (e.g., line 344 in dsu_pmu_event_update).

Issue Observed:
===============
I've encountered overflow issues when using perf tools on newer ARM CPUs
where the event counters appear to be 64-bit rather than 32-bit. The
current implementation causes incorrect event counting and potential data
loss due to premature overflow handling based on the 32-bit mask.

Questions:
==========
1. Is the 32-bit event counter assumption based on the ARMv8 PMU
   specification or DSU-specific hardware documentation?

2. Are there known ARM CPU implementations where DSU event counters
   exceed 32 bits? If so, how should the driver handle this variation?

3. Would it be appropriate to detect the actual counter width at runtime
   (similar to how num_counters is probed in dsu_pmu_probe_pmu), or
   should this be handled through device tree / ACPI properties?

4. Should there be a mechanism to query the hardware for the actual
   counter width to ensure compatibility with future implementations?

Thank you for your time and any insights you can provide.


Best regards,
Feng
