Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6F206F2D;
	Tue, 18 Mar 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337667; cv=none; b=Nl5DO4DX3fS6vAxL3Zo2bGThRf8kBXjPhpccHj0WZhonIYPOWcSLtMt8PAE4fHKUEKBljPRNrv8BVFkTZQDRcoWp7IsLR3I5paam6xnCX4D1Exml/3C/0f4v98ghjByd7Jyc9MXt7FZm5R+wZmJV/nCfMYEJ0Ac6iwu98Oke780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337667; c=relaxed/simple;
	bh=d/MVCWYqnnkB4DfBcH7JMvDeakPvoJrlYXYuB6YqTEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9grn8oD/W9H0AHac2vzPODKZtI5EU0KIYOcbgIy4BBm7z9q3acM68YTvpKkwbOIsYMuQsK9BQHv1SsCJWv8VlgQ2/f2Uo5077lNOfAjoU9d9UfD/a3+quQHgUbF9edzaVQRThA8OR5jLSBRQLAtT5bRU41VJQWuPsgylmp5JXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDqWr8gJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDqWr8gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742337663; x=1773873663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/MVCWYqnnkB4DfBcH7JMvDeakPvoJrlYXYuB6YqTEo=;
  b=oDqWr8gJE9qzZw2PK9riFVgIx1Z7ZBXsgGgptZp+glsMOoHRwnOfxuf0
   Rtr7C7VkyR6FnpJIaNoZacMWu1v9aH498+ziVeY0xI8+wJRAaB/mOggj3
   tC/TKkz9rezn3MnJ6JXvwGsALhfQCCnFaoaAoTTjfIKgFJ0BXiQmq5on0
   oqM4ljVYhQuHGDKvVwotAzosaEnkN3frwmSs4/p4N5wTWdi/hXoDeBUVg
   BKhDXhlj3ytM6KVwZeFLt3/dCD30EMcpm90Z9JuyIOKBhVydp7qSCv9uN
   E+X/2uUMiG5yNJfAAM2R3ct9hSwWD4CuShS14/gLkRqzzbmmV0UwKsvds
   g==;
X-CSE-ConnectionGUID: lYbxKGu3QKa5ILUxOPSVKQ==
X-CSE-MsgGUID: TKK+ZnPcT0SK6ZHm420/ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68860966"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="68860966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:41:01 -0700
X-CSE-ConnectionGUID: yXZAsPdmTeORyHlo8inRFA==
X-CSE-MsgGUID: 6xjyh/wET+2HQA+cX6082g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127069861"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 18 Mar 2025 15:41:00 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] perf/x86/p4: Replace Pentium 4 model checks with VFM ones
Date: Tue, 18 Mar 2025 22:38:28 +0000
Message-ID: <20250318223828.2945651-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318223828.2945651-1-sohil.mehta@intel.com>
References: <20250318223828.2945651-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a name for an old Pentium 4 model and replace the x86_model
checks with VFM ones. This gets rid of one of the last remaining
Intel-specific x86_model checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
v4: Pickup the Reviewed-by tag from Kan Liang.
v3: No change.
v2: No change.
---
 arch/x86/events/intel/p4.c          | 7 ++++---
 arch/x86/include/asm/intel-family.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 844bc4fc4724..fb726c6fc6e7 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -10,6 +10,7 @@
 #include <linux/perf_event.h>
 
 #include <asm/perf_event_p4.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hardirq.h>
 #include <asm/apic.h>
 
@@ -732,9 +733,9 @@ static bool p4_event_match_cpu_model(unsigned int event_idx)
 {
 	/* INSTR_COMPLETED event only exist for model 3, 4, 6 (Prescott) */
 	if (event_idx == P4_EVENT_INSTR_COMPLETED) {
-		if (boot_cpu_data.x86_model != 3 &&
-			boot_cpu_data.x86_model != 4 &&
-			boot_cpu_data.x86_model != 6)
+		if (boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT &&
+		    boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT_2M &&
+		    boot_cpu_data.x86_vfm != INTEL_P4_CEDARMILL)
 			return false;
 	}
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6cd08da64684..3a97a7eefb51 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -193,6 +193,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
 #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
-- 
2.43.0

