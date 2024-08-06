Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB081176233;
	Tue,  6 Aug 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984619; cv=none; b=igzLJVeFOwTfAltFavq2PFO7H+pxF0hyYZioZ4c2iZCB7Eu9H736w5rrXHLyNwqzsqRkEwjv9xWbuCwCVHCxyWNhT7dB7dshmao5tHh6sQIVR7By/c3X2Wdy8L7PeOlzhLD4MNHjREJ3wpBH3s99y4ZeilzVZ4TaFw8lby7v3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984619; c=relaxed/simple;
	bh=4uqDmHfTVYMjd8RXD+8oDSjLrkJG3omeOlru6Ot9MhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO4Ab5SWF2f/h1oqMosCjRZheX9hjEt50PdVMtVJ3qjA7+Vsn7QnEkEadGLRdfqXwLnbvrVWLJ9GfAt15sWGzZA58h45g53wZI+YDD2tzAqNvpTjeWXBTFNdQtU3yWXJK1KDDedgrevw8gs/Ia49LO9hvbwZa+1UsTmHqjK1Zxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZYRHS2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZYRHS2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2583BC4AF18;
	Tue,  6 Aug 2024 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984618;
	bh=4uqDmHfTVYMjd8RXD+8oDSjLrkJG3omeOlru6Ot9MhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZYRHS2PZ9y8uF5cbuMO+ZG2WaYmMVikU+5owlNcPPpA80oAIJdtGI+sIYw3ms85f
	 Zdy0fZSSsSq4eTWP0ZjegaxPMvXYAf6mVi45UfgFX1xbqco4vNIviay1cZPsh6rKVe
	 gDIhH80s9ZpHH/9CHO3oR+wMRgxLM1HilaJJSSTAN98rIMCHTVSPsEztSikFL609iW
	 6tdjj8RFzHHkOPULommWF6EScI6VRfNEmHIpJYff8brVWMgqCE+7pjTJP7yg8nHGrD
	 1OI9jqwsO2G5GfAEnhnSS7yUk2doLERCQanX2UbLMpe5k9VOIc65JRZ/6O5kmCMtOP
	 +37VKW1i+VMaA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH 04/10] tools/include: Sync uapi/linux/perf.h with the kernel sources
Date: Tue,  6 Aug 2024 15:50:07 -0700
Message-ID: <20240806225013.126130-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  608f6976c309 perf/x86/intel: Support new data source for Lunar Lake

This should be used to beautify perf syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3a64499b0f5d..4842c36fdf80 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1349,12 +1349,14 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x7 available */
+#define PERF_MEM_LVLNUM_L2_MHB	0x05 /* L2 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_MSC	0x06 /* Memory-side Cache */
+/* 0x7 available */
 #define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
+#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB / L1 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
 #define PERF_MEM_LVLNUM_PMEM	0x0e /* PMEM */
 #define PERF_MEM_LVLNUM_NA	0x0f /* N/A */
-- 
2.46.0.rc2.264.g509ed76dc8-goog

