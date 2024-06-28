Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C556448
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602415; cv=none; b=Jl5KJxAPMSkohyvHeNXSjbwMy+PVEV1eXDKHRwvIx3jVGoo7t8mTWrTk9qQdbw9g5/sENrsWzRiGPYt289wWIM5nmav+l2zyLnfMUxBF5cKRYcYrDudhpyXfuctxq0kANIi5lfcOjdtayVqyCpH5ra+zsO9/s0stpVFhI3tshU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602415; c=relaxed/simple;
	bh=7Ew+cqc+0DdaV0ZwQ+yWHVG9PQ1I4biV+LJtRf0MDOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo3c3kGe875sFc+ohDycy/bj9eQbpMxGXidRaYQZgIfhaavt3roLhPL4ajJj3xtCBnz+/dASUMLAzSE7D2S5FNTPxJ39KUmxFvo8edLcrQ3F53Fl/h/1kiHIpo2kcFDf9rYqFg8y5w1mq+e6dbkPYwnqXkSr02RFWVPjP/B/AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNed2nxA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNed2nxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719602414; x=1751138414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Ew+cqc+0DdaV0ZwQ+yWHVG9PQ1I4biV+LJtRf0MDOQ=;
  b=PNed2nxATyHqU2MS0dM9XqLLQBCdxJ8u9PkKlsd+JRd/b82tbHvphcrX
   Lu3bQ7RKIShQHd6JzAz27XZ0Yu2c2SwXqhze+1P9NzedcBSMQL2nuk0IQ
   IdD2lN4Xpgir/Gh8g3hrd2b3Tdaryib7ngn+RB4z9bqIRCUJIUnhtnGd2
   ngFta6RMuvFSc35G5AokZKbJ9ipYFf8ARFRJSW4WEKaHnGW+GPgN6AmRS
   gMSTuGtnPTlZb9px0mHsu9hKtENcjcHacNn9btHDBxwIXNI9EcL8a+X4G
   QscsJ0XnZHqwUAGmiITOdr4RL/7s5xQ2la26qGZD1p6E8Ni1OKJ0lUDgm
   g==;
X-CSE-ConnectionGUID: DVjtvDJxSpOsGVG3meECpQ==
X-CSE-MsgGUID: JHa396dATj+Av2cCSNVYtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16633367"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16633367"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 12:20:06 -0700
X-CSE-ConnectionGUID: r9aKir+SQ+Wyr3deEaGR9Q==
X-CSE-MsgGUID: B7kZz81ERvSFu79jAi9Xuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49795321"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 12:20:04 -0700
Date: Fri, 28 Jun 2024 12:19:59 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Fix perf script -F +metric
Message-ID: <Zn8M39dHtqYpRa0o@tassilo>
References: <20240625004232.1852705-1-ak@linux.intel.com>
 <20240626090924.GA56952@alecto.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626090924.GA56952@alecto.usersys.redhat.com>

> This works, however there seems to be yet another issue on
> perf-tools-next branch that breaks script metrics.
> 
> 617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
> events over legacy, 2024-04-15) changes event priority so on
> my host "instructions" have type PERF_TYPE_RAW instead of
> PERF_TYPE_HARDWARE.

FWIW I don't see this on my build on Intel, even with that commit.

> This results in evsel__stat_type no longer recognizing these as
> STAT_INSTRUCTIONS.

I guess we could just fix evsel__stat_type to handle that case

Does this patch work?

perf: Workaround event priority problems
    
When instructions is not of HARDWARE types anymore, but raw,
which breaks the shadow stat metrics detection for IPC.
    
Reported-by: Artem Savkov <asavkov@redhat.com>
Fixes: 617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..87a503e47ff0 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -97,9 +97,11 @@ static enum stat_type evsel__stat_type(const struct evsel *evsel)
 
 	if (evsel__is_clock(evsel))
 		return STAT_NSECS;
-	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
+	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES) ||
+			!strcmp(evsel__name((struct evsel *)evsel), "cycles"))
 		return STAT_CYCLES;
-	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
+	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS) ||
+			!strcmp(evsel__name((struct evsel *)evsel), "instructions"))
 		return STAT_INSTRUCTIONS;
 	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		return STAT_STALLED_CYCLES_FRONT;
