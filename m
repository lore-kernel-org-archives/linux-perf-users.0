Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DFB35028E
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803903; cv=none; b=uPhFZuxMe72Hy/06mRbcdIS/8ioxGKrWQCDPd85VmCnDqqODge+ZPVFKL9yngSdR9ZPrksWCGZUJICsK6QWKgj5qdpqPy11WZRHquejJjIAqJKXZmDDwA7VAK0Q0iDV4DJx97R+PEPUFoIVyvPbIbld/sfCr+nmXwM3R7iKRW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803903; c=relaxed/simple;
	bh=/jY88c8DfenVP33BGf4ZmBKcEhRGxzA1gRHO1efpgkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hErX9Tv99J80ukoedmEZQpzgZomtODa9vdNKlrsj0zCuK6FqQelnYb5qvoREYCx8VZEVL/+lqJXa9bG0YIw/q0O1O1GpwaSw729UzTPjwUzr3McoNDIcNq+aJShm9Q2FBMSQs80BK+Zj9S0dEsOGwxazJAJRKZardlJ44PQ7Jd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL4ytrNB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL4ytrNB"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8876d1a39bso714097966b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770803900; x=1771408700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDkN2CtNrqc+uj+094uU1VeIMVKx6CU8wHpEzkmJ2Gw=;
        b=AL4ytrNBdKG8sJcHehKTN2i/94sW7Gy4AnSaTjRdUSU2qhB+lg+ArscKO42LTzdNJo
         pV7y7yj10l+WrPwzZiqtz0wj0dBFYsc0PXX17gHLIZ/twDCoFNHc8FdIMevRdICTapf2
         UM6WN5wxbjdBfB9MDuBU+DPC2u7rt6pw/81bWRv2hEngZjxkxmwxyu1ZQyKA4ZbGSuu/
         Nx0h8LD9xRG/8NscdigtgaO7kqkrGypGp9oe5dkxlhq2SyaKdQhnZ07vhDWd3JJQZh2W
         lJ6tCBf+LTbjjMotEJ+63aL+POLEJHfhVjYMDiB6Yla9F3LLxQxyeWp5GIKh7aa04q50
         6s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803900; x=1771408700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDkN2CtNrqc+uj+094uU1VeIMVKx6CU8wHpEzkmJ2Gw=;
        b=NI1LUharobVpU9XBMlIqyoQYMQKbEijXwdNpsC7x9K1uaUL5pqe71AQfjp7kFXLfNj
         d+77NF6pD4ObFna146J7Y+8m0MdgkuzQX9wzv8tiMkXwp7ZekkxhJ5Ua4PDnQZTZxZr/
         6UqfbtGo839cVcxmBiLmZolvo7Ya2fcwIzzRg3ef6oXjX5ILgpM5Yadze7Tf0Xq9EIrR
         OgM7NmK0kYDs0KrL5M7rCwpWd1lVtcOqWjjJEh4fQ/p1snYj+UF3y5SBr/wVxWyuZOsC
         acsbZXoOn6SwTW5ww0aqD72KVbxqHQ2X9PQTBbF+5s4ejbWSStlgymMcd5IFGB9mCzzc
         7fCw==
X-Gm-Message-State: AOJu0Yx39L8J5IeKEIY2Cu8PDCl4OcYa9fcYPJj+i3L2xmys846ZdDtC
	R0qFdq9WBrxfi5nFBBDlD89xK4S9v1tg/2gYhV8fZA1Go+PYQ+ueHUhyepd8Ug==
