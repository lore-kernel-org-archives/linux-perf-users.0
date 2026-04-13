Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB038C41C;
	Mon, 13 Apr 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106709; cv=none; b=d0Eixpiwu3EoxZGNo8Ad5Oc7dchTkEs38HVAsab8OlnX5GXxFlsQxWJe2bGVBgtoeUJ2SV5wi1hV9+Ns324VP0sff2PNW6B2Ob2T+dtS3v0anXy1qRhI6OqeIXXdUQbpb160kciN1qj7O4HfqLVPkMmRMMN+hxzC+nk0pDh2dzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106709; c=relaxed/simple;
	bh=JQPVHfvUkzj2ic9SS65cmjJ9pkCh/Jz8i86/isDKNZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umou21LcEr71Q3uByFotIk4GUlvmdlqpujgwEK9WvsDhIsYUkFT5dOpv085oPzryFlqctAagIXIv5NPvyMAqQgbedK4EfmNc8N5Jrs3Yjngd4vuIMs2NvfeyyQ0SFodjfM8P0/2kZD8P7X9LXKpxr+OyC2R6MbNyUICTDxrDruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYOt2bz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYOt2bz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2382AC2BCB6;
	Mon, 13 Apr 2026 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106709;
	bh=JQPVHfvUkzj2ic9SS65cmjJ9pkCh/Jz8i86/isDKNZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYOt2bz4Gg+cTM8EoWwBy0FSyl4AWWaEADtib0LmRnPICQ5nItok66sSo64KYL8mU
	 aWqAQc4VbMpftssTkn/Wy/zpsnc5JzF4mUUdKbiqIMFFAj0C/wLRHCFi3n8PeMwci/
	 04Z/IJe7JjHwj9kdvmHXz+dtxwz7kq4jFgrQqzAyFS6MPxR41hkiI3jrsE8/VeVrJs
	 uOOTZsHJzRBlIwNMmYDNyXbi4/uJsq3TKwC2AiWcItqUnBWZMQF1uF7x6GlmB7wWqU
	 WkGVl3rfd5mstu6bqRKmYAEtrVubwR8mZNsRSTFFThxLqowYT9Tl8QZeKZZYREXkFA
	 WRHj4cX6/k6QQ==
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
Subject: [PATCH v3 2/4] perf: Use a union to clear branch entry bitfields
Date: Mon, 13 Apr 2026 11:57:21 -0700
Message-ID: <20260413185740.3286146-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413185740.3286146-1-puranjay@kernel.org>
References: <20260413185740.3286146-1-puranjay@kernel.org>
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
 include/linux/perf_event.h      |  9 +--------
 include/uapi/linux/perf_event.h | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 18 deletions(-)

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
-- 
2.52.0

