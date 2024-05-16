Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EA3219F;
	Thu, 16 May 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895867; cv=none; b=bP9R3NZwUv9NpI8Yb8c9bKqgnc1XHtY4bJ3MftzNpSJguC+KX3VOmqbi9xNEPXzo3qC4HpwhoGYUIWr7u7i0vibY/jdhkvTUtYzeBH90T02tafZtIMyLLsAut1D9FFk5wln55PjEM6R86bwtG3YjT5REF4OQL11kvZm0xIKUe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895867; c=relaxed/simple;
	bh=DunYNQ3uCp9VGArF9QXWHvnL04RMfkZhAcgrfvD6Pas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzDfg0qshjHs6TysXz/TB6xevPhjmc/8d4q9UFf/TnyGoOW9v+aTtMNVjBw816O8+ANWy6mCu38QCw9IPrHqjYK0c3Y1EaS0X4DKDVumyLcSjXY/wFpQ5V/OAVzd6bqnyZ5h2t9DMRjhqthV7DqQx2dyGi4mqP5iMfevIQ6hQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL9qpey7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL9qpey7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b097b202so302338366b.0;
        Thu, 16 May 2024 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715895864; x=1716500664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vVuaWcV/VJCXyOs1sAVhMBKMj/zAAIhBRyu2C5mMPE=;
        b=nL9qpey7rHlZ9H9kZUQ6vXOdTl2I3zBU+GBjTFWJ5i1Em8gNyWDsQIin+LWQ6QWmm1
         wW111QVP/uLJWqreOATt/pq7PiGRZFUi1EVc58oAUwupJ6F9Je1przTipzBmeeDSd14/
         ohlt+CAus9qYgIuTb36fEqc+mro0SlbuiNPeInCKJevLUsfR1a3q1APZwvsLSW+Bsnid
         9FLbUN4RjBK2+q2WD7qM7quPlpjpHKqmNlLTjvZcAT3WtbfWAjcxUWfOt2ROLeCZpipX
         B8ybi5CaaiGLWwRwG2iaUxztqnU+TH1RIoZhFIlkKccu1X6iRFHi3842mZD1rHoUT0Qn
         Vz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715895864; x=1716500664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vVuaWcV/VJCXyOs1sAVhMBKMj/zAAIhBRyu2C5mMPE=;
        b=I0x9lEKv/RqghM74crasbsZk7VHQswuTlH9dp+stoRAWcB9wpWmU8g6pQT7pO+HfFC
         Wqb+Fj2N9/lynSt8M+NDbGGvYutqqt8dA26y8rq4v/nlqevDD43nLeQ2MVZ97o0I83P8
         CUQ1/meAnAco1hZRePnBn9ZHWFbtKml4PcxRyzQLbbcs8lTBRnn1xBAAu2JH5EWDNu9W
         sS3rmEk6k0C6zG0IhqRYOFEyr81maMARk3wNK8D6w1/oZ81kg+OcPqmqamw9S9MeyRkJ
         fNBttQ1HwP7dzpeijXL0QwQHdnsgUqvdULlRN9T8vOKp4Pbf3FnOztkLXRX5Dbn5g2mT
         mQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCXJmvzqNBgnrbxiYXsFMspI1MfzhClO6QMeSk+VkDs/c1SJ5Oy3HMaLkmgT44nRWUJJZJnJ4fYmLw2w2bXh9pTlFQz9wHt3Est0ZmLpozLkIAuq7h0Yg6EceWEs1GX0aZ6BFE8Wm1sb1lZvFfhQxg==
X-Gm-Message-State: AOJu0YxrIVfElNixG+TEiqPh0Q7SbD7gSzqMdMlQHLh5sVmdIn4FPHck
	5MGGmImH3WmzLGYhCJUf/6+NuwPs7HCDSR/Rf/D/Ai+/So6FSSBpnjyw7vBdanw=
X-Google-Smtp-Source: AGHT+IG8W0Glz3a4MDh/hzyT7d0yWL+cDX4f6H26o5FhLnYKPGhdhMPl8+3THNcDp5z4bEdyuB7f6Q==
X-Received: by 2002:a17:906:34c7:b0:a5a:4683:e961 with SMTP id a640c23a62f3a-a5a4683eaf3mr1047825566b.52.1715895863923;
        Thu, 16 May 2024 14:44:23 -0700 (PDT)
Received: from localhost.localdomain ([93.51.30.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d2bsm1016688566b.120.2024.05.16.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 14:44:23 -0700 (PDT)
From: Marco Cavenati <cavenati.marco@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org
Cc: vincenzo.mezzela@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Cavenati <cavenati.marco@gmail.com>
Subject: [PATCH] perf/x86/intel/pt: Fix outdated and add docs
Date: Thu, 16 May 2024 23:42:36 +0200
Message-Id: <20240516214235.14770-1-cavenati.marco@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds docs for the TOPA_SHIFT constatnt and for the sizes
function, removes two outdated parameters from the documentation of the
struct pt_buffer and renames the constant PT_FILTERS_NUM to
PT_FILTERS_MAX_NUM making clearer that the number of filters can be lower
since it depends on the CPU as specified in Intel's SDM.

Signed-off-by: Marco Cavenati <cavenati.marco@gmail.com>
---
 arch/x86/events/intel/pt.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..fd5d9095997b 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -17,8 +17,18 @@
  */
 #define TOPA_PMI_MARGIN 512
 
+/*
+ * Shift for 4K-aligned values
+ */
 #define TOPA_SHIFT 12
 
+/**
+ * sizes() - compute output buffer size in bytes from ToPA entry encoded size
+ *
+ * @tsz:	encoded ToPA entry size
+ *
+ * Return:	size in bytes
+ */
 static inline unsigned int sizes(unsigned int tsz)
 {
 	return 1 << (tsz + TOPA_SHIFT);
@@ -61,7 +71,6 @@ struct pt_pmu {
  * @cur_idx:	current output region's index within @cur table
  * @output_off:	offset within the current output region
  * @data_size:	running total of the amount of data in this buffer
- * @lost:	if data was lost/truncated
  * @head:	logical write offset inside the buffer
  * @snapshot:	if this is for a snapshot/overwrite counter
  * @single:	use Single Range Output instead of ToPA
@@ -70,7 +79,6 @@ struct pt_pmu {
  * @stop_te:	STOP topa entry pointer
  * @intr_te:	INT topa entry pointer
  * @data_pages:	array of pages from perf
- * @topa_index:	table of topa entries indexed by page offset
  */
 struct pt_buffer {
 	struct list_head	tables;
@@ -87,7 +95,7 @@ struct pt_buffer {
 	void			**data_pages;
 };
 
-#define PT_FILTERS_NUM	4
+#define PT_FILTERS_MAX_NUM	4
 
 /**
  * struct pt_filter - IP range filter configuration
@@ -107,7 +115,7 @@ struct pt_filter {
  * @nr_filters:	number of defined filters in the @filter array
  */
 struct pt_filters {
-	struct pt_filter	filter[PT_FILTERS_NUM];
+	struct pt_filter	filter[PT_FILTERS_MAX_NUM];
 	unsigned int		nr_filters;
 };
 
-- 
2.39.2

