Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25A347C3;
	Mon, 13 Oct 2025 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340184; cv=none; b=Oc3Cj31eNeQ+rJcAw51nTDHi0c/PhE+H1Y0y9gba+KHm2sqBBfVLwpLqkzROZPkcU5dlLbATYKd94Vs1oyobgpcD8XkZnMsb+eVnbZZjjeHwzBGzx/5MeU01ff+Wx3W00jK+ZBAFh4DZYhrMfMPHuKRwyE4c6OIen9W8GRiHML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340184; c=relaxed/simple;
	bh=9zPf5jL7xmZ67FUpEk8TkOzrdoR4idKVHK+kNa92STc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TW9IWFhiFBFqkF7slPAgbFjqrRvf5AKs4H+znA3ebVSR8tIjDIFxToW3lvNE/HakYpC7eezJSKlgWNlusAZKQRiHOJJaTD9XvhLgg93DJ/rFhUozPR5NqyknQJvyxi8BrhxICGDb+t6GPFi4PI9Y5y7FRBr37uA8AxSneEwaujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJMKZ51W; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJMKZ51W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760340183; x=1791876183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zPf5jL7xmZ67FUpEk8TkOzrdoR4idKVHK+kNa92STc=;
  b=NJMKZ51Wh91ECa6GUlNOGQvZcCc+mejhNw1yyYhylaJWSudpQIQ16uml
   4d0xkxLMcM9k4Xb5F/sNEMVbBv56m1/YYWnIw3eoEfUqQRIGsp6y0u5nD
   TzN52mTyNRea3JA2DxY6H34/rkZSATGrfffgqe+8Jdj/OLuweIui2dy1J
   4wiFnrknpvqvRlGDwd9cpasnEa1B+JTeHXHMmnSFtJN/0J2QffI1RH9YI
   3cHChv9CrAC+2Xj4hCNwi8U7FR8iuS+4WEhQqR0gHS/mbmsR9z4MdmwAn
   MpE5NtLbCtj97qLRpvYqNAjq30jRN9n5AjCmScdn/BDtsyoOB3DMQTBtY
   w==;
X-CSE-ConnectionGUID: YCIH0Ji9T++IjT57YPqesQ==
X-CSE-MsgGUID: /cbLEcyeQU2yyKlMkN+q8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="61510031"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="61510031"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:23:02 -0700
X-CSE-ConnectionGUID: hXSjsuGuR4iflDPvSpNIGg==
X-CSE-MsgGUID: QGFSt/1dT/ylSwy5Z2UjAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="185790413"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.25])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 00:22:58 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Edd Barrett <edd@theunixzoo.co.uk>,
	Laurence Tratt <laurie@tratt.net>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH RESEND 0/3] perf/core: Fix address filter match with backing files
Date: Mon, 13 Oct 2025 10:22:41 +0300
Message-ID: <20251013072244.82591-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here are 3 small fixes stemming from a report that Intel PT address filters
did not work in Docker containers:

  https://lore.kernel.org/linux-perf-users/aBCwoq7w8ohBRQCh@fremen.lan


Adrian Hunter (3):
      perf/core: Fix address filter match with backing files
      perf/core: Fix MMAP event path names with backing files
      perf/core: Fix MMAP2 event device with backing files

 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


Regards
Adrian
