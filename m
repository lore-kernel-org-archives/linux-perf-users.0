Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09634AF167;
	Thu,  3 Sep 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441805; cv=none; b=o/txpw3Si+Z+NgCwVilG72Vg0x1wvKLVYe0d7pZQiu9M4bibB5jEHjI7irVFZBusghyjAy26As0lLa2EuR42sqfBtVjuYC9AFPFuOZvvBmtm7LGKMxpEps4/SD4GQ8/j3JSgU7bPzuXGRTuq2SABLKJSo/wPpeq10PNgZMoZIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441805; c=relaxed/simple;
	bh=L94mGG3+amf0Eb6VJeYe7NEefJQ2vWe2zgiYN2nKYuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU5kMWKg73yC4k8ISHPkrKWvMx5zfj8KSvjQWxroGBbMQEggySsLMqtWmbMt0EAsfDiftTSnKqDDSUhdEzKdcF3ig1kC/934h/0HUD7Uazmoz6AjUTkAxAt5GhMYom17seGI9AmFzuPNvVR8nAt3bHJ9Vb7gQXR8zhCtQCMp9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EehSvjRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EehSvjRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D381F000E9;
	Thu,  3 Sep 2026 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441790;
	bh=p9ekETLC2l5v95gbac18OOJQxqsfYxKvXUWjvZAOyBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EehSvjRV8xL3r3wM2Re9JboBAJr0NKClZlXR+nzZz7hbM0fg+7KTAxPgVj2rlzlYT
	 ReKccM0OXXaoC8ldv+Ra/cecHboGdwfCylevbgM5EKx+tO4z+BHtVd2vqIQqScckIU
	 gBfZTWV+JpfN+IN2ke6y6OBEdaqGX68PH65ZyuymhmIcOkf4eVcBHEwKF+RfytQ6J2
	 1UyLPiXHEIYabU5sK+/hWlpudyMvYRedLmg+xFH++OKhqKlJWX9CPxibMkC10qLjCD
	 UZ87eUPCRkwSg8lPlJsdv9H1acVRcGPxwQING2T1Yf13W6ETms5zbL2s4qgZJwFzDz
	 1nYIsfww/htMw==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/5] perf jitdump: Size code_move event allocation with idr_size
Date: Thu,  3 Sep 2026 10:22:50 -0300
Message-ID: <20260903132251.237029-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903132251.237029-1-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_move() allocated the mmap2 event with a hardcoded
+16, but computes event->mmap2.header.size as sizeof(event->mmap2)
minus unused filename bytes plus idr_size.  When idr_size is larger
than 16, header.size exceeds the allocation, so perf_data__write()
reads past the heap allocation, leaking adjacent heap memory into the
generated perf.data file.

Size the allocation with idr_size like jit_repipe_code_load() does.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index efb40d93e33ae664..689aa0a8c60bcd8b 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -636,9 +636,10 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	idr_size = jd->machine->id_hdr_size;
 
 	/*
-	 * +16 to account for sample_id_all (hack)
+	 * Sample ID is written past the end of the mmap2 record; size
+	 * the allocation to account for it instead of a hardcoded +16.
 	 */
-	event = calloc(1, sizeof(*event) + 16);
+	event = calloc(1, sizeof(*event) + idr_size);
 	if (!event)
 		return -1;
 
-- 
2.55.0

