Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0821D5B5;
	Mon, 19 May 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690902; cv=none; b=XyfAmeaihQFSRfN+Z5T4hdWtldHJW/X/pH++Uj8mz/uK7uG99ahQ3WG4Acy36nvKMQkNqBsC0wihe4Cbrm9vLQLsFCV8eTdmbRtwE9tsmXHeaqwsBAyoTwMe3OEMBhgjNPFEpB9JCjqqjYa7hrl6ro2SNrBeqyT8B9IkuXvmhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690902; c=relaxed/simple;
	bh=hrwbmJC+bvH5LdR/c9uplAVPbyooJ+HSynvCKzaZ5OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfY6NccXhtIxK9DHCMx6WSyfGqdSga2NmO7vhncWLsOkHBtiJ+aTd5dMCQNb5E5S9e+siQoozW++j+Wwe7i94XxD9NxIjPYHMbNHmJhYomvszB44vo/BYt6IwErE+MNzqEXbNpniECjHMhyq9fRwW/52u+hkgINIlShXbOX1X8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai2/e38X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai2/e38X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F103C4CEEB;
	Mon, 19 May 2025 21:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690901;
	bh=hrwbmJC+bvH5LdR/c9uplAVPbyooJ+HSynvCKzaZ5OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai2/e38XbK+nt+faOQ2RECCMj6v13FsQs0dfcN4Lpmu9Ha2n+u0KaEaxi447GVm9/
	 VZ2yXXmmxB9scCWFYoj2ThsyOYGF5VHqbBIJyzDmL88LcOLcpH3eoo1LX4JABR2a20
	 K0iHnFvKHaTVzsujyQpT0+2mrUMg3GEKt2p1l28sEPDrYoZKtnuQ14KZMD8pHwKe0v
	 ZxseyOyguR1dItTnyRrkveV9LkDhBVtcBI4Nq8Y5vynwODAiL4V5+Fl7A3N0Vyc3dQ
	 Ud5BwaQ9ABVilI8bJ+kDO/3/xC9HWbewQh/AjoX7Y0S32tgC41yTF+TKKapGbVtDpg
	 mzee1XiI2RqtA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/7] tools include UAPI: Sync linux/vhost.h with the kernel sources
Date: Mon, 19 May 2025 18:41:20 -0300
Message-ID: <20250519214126.1652491-2-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  a940e0a685575424 ("vhost: fix VHOST_*_OWNER documentation")

That just changed lines in comments

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/vhost.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/vhost.h b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
index b95dd84eef2db231..d4b3e2ae1314d1fc 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/vhost.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/vhost.h
@@ -28,10 +28,10 @@
 
 /* Set current process as the (exclusive) owner of this file descriptor.  This
  * must be called before any other vhost command.  Further calls to
- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
 #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
 /* Give up ownership, and reset the device to default values.
- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
 #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
 
 /* Set up/modify memory layout */
-- 
2.49.0

