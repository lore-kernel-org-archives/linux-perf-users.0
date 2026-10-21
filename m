Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622199;
	b=JkrWhTFAq+AnBKN78c3uxxl9BkhVLz3gr28/OyTFyj7k862VTuLiEv7HJsCZKwkj1oCF
	 3V2cjlHrYfOJEefUCB/rFmuV7WN/AKscYYvVD3MQzkwcSX5rr9bN0/jPeFE4aCioVtY+h
	 gxyMFb0KcWrkgjLl229VHv/Y0x2pK4XsXuN3KLSdbWLqpstX16QOTnLaKjXxuUn+KrjDr
	 onX5IkzQSoo3SSpRwF93b2Uh1AdJB8o3QEO9smfirUEjiQFUsAgb4ox4AT4xla68nFG9a
	 eMcxBOQAQmxsaPr8Sj/cJfrNYWwsKn/1vT9EImQYK4biWmFoujS6qR5YCTL+7HATVxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622199;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3V2DNkDLfU2DSu2SytskyV8hCqSvepdJ+kYH9To4EK0=;
	b=yPBeyRee03A58+JoMnSIyGllRilFtxGwNdEiPJcKc6Ge+FMJCcdRKoDk/LPXkeTpjtqg
	 9pBRbjhdyZGO52nwMHawWnw31fI9bfKrhGPNH22lF887ky9Cntne0YrBg6Zz0KISG9YGo
	 XZy4cEp7mfLd5O9d8bOW1Ka4LiTlwStenR2EkEZJ/p0BovT1AvUljqSc1BuN3+lhmkklJ
	 Sh2rl6h0ZyZLSc4OQYC+k5kyePxsbCumHlQpKmzC9Wg2/iGmpo2005Vm3B9+lMWYb2RC3
	 7j2c58AXdXYcBEoezKN//1ujI1AXfrcKExxs0WTLEVG2ETuXrnTCzWjyeY22GnbA1Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bk/PstFv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B5606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bk/PstFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BFA1F000C1;
	Wed, 21 Oct 2026 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622199;
	bh=3V2DNkDLfU2DSu2SytskyV8hCqSvepdJ+kYH9To4EK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bk/PstFvC/kYEDvR9BqTJksp330Xd2oVJ1KZJB38QtfIkf/9LaQSYJvNQliJWbxHh
	 88imk1GovzvTVpt6Gszp4PuBZRsWA1+y48tGs24HWX1cEqDb1pBS0S1cTd1ftLZSRO
	 CyyKNFpTgVK3IMwsUEiHVvhnAuI/Uq45uhrVo8mTMQbA9GjWirK3fBpYuHEyZKUlu3
	 u71NOqkbYdrJLk1SbCs7F/3hcLzhz0Q965cS9vefdWmTFekQ9ZtPU1DIDr7nGv/L6T
	 9N63DE1rwcc23tMH53F6sLr8vkMMoelgXuCAL+tNFYXQWTOD8S+2qeds+mflt4XVZ1
	 QCTwDGefgih3g==
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
	Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH v2 10/12] tools headers: Sync UAPI linux/mount.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:49 -0300
Message-ID: <20261021223555.28372-11-acme@kernel.org>
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

  73b40395c71c ("mount: add OPEN_TREE_DROP_MNTNS_MOUNTS")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h

Please see tools/include/uapi/README for further details.

Cc: Kir Kolyshkin <kolyshkin@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index 2204708dbf7a583a..ac865edac5173e26 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -63,6 +63,7 @@
  */
 #define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
 #define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
+#define OPEN_TREE_DROP_MNTNS_MOUNTS	(1 << 2)	/* Drop mntns mounts from the clone */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
-- 
2.56.0

