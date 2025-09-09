Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F933471A;
	Tue,  9 Sep 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421757; cv=none; b=CW/zqTKAhsL9MfcHmrMbs3cmIRWdBCuG/BsQrgHDShAF2NfGXcLI+DaQdaoXete+kQVWc1ckpQikZ7G7Idv0XzZKi373MQwkXIq7Khgqgxeq6j5g69U5Pexjy9SoBRtR68oDY5I1soeDq9tadIVlyXA8ILcVbDRGFv9mqBF+Atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421757; c=relaxed/simple;
	bh=9zPf5jL7xmZ67FUpEk8TkOzrdoR4idKVHK+kNa92STc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XizJ9awDbxXXstQVUeXHHhlC9EE1RdZ5RMCnmfIZJh9dbF1Koa4u86vnXCfMmimF/lE37FTvneaXIlwrZ7b8fopqZtCDUVr4hXC//50mJ1yQpkzOh1QfsW06BsSbKvfwbicTuVfS6SiJRcr89yhVvd99ilKznDgAEcLIvhAeYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzJ6XM8X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzJ6XM8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757421756; x=1788957756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zPf5jL7xmZ67FUpEk8TkOzrdoR4idKVHK+kNa92STc=;
  b=fzJ6XM8X4Fp+9P1tRrcTtT3n+MxAoSx7OD2kJRgk77LYDNF2t/6c1Zbe
   NOCk+qn5jjdSq+lPENLrm1GysF7isPmQbqcBnQpU7h+Rjc5owzlrKMdmZ
   sXcvxuG24mSbn5MObB5BoXimCze73Ui954oBjkNeI3cwsMsiOgCNnPCK+
   SgLBcRHohB8X9Xomu1l1V3a9zLkM1vMQhiKQeG5nKahUKV/TpfX5vWfXa
   JHEzVbv7V/UWUTEWvvffTPectvaA9oW0lStZaQQY/zH+K0R3EtBguKfkI
   Jek4YnWKz8miuIWHwVILQt76bQQ2vkwyI8eF5IP2nvU+IdIsagSfQ+huT
   A==;
X-CSE-ConnectionGUID: Fo+9NhfRS6KlbbWyRT1jPw==
X-CSE-MsgGUID: 7T8Jw91LQSiRI8mZgCz2aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70399526"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="70399526"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:35 -0700
X-CSE-ConnectionGUID: 2JeZ+tDQRHCHo0k+18CNwg==
X-CSE-MsgGUID: gVZOWNMWSfaN7JIfJjTJZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172667391"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.84])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 05:42:31 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf/core: Fix address filter match with backing files
Date: Tue,  9 Sep 2025 15:42:19 +0300
Message-ID: <20250909124222.222945-1-adrian.hunter@intel.com>
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
