Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF12EB860;
	Wed, 18 Mar 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854255; cv=none; b=MLjKn2h43RTVsJeoemk/iPg88+YnJRLdTeTK+ZhF9LkB9srbNEq+KMiMEue4DV949AvAOoB0MRMoRyxSLFOC3SL5SXIVUZPjVbsv0yn+nbY2g7PYnUybDow8Khffa7mxddqIUjMKI+AI3Kgrd52/Iz0S6iIDw7KZw45UpjCPgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854255; c=relaxed/simple;
	bh=dm3G7/u4dkXgG56i0lULzKkyOM7j8bbEFH4ISzHFyUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYUEdvTPM0lSp9LSa8DK8qiI7DZHBf0/zx3Gsll0qogs4blm61oyGau/JWVBr1MI7+NnmWuOAAZESipP3bjDXF/xAHwcuxxXBiC01Q1Lb1e8wwLV73HtZDaNhRp3zc16B8WM8DM0hBPit14rSm6Deu2a05MQxOyJRWt0Z+YnOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBWFAH42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBWFAH42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D75C2BCAF;
	Wed, 18 Mar 2026 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854254;
	bh=dm3G7/u4dkXgG56i0lULzKkyOM7j8bbEFH4ISzHFyUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBWFAH42lPCuKmuEdfuRq1aSN36d87ndQsXolknWabBU/+uBts6zddmVGhOw5SXMA
	 vu9KRw/vuWN3g0LJKpDT+n7iTF9ugFmXCL+0X3pMtmy2ahZ2t2hKOlX0VEPmmDIek/
	 u9Y7GjMnvKAA2MmDuuu+WkatpDmJt5aiy1QTKFKFNCYDH0iK8UDPeLpFpfnJvmbBEh
	 Ruv9mzrxF9aXguTTVEggkIjd3EB9ahiJy+8vkanfJVsKd8LoTD6Mt1CklESSuDK1Yu
	 Nd8m9TdD/3aOi0Zrd7PCgxPXFgy7alvH5oGGSgV1qd8k1IMeEBU8zZTAtUVFQLWaVK
	 QZWwGOWepMXRQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 2/4] perf: Fix uninitialized bitfields in perf_clear_branch_entry_bitfields()
Date: Wed, 18 Mar 2026 10:16:56 -0700
Message-ID: <20260318171706.2840512-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318171706.2840512-1-puranjay@kernel.org>
References: <20260318171706.2840512-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_clear_branch_entry_bitfields() zeroes individual bitfields of struct
perf_branch_entry but misses the new_type (4 bits) and priv (3 bits)
fields. This means any code path that relies on this function to produce
a clean entry may expose stale or uninitialised data in these fields to
userspace.

The function was introduced by commit bfe4daf850f4 ("perf/core: Add
perf_clear_branch_entry_bitfields() helper") specifically to "centralize
the initialization to avoid missing a field in case more are added."
Unfortunately, the commits that later added new_type and priv to struct
perf_branch_entry only updated the UAPI header and did not update this
clearing function.

Zero new_type and priv alongside the other bitfields.

Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..d7f39b7e9cda 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1481,6 +1481,8 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->cycles	= 0;
 	br->type	= 0;
 	br->spec	= PERF_BR_SPEC_NA;
+	br->new_type	= 0;
+	br->priv	= 0;
 	br->reserved	= 0;
 }
 
-- 
2.52.0

