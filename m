Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749683;
	b=sRJk0gl7mWvtFfS/Dm5UNcbeHjB7j90l14ETVwgLK+DySGJ+rWnDcJk0m7RCP4FJyZbZ
	 5a/o7qIw05HcyQRSf2Td5woP2t4FoxhVSF0AvpPu80rxOtspVrrM8cEtNh+P4CCwnnjvv
	 a57Fh0wI2teHQxJyg/f4g35hLN48Q4MNf/3xeyvWDxLqJZb8B1bCFddl9tXaeIGPkEJz8
	 SuXNLCYjjbEeZ/TBo/p2qdtRh7dx35l2fOtOQPiPMN7zPw5W/Wl0NdmWoIj7//ykwSD3q
	 hrGA5UJI0Fh63SqOkm+ALqPeXW+QCgQXXUBRP0FIm1o7CsYNNF8HyTZARW17YzaRQDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=cy2nNK1rI/kLhuzSyR0baNH1H94wn090BymVcYk+AF4=;
	b=O5Mz7WY03sXX4DmDYiuyBWuBw0CK88+l2h87AJpPHKlHgZQjk6m5XuVdXio7LcXMnYmk
	 HweMperOF6W4HnqFPE4NvrkIkxn/euFzBqAf+CTwhFwm2pJLuMfjuCVi8h2xDtQgKx9tK
	 AjQKDM92yctXktga+1y+MhSMHJ/Vu6rvMRNpEwjIDCxWVm6vWIlQVXvrefFQp3gKPHGB1
	 tVbpisXVW7pnVsIFfqdn20O6cDT/siLskiPvndQvbOc9M7tKv7ORuu4G7INHOd18p0r/R
	 6C0zzE0YofQtBEUIwTQB5lnA9Z/pGRCGfsupf4pfSoEjpJ0aub6GfjyWuG4+afY+fzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=M63F1wkv;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD5606A31A;
	Sun, 15 Nov 2026 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3BD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=M63F1wkv
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E491688;
	Sun, 15 Nov 2026 05:34:39 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E3D3F85F;
	Sun, 15 Nov 2026 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794749682; bh=km/W8N+ZMvEGY9g0PkTnKKdqrsdpENOnRL0v1yDlAG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M63F1wkvBUuCeR5BtsdpVEpywDj9MdyD8B5xSr7iM5k5HAgZmcSz4HW8OgrgRWdFF
	 9JdvtTlI8mn272s+Wh3azqxpugq1UVFjX5tt15b/PVxTUtPw+yQ4ac3P4c0shSxwOz
	 mHUl97ErrzB6y8UGTnJiovVY0ok5k0ik9Qp6Wssc=
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 15 Nov 2026 13:34:22 +0000
Subject: [PATCH 4/4] perf docs: Describe multi-record thread maps
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-perf_fix_large_threads-v1-4-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
In-Reply-To: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749674; l=1961;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=km/W8N+ZMvEGY9g0PkTnKKdqrsdpENOnRL0v1yDlAG8=;
 b=aqjjd2fCbLNg92lBrDb2qhU9uahjGE4oFmONxbLbNopAR65qu0r9EOGSDh5vjGqUtJVgEA/aD
 86ktP/AZA7BDv2oYlTcP35zKzUbl6Oedb1jFFN1C2dlYbU8L5T+GdXf
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Document the PERF_RECORD_THREAD_MAP layout using the structure names
and flexible array declaration from the code.

Describe the continuation flag and ordered assembly of split maps.
Explain that readers must collect the complete map before allocating
per-thread counters or processing statistics, and that split maps
require updated readers.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 1f8e7d8e9ae21d732df698c9d2560377dea5f03f..6b59404ef0ff92102aeb63fc0d1da283536a4add 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -651,6 +651,30 @@ struct auxtrace_error_event {
 	char msg[MAX_AUXTRACE_ERROR_MSG];
 };
 
+	PERF_RECORD_THREAD_MAP			= 73,
+
+Lists thread IDs and command names.
+
+struct perf_record_thread_map_entry {
+	uint64_t pid;
+	char comm[16];
+};
+
+struct perf_record_thread_map {
+	struct perf_event_header header;
+	uint64_t nr;
+	struct perf_record_thread_map_entry entries[];
+};
+
+Large maps are split into records that fit in the 16-bit header.size field.
+PERF_RECORD_MISC_THREAD_MAP_MORE (1 << 0) in header.misc is set when another
+record follows and clear for the final record. Each record's nr counts only
+its own entries. Concatenate entries in record order, preserving their
+positions, until a record with MORE clear completes the map. Consumers must
+assemble the complete map before allocating per-thread counters or processing
+statistics. Split maps require readers that support this convention; maps
+that fit in one record are unchanged.
+
 	PERF_RECORD_HEADER_FEATURE		= 80,
 
 Describes a header feature. These are records used in pipe-mode that

-- 
2.34.1

