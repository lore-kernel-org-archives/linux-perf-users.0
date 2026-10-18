Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B804AB1A2
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331013; cv=none; b=KImfCe/v6PT+GI1nc0mpA+s4BKdi8DfRspb/mS2IomUSEu/xGmbeOTQYRQ9JLkLif8LRNgOORfiA5fWXf+mGVKbuhQxLLDZgCA+M9Ob/0MT7mY7wovEHYRlCA6JCHWbnEgvV/ssNek8aFEbyphrVCq8S46rattaY0/zqULCQFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331013; c=relaxed/simple;
	bh=3c8FLbHksQibEqB3kL5wCeH5x61Waf9pm1mxuk+dweU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCfos6CU2X2FLXbfjmUMzR+1Cl+PCHLBpKloZ5zRG/C8qSBAA63tWi9xORVaye+Tqcx9s75sgp9So/X1KK73mjhwrVn7uTmcYPsPeEe+veZ/QD3CH5mPH6/VOLNX+Hp9M7Hg0s5Kq3RWJUr/Rp5znkUKQKbB4t6WPryCnwf5zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMC0W6lK; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMC0W6lK"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so3614593eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331011; x=1792935811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZCDb29RXoNd3s2gr9vco9lTSJAXM4DbUDPNku3m12E=;
        b=OMC0W6lKBQvYsZKtS3Ss6ZAEwgzihd6Vg/TzKcfCw3FgdjXCHmwqCsTYBHxc+TwnDY
         SIl6cBf2VnivZCAjWLzNGfftxTWSDWd7hZEHP8tp4fm/CUr0qWN7wbNCBchP+IjweHWc
         mx/ibx64YQD/CRx0HwtYnI4KtjORhX8pd1PD5arvg7Wy0ifc11XyMEsDeWw92ByDQZIV
         otBnUI7i8lEN9S9tRe4o2/onRZwzZXgJipPciroPiDJZi5zWZ2oXkSisd+O/1EmH27yw
         vgp1gHGKXolGLsRjiQcS7hpJVhivRbubdmbUPAf0AxUYfk6O6/yvO7CpHzXlXLPCpjM5
         qyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331011; x=1792935811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZCDb29RXoNd3s2gr9vco9lTSJAXM4DbUDPNku3m12E=;
        b=rDXJ8IIsgP80qyYpNBoByTt7szErgXPDUkSMMlsFL4kxb3WtL9crg6GehAkoqW+JSc
         MfrMikwhlQfk2fEIs0W3ZBUPjUTEcGAt7NHBbJKD0Eqg3rjqNw0aQ1KG2vo2WlHG2AWj
         wC49I6e/fyHimHPLdjU18VPfMTcOsqd5dQTNgqyf5tIdZ/XSw6PUbwFVt0CWniAwbjGc
         rKTfhgRh+pxv27WzmuyySIn4IrLILVEGi81twov7m6DcV6KehKyMaRUSSwU3/F73FSsR
         HJzUvI5hfbwLx2TjNtDtj/CcQRUZX2LbXSC+d59IzME9b4Spt88HKtRdb2AW8BgmS5wD
         939g==
X-Forwarded-Encrypted: i=1; AKwUvBzVYVKKc8zM9pHhIRVXU+WnqJWQbZLbtK/0svrFpRkeGY4NjdNijFlySVXB7EIJdFL3QQ1wv4G9ZXHGd0Y2tFJx@vger.kernel.org
X-Gm-Message-State: AFq9FYKvvyLmy6AwaOQjIUBTt9wRHvTU51OgGa8Kr1gnk0F8EQlDDeY1
	kaxRPQvEI/VOTZGMIhFl+ZTZYsEIlr/nY5hmqmvmv8z9thInEllATI8f
X-Gm-Gg: AYBFou3ODjguY0ea/e3MMkdX37Wr5ObB1bQSrk//cV2TXqBxYkW6VJUpaO162xKu++p
	0PiDqEv0HuN0Z9KVBjHwVB4hJ5kz1I17h2YJoz8uEuXoWWDXjs5t1UdvzlbK5h2/6H/E5Dij+3p
	AvgW2jLkxlgf96Wtnl3A4sGLGm0+IvGgpNiv8Z8onhqLgeMx9q/WxNd8651Eu0xVOT4Yr1BmgNy
	+KsGgdDuF270l7mUw8et06zMFVDVVVVf5Qd+qMT1ksSQ7g1JtGeB8dNFS5XqBYljxJmg14OiOPw
	oe8pWD6zi5yLBGvQywKId0hbrBoWlS6OjgFhenp5G9SfqlogWc4rNDn01f76olgM3e/Fhqa3q77
	e00tU+Lu3eIEaYzuPW9FyIvU82MvBOUzb5UbAG72rZjqPiCUZ7Lato2PAulfEx0BlAQpR8/7k8e
	Lqbbl6+V4G7Dz0GKxdWw3C4CniTi5dVEQUV4dEzvntVWeC5f9wl3XqpXBTVXUciscVchonFlQ9j
	j+nGgvCvDXUwOKKH52wl6FxN+RGbf9v0wKGQY4kwg==
X-Received: by 2002:a05:7022:b050:b0:149:ef22:2fa2 with SMTP id a92af1059eb24-18512c38593mr6986527c88.8.1792331010569;
        Sun, 18 Oct 2026 06:43:30 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm27868593c88.16.2026.10.18.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:43:30 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH v3 1/2] perf/kselftest: convert prefix.pl to Python
Date: Sun, 18 Oct 2026 10:43:21 -0300
Message-ID: <20261018134322.26445-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018134322.26445-1-breno3011alves@gmail.com>
References: <20261018133032.24467-1-breno3011alves@gmail.com>
 <20261018134322.26445-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
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
index bc4fdb6f5..85ed9af96 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -285,7 +285,7 @@ ifdef INSTALL_PATH
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
index 12a7f4ca2..000000000
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
index 000000000..67c4fd0b6
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
index 311811dc5..1944c74f1 100644
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
2.43.0

