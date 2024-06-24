Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5B1A01DE;
	Mon, 24 Jun 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259887; cv=none; b=AMbAg94vdVivzRZHncspRZNUZFgBbGG+Jr7C8A4tvN4UeldUkxTKpgajCvDLylMzjN04NMK7Hbl5qQ2AXl7iKb7S78OE2VWph52iFQyIZy30QE5bR00RxIcDkUkx8TAl66YBBNqI7sfKyYSsgg5qnnTIyFrdlEAqi9lbdZFhPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259887; c=relaxed/simple;
	bh=SvApPi+TU6egetuAyMNIlHsB1l52Upy0c6kLUo2bAtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+CEzm+oppVZr7rCalgo4VI7OZa7YZ3XgBTXOz+BNTe7YzGOqlWHia+tQNZNSlO9kpF/C9/dxQMgYM5sdgfLvvTbtPTEV65qhYHlC8c2gNesaZ4sqqqNTeStCaxlZHC9M8VCJPsuKJjZVqAqv8AR5jMQemEYKRdT7bXbSnBXF7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrZgZ7X2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrZgZ7X2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719259885; x=1750795885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvApPi+TU6egetuAyMNIlHsB1l52Upy0c6kLUo2bAtk=;
  b=mrZgZ7X2eZxWr+gyY/F6pD0V3UKxOh6gQLtZwdVbwPQbEsE+Rx7bkAnr
   sJ6KujB8/OKw0hcqk+hgG2dY7C8u21wpWY0bMei2G3s6sgnSM6bcUHp/f
   PzcC07a88Dx5Jk6e8Td4VDLu/PN2I+58bxKeb9bH0aGQR9J+jFA/dX7wC
   xQi6ePicCn+LZoZIXcFr80ZE0g7UfoGHcWdDHvjxaOs1/BeNV6mHYS/uy
   aCwVowhLYZQD3YCqLjw64iFvJ/OtG2MMvxJ+j/sX+GWIXFMXv5eUdV2Qd
   m/tvdakSSjXHfNf66QgETGMx53T1RWJyqMRdYaLSjkdVdKoblAyrB/n6Q
   g==;
X-CSE-ConnectionGUID: sVc+pJENTxuGUFyROxrufQ==
X-CSE-MsgGUID: hns1J9IcTbilQaUy8yW1XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16128011"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16128011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:25 -0700
X-CSE-ConnectionGUID: iacqyNW2QJGsWsohk+9qNg==
X-CSE-MsgGUID: xWZBTU3CQhSindQVCCqDzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43387286"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:11:21 -0700
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
Subject: [PATCH 2/7] perf/x86/intel/pt: Fix a topa_entry base address calculation
Date: Mon, 24 Jun 2024 23:10:56 +0300
Message-Id: <20240624201101.60186-3-adrian.hunter@intel.com>
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

topa_entry->base is a bit-field. Bit-fields are not promoted to a 64-bit
type, even if the underlying type is 64-bit, and so, if necessary, must
be cast to a larger type when calculations are done.

Fix a topa_entry->base address calculation by adding a cast.

Without the cast, the address was limited to 36-bits i.e. 64GiB.

The address calculation is used on systems that do not support Multiple
Entry ToPA (only Broadwell), and affects physical addresses on or above
64GiB. Instead of writing to the correct address, the address comprising
the first 36 bits would be written to.

Intel PT snapshot and sampling modes are not affected.

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 14db6d9d318b..047a2cd5b3fe 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -878,7 +878,7 @@ static void pt_update_head(struct pt *pt)
  */
 static void *pt_buffer_region(struct pt_buffer *buf)
 {
-	return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
+	return phys_to_virt((phys_addr_t)TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
 }
 
 /**
-- 
2.34.1