X-Gm-Gg: AZuq6aKkSrMWxXCNFQAhumxh7Fc+nYMoO9lofR3epRbRONr/OdkFVIicCGuorRYwH3H
	JLtw1R5rDo3ZPevHFzZvT/zJTYDa6EQ74yQCNJgh727Rb4HJBseojscsoYjvDOAhnO7X6aTcYGT
	dLnATYpmHPQMqXX+tg/85oe5BnWsTQd0eN9dXoD97CBXgQVON5Cx5W+gzDVelsgQ8FASITqDTZ5
	rd5IPauODg6Pams58xlvdzwSK5MOUGWi8UJ1Zd4rNJTyEo0lhO9/6uJ5H/gs5sDoY0ptUQz2s8G
	1PXNQgiR/W4KhpNeq/J+5tWnoJINvio4JTrBmDF6WQv3vY3Kub//6JJ/gBezj/uh7o0k2mqn0my
	eh42D86umDvf5sqy+tgtJo92DKXLnGk7on76TdO8wJlfJLhu6+h0yPxnJg6dQ3KFXT57BeLCRHq
	3aK+tMStspY0jO2GSX7kAHnIf+a/N1BQCNrxe29Pw29nKsSrOasOm8FVSo13FdnXsGHdWMZhugC
	fLoIDIbND9XZHP5ErCwcEVIVwdpFCI=
X-Received: by 2002:a17:907:1c1a:b0:b8d:cbb5:c068 with SMTP id a640c23a62f3a-b8f6aed4feemr144170966b.58.1770803899007;
        Wed, 11 Feb 2026 01:58:19 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6e9e98ecsm43829466b.30.2026.02.11.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 01:58:18 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v1] tools build: Fix feature test for rust compiler
Date: Wed, 11 Feb 2026 10:58:01 +0100
Message-ID: <20260211095807.132855-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently a dummy rust code is compiled to detect if the rust feature
could be enabled. It turns out that in this case rust emits a dependency
file without any external references:

    /perf/feature/test-rust.d: test-rust.rs

    /perf/feature/test-rust.bin: test-rust.rs

    test-rust.rs:

This can lead to a situation, when rustc was removed after a successful build,
but the build process still thinks it's there and the feature is enabled on
subsequent runs.

Instead simply check the compiler presence to detect the feature, as
suggested by Arnaldo Carvalho de Melo. This way no actual test-rust.bin
will be created, meaning the feature check will not be cached and always
performed. That's exactly what we want, and the overhead of doing this
every time is minimal.

Tested with multiple rounds of install/remove of the rust package.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/build/feature/Makefile     | 10 ++++++----
 tools/build/feature/test-rust.rs |  4 ----
 2 files changed, 6 insertions(+), 8 deletions(-)
 delete mode 100644 tools/build/feature/test-rust.rs

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index e959caa7f1c..698e89da015 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -113,9 +113,6 @@ __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(
 __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
 
-__BUILDRS = $(RUSTC) $(RUSTC_FLAGS) --emit=dep-info=$(patsubst %.bin,%.d,$(@F)),link -o $@ $(patsubst %.bin,%.rs,$(@F))
-  BUILDRS = $(__BUILDRS) > $(@:.bin=.make.output) 2>&1
-
 ###############################
 
 $(OUTPUT)test-all.bin:
@@ -393,8 +390,13 @@ $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
 		> $(@:.bin=.make.output) 2>&1
 
+# Testing Rust is special: we don't compile anything, it's enough to check the
+# compiler presence. Compiling a test code for this purposes is problematic,
+# because Rust will emit a depedency file without any external references,
+# meaning that if rustc will be removed the build process will still think it's
+# there.
 $(OUTPUT)test-rust.bin:
-	$(BUILDRS) > $(@:.bin=.make.output) 2>&1
+	$(RUSTC) --version > /dev/null 2>&1
 
 ###############################
 
diff --git a/tools/build/feature/test-rust.rs b/tools/build/feature/test-rust.rs
deleted file mode 100644
index f2fc91cc4f6..00000000000
--- a/tools/build/feature/test-rust.rs
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-fn main() {
-    println!("hi")
-}

base-commit: 5d1ab659fb93eed85d6d8b2937013360157032f4
-- 
2.52.0

