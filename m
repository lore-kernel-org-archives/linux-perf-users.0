Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44132252E
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479444; cv=none; b=hD/PFLXCFVJfbbU93aJUtpZmqU7FR2C0ej2UhxwYF5NfW4yhp+7mfbu1uYT7I6+/GIpRgs1712rBXOHSCu2WmAxDZOGcNeCZPt8C3dkTqMtg8/PsEiMB5pWFoYbvW3yt6Cp1bSs1PIZ2HuZ9Q47ivOKk4WXSTbveFVqIoUpntk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479444; c=relaxed/simple;
	bh=JNcxDi8XtzEu3xbpObOr3vCN2IHmRD7IAR2ObU+ycjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9bu7uMENdSm83mDtqjk7bTbJmQSguxrvfLPITB4ufQa4xm70MZ3iAUjfrcJ1/RjiHQQoAI66ZvA2b3+g7BhuoAhr5vXZ/vyQslMVjWqq0p0aqAPbJpV7vZsoq2i6LhEBrBQ3fL/xKJMDYkp/3us7hkdnOQfLR4VdmE+5bxJl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX3YAH7I; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX3YAH7I"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so2984365a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 00:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766479442; x=1767084242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNT47R5lyHr6s83aFhP7qeMV+Nwtti6xzxLjC7+hnjk=;
        b=kX3YAH7ITnk4k8ju8X+TWFVqTsEzrnfcrALl1eA145Rurcfg330eqNSTrxN+EzsUof
         3EF6kKH5Jn4xDLfzrEY76wheOaVgR7lfq/IsKaD0rCqDdOvoXMjE1182ypqf5j4YFzvL
         okPnncOmCJzlUUw3rHHSnhtP/kb1M6nzDoAKvYJESCrLARfjE/St0/yPSezUfytcA6HV
         F2+yByzdh/83fAObVUBWzE5dITDnbMF4Cv8tCak9LKQAgKTq4Yekkt8+Nx94YWEKNhdo
         pFVTNbcETqLAXMSX51vt2qMQBnuFYgtZMS1RYXyK9xwNgaik2Qqc8M1BwFcivtfj2zGB
         zM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766479442; x=1767084242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNT47R5lyHr6s83aFhP7qeMV+Nwtti6xzxLjC7+hnjk=;
        b=j2W5nl2gk/A1e73PCxyLHTzctdbNMauR6iYtzj6K0EgcvWhuMIcNcKzh2A+WF0fc3o
         7nAD+dupie0bZ+1dK9DFvVBfFDNHDVpFFMaasOAJHu5pxAQgMRm/Rhxt/AJjn89n5zGh
         PO+g8WThw2IiJ856UNzbYqqLqxr5/x8p4gsqNkUnF40BylsJjH0nrKC7gtf16JqNhF57
         Epcfw4Vyi+p1J5HQ1xXu3BLyxCItBs1Q+/SFs9Rfe0Uhm2NvXsnev279MXe/mFGbsZDy
         ix5Afgryi9+shOpCZieJPYrN9R05pIlF60Yy4nzZDzkZw1BJEe5q4pU4ecgcEta6ScXQ
         MJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJTlpkKtEZ5cqkehIyVo1sGmVxIIl8WuDUDRbSFvp4zkYVMkNh5Ble2q1zOUPephWlDi2p4YTBHQ2yhIiu1x3Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtAGavn/rge7BrvP42O8AsYKGrOGsIjL5O9+RTpWUM1rxzaIH
	WriD5sr23e5qqaMvQhAe6u4a7aWdLOCf4H2hAzUySWo69zkX9DkD9MSU
X-Gm-Gg: AY/fxX5TQdFM0zqZ5C1C1leVHNGUH9GVzkSFfdwyieJvloPI+Nzl+5HuzM17isXPnKv
	WgZ1Zohxp2kobNZ3PcVtaa/cAiAsCd8OuHilOEfYebK3Tzrgh5XTKUcMcIDXuy1hD+v1w+UXJiq
	7KzDHKlpmiQaI7Kmry39pMyV7El3eQBowzc1c80dRAiGU+x8O0qeocuygsU5LsEuUyUuwhffGuS
	lYXuwPmzXYivtUoz26h2XYs9p9tdmADsVSzEsdkL7vL3sHov3owZBKOE0WpbjLZD++oRwIyJcp/
	0I8IJE63YKv65sFiJJE1vi5ShUt64ydV8vjanR1GqbXKtbgbUqMSuuOiWMh9N6TiNppPA2TYc2J
	srZk4HOIxqZiNzSA2G4MxtKx3FVdRXroRGEq5LA8+LR+4ASS+2zHjVALAC+iuAlBUFycPTSOrCm
	jKkFqJkRtG3SVetGgg1t3PnNM7AA==
X-Google-Smtp-Source: AGHT+IHYU+Os1x0yRwca4Pe17iWLQntYr4tzo/e2hIsHQnCg2+Cy7uhXYlQBCpFNDm7a2HU6WuZDfQ==
X-Received: by 2002:a05:7300:50e2:b0:2ae:5b2e:9d45 with SMTP id 5a478bee46e88-2b05ecb39c4mr10097700eec.38.1766479442294;
        Tue, 23 Dec 2025 00:44:02 -0800 (PST)
Received: from HUC.. ([149.34.251.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm56720887c88.13.2025.12.23.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 00:44:01 -0800 (PST)
From: hupu <hupu.gm@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	hupu.gm@gmail.com
Subject: [RFC 1/2] perf build: Allow passing extra Clang flags via EXTRA_BPF_FLAGS
Date: Tue, 23 Dec 2025 16:43:34 +0800
Message-ID: <20251223084337.3789-2-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223084337.3789-1-hupu.gm@gmail.com>
References: <20251223084337.3789-1-hupu.gm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for EXTRA_BPF_FLAGS in the eBPF skeleton build, allowing
users to pass additional Clang options such as --sysroot or custom
include paths when cross-compiling perf.

This is primarily intended for cross-build scenarios where the default
host include paths do not match the target kernel version.

Example usage:
    make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."

Change history:
  v5:
    - Update commit message
  v4:
    - Apply EXTRA_BPF_FLAGS directly to BPF skeleton build command
      instead of modifying CLANG_OPTIONS
  v3:
    - Move the variable description comment to the top of Makefile.perf
    - Update commit message
  v2:
    - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
    - Update commit message
  v1:
    - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3f481a626af..8b8647fd4f41 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -35,6 +35,9 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for cross-builds.
 #
+# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
+# cross-compiling BPF skeletons
+#
 # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
 # EXTLIBS.
 #
@@ -1250,7 +1253,7 @@ endif
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-	  $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
-- 
2.43.0

