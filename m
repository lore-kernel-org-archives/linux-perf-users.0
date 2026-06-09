Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DD2F90E0;
	Tue,  9 Jun 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967140; cv=none; b=nhugF5ti00FYDXe2c2yqlVrYF9Y4mNZoE0uvXYglp1sFwZDV0WttrXcXCYEmVgpuFWddFijpPiR1mmbqVRtgK4XZS6+Esbi+CPEP00W+Y4/+vMnJWowt9HCoQV92JdVDPvucDkarjOf1zypz0TzyVayrQQtQ14osuJ4WPqnPSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967140; c=relaxed/simple;
	bh=ZFmxeRF33aOVcAm6nSVaLFATExq9wDl2gMN4BS28DjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqudpLp41XOKx5+iBxsK9vr/wfaeK2x4U/4p5OI/gotfduSRvWSGCkhGblWuIPZrD6zURtb2iISm6yu3cZjTs+K+Gam1pE/LQNdWl2PGeQfOs9T6oGTPyH9a+RAxGe25NTW8TkeFUyajO4rlHNzYsDfWBv91pPwMLuhy8uHsURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhk0lAuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhk0lAuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D31F00898;
	Tue,  9 Jun 2026 01:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967137;
	bh=QPs98qVff/anFpPoGyuFck/93uaLBPSTCG1Ifpj0OGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bhk0lAuZicludYQduTAulmpkJTxCK+S9r1XNiYz7eEK1cUysSm4W0TFy+s3kI3QBH
	 j0M2GpKSMrSmpKPqkC1g8RhjoJcK94A98AWRdOc6XszkHmzDjg8O4lQbbY2vmuk50D
	 e0xe/zW1uuQUCTb7Oig4T/2JPppgqCH0FZkTZU7O4oKXGjFO70a/dygZW1LYO/mWEe
	 hvuES98Nr/1YVFICKOzZZK6/FNulL7pGVVNdiQDnkoS+2E577VVmK9wUNtvIm/mT1b
	 CJWZNHoASye9q37a9dV8ssu2isa1JZaBKcWHaK/U8a3vASq1ignM09jhFXFSOcKOLL
	 ErzujcPk0g6AA==
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
	Don Zickus <dzickus@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on empty sysfs file
Date: Mon,  8 Jun 2026 22:05:15 -0300
Message-ID: <20260609010526.1998472-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609010526.1998472-1-acme@kernel.org>
References: <20260609010526.1998472-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

get_max_num() reads a sysfs file (cpu/possible, cpu/present, or
node/possible) and scans backward from the end to find the last
number.  If the file is empty, filename__read_str() returns num == 0.
The loop `while (--num)` decrements the size_t from 0 to SIZE_MAX,
reading backward across the heap until a comma or hyphen is found
or unmapped memory is hit.

Add an early return for empty files before the backward scan.

Fixes: 7780c25bae59fd04 ("perf tools: Allow ability to map cpus to nodes easily")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 21fa781b03cc7409..1fab00ec4a59a0c7 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -448,6 +448,12 @@ static int get_max_num(char *path, int *max)
 
 	buf[num] = '\0';
 
+	/* empty file — nothing to parse */
+	if (num == 0) {
+		err = -1;
+		goto out;
+	}
+
 	/* start on the right, to find highest node num */
 	while (--num) {
 		if ((buf[num] == ',') || (buf[num] == '-')) {
-- 
2.54.0

