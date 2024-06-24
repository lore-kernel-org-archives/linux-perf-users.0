Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F41A0B0C;
	Mon, 24 Jun 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259896; cv=none; b=q2LQq4fspWxY47tgMUmuEMsbIhvtG9lF1umGaHpP3/25e0LiRAcvV57im/epa2ug612GzG+NWUhsDnWtwj2qnVKSQZ6cH7MQYjZmpNzcI3gP9k0LaO/zX9gGVuvtH5IcQEXmFQ4+lkdI4JIXZD2V1xi1/bqu+zHBjI9Thxc+VR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259896; c=relaxed/simple;
	bh=60o2mQRsYIshyDRjr/8WJK7Blsri2g7LodXDQrgcS10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4DjkX12LNmb/EEoQevjcbmrX5ZThlnVeIRP0IfB26Xs4uGtNGoDU49y5yU/NUKJzbEbTjttm01T3+ZORrI2XzManP5WBBwMsSqyqHWJWqr1NBe39HWv/VqqZN08NfOgu4xLh336vzgL8fEQ068lRyELMZ6v1ULGa467Op2B8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP+RcLvA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP+RcLvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259894; x=1750795894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60o2mQRsYIshyDRjr/8WJK7Blsri2g7LodXDQrgcS10=;
  b=BP+RcLvAXlTZ5OovWuvJqok5w2KQWde8wSIh2lBcAF24G6SzIjtbZqBi
   4wiD4qUd2k3W0msIWsALEDk9b05aCDh+SnCZT773OkMSB73AJ7CcDLtZO
   OOhGhyq8z6sVcPuzxmBuXIXJYKxIAfdXIS1YWTtFy6BcK5r1JF6WOAtZp
   26lH3QmS+6YVq8wHLolpNIhEFpj4UzB4+dCaaVRXFjvjQFwYkrdjVd4EU
   zHLBkQlP0n9c/48rhuHdQ0c7Rgf3+TNDln7Kx8i/ZFiyOeMj2SExSoOzp
   Jx8F0ZeRA5KL4TvAIWa2JoffwgRzZXwQqLnbfX3ePVUS+9eg9oONRYUQA
   Q==;
X-CSE-ConnectionGUID: 3UxpKvDUS2mL9oM4q8EYRA==
X-CSE-MsgGUID: 9mM28z0RQzGz+sTD+xlBkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16128044"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16128044"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:34 -0700
X-CSE-ConnectionGUID: EuWWSbQBRWyS96PsoqaYTA==
X-CSE-MsgGUID: WYvo6EEqQnCzcv1a/AWoRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387305"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:30 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Marco Cavenati <cavenati.marco@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/7] perf: Fix perf_aux_size() for greater-than 32-bit size
Date: Mon, 24 Jun 2024 23:10:58 +0300
Message-Id: <20240624201101.60186-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624201101.60186-1-adrian.hunter@intel.com>
References: <20240624201101.60186-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

perf_buffer->aux_nr_pages uses a 32-bit type, so a cast is needed to
calculate a 64-bit size.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c03..386d21c7edfa 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -128,7 +128,7 @@ static inline unsigned long perf_data_size(struct perf_buffer *rb)
 
 static inline unsigned long perf_aux_size(struct perf_buffer *rb)
 {
-	return rb->aux_nr_pages << PAGE_SHIFT;
+	return (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
 }
 
 #define __DEFINE_OUTPUT_COPY_BODY(advance_buf, memcpy_func, ...)	\
-- 
2.34.1

