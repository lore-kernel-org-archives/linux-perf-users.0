Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABE178CF8
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Apr 2025 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540919; cv=none; b=RrubdQAsW+DeEp9bhaJa5FuxBsYgNnEPf+YTbw0RpntSXo0BfcbZQLmdujKjYkauAECXIMc6pzsH/amNu2QNlP5llM4W9cJjWR5xGutwwhUnxGhU4Yo58tEmUyhXzNB9VV0tT2AOQcazrdHOywqqBWtOcMxHH9G4+XR3KW/EloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540919; c=relaxed/simple;
	bh=BOW3297Y41WyxN9o70I4jCToDIFMCjKP42skFXi6u/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fid9Yud1XycdSbCHL7Z0gQoPeNqD65ZXeMTz+vO2Q3Y3P5g6dkK7eslVYYHRva9T1nHOPZhValYZ5q9+ks2P3Pepm6o8WcnDSt6COhdioa3Hf0AOGqsT9Llf6m8WLBmb600XNtshlFlDQpMnLyFjHeA3aTaLmQuQgNW7UxzsMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dEnaLEKw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dEnaLEKw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744540903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V5sLZBXFz6J0J+lLlK+U1RjUTi5QPbTvi0740hkhwlw=;
	b=dEnaLEKw7bwScZNE7Vbbe6kNtooCh1O84DTQAOyJSt2KwWkSvx6lF+qYQgLF0YJHIn4bhH
	FHnAYkjfMA1LWLTrj2EdUrBWqsi/XIPJ6OtNE76+LKjzLs2xXmuTnix4sGIS5nl3/GqUJg
	6zoOnRukC0h6xKQKominrjBCKS3t6RE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/bts: Replace offsetof() with struct_size()
Date: Sun, 13 Apr 2025 12:41:09 +0200
Message-ID: <20250413104108.49142-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to calculate the number of bytes to allocate for a new
bts_buffer. Compared to offsetof(), struct_size() provides additional
compile-time checks (e.g., __must_be_array()).

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index da03f53bfa18..16bc89c8023b 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -101,7 +101,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (overwrite && nr_buf > 1)
 		return NULL;
 
-	bb = kzalloc_node(offsetof(struct bts_buffer, buf[nr_buf]), GFP_KERNEL, node);
+	bb = kzalloc_node(struct_size(bb, buf, nr_buf), GFP_KERNEL, node);
 	if (!bb)
 		return NULL;
 
-- 
2.49.0

