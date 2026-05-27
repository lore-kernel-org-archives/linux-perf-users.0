Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2823F44EB;
	Wed, 27 May 2026 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883966; cv=none; b=HpDb0O4a7+Hrp/EHErZVOAOmuSzIiDQSLooetV1L9mxMj3FuSN6iaZE9VmwQI9TJYJKbpNebCWBEjJVHS9lSeXYmqGZkfdjkLoTP1mFAObEIAkYOYvP4jVGXyFn1yaHBhY06RBxEVi8X7khrzru2XZrJYZ0n9T5BVRSJGgxWGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883966; c=relaxed/simple;
	bh=ECf/L8cm8+F05E4oCNG+j2SuvufsDhOisGsADV9b7gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7MwEiiFYOGDtMQXyu4xaTZiYz/gCFwqeDifBYbI5Qmpf4sht7lz9a+WnwCpyuB7LAzCDQ+Uaz1TgMEoBAplCMh8XgJuG3WHjVWDvopzFvnl9za4H+CYMa/crTM9odaap/oq615QDF+j5qz7rYm/O7y0fb2olDMzAcFLER/NyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4T6SXkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4T6SXkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6FE1F000E9;
	Wed, 27 May 2026 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883963;
	bh=6no4BGDS0XyYdBrexKoo6TT3tPuXPbKEDRVyJ4oD9Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4T6SXkbAlc54eDKw65mlkSVgcFAfv+QCqI6M7Eqoj4vFARUv2EOY3fIBfVW0xv2H
	 MynfGT2ZiSPWsJRuX+AzZkU4oh/nFxWZOG9i3D/mzZenfWXHaJh9ncMgHsjLFjXcCx
	 7A7atXEQJDJYgWXAZiK86m6DTRnAQv61S+aOkAcGaedRko2FEsgCYeADBJK28goY2E
	 xyTx6OYYQ77qUlPZCUZYxVycOP1AvbgNLtKM9axnbp70Ngin8pZWTipAm6TNWTtHvf
	 tXiqXY7lM3yvojNpVnCTikZTtctK6Rfp6wTsdF2g712JE+Nu+3/XaCjSIRxhVxyRqf
	 x1M/Kkxf0MB/w==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 2/4] perf: Use a union to clear branch entry bitfields
Date: Wed, 27 May 2026 05:11:58 -0700
Message-ID: <20260527121207.2312181-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527121207.2312181-1-puranjay@kernel.org>
References: <20260527121207.2312181-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_clear_branch_entry_bitfields() zeroes individual bitfields of struct
perf_branch_entry but has repeatedly fallen out of sync when new fields
were added (new_type and priv were missed).

Wrap the bitfields in an anonymous struct inside a union with a u64
bitfields member, and clear them all with a single assignment. This
avoids having to update the clearing function every time a new bitfield
is added.

Fixes: bfe4daf850f4 ("perf/core: Add perf_clear_branch_entry_bitfields() helper")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/perf_event.h            |  9 +--------
 include/uapi/linux/perf_event.h       | 25 +++++++++++++++----------
 tools/include/uapi/linux/perf_event.h | 25 +++++++++++++++----------
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..f7360c43f902 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1474,14 +1474,7 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
  */
 static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
 {
-	br->mispred	= 0;
-	br->predicted	= 0;
-	br->in_tx	= 0;
-	br->abort	= 0;
-	br->cycles	= 0;
-	br->type	= 0;
-	br->spec	= PERF_BR_SPEC_NA;
-	br->reserved	= 0;
+	br->bitfields = 0;
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index fd10aa8d697f..c2e7b1b1c4fa 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1491,16 +1491,21 @@ union perf_mem_data_src {
 struct perf_branch_entry {
 	__u64	from;
 	__u64	to;
-	__u64	mispred   :  1, /* target mispredicted */
-		predicted :  1, /* target predicted */
-		in_tx     :  1, /* in transaction */
-		abort     :  1, /* transaction abort */
-		cycles    : 16, /* cycle count to last branch */
-		type      :  4, /* branch type */
-		spec      :  2, /* branch speculation info */
-		new_type  :  4, /* additional branch type */
-		priv      :  3, /* privilege level */
-		reserved  : 31;
+	union {
+		struct {
+			__u64	mispred   :  1, /* target mispredicted */
+				predicted :  1, /* target predicted */
+				in_tx     :  1, /* in transaction */
+				abort     :  1, /* transaction abort */
+				cycles    : 16, /* cycle count to last branch */
+				type      :  4, /* branch type */
+				spec      :  2, /* branch speculation info */
+				new_type  :  4, /* additional branch type */
+				priv      :  3, /* privilege level */
+				reserved  : 31;
+		};
+		__u64	bitfields;
+	};
 };
 
 /* Size of used info bits in struct perf_branch_entry */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index fd10aa8d697f..c2e7b1b1c4fa 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1491,16 +1491,21 @@ union perf_mem_data_src {
 struct perf_branch_entry {
 	__u64	from;
 	__u64	to;
-	__u64	mispred   :  1, /* target mispredicted */
-		predicted :  1, /* target predicted */
-		in_tx     :  1, /* in transaction */
-		abort     :  1, /* transaction abort */
-		cycles    : 16, /* cycle count to last branch */
-		type      :  4, /* branch type */
-		spec      :  2, /* branch speculation info */
-		new_type  :  4, /* additional branch type */
-		priv      :  3, /* privilege level */
-		reserved  : 31;
+	union {
+		struct {
+			__u64	mispred   :  1, /* target mispredicted */
+				predicted :  1, /* target predicted */
+				in_tx     :  1, /* in transaction */
+				abort     :  1, /* transaction abort */
+				cycles    : 16, /* cycle count to last branch */
+				type      :  4, /* branch type */
+				spec      :  2, /* branch speculation info */
+				new_type  :  4, /* additional branch type */
+				priv      :  3, /* privilege level */
+				reserved  : 31;
+		};
+		__u64	bitfields;
+	};
 };
 
 /* Size of used info bits in struct perf_branch_entry */
-- 
2.53.0-Meta

