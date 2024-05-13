Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9301292CC
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586568; cv=none; b=C/38E7KGYC+NzZ6bWqaDoLQtBAvKLS5y41jpFVelrXWZ1Ue1HNi9IDOou78pjQFYx5RhQ/7f7xJ3frilPoxYYNQeF+r4Kz6iqGWe7ABiOF2ByZ2SxzAOMvcNDcNiFDANBiAEghnKBPx6gy5ZBAeb2neSHiuCkKu4KV9urK7YBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586568; c=relaxed/simple;
	bh=nNY02W8+mwn4OfGfOk44xFpXhIwKsr2nKA7lZGKZsG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZ9oI/fZCCtbbscmR+AVLAwtc2EoZ/bBvk12keHFwrrYuIjsap1pzVaD/WH8xWhbQHD7imwdBqDffZONzrLx0sYs0Mm9u947tdMptifBoV7Z19n2s6utL1I481fSwR4M5PWzoyU4A/XikbI8MzoPPLIzgkjBTqhkSuu+FmtmLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EdK3EXM2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EdK3EXM2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so36114445ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715586566; x=1716191366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvU9L4BSNfi8J9xPmuApsxXdGaL41m0A1yNVgMIPbng=;
        b=EdK3EXM263ygSf52V0zHBqXwfchG8EuIMqi9xmS6Q1V4Qu/XEJX3M5byuuOp4aqKYY
         tiN8gHnZR6nEYuI3vjLpejZ05sGFd2sop1h/RRmxBLx3cG9B0RLIGl2tqFEz3SCm1Rrl
         TVP5n/6shFqCWq3k4+sSOonQEOrgY11oTZvx0vSWAmUXV0rAj8TVUuZmes8pCSFdhNZJ
         cEKrV4FHy7Gwz9m11zSHN4fggL1ozwGknZXhuTxkuyR1l5tCIGgfEc67BKtJ0FF6Uo8s
         VZEOSZxeUHZHcgd/wFeD1smOk8VDnlSYVA6ec11Ua4ekEOExD3YBBoHQx7I7qay15ggC
         zUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586566; x=1716191366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvU9L4BSNfi8J9xPmuApsxXdGaL41m0A1yNVgMIPbng=;
        b=gShXP4d8wVIWzn3nvUwZMll7wF2CiGjYjoRng8cvFNecmD0oWPHfONIGVFCBW9dWK0
         6Oh87y+RAc9Uon0HmdxjqynYqM/RDWsbZDhRbVSRdJV0dwoPT4XEaTZMMAsiL9JB2zJQ
         Xu3qp7Ll42UEY5NYSqM5VryF67T+88QiZvgmP4XvRKwXa/S3J6AgQgbX35jhdj21JjyQ
         OdoNc4RRPmDOxsmW+I4rM4OEv9T5BZVSIeZo5S+XaBsdVy0CgJKFl2mFeEUwkvTZJWYo
         k8o0QZjMu0r28aLANki/GljqdZtgBrhsDXb/X3PZnC9Kn3D+bBFKOfBz17hnR2UAJogd
         6f+g==
X-Forwarded-Encrypted: i=1; AJvYcCW1SzkIx00WEfD6aFnqT4g+8e7aVniiBr2Jo6iOPRzk6Eki7qndDXVc5rYL0M8U/cDsYzDgi2txXCt0FaVyF4A7kIAo9uK+bpleXtLYEaMBJQ==
X-Gm-Message-State: AOJu0Yzj7XcflnDlyGZurPT81EyXRnKJZKovRF+21BD6GnxY64h+BtO8
	A6vE0+hvkicI1onMUjNXtpYGVFTDnJQHt2RhoY46sWDxut0nhT58gQvLgAbBRc0=
X-Google-Smtp-Source: AGHT+IH4JooL2Xn1oFULJpSiLnWe/sK1u5EuizKlovQAmyypuZ3uwWz/JZO5VX66fX8eMuIfWbdI5w==
X-Received: by 2002:a17:902:e883:b0:1eb:d79a:c111 with SMTP id d9443c01a7336-1ef43c095b1mr155344545ad.4.1715586566631;
        Mon, 13 May 2024 00:49:26 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm73396695ad.111.2024.05.13.00.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:49:25 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 1/2] perf build: Specify libtraceevent dir to rpath for asan/msan build
Date: Mon, 13 May 2024 15:49:09 +0800
Message-Id: <20240513074910.1660373-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513074910.1660373-1-yangjihong@bytedance.com>
References: <20240513074910.1660373-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf built by asan/msan will not search for shared libraries in the
-L directory. For cross-compilation, we assume that sanitizers is
generally not enabled and add libtraceevent dir to rpath in a simple way.

1. msan build

Before:
  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 LIBTRACEEVENT_DIR=/opt/libtraceevent
  ...
  $ /tmp/perf/perf
  /tmp/perf/perf: error while loading shared libraries: libtraceevent.so.1: cannot open shared object file: No such file or directory

After:
  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=memory -fsanitize-memory-track-origins" CC=clang CXX=clang++ HOSTCC=clang NO_LIBELF=1 BUILD_BPF_SKEL=0 NO_LIBPFM=1 LIBTRACEEVENT_DIR=/opt/libtraceevent
  ...
  $ /tmp/perf/perf --build-options
  perf version 6.9.0-rc5
  <SNIP>
           libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
  <SNIP>

 2. asan build

Before:
  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' LIBTRACEEVENT_DIR=/opt/libtraceevent
  ...
  $ ./perf
  ./perf: error while loading shared libraries: libtraceevent.so.1: cannot open shared object file: No such file or directory

After:
   $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' LIBTRACEEVENT_DIR=/opt/libtraceevent
   ...
   $ ./perf --build-options
   perf version 6.9.0-rc5
   <SNIP>
            libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
   <SNIP>

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Makefile.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..a9a923358604 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -188,6 +188,10 @@ TRACEEVENTLIBS := -ltraceevent
 ifdef LIBTRACEEVENT_DIR
   LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
   LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
+  # Specify rpath for asan/msan build. Generally, cross-compilation will not enable sanitizers.
+  ifeq ($(findstring -fsanitize=,${EXTRA_CFLAGS}),-fsanitize=)
+    LIBTRACEEVENT_LDFLAGS += -Wl,-rpath,$(LIBTRACEEVENT_DIR)/lib
+  endif
 endif
 FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libtraceevent := $(LIBTRACEEVENT_LDFLAGS) $(TRACEEVENTLIBS)
-- 
2.25.1

