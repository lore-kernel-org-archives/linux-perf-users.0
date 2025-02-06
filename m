Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B8151991;
	Thu,  6 Feb 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738841759; cv=none; b=Db69Pj3jDduJbS6O0X/4Uvi9DZWi9c/oQZ7goP9T2wzef7h2zzopS34H/QXq3JYBnQ3VjYhyWfpI1Db5XUDJbGN1qaMrWX+m80PPORiDkRbAW8vwubumBioIFem/KFz+mfjw1Jwzs6ALAuwpm6edFjaQCGhDrsibw4PCvt4Deeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738841759; c=relaxed/simple;
	bh=NjHnUE5wux5CDuoPXGUZzkj6X1RJFp49eBX0DR2mMt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QGhElMJfrbqzfpy4SYWiD4+9DNV+6vN0mq/1d9LvCtKh5cAr9zgQ5tp5fh7mNaGWobrKiqZpU9kFmNz2zeHLsWUzxL4lq8ssSwfcEuyfcjYCYVB3B8FOB/RlQKAzQnGc/u86Mh/Sm99QpAN2lV8ZcYsGxJuGLvkQ4yxv5YcgyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV4Bn1bt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV4Bn1bt"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso158481766b.1;
        Thu, 06 Feb 2025 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738841756; x=1739446556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkJdmTYyXGOGzgmLgZvRSSjbQyWXhEcU3uhyFsKx7XQ=;
        b=kV4Bn1btbY4S/8XORoeN70kEqfpyd+5foTM+6ujCQEXtADnlSPnXvGD3H2Hknuhh9a
         IAqyI/naPNXyQgHaV+x4VDUtVJwhbgTJNQJ+GT6ZbaafciwxBB0ojJZ2b1IpkYEGNot+
         BJgv4WmpMfq1wKbgy5XXit/+N0a5vfFAV0Hj3qF9S0fZeM/yNUfTL0zzrUmJ5jR4ElCF
         xqCON/pf9HK2rM82gtYNXMkTYAXGLBelKClC2AJsIiTO0Sjf6NIRszzHr+WXkS+lr3+X
         5lHjBOOvA5Pd/s/qA4L8X45LRVKZOcs3ZPbgEI2vGo4XEHRzQPKSnn29YzmXPwfS8j6Q
         Cf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738841756; x=1739446556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkJdmTYyXGOGzgmLgZvRSSjbQyWXhEcU3uhyFsKx7XQ=;
        b=MxBVVcVyKbyfJhn9QwETpeZbUm7A6HfefagK4hPeG/azJzSuGh9KlibGuY69hv7P6d
         tqxd6aCHUWly+YFySqH30cB5upK7JUMBnD/19F26FCqIGf8raaz/SG8+sGdp5i+V4Ta7
         PpT6BpmbHBhIMNxo+juVi4lSp/JpHRfSP/cM7LytUYPab+uAnEiHRTuXE4OIEzNErSbt
         Gws8QaCIwujZ/pDznPTg5O9S4/CcP2388bEXYs7AernVOGGOC64ZpJ05PmOCQ0RbnLaI
         5aJyGq6XYOSUTncSv8Cs3GfxcpJc7Q2GVCTJPQOkDqFK3nX1okVz8o9DmYLHfS3PREec
         mqng==
X-Forwarded-Encrypted: i=1; AJvYcCVtp8P0Afi1XuL2AyRFOHlyuMzeM5yCxrccY3FTxqqiXvlTfIoVkAqwGzIxCR8Ll2jsqfgEaknqIXkXq9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF731zZWmxtAX1eObKzJGC67fgj2kaPO2HYxhDxpN0FIQ97e5S
	5wp9EmqPP3ywTsOPLF6C4qDEdqpQpWE8mhE537Ci1gy3CeUq8N+K
X-Gm-Gg: ASbGncu2YMVnZmDFYCTZ/fjae923NTBun/CNyfcdSgw3wea5N2xjlxk8lA8Tt5pPZes
	FbTkrL96mkNFylEADJbpkPZtoPw1wiQujQd1QN1wPFhiOblWztd35Y+DcoRYQS/0Bk8OWspnjm4
	j9CQnx4xz+ZMBWyHNZ48971ME7BvemAekQcV2q38NoFdj1NRxADgVvQcUNzdhxRTGJLDvvb/mO7
	qByC3JxtZRndCrngQVaPFxcz0v4zj6+o0yKMh8vZUUjPnT11raA6yy1LaYX/AdBQSBvl20xDwoj
	GmvBOLTLE6ERrDUsK4rTvFWcj65i3iBJ8sGQuw8RdTQe9/M=
X-Google-Smtp-Source: AGHT+IErJD5msh+hOm6k6vXCVCW0zAkpZZnCO/7oNPw4zwJw7lnhiwQqQuUSqLtVIF+Avt40QZtBVQ==
X-Received: by 2002:a17:907:1b14:b0:ab6:f688:dae5 with SMTP id a640c23a62f3a-ab75e2f1185mr719959366b.36.1738841755347;
        Thu, 06 Feb 2025 03:35:55 -0800 (PST)
Received: from lopk.local (c156-123.icpnet.pl. [85.221.156.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f49378sm87219766b.16.2025.02.06.03.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:35:54 -0800 (PST)
From: =?UTF-8?q?Krzysztof=20=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Subject: [PATCH] perf: Improve startup time by reducing unnecessary stat() calls
Date: Thu,  6 Feb 2025 12:33:15 +0100
Message-ID: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When testing perf trace on NixOS, I noticed significant startup delays:
- `ls`: ~2ms
- `strace ls`: ~10ms
- `perf trace ls`: ~550ms

Profiling showed that 51% of the time is spent reading files,
26% in loading BPF programs, and 11% in `newfstatat`.

This patch optimizes module path exploration by avoiding `stat()` calls
unless necessary. For filesystems that do not implement `d_type`
(DT_UNKNOWN), it falls back to the old behavior.
See `readdir(3)` for details.

This reduces `perf trace ls` time to ~500ms.

A more thorough startup optimization based on command parameters would
be ideal, but that is a larger effort.

Signed-off-by: Krzysztof Łopatowski <krzysztof.m.lopatowski@gmail.com>
---
 tools/perf/util/machine.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2d51badfbf2e..76b857fd752b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1354,7 +1354,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 
 static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, int depth)
 {
-	struct dirent *dent;
+	const struct dirent *dent;
 	DIR *dir = opendir(dir_name);
 	int ret = 0;
 
@@ -1365,14 +1365,20 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 
 	while ((dent = readdir(dir)) != NULL) {
 		char path[PATH_MAX];
-		struct stat st;
+		unsigned char d_type = dent->d_type;
 
-		/*sshfs might return bad dent->d_type, so we have to stat*/
 		path__join(path, sizeof(path), dir_name, dent->d_name);
-		if (stat(path, &st))
-			continue;
 
-		if (S_ISDIR(st.st_mode)) {
+		if (d_type == DT_UNKNOWN) {
+			struct stat st;
+
+			if (stat(path, &st))
+				continue;
+			if (S_ISDIR(st.st_mode))
+				d_type = DT_DIR;
+		}
+
+		if (d_type == DT_DIR) {
 			if (!strcmp(dent->d_name, ".") ||
 			    !strcmp(dent->d_name, ".."))
 				continue;
-- 
2.47.2

