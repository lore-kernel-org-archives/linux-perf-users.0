Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3B19DF74
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549074; cv=none; b=Vcsz4/fKkIZCsTSf6Xl+bif7ONfZU/CRKanWTHdzc19EkpMDX2y4IMGJnN5nu4dQ3OyiUSHVWK3KwhDi5wabbpMA+ux6sEPJavLPAVkAuN0I4qWUMjctbZ/eK3fCYo3li1k5yZwX9M5pp//DTUcj20QtkfH4LYPKW9SAkDtaOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549074; c=relaxed/simple;
	bh=P6LIOlLcorXFL6kjZ/gtv4m/ERDX7C1fKxQW+shzASo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZuTROhGHSeLHWtNUDjZlUqFM5U4vsuSPYT1h7V/btwuvV/zrq44LX+2Wct7ov8k3fMLaFiEAZt1QyIke8g67RO/9JKf52xZeDRMsAa5qAQhRB5cF+edaUW8EZ4gIr4MPbJmb2urB8Zc7GDnsMnZxIIQK5poAd9n/GSHTdEAYj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv0Ya3U2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv0Ya3U2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549072; x=1757085072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P6LIOlLcorXFL6kjZ/gtv4m/ERDX7C1fKxQW+shzASo=;
  b=Dv0Ya3U2DSEB2Yw4D2oD5uw77vg7UrnMg20UyQege1yWpHFyfXEt4fce
   ptfPTW+Eg0BnXwHlOcAnGXCz4FIARS/F3DZcd4OC5Lu1qEI3CL4M89+Ea
   neHa3jVI9WhtAIctRAYqzMpr2JVnv3kWe1SQED4BrRc+/Fm00hF9LfgxV
   fb1CYnX2FFJ9udjNx2o24x1XQs2AH2bvRKVQwsfjPamNEuJr7az9E2dwC
   jRvnCaitkG7aLLKUBd3mk03f6n2uXfEJlPAbkbwiIU8oOCuncRw2bPO6G
   lfidhq2yHFhRjw7H7xe21UuEwsuCwhdu95Xorbhwxbelt5aYPVEs4UcC+
   Q==;
X-CSE-ConnectionGUID: R2C/K20MT/Wg1ksu4VyeSg==
X-CSE-MsgGUID: 0EXOlEgAQmOJO6GIKWhj/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688969"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: tMoLhMF8Syys+rp9qgxkYw==
X-CSE-MsgGUID: jffebEVGRCC1vCldNqK/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456093"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org
Subject: [RESEND] More dwarf support in python interface
Date: Thu,  5 Sep 2024 08:07:54 -0700
Message-ID: <20240905151058.2127122-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[resend because I typoed the mailing list address in the first try.
Apologies if you see it twice]

This patch kit adds better support for resolving DWARF from
perf script python scripts:

- Add new perf_brstack_srcline / perf_ip_srcline functions
to resolve full brstacks or individual IPs.
- Support the DWARF discriminator in addition to the line number
- Report the inline stack to python
- Report the build-id and executable name.

Most of the patch is just plumbing to pass all this information
around.

The first patch is a bug fix and can be applied independently.

-andi

