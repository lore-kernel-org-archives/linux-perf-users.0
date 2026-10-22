Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693501;
	b=5SilsinTcz/Nk5+NpT0myiNtej8E2HuwpMgUigr7Mqgg4/xr6lvXCArYEwTnHGPESROn
	 dyS0C06NTM+EuvVYRJ5NnotJwabn1oqK7JKcncoR0EaaFjRxa6k2AjbOVdLG3IXBPDt0b
	 v6/BKW4UX8XGDDN0ma74bRh2nt0IwudEimH3ajAPQgekeBL7r/kbhm7Y5bJuSxzBbd/tw
	 RX0Ozy89GPueSxBhrY767hrOfBJVgndXYInEToCJJXR1RWAAZvI3OlSNAGAOxsXprZqNO
	 Zh+5apNE/VS6ZofqS31tz5q+Bd3CbWLum40APYlmLnmmo3HNx5PW5LM9Z1mip994bXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=od8WN8CVmg89zdoHb82fXFB7zIVfQy/GQmojzRyVr0I=;
	b=rXjboDze4BWKJut54bfhPU7T58mx8LxjTMjfMjBs9s8EVc0VLA8THosnoLjJq8EaHNok
	 uNXDS/SVeuuU2l37WTb83XS9GkATZlCXWg+2z+r6hlSismh3IuFiojXD7cherE1LWgl4d
	 6y9Fl1AZaEbdd/ZWSjMbvPOzfLVo79ET9Q7MW5OHR5xgizGYfWH3JMFlNEcwWG+V5FIhc
	 5ejH9wzVBBg6DjJ7r8d/V8BgIMqzhsiIIwzzoERrd2IIyqXzLb7zh/uj+yky6zxaHWunI
	 2NjT1vTMRQrdpASVhW7mlzg/yEO7Zdc5PR/g4srGonqGI3pD8pzKI7XAYAFKgJfKZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnikR+8F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE6606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnikR+8F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C31F01829;
	Thu, 22 Oct 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693501;
	bh=od8WN8CVmg89zdoHb82fXFB7zIVfQy/GQmojzRyVr0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnikR+8Fk4oUpuJM5QBt0gGIv+WHEYwclAJFBkKi9fcYOcDDzZaq2PbWyVm2wEQr5
	 8yulob3tFxCY1Hj1iga9V0H6cQ3pNvW7CZSFjygLWVTrTrm6F5bIldutTOdufsgWPk
	 HLuvJps9BLSLcD05uS0xxM2qHxoIrGTOGCh4ZmYxSukPHtbPCsuY18yBEFCl+eKkWJ
	 mIRXG4qAk6P67qozHKiPXfX9YmjqrXfy451sXEdOmipM4voklgI08XoKQQJUtrvWv3
	 jMKBp80e8Z/UlStje7q1Sb7orxj9D6strHBtD61ZP4Irshw7AN+DevelE/TU9NHxZI
	 j7ewREF0mIfXA==
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
Subject: [PATCH v3 06/10] tools headers: Sync UAPI linux/fcntl.h with the kernel sources
Date: Thu, 22 Oct 2026 15:24:25 -0300
Message-ID: <20261022182431.25673-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
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

