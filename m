Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007B440A1D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655479; cv=none; b=YeTzMut0tuqGmJQYBsV27eTX4/XCQ33NxurYMrAFWEvu2omg4fJ82jn2Jym49N5k9gqiC4qrMAwdSINaYQwDULp8OAyEVA2Y8yHvo0/F1Ez54f6VRrPf8l89ToBqglu1VgGJs9kPGVw5QBUPn6232XYKJnvFvWJNWWEriXidWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655479; c=relaxed/simple;
	bh=zOZwppOLODBgBn5TRXcOd1i7/Tv3CuDAFiaZxCbQCE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBAFxU6IHYR8k5/Z7B7h9Oe4O/+LgEb5DrHQOkBDEz87p9M4gmM6DS2ia96xy64zTWo/nRT9ETdXDbDY/0Ay5wyJHqd2I7eMpjAK3uWljli4sa4XMKIUo5PcGLRMluzCzMpRw4UonrlUvSYQ7IkRXJwndyMBbQBdy3OPLLxYGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcOI4LRc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcOI4LRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786655477; x=1818191477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zOZwppOLODBgBn5TRXcOd1i7/Tv3CuDAFiaZxCbQCE8=;
  b=mcOI4LRcKpwE+zRjENiDKFqwONhtoa8PNXZ2lcZus49IDMa3KB+kZwGg
   wm0f1Usa6c0sBDehoCveLEt+h9yziKg5xhRQDfNctH5z5dTN/EZhtcKmx
   DzslA+gXy2hZekjhcqQ5UnaZ6ss9HBitP8k6pXFXBFH861yk1WxkVWzBZ
   RM6PmK6vvJTLt8ehC+q6a2fZztNCWsqewU9NPJpz0/2Vv7pTDsKmRfnUQ
   o9weYJZD+Fukq3QMGHTapMVyoujsaOtXTZVXakCDeGMDeQilQK3Fz677r
   qVOsRmqwgAi+FRDiqepM+frrozVYzT/ugJUh0gChE6rhjy54uS2VCgIYs
   Q==;
X-CSE-ConnectionGUID: 3D53ZtCvTOujo6UHljswDg==
X-CSE-MsgGUID: e1COcY2eQqGLATi3q7AWaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89760241"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89760241"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:17 -0700
X-CSE-ConnectionGUID: MWRCoO4/R764RdI7YHYfyg==
X-CSE-MsgGUID: WrTc/uuzRKOF5NI+++am0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260773086"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:11:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Updated patchkit to show weights in annotation
Date: Thu, 13 Aug 2026 14:10:06 -0700
Message-ID: <20260813211109.240689-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko actually found some real bugs in its v1 review, this version
has them all fixed.

