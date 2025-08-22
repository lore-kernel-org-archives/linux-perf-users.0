Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EF2874FC;
	Fri, 22 Aug 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880100; cv=none; b=KMA8lXfAGxHYq4IFvLFIcTRnAOCG0MOxKljadCEhfp4vAT+gTbmEPo6VxgZh3kwV1/LOFUusl87rSp+76kIXL+q8kdfgmKDnm7NzbXz9o8/dl1dX1IRfyIa54MyxRmBgtNlUJvb0J13Or9le40tvDpfgKQ+l0JMBe7fYMSHCBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880100; c=relaxed/simple;
	bh=dpr39bqo5R7+Eour11NTXhjEgQpmqN7p6MLG6/xzTGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xjn3I1QkC09REWBYBrCDGexRDTWa296jJIIhwWui7MODBCd1aWcOwitWuPPu44VbP7BBMxRmjDkHJTi/x3Eh8wNwb0UMQ9p+p54fv/OkNBi1yb5vAEj5Gnn2DOAr8AK4EhuDg6pcA2B6AS9ydyy1nlbilg4Nbc9wDZcMkbLXLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-770351ba0beso28324b3a.1;
        Fri, 22 Aug 2025 09:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880098; x=1756484898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipypVaGzOYgWicbm11sgIKcXAHn0ao53+dLQO52xa60=;
        b=RvDbupBPiS1XuxVbt/fVJ00AWqV9Wjf//jTkMuVMdIeyqykl6AK1Ez3KeMnC09DU0j
         FNhr88/doFSbJDu1VHmDY0DFlADEaGqOfWgbh2PwmHZhrBkMqJT4W/z7iGSUyb/H0khS
         VTakPoj2uIZbdvanFzhFP/x6td/yGS6VNYGj9/j/fBW7wExqHhMtz8/gL5Nv0E8+vENU
         tJau1xEdMXdFv9/5Rry18rUs/2n/6M7VJNrWl9UVztuTrX/VXag6hsQvpGSXpLkBX09u
         F1IFxFQt4MVN+RV0k/seUQqBB2+aaKyUShr7ACwbtpPQVrOBL7pAelWhu4B8JNJ9Ka83
         7vFA==
X-Forwarded-Encrypted: i=1; AJvYcCUyG/rkk8ER5AYwDbHmb2IXGBS/YOfgQlcygCMD/1yM32zUo4/EdsQQ5wV7OEWNqKUob+pCZZZ6PMHPGhXd0GUGcg==@vger.kernel.org, AJvYcCWq2FyZLEaiL+hyUBAQBVdHAsHW0U3g7pynJh+K6jYicPBiQkena4wLepRKEoKMRE40Dq1CRWGTG9BZ6f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZX8l667QTE2htJKIDaRubP3LH4zermPIYNB4rinqDYGWW/ubG
	h9DpXlWs5hzZu4hcnEtgw3d4QA0gklYhR6cRDsPsHXWzWnHoQQIDG/S/
X-Gm-Gg: ASbGncv0n7QpFtvo9zXPvnjlcE7ezobDAP+2DQD1EcOvhWUFQZaI33QABdZUpFWA6TF
	1FP+COlvRiPfN78wxMQUn6I9fTQUEfzcXlwtKXYhoYOYpuxhmHFsEeZ2kcHfgkEjFWt5Uz0mLdu
	APNLXdnB7SZlmgY3DrFerURvTNKW6rc7CH5pJf0o2hDpTQ3pgkY2JC8T3ZKnWTI7CwGgZGZnP5d
	cdx0KRa5ugVPdGRqIiKH3Pevfza60MulJFWn1RgXXlAViy/IhLxe4dpsxmQ5JLg3pnZ01hJ4Ypi
	ACnLNMtCnNIhG1NDTcOwelmPkA9MNfDnU3MORgfWT1MHGdNWFL97qwnoloNlBrGzfo+skosj2d7
	tZ8Jy9r/YBHBs1QFUbXiuNZSKE+acqnfmwAIEkmxtuKYmVRpCJaHFmesPzj+K1ydIe4dVMIsr4Y
	s=
X-Google-Smtp-Source: AGHT+IHla0cQ+1yIJTrfkiFJujdUfCCyQHoPz3NU+Freiovsa+UY8066EdbmNcpeXYeBSxtjlc4CBw==
X-Received: by 2002:a05:6a00:1a0d:b0:770:3ad9:4ee8 with SMTP id d2e1a72fcca58-7703ad9513dmr880614b3a.6.1755880097822;
        Fri, 22 Aug 2025 09:28:17 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffef1b0sm351622b3a.34.2025.08.22.09.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 09:28:17 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] perf util: Fix compression checks returning -1 as bool
Date: Fri, 22 Aug 2025 16:25:08 +0000
Message-ID: <20250822162506.316844-3-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lzma_is_compressed and gzip_is_compressed functions are declared
to return a "bool" type, but in case of an error (e.g., file open
failure), they incorrectly returned -1.

A bool type is a boolean value that is either true or false.
Returning -1 for a bool return type can lead to unexpected behavior
and may violate strict type-checking in some compilers.

Fix the return value to be false in error cases, ensuring the function
adheres to its declared return type improves for preventing potential
bugs related to type mismatch.

Fixes: 4b57fd44b61b ("perf tools: Add lzma_is_compressed function")
Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 tools/perf/util/lzma.c | 2 +-
 tools/perf/util/zlib.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index bbcd2ffcf4bd..c355757ed391 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -120,7 +120,7 @@ bool lzma_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 78d2297c1b67..1f7c06523059 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
 	ssize_t rc;
 
 	if (fd < 0)
-		return -1;
+		return false;
 
 	rc = read(fd, buf, sizeof(buf));
 	close(fd);
-- 
2.50.0

