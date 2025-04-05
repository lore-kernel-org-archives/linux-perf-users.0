Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BA634;
	Sat,  5 Apr 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743817683; cv=none; b=PPrzsAsz9G9pXxtPPt8IQS6ozqqSfS9M8LXXwUsrTESc+Bpgp7VFA1lp+kmAOKR16DrMer7tBlTF4ef8KSRpZmMMs1uqr3F5cMoYtzu6uMOF0sn59X3O5TbGxCoIU6wNPim1n4QDJ8swKzDD2t8bBhaIyPFuBFyKtoqIL1EwoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743817683; c=relaxed/simple;
	bh=nHf4Zr86swx/RSMX3KTxsmjvbUst9VfVBDQTbA4op+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmgQ7g3l+dZqLMZY90RnHYSjooFJBPUvTz6orZi2VoDsuOnzUv4C1vcDhkmlcJAHRMRnzB3XQXOg4ckUrwJsDJfW5i+meClnkGHMJGL6hY3Wri0FVcMISZ3b66r7PvWHRPPxYfObr5dIHAHYD6vSdxs2hFzuZp8dfImZ6h8Rq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp30tp8i; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp30tp8i"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c592764e24so296386285a.0;
        Fri, 04 Apr 2025 18:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743817681; x=1744422481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sQ8NjoXzJOH8Ke5HnVIn3JhMsqDWPHif5pTMyDKJF4=;
        b=Bp30tp8idviNZ6x40yiN3SwWjgYX3KHfID25cgjv5T5NzFkpVv3+DqIZyc2kieb+gR
         Q0OBO62peFNAl64KDOKhqDgYZLeUNvQ4HjRvDxrNHuJHLFS0xCUcuvvn+DtU/8q7o5fm
         oBeEBS/Yud9SsgglwolXCCMNpxPby5PzcAPj3bYSLZpqro5eHePJn5MIAGK6oi0oOOFm
         9qM6p7FG9DaVwBg1FHHkCMOgkpQMLqrGeP9/C196OdM2WjPclYZStdpa6J5g8joZpu05
         v8/4YN/N0+lD1ZY20lrpj3jzYP7ao18TBkvB7mYfPEYRy51tyo87Xw033APrE7IBwbbB
         bXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743817681; x=1744422481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sQ8NjoXzJOH8Ke5HnVIn3JhMsqDWPHif5pTMyDKJF4=;
        b=eMhY0rq+Cz2ZhTyeZ4wnBCtaIsW/FPPW0HMjZXdFrbwqvWoHjosD3NxHEtSwdK9N1w
         sgSk9FBZDu5NdgIHFKQDdW4SjM1M9pOhDvHPzoZCmE7c4f40OsArmabkG1skg9OZnMlt
         zJJkq//betO12cXhW/vSZCfiW1sSjgVbW3O3ZEBceO3sGXCmnGkWtD3hCUVN2oAcz6rU
         h6giG5xgptR7DUwDXAJ9MZ4MIfyAK2fQ6bwhI0+H3DybHzs32xXtgCm4DmBgElyKPn4c
         lxXm8Prf0NdTK0wqtXoksMtYpGrFdNOIkABIb+uPlgHPk9VUBe2/kO0io/Z5zzuqlrN+
         1iYw==
X-Forwarded-Encrypted: i=1; AJvYcCVwaW2AJb+j5BfgXfXk3+aAS0cN4XcaxOzSTFCl4UMRPcMaUUp4ec5eKsoe86NizkLVyGYKngZM9sWOYL23TVrNbw==@vger.kernel.org, AJvYcCXEC2UNzrp8YsTIeJ0kfcfcusUrRwBTnqheqyCqzlVhiAtVLPvM0IaIlJHsV1wQMBx9j23LAYnG8IOqRLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwRiDn4WIlrn0PB6f0cSqeHGFSWAB6G6L7wSz7dJDvt93nEpB
	dy8QjpSaHoy5N+5tIS3LLefdC8ycypmukoLGIU/Hw2gHwCJoW0DO
X-Gm-Gg: ASbGnctglsc8SJATZWvBXZYYhMfMdiZvhkdBVplUvyt9Pg3g1Jac/KnWdI3Q8LfQ5rT
	5983l1BuY/sFaZOAzFZ/epkJi91tplDzyLEwvtZXBg0/w2d7VeNpp4k0cM1FCs+KYAgm/enkX8l
	1nukLK3p/6madq9uJ3iNl7fa8W8WpVq4lYn4yxh8VI9xQ0aLB9U6mxT5whS/kci7Q8vdiV/t5lr
	cbwazOEkyXyvQwjxoKWc0E5Qtko8uJKQI11jrolGIXUj0Pb+V6glfpKH09+dunQdtSqBf/vin38
	x5wUaR5NgKqmkmDleOIWjpvhDFIPb6f0lCu7Vad7DdFHkMMXfp0=
X-Google-Smtp-Source: AGHT+IGZzAiHFBGoLZi4qBZSctLNyksrZmj9QG1qvCZ16hskKacfrBQgelDYjCutJLnJXLgJbXg8rw==
X-Received: by 2002:a05:620a:4001:b0:7c3:cccd:92ec with SMTP id af79cd13be357-7c76c90259emr1477571585a.0.1743817681084;
        Fri, 04 Apr 2025 18:48:01 -0700 (PDT)
Received: from howard.neu.edu ([50.232.161.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f0483besm28416786d6.67.2025.04.04.18.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 18:48:00 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf test: Remove the temporary trace record file when the test fails
Date: Fri,  4 Apr 2025 18:47:57 -0700
Message-ID: <20250405014757.3447393-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if there's no nanosleep in the trace record file, it doesn't mean
the file itself doesn't exist. Remove the temporary file since the test
frequently fails on my machine and leaves behind many uncleaned
temporary files.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_record_replay.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
index 6b4ed863c1ef..555537dc6cfa 100755
--- a/tools/perf/tests/shell/trace_record_replay.sh
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -15,6 +15,7 @@ file=$(mktemp /tmp/temporary_file.XXXXX)
 perf trace record -o ${file} sleep 1 || exit 1
 if ! perf trace -i ${file} 2>&1 | grep nanosleep; then
 	echo "Failed: cannot find *nanosleep syscall"
+	rm -f ${file}
 	exit 1
 fi
 
-- 
2.45.2

