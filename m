Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C61165F13
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Aug 2025 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329362; cv=none; b=hSdkr/uRKiKCe+5WqZBVobVR0JJ5KNHFc8gP1VTAPmjP9m8qotAdayK44Sba4A+58kJVXP9FEfkIn1p+YVQZxRBBib3dzLywuOiXFMnKSo6fyHGeKhUraNDkAV7sW+8mc2HjVH4prmIMClzltReba1dIaZt4GBcpJkgcCBqps5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329362; c=relaxed/simple;
	bh=vzrXIt5TL4b9Ng5jv3r+kCVZCYVNZ1OqQdurqTIo3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYY0PJfxr2MxcUV6bgqUnx+HFfTrkm3dUH5PMtGnW1vKDXSVsKWSObkEG5sSU0LqYV06YNq+8WO3dKXBIH3PdcexwR60pVAmsc0RAkUO7w9/d3brFWJJqRhQmHMzDsKZLn3u4xsyDhxJNt8ztQn9c/Hu3+TAUMX4xYEYl238uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrqH+g8b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrqH+g8b"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2407235722bso51114875ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Aug 2025 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754329360; x=1754934160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmpuDQw4lcTu4tXxdtVUEIunPau4aNsOSJumWE7v3Hs=;
        b=hrqH+g8bJcXEoPGd1p6+XsEeRFb+JnIylwOitbgJ7dHtOnIfpvvoX7YrKdxs8SQMqx
         BVKG/6wSBCv2N7xfsw4q+uHepBRkPe4RMk+E8FD3GZxxhDQZx2ALKOd1qdNF1pLNcBd9
         Kobp35UJEYEdgeArj7hajQPKYgchxpUWv4FW8Uwoj5/JtA8UI/ZGHvOwSsF2HMHbqEyq
         jbhGybY80Ufjb20d6VfZFLR9tLagNuY6PWkWGF9otv+XP6LsJe6ynfv0t8k9+qa3Q5fS
         YRfqmPo0Qj3OE2wTBknskmpjJ945qQX0hUjKsQ0T7Qt3L5Cu8Qhz/OQ0YgT1dEkMcwv5
         7+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754329360; x=1754934160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmpuDQw4lcTu4tXxdtVUEIunPau4aNsOSJumWE7v3Hs=;
        b=PVBQBl7LAh5NK0PqQnE5Xm/n3oGYnfeU5QfjZ3nqwVd5a3dW773oEGeSSLQj8ZRCGB
         wItsHeZv+0wXSAOhKvBXLDncswO9CCxriMOTS82HNa2Ry5phfSlk4tiLv8ma0VQgTVPY
         phbh80GMiMZ+6b63/DZAEb9HGGLhWqv1MteV6Ulvt7T9esQx07NntMQv6QW5fFIVyQI5
         atCCqI+aNgMvqXQzLeE/Tip71inE+OLHcZRxkqhKWe/qQPwg+alaAOONwhH6DvsWbAXM
         008+jGZUNORTXi02zi4TKzm+2hf41dgGblH1nsAdQbD5z7dqXQmsonVDmnvwSyCJ8fze
         +erA==
X-Gm-Message-State: AOJu0YyB/JKFGz8SsKlKUq8dTnNDXWgUil4v+rgujPk++3DQTVFEtOVF
	qQkDa+UNdd4pds94EbrcLXPE+ktlyMXbxZh7sYpEn75qhIuOQTmkHxyoFIm37ubN
X-Gm-Gg: ASbGnctYdwIpw/E7incaUV+Q+K3y1kSmdkqB9pcvSyrUzxVwQ2+rUgSTgLyF4rVzdV4
	pgcXCvv4Wu60J/ue8PcL0IANUwZ/f66PfHBAzs1z3/k/Du5dKDU3KDuPXhxTaRlwD9ytG+y3/9R
	sU+rrOhbRvV9SPjew/6iCf3b1Ez9O1EgUHB5bzSLUsNuuIeuvrbDjxo4Wsx/5jYSEVeghdT2B0L
	/JgCMkDi0f6NMPbywFsRkVril3bYkKrD/hdGyRD+p2BepVMVDW5rxgwTB543+rVR0+6QrHExNaq
	WkZy6O9IsRZnrI7LmKDNbsXvk6CSTfVQFcGLuMlmnipJWrq/RwX67jWkbrkZ4aU6Cwsrxm7RsQx
	3Ni98zF1K4aK93FTEVZ5ff6sodowwWTZN
X-Google-Smtp-Source: AGHT+IFI+8SdSFUw0aVzC0ng054xt2X3I1hBjCdWEE3aIB2LDKXSVvzTElJ/rk4zbP2WnqZwBQ+KGA==
X-Received: by 2002:a17:902:db11:b0:234:d292:be7a with SMTP id d9443c01a7336-24246f30349mr169796815ad.1.1754329359639;
        Mon, 04 Aug 2025 10:42:39 -0700 (PDT)
Received: from fedora.. ([110.225.60.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6713sm114370935ad.12.2025.08.04.10.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 10:42:39 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: linux-perf-users@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] perf test: Added .gitignore to shell base_report
Date: Mon,  4 Aug 2025 23:11:55 +0530
Message-ID: <20250804174157.319224-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Created .gitignore to include base_report files so
git status doesn't gripe about untracked files.

Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---
 tools/perf/tests/shell/base_report/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/perf/tests/shell/base_report/.gitignore

diff --git a/tools/perf/tests/shell/base_report/.gitignore b/tools/perf/tests/shell/base_report/.gitignore
new file mode 100644
index 000000000000..8d3ce1278d83
--- /dev/null
+++ b/tools/perf/tests/shell/base_report/.gitignore
@@ -0,0 +1,2 @@
+*.log
+*.err
-- 
2.49.0

