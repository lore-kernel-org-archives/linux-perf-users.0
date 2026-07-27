Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED9420889;
	Mon, 27 Jul 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169043; cv=none; b=YBCD+14FRDVYNwwtZ2CrSjvFAqlLarEkL07euW3c9clZOft7eZKOLErwuuXBzzeNFCACOTsqf5TWOAl6oq0Pg5opTQFrLz8H3x47/unVOeotd7weqV59WQoInwna6bD+P11N1pz0huE2aOWEBnewPn4qnKHg1U31I60cf3O+MiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169043; c=relaxed/simple;
	bh=bRqcCa6daN3XJU6jEQxFF+Uv0Et0xS8RonF9dw98iXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jORjbLcChFbmzi7TjiAclTvf4iuallFvYDohQjcndHcogMsxwLFsWi9mpBy6uihqHg4Dbgg3RgVkZq4epN/R774aPbfvtRK4Z1hyzNK4wY4HcTq8B6WXWH/DnYms9F+c97SIO2kgvALO3ScIMrS0O6GXRD6zHL2lWwFWwhCST0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcLgANzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcLgANzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552E61F000E9;
	Mon, 27 Jul 2026 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169042;
	bh=BNRj/UHytL/XWHBpwQpI5NSJDqXpT/8Gw9BXnE4fgeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AcLgANzo0BLjtgsHQDQqHLT0zdYNJc30UPWAIKphpT8f60gHBwDE2S2Nu+chWn0ey
	 Ik+vhe2UoT4G2afHltwuwN/1ljTL2dkoBbxGGSTS++RHdP4p7CzYsLrWdWFOekkouu
	 FjwhDhv2ZFqLi9E+xZojjH9IzqYDNWXRFkVBolchxkdPpz63wCyIgtbhRU1ocSB2k5
	 PiqJ3ec2kRhO8nU6tADH/Q8w7NqpBxjC9pFI9mXl4//OW0VJL8hNx8ac9YpJSZKyvC
	 X9Gua8tzmjBcXkbsnjaWIG6h/GbY7aFRdZArxFjm2uBx4JJdfD3bRZoUXdSZfdXDkr
	 bHHKCns+gR8Zg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/5] perf auxtrace: Fix queue grow overflow and old array leak
Date: Mon, 27 Jul 2026 13:17:02 -0300
Message-ID: <20260727161705.64807-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

auxtrace_queues__grow() has two bugs:

1. When idx is UINT_MAX, the caller passes new_nr_queues = idx + 1 = 0.
   The function skips growing (since any nr_queues >= 0), returns
   success, and the caller accesses queue_array[UINT_MAX] — an OOB
   heap write.  Fix by rejecting new_nr_queues == 0 up front.

2. The function allocates a new queue_array via calloc and copies
   elements from the old array, but never frees the old array.  Fix
   by saving the old pointer and freeing it after the copy.

Fixes: e502789302a6ece9 ("perf auxtrace: Add helpers for queuing AUX area tracing data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0b851f32e98c8517..aa749e1c30365a02 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -251,8 +251,12 @@ static int auxtrace_queues__grow(struct auxtrace_queues *queues,
 {
 	unsigned int nr_queues = queues->nr_queues;
 	struct auxtrace_queue *queue_array;
+	struct auxtrace_queue *old_array = queues->queue_array;
 	unsigned int i;
 
+	if (!new_nr_queues)
+		return -EINVAL;
+
 	if (!nr_queues)
 		nr_queues = AUXTRACE_INIT_NR_QUEUES;
 
@@ -267,16 +271,17 @@ static int auxtrace_queues__grow(struct auxtrace_queues *queues,
 		return -ENOMEM;
 
 	for (i = 0; i < queues->nr_queues; i++) {
-		list_splice_tail(&queues->queue_array[i].head,
+		list_splice_tail(&old_array[i].head,
 				 &queue_array[i].head);
-		queue_array[i].tid = queues->queue_array[i].tid;
-		queue_array[i].cpu = queues->queue_array[i].cpu;
-		queue_array[i].set = queues->queue_array[i].set;
-		queue_array[i].priv = queues->queue_array[i].priv;
+		queue_array[i].tid = old_array[i].tid;
+		queue_array[i].cpu = old_array[i].cpu;
+		queue_array[i].set = old_array[i].set;
+		queue_array[i].priv = old_array[i].priv;
 	}
 
 	queues->nr_queues = nr_queues;
 	queues->queue_array = queue_array;
+	free(old_array);
 
 	return 0;
 }
-- 
2.55.0

