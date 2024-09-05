Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261561A0BC4
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549081; cv=none; b=KmJlUOjS0hX3+iZ/J65N0aP4zNzByBJXTqZ/9CyAhZvlAifpG7qSI/NAwmjmqc/rQNqURNvZFnBr2/AvsoQCJbMIkoigMC/C/UVbUa266Xg++yf+m2N2v+N1zHDsNFlSHu+xws4REpAE3UoP/RyFQ6rM12h5WwfcDQYWT+fjfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549081; c=relaxed/simple;
	bh=Z5MDpqWHLaZpyUX78QlYSYAt8gsc/3n0ogrIqC6jtoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh1S8vQi1s3JjGM5WFqDCsgqrXNB4BSLj2fuxTvgp8ZQQtdjsdmGfThwZ6VqDwfXs6LwI4EEVQ6aKtP/eoc00mQuYHP5QXDEtFBsxiHoAOwY4xWeAhifGbV+soGW16dhFjNUuLRmYMILXP3rrMc+Pcbi3Ec0HEr0QJ9UIlZuLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWirPHDK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWirPHDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725549080; x=1757085080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5MDpqWHLaZpyUX78QlYSYAt8gsc/3n0ogrIqC6jtoU=;
  b=CWirPHDK58ptNOhzTb0eHZRs9S9jExMgpH+ggkQmwg7thn9Zs2/TCwrD
   LrvsOGoZTJacV1ma81AIRSx9yJnb4kuQ40EUG+op/to3d4y9TNP8/S7bP
   zcT3D1WJT4yExdUURSBY7beTF5jHf7uliCXOcySmSTlmcClyd4za5BETv
   /TEQLU9IuQ/MAy07FbzjuNwCsCsXVaYk1yzFH8VXz07qUpAwfT94NSRJT
   UkMik0xWZg5I8L0UXp1byN3aT4kkeiN/VQWh2cnQCOPbKdbEZYgO5Q3te
   uE40QsaC77hfnu+1QJljqACVaXD4iVwi17OZBO7U+mJ1KzlzLJuOyqXt/
   Q==;
X-CSE-ConnectionGUID: 6pfy/4F0Rp2CDI7bNGRWUw==
X-CSE-MsgGUID: 4zXHLnknQge6bLf1FxvPBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="49688990"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="49688990"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
X-CSE-ConnectionGUID: 3MQaTtLgSD2ttvtOpuV5Vw==
X-CSE-MsgGUID: jWK/rsxJQOi27wiOeCMRBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70456123"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:11:12 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	namhyung@kernel.org,
	acme@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 10/10] perf: Update documentation for new python callbacks
Date: Thu,  5 Sep 2024 08:08:04 -0700
Message-ID: <20240905151058.2127122-11-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905151058.2127122-1-ak@linux.intel.com>
References: <20240905151058.2127122-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document perf_brstack_srcline and perf_ip_srcline.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-script-python.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 13e37e9385ee..8afa86189c3c 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -624,6 +624,9 @@ as perf_trace_context.perf_script_context .
  perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
  perf_sample_srcline(context) - returns source_file_name, line_number
  perf_sample_srccode(context) - returns source_file_name, line_number, source_line
+ perf_brstack_srcline(context, brstack) - returns source_file_name, line_number, discriminator, executable, build-id, inline-stack for each entry of a brstack from the sample. Inline stack is a list of inlines with filename, line number, discriminator, symbolname for each entry.
+ perf_ip_srcline(context, ip) - returns source_file_name, line_number, discriminator, executable, build-id, inline-stack for a numerical IP address.
+
 
 
 Util.py Module
-- 
2.45.2

