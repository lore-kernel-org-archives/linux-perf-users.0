Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616131;
	b=PR5UUc1JnXdrLIqJbmP77LpB2T0b+ow5AMHLXsLXJLp0tFCCmVlOOrDg2rhWd66NUuPQ
	 sRXnLnUxvZTvz3muOCOSC9Q6/BKlQCcai2YIJ8RFPlhmdTn7KD4Qp17snuJW0XPxa4yt1
	 kKBcqvmE/1JXu0bEkYnLjhIbf1rpqG1HeOJ/o5935b4k9rIhhfW6ls2s80aU9jMlJS1CQ
	 nlH3R+IgBop0JaheA0hB3HvJylVqobejVQQljTCnacrzWZ78aM6c+wk0n9nOa4L/wE1sM
	 Dk75LDB5+mhjXzIjufEZW6yrZE4qPfw4fy43+n7kLJcCAl4lshTUtE6XpAL028UwX0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k2CVahfdtfCEt6Rhl5+UPBC8R4qgo2uKGjGxWZGnVNc=;
	b=H0qz2+r+V+L7R/WAwhKVD+QflJx6XlkH18DOdAncfiWTXMopY0lvXLWSDE5EioOUlNoR
	 IY/HEcEeXkT8nZrQfbd6NIY4dmd1dGFhtUy5+xdmVrpDCvs+HAG0FQDc7+4ZRoNfKgbyd
	 9RTxuN31LN4WRiyD2p9ut5Qo0EVkgrtP9fGaeGPRD2CTeJtcIRTHdPRbka2Wp2zqE5HDo
	 ebzY3O6JI+yj9khBXVS+s0PsKcwtDHwFpyMGVX+HTL1w8DVoP2D439vKSDY98LCvPT7QO
	 qFR6tfxkiXuPBBKEqB+8V/mYIOT9c5lo40qpGt2QOmmg/PvjGewp1elwTOcWj9/rP6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pal82Sk1;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC1606A326
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 20:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AC1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pal82Sk1
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7c03744ef27so423803137.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616130; x=1793220930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2CVahfdtfCEt6Rhl5+UPBC8R4qgo2uKGjGxWZGnVNc=;
        b=Pal82Sk1MxtlriboG/NXM+O/pVnBqIOA9veaPFQvJAXMxlmo29mkKVQb2jYoy1+KsJ
         PvjGx5DTLvqpv3AKnkr0VvRbkzq90T+S99IpYmwuEUDAc5qmEJgobeEcSb4m6oUXCeJa
         Ls/v0Xz8yUaa3XSh3Sg6g6pG3vqPi1/ZOsOBv3qDPP83Fq0CZJHprD8sbadbovTIBoOg
         0g3dyON3oil5G+pQRRD0Q5yPXokzxzaA4yoA7Zfm9C5qb8u/Gkrfpi/Dye8bMCljEaeD
         tMYyh2G8HFye9526ybmnM0xRie+IpPlYKsmOAgc8yA16LXxWqr5evtoUg3INlbw2UYkU
         XW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616130; x=1793220930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k2CVahfdtfCEt6Rhl5+UPBC8R4qgo2uKGjGxWZGnVNc=;
        b=uztb4/adekCVHxs15m/BacLQv6yIlM3zEuRTjI9JdFgFpQvGITTm8VJYLyJHSDrOzF
         DHxbyWZ+dY9YcigUUC1u3zq9Q+tHCoYZ2PlHs7u7dm81h6Cf604EO1LCiiAZt5It78+C
         O2PktiDWHE34NqoqWVUosDRo61Qn2MTrNawNIBn+rsCrU4NXteHTTgMat6INiYgcX5nB
         WcivSi1VoUm8bTFkviB7VPrc/3b+aJwuUsk/6vcJk26obszqW67atpfm3buZlQS9EmsE
         YR7X2PDVhFPoxzlXtPICqTa3TkscKX+KFbgyGJykUmCU4xSO2+Hr7lIDKsTuo+3Dgea4
         nokg==
X-Forwarded-Encrypted: i=1; AKwUvBx8Jgk8wUOs1DBrHhYVhyNG7eVtEU08zbPWDDzVvj/b5tQfUrdIhwCljhK83KdWrPVw3/NH9nTsFUrXKhXW9Xor@vger.kernel.org
X-Gm-Message-State: AFq9FYIk+8M+H3XaXkW4NPY1Cg4+Knl8Jk6OrUc0IZjs2WCn53oT0dzh
	Tz/W5fZ6bZnEBC3TjX4geS8l8u29sIsau8I1e3LEeaYlmeE6yLkyq5ZK
