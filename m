Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622193;
	b=aw+1oKsjVBa5+S96obRfiZZo/0m9wRb7C+WPyPdBMFqIermiznf7prBxAvh8jA+C0zg+
	 +RJFXbx3Kx06NjxiB/IX8emMs2GhJuLVoxD28JeC4zleabEl3bPzjIlf39+TJ4rtVhrBG
	 S2sc4rITYuyFUEzLvL1M1mpIrDNHXCrtNFh/XIcY30sYvI7L4Zjx+kdUkHQeEYGle/ctc
	 N5XzpEkH8aR5VpXcyoScAEC7Qpzup5q0o8UDcqM5JOn7dZXeC/QeDQr898eYuSqcLIeKL
	 /Wy2XM1tnZiFEvxW8zK9HvYaL8uU+kmu6QGXjyfJ9x0RmA7CMA3OppPkLY/0v0j6EZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=od8WN8CVmg89zdoHb82fXFB7zIVfQy/GQmojzRyVr0I=;
	b=cBvHSrJx5NlqDCxcUNfF0YRyiFZ/M3XrZcLEZai1ctYTsC1pKe7XqGzhrnW724lQNEm6
	 voeZLf0e2OxZvXKLB0k6udVRjtGioms9Jnd1qoYNE3En0GEgxk0Ltb30mW2mAOc/IZvd9
	 g+z9MWUq8YMVIciB2dq+N4zsdIYDLDcfowrHV8zXjGvQdriiB32PACEQt5sHFJQRrCpIV
	 q7Z7N6A3V2vDCFFVlD2auOwwjWYi46zV4zuqtylEkyJcn1GQ3VwxeU5c9s75PBfjxit2I
	 I1XQjS5455IIDvgI1H6ypxLlFFDxybPLiSDPWjjLGBtZ1YkZnoJ8G9iJvlFuCH/SLAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndkLDRu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E1606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndkLDRu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947961F000C1;
	Wed, 21 Oct 2026 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622192;
	bh=od8WN8CVmg89zdoHb82fXFB7zIVfQy/GQmojzRyVr0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndkLDRu6gIKubz81j6WnViMwPu5nr+jauPyK/e5IKQfMHCsB6LQ0xSXTxdRgYAQ5V
	 cquE6Sk7okxlVItHbhP2dpouc2Jdn31OGTe0wcGDWxJ9PMQff40KB1Nt4FUMM7x0Wa
	 PlbA1h9Ql2O/yRTohdnHuQfLil1Nm0pGBVzRMqF5+3X/zDVdAgojUqBupv6HoHYALP
	 zJr/lBHlQOnN1zn/u6PmERWla8jGnOWtmMRwL7YxNhOclBC7Ip1aSMKTSV1ICAm00o
	 4gzKO9YvQ6aMs/8QaxFlarkKwKEiMRg1yIMwzRzmqoLEwBf4nlManhrvXGEwNfguiF
	 88LpuBt1V/x+w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 08/12] tools headers: Sync UAPI linux/fcntl.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:47 -0300
Message-ID: <20261021223555.28372-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  cdf930a00949 ("fs: support FD_FAILFS_ROOT in fchdir()")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index aadfbf6e0cb3a004..e43e3de3e9ee44a2 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -124,6 +124,7 @@ struct delegation {
 
 #define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
 #define FD_NSFS_ROOT			-10003 /* Root of the nsfs filesystem */
+#define FD_FAILFS_ROOT			-10004 /* Root of the failfs filesystem */
 #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
-- 
2.56.0

