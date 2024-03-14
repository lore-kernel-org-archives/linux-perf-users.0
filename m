Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5044683
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397813; cv=none; b=L7Q0jw1qDqenXh7/Ltk3MAywL0l89euEy28yGJpVdpap/LsYeNxbenMQlQs6Y+QDkTB+72C45GjJzHiiNQ4uaNV9IoB/30N6m0Ho7guRHH94ef23arRVdajniUPM2Y3+Js6dfNbewukEhd9Wm5kAQA1rI3aZZ7Rzjr32QZShYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397813; c=relaxed/simple;
	bh=yGPOXqaYAlZIM2euNw/rXxkt1VZ7zu9X9IEqaqWRTC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nh0p/klrNpb850Ry6doJ75hubDuGRlbqjp5wj2y5e7XQz3jiyxhhKmn/6Y4RWHzL1bPLbXHF1aeFu2fiYHECB5UcEevosuOZHqlo1I1VtHnqeH0A9wZ88K8KmxNTMypucOd2mLLj5EgvWWC3xJdCyv2wsr+2V0F/EJsGjPEDJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XOuD/9Rh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XOuD/9Rh"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6aa5c5a6fso737965b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710397810; x=1711002610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAR7C+iK2X4w9xulmwE7Rw9Eiajcdx9SmmY05UvfD6w=;
        b=XOuD/9Rh9dYVx/AEL3/TVjKRYhFA4Oa2xx7bkhJdbb3htEcvB7fICY8Jvy9HZBJSL6
         kPLVVWjomlfA84cY2v7OwnRX6tgdDc9UKSzMtaBbArAY9m/J8Btd/ZsS+WDv9WmIgATN
         O+HoKp9FPF2I/R6EzrhvAz9762O745smPbb5+HLa3P64PvxWBHd77LEqSc9UjgN3f16S
         MlltRm6xVZQxkytzIHgcmwfWrrJL+tp5n4fa9SjoAQr/m+v6GTP3+j1aQAKzCkxi0FTt
         tRwwe1oQJj9NxfcK7unv6y/xV3xOocxVy4CozK0qLCzD/EsOmq1dfE6dT0lyFzBq+mEf
         gvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710397810; x=1711002610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAR7C+iK2X4w9xulmwE7Rw9Eiajcdx9SmmY05UvfD6w=;
        b=a09caqB+gs/pWvLpZ2yEtREouUoLrqIZTw9CE+8FJTor1oF2UxTg8lsCrFkTDEpIjh
         KnNRceZR+uGGkn6vPx6yVOo8PFCIoJuxgCLtCnBo5IZ5GKuqFZzV/ON7h8B2meKMDbTG
         VFRkxmgZexid/u7+8CiOpMo504CuWnfj8xLzv+6Y9uw6u8tAGtcRAQqWE7yzKOBUNt2r
         Xm+9BPp9Z4nqGZ7Xe9MnElmRa5nkgAnRQ+NpLnm74fy8+ZbFpLnAbOZXO93MVN590za1
         IvE6q2rOCNtie82a+WsWK/Y/IttjfO+zZKA8100BIvGUz63vpvjEYCJFNFn+dUaqOOzM
         wqNw==
X-Forwarded-Encrypted: i=1; AJvYcCVd0XYxMIVxdDVSLCrfjiUoYJ21nloRFXt6tOHGe1qbmM2tA5S4h7IOpK7VxxY0WYrc1Des6j0rm5hh6rAS9z9fDygLwAWTj9QAXLFA9wQ83A==
X-Gm-Message-State: AOJu0YxotbokxItwVpmr2vUpfL4c6mcb711p7bhvBfD7Cq3AEupu1hfz
	QSrIBGxr+x1FnSImeYtsKJ5qg7aTKlRHrltH0MvJFE84V/3tfQvJU2FZZvGMNeU=
X-Google-Smtp-Source: AGHT+IHrbiFvGrpMHBhYuPm1xV7I2ye9rWimapbJXk9sGW6YT5fYeJeh7k1XjGYPX7J+UthxA2fgRQ==
X-Received: by 2002:a05:6a20:2594:b0:1a3:4138:2221 with SMTP id k20-20020a056a20259400b001a341382221mr481126pzd.15.1710397809925;
        Wed, 13 Mar 2024 23:30:09 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090adb0900b0029dde15b125sm23018pjv.45.2024.03.13.23.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:30:09 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] perf build: Add LIBTRACEEVENT_DIR build option
Date: Thu, 14 Mar 2024 14:30:00 +0800
Message-Id: <20240314063000.2139877-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when libtraceevent is not linked,
perf does not support tracepoint:

  # ./perf record -e sched:sched_switch -a sleep 10
  event syntax error: 'sched:sched_switch'
                       \___ unsupported tracepoint

  libtraceevent is necessary for tracepoint support
  Run 'perf list' for a list of valid events

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -e, --event <event>   event selector. use 'perf list' to list available events

For cross-compilation scenario, library may not be installed in the default
system path. Based on the above requirements, add LIBTRACEEVENT_DIR build
option to support specifying path of libtraceevent.

Example:

  1. Cross compile libtraceevent
  # cd /opt/libtraceevent
  # CROSS_COMPILE=aarch64-linux-gnu- make

  2. Cross compile perf
  # cd tool/perf
  # make VF=1 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- NO_LIBELF=1 LDFLAGS=--static LIBTRACEEVENT_DIR=/opt/libtraceevent
  <SNIP>
  Auto-detecting system features:
  <SNIP>
  ...                       LIBTRACEEVENT_DIR: /opt/libtraceevent

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Makefile.config | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1fe8df97fe88..7783479de691 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -182,6 +182,16 @@ endif
 FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
 
+# for linking with debug library, run like:
+# make DEBUG=1 LIBTRACEEVENT_DIR=/opt/libtraceevent/
+TRACEEVENTLIBS := -ltraceevent
+ifdef LIBTRACEEVENT_DIR
+  LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
+  LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
+endif
+FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libtraceevent := $(LIBTRACEEVENT_LDFLAGS) $(TRACEEVENTLIBS)
+
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
 -include $(src-perf)/arch/$(SRCARCH)/Makefile
@@ -1165,9 +1175,10 @@ endif
 ifneq ($(NO_LIBTRACEEVENT),1)
   $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
-    CFLAGS += -DHAVE_LIBTRACEEVENT
-    EXTLIBS += -ltraceevent
-    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
+    CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
+    LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
+    EXTLIBS += ${TRACEEVENTLIBS}
+    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
     LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
@@ -1175,7 +1186,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
   else
-    $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=1)
+    $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
 
   $(call feature_check,libtracefs)
@@ -1301,6 +1312,7 @@ ifeq ($(VF),1)
   $(call print_var,LIBUNWIND_DIR)
   $(call print_var,LIBDW_DIR)
   $(call print_var,JDIR)
+  $(call print_var,LIBTRACEEVENT_DIR)
 
   ifeq ($(dwarf-post-unwind),1)
     $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-unwind-text)) $(info $(MSG))
-- 
2.25.1

