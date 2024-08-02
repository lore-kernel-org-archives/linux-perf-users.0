Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6AEEBA
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633339; cv=none; b=crTK7F2OEFibO67DtZiEMDPTfO5At6gnGLg2UdGeqV4fbrnPy3mwF0CS1QgQeUo2nG59/O/I22KQNSqQ19DYd6Az9sjqq4LQeOPxJnw9rpKaMilTfDtnGQfTu+etXw8QDzJS0D8JrnNB6l47bZDQkCnKGbzBN0/Ph92frWYvETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633339; c=relaxed/simple;
	bh=Bo8ad9NTGv/SDOUZUbd4RwyoimHlaVGRs6rx9n1iH3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K/DxR0B2i5MmjWDN41mVm+Rdd/hg6o9FhUKWYq59vbKwdbKlzZD50gBoUumnhKhPQ4q84i580LROwDKZSNbTHbb/3f/f0IB2V+gG1a+z15mPUpXUKHB3X7WtlLxhcRAtXw4fzKJ3KoKFQqAQ0MIqRJpVcPOSmF/M58WOKaTnGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLS6dr6k; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLS6dr6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722633338; x=1754169338;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bo8ad9NTGv/SDOUZUbd4RwyoimHlaVGRs6rx9n1iH3A=;
  b=TLS6dr6ke185EBSkO1WYsCPsJCu0cfLWFhEsI1tYfpw+/oJulXawwyNb
   uy83BZnqX20WQBTJIWC7eu2+OBkTsn6OTe+zE+TqNeyzAddnNtdiIpZZa
   rsWOwmBb9hlAiYPsw5E6EumOEi0RQZMR/u7LLzWXsL8aqKYCnoC3PU/4B
   C+wD1j/MjKAiDREXkeaMCySKnvvaGgGHlP9PY22d1eO15/gISH99ju+YE
   kZ0D8ztXG+JEazKdDNLxWGQ+f0MI4lNvrnSCXrkuhVk9cgLp8Nd6PgoO4
   Z5SdMNIw885+fIm4h3jvNjKQhsc2q9u9+MgUiQjtpC2iJ1zo2yqSzSyxi
   Q==;
X-CSE-ConnectionGUID: iuwwSQOQTqGfLFSIU/885A==
X-CSE-MsgGUID: esKTrs4KTK2jFy1mo9qKWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31246281"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="31246281"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:15:36 -0700
X-CSE-ConnectionGUID: 8D3zG4uZSW6t4IYQm0QBqA==
X-CSE-MsgGUID: qoVx8BdGRASJJ/lgg/yIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="56282263"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 14:15:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Subject: Minor improvements for brstackisn
Date: Fri,  2 Aug 2024 14:14:16 -0700
Message-ID: <20240802211530.776055-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One bug fix and one minor enhancement.

Note one of the patches will likely conflict with Kan's LBR events
patchkit, but the conflict should be easy to resolve (or I will rebase
if that one goes in first)

-Andi

