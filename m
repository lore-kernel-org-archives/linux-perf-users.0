Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542625771
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657312; cv=none; b=VfaMLL1S1klRO9lsgXxiu0o/5EAQ2tFiTMjculH6CTrMWRNmPVnpiXbBdOvbN3uhChKHQ8ARCAzwR8AIJtQKc0ZDc65bygRJ3aqCzDlwj86Q7IEtCxjA+PVS5hcnu/5kXXWHZaJH7zbTIxIX7jT5cilPHH9Ec4SpLo0YtFYW+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657312; c=relaxed/simple;
	bh=5FOiFSoRjIG66sJDeoIwAe7VOsGaiB1dIXDliP9CuHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdRU9YPKS/y3MZNjQb8YcL1X7DK5o/kbFxJzw6WtlUkthAqSvH+PmhE807Z7LJ7sLKq3Tr/Xk+96/RcKDXA785jtkfjdTeTSMZ76EJOCjpjYeWGwE7yt2Otbu16oICEAVoq7C0neqXVD5RWfJP3GzlbvwTHf+1dRliSMHvkWvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpdzCCS2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpdzCCS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786657310; x=1818193310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5FOiFSoRjIG66sJDeoIwAe7VOsGaiB1dIXDliP9CuHc=;
  b=QpdzCCS2NpS7H4Bwy2EVZDuzk5RmRuCCB2ORzutiVsI5BETT6+Ib9Urn
   43JnxMzO6u3SAexIpf2WWSOWuV8O8mHAH7684y53xDG32S4eZDHBwoF+i
   dgq+cFdmIC5x1R8fWHumIM5nfR0U+H9ij4NhaIA2uq46g1ihW7vfGWmw0
   v7qzfUi60IK3lBzMex5teNq9+K3rA0jSAHnkG0egxlegA3MDLi/GxtFek
   hWXd7Y8tubeiIGq6Fe7zUiV+ahUAtFguMI2sewKV0IYQeE9sD2fLJGbYB
   9ZG8kO/ov/hW6DsYRiJlE0C+oj1d8AphmYy+jyxIrkmYJXk6oN8TPoP3Z
   Q==;
X-CSE-ConnectionGUID: IK5ekk0DTDW8DDaQjF3hQw==
X-CSE-MsgGUID: mYm6HdcaTbesigaeq8KaPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89761869"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89761869"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:49 -0700
X-CSE-ConnectionGUID: EpgzvgiQSm+DKm/TjUmv+g==
X-CSE-MsgGUID: 13QRFpTMSNieyJI5bcb7Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267909908"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Another perf annotate weight patchkit
Date: Thu, 13 Aug 2026 14:40:55 -0700
Message-ID: <20260813214143.253418-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v2 version had some bogus white space changes included. Now cleaned
up. This version is ready for review. Sorry for the quick repost.

