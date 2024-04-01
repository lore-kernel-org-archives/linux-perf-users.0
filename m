Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A653E12
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Apr 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005778; cv=none; b=ZERpajRbnOd6yrdCGBBjczU2RYAsughP3gd3QaCPicF2f60EoAAoeJ/gg0M49SZPP9l6WU3b5wDf2PnQGxizKiUZ6azyeLDbludEZ8NgO8gkv15+x7FLxmEOw0PLF+o2GbkO7TfKJ9ukHUdgOr1VqHOZE4E16BP3w9hwjH+8+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005778; c=relaxed/simple;
	bh=sXqQoe0eyWTFdzDNJi2O1I/u73WUHqjUSZwixxfjY9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8ulPkrpL8Gcs3RiwBHl0jMsXYajogBFOo4+qxAfkbURK7ed7x/4AROAOTOYW7ps60x2uV1WsdwzrpDEWKwptsrJXJstigHxwcuMk5yDYZ/u77etT2wzQFlVLC3kwccshKI8lf51f/Yi9qiKrtbCSmK4u5PdlkTzMQXRHBviBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvfyYT65; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvfyYT65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712005776; x=1743541776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sXqQoe0eyWTFdzDNJi2O1I/u73WUHqjUSZwixxfjY9k=;
  b=ZvfyYT659rHp58GbkO7YXkPj9CNP9DxvnRnesJCH5jHqOlNjxAIqCn+8
   li7Z3NSbGUSZQDj1Mt3uaZH8ZZoVP262NEuBcKxRiO3YrHSAN/j8IteKs
   ubh0A1bbB0tV67H8dFabCt5lTb+1qdmgZBkR5OTGecZGf+JRquCVXUrKa
   uZ179egHsUxFCNiyBFT55Un2PDBEh+33xVv5eKuyzzMmucM3oIHMKDnBK
   ItUrjJrqcbmqmjLJKMQueDYXqjgunQjxhqU8z7GEuiifoaAlRAMoU3QXG
   zDdkQXEMpnl3QByoar9r3a4xk+//y7UQeRfTkpJt/GQ1dvNDQP26rnhtK
   A==;
X-CSE-ConnectionGUID: CrQGyp5QRhu+CKrLw5Y8YA==
X-CSE-MsgGUID: 8kMJ5WCuTOKliQUtkTxSaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7015548"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7015548"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="55283624"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:09:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com
Subject: Updated capstone fixes
Date: Mon,  1 Apr 2024 14:08:02 -0700
Message-ID: <20240401210925.209671-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add -F +brstackdisasm and support 32bit x86 code in capstone
v6 adds Adrian's cleanup patch and rebases. Other than that no changes.

-Andi