X-Gm-Gg: AYBFou15uuIaBv6mp/+681yhvz3F7SlTOhCjNO3i/DMcWMIlGqMNPN/dKJ5Xp5c5yXo
	AULfMUz0hTSD5KN0UPF3Y08FngDwHhML9O3xB+TT/TdtvWjTv5zECYv37AwUCl3dPnnCyRRSRZ7
	mH5IKA2HmCBbimbQnfYZbwOen2gXpcgmVxzR3ls8/NtGJHo2LEpp5ExJQWZSUZYKqHWKeJxNdmu
	KShVYC/HE76RdG/+WJeCmV3/JHYgAL8/JBAWJNlMwif/Zzvq9EG5NzF8IfIBHC566mGWrwxXMz0
	QIiahwUFNcwmXzNsjvrzYl+I9kgSt5YKXpTvS23XI8oJ0JFRiJ07Q32rB/IABFR4467MehZ+fJz
	7Zp7BYswCfC5/vqpT/g2BL+6Eyn0X4v8TqtQ7rnchBCQ5XXdSaf3Oqc7hqx9aT7smqdWkMUQYC9
	2Y3c4PD71tTeMOXZq7/MvnA2o7i8P2qihdrsGe8uQGF7Jm6zHnuQBvAd+OYBVOTNGL8r3CRi3yf
	UQ8LU0wuNO2cuiiohvi4J5e9yBLuTGdTEqtsXtytMhQiM6PkiLmJXxlc+4V1wSLBY5JT5dNiZw6
	akXJhmFM203dkbJzQgR128uyVmeV4d+T/9i0AefTeg==
X-Received: by 2002:a05:6102:3709:b0:7c8:268:ecd7 with SMTP id ada2fe7eead31-7cc92739b17mr1017473137.23.1792616130118;
        Wed, 21 Oct 2026 13:55:30 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae980f64esm4553359e0c.13.2026.10.21.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:55:28 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: irogers@google.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH v4 1/2] kselftest: convert prefix.pl to Python
Date: Wed, 21 Oct 2026 17:55:05 -0300
Message-ID: <20261021205506.26736-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021205506.26736-1-breno3011alves@gmail.com>
References: <20261018134322.26445-1-breno3011alves@gmail.com>
 <20261021205506.26736-1-breno3011alves@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Faithful re-implementation of tools/testing/selftests/kselftest/
prefix.pl in Python 3 (stdlib only). Same unbuffered stdin-to-stdout
processing, same "# " prefix behavior.

Update runner.sh to invoke prefix.py instead of prefix.pl, update
the install target to install prefix.py, and remove the old
prefix.pl.

Verified byte-for-byte identical to the Perl version.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 tools/testing/selftests/Makefile            |  2 +-
 tools/testing/selftests/kselftest/prefix.pl | 24 ---------------------
 tools/testing/selftests/kselftest/prefix.py | 24 +++++++++++++++++++++
 tools/testing/selftests/kselftest/runner.sh |  4 ++--
 4 files changed, 27 insertions(+), 27 deletions(-)
 delete mode 100755 tools/testing/selftests/kselftest/prefix.pl
 create mode 100755 tools/testing/selftests/kselftest/prefix.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d960626750e..4bec301fe278 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -280,7 +280,7 @@ ifdef INSTALL_PATH
 	mkdir -p $(INSTALL_PATH)/kselftest
 	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
-	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
+	install -m 744 kselftest/prefix.py $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/ktap_helpers.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/ksft.py $(INSTALL_PATH)/kselftest/
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
deleted file mode 100755
index 12a7f4ca2684..000000000000
--- a/tools/testing/selftests/kselftest/prefix.pl
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/usr/bin/env perl
-# SPDX-License-Identifier: GPL-2.0
-# Prefix all lines with "# ", unbuffered. Command being piped in may need
-# to have unbuffering forced with "stdbuf -i0 -o0 -e0 $cmd".
-use strict;
-use IO::Handle;
-
-binmode STDIN;
-binmode STDOUT;
-
-STDOUT->autoflush(1);
-
-my $needed = 1;
-while (1) {
-	my $char;
-	my $bytes = sysread(STDIN, $char, 1);
-	exit 0 if ($bytes == 0);
-	if ($needed) {
-		print "# ";
-		$needed = 0;
-	}
-	print $char;
-	$needed = 1 if ($char eq "\n");
-}
diff --git a/tools/testing/selftests/kselftest/prefix.py b/tools/testing/selftests/kselftest/prefix.py
new file mode 100755
index 000000000000..67c4fd0b6089
--- /dev/null
+++ b/tools/testing/selftests/kselftest/prefix.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Prefix all lines with "# ", unbuffered.
+
+import sys
+
+
+def main():
+    needed = True
+    while True:
+        char = sys.stdin.buffer.read(1)
+        if not char:
+            return 0
+        if needed:
+            sys.stdout.buffer.write(b"# ")
+            needed = False
+        sys.stdout.buffer.write(char)
+        sys.stdout.buffer.flush()
+        if char == b"\n":
+            needed = True
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 311811dc55a0..1944c74f1e31 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -29,10 +29,10 @@ TR_CMD=$(command -v tr)
 # with sed instead of unbuffered output.
 tap_prefix()
 {
-	if [ ! -x /usr/bin/perl ]; then
+	if [ ! -x /usr/bin/python3 ]; then
 		sed -e 's/^/# /'
 	else
-		"$BASE_DIR"/kselftest/prefix.pl
+		"$BASE_DIR"/kselftest/prefix.py
 	fi
 }
 
-- 
2.56.0

