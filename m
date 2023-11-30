Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwCbTROb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDD1B4
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701379777; x=1732915777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w+OjMcuCSZrXheWfx6Yjnpf1HTtRVXAKagGBG2kfBSA=;
  b=mwCbTRObH37mVIYVH9cht3rTaX3+Zc3P0FXRR+lEvCWiM17mUOnM5e4v
   QwbYMLiSae3Of1hoYHQPnZlA5XMv/UX8+LgqEyd8PfWR/gJWQ3r+MoSxj
   VYrgg5pSPnxaDvA3Z1cFUGGnFlkHjvsomfKhf6dnMRZRIwrn+HhBQPCY6
   vW+T8NMCJ5FvdTmz38WRKQs7B+uwzVsAgXp3EyMsK5JsrtHpa8qfZMl2i
   QMoeycSLqyceYARpteZzZDfn2Dk+ag8zrPcl7022+3dVfS1Z/CaPzNSCE
   OyOuNXTwwU/6I+Dno5tKMc5XjuRlhc5m2F95h+PuvUdHWC0inGr5MM3nh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="390559429"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="390559429"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769431276"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="769431276"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:29:37 -0800
Date: Thu, 30 Nov 2023 13:29:18 -0800
From: Andi Kleen <ak@linux.intel.com>
To: irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: More perf events reordering
Message-ID: <ZWj+pdRg4Z5dtiRR@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


(on a Intel system with TopDown metrics, Icelake+)


$ ~/perf stat -e 'slots,cycles,slots' true
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'true':

     <not counted>      cpu_core/slots/
   <not supported>      cpu_core/slots/
         1,458,844      cpu_atom/cycles/
     <not counted>      cpu_core/cycles/                                                        (0.00%)

       0.001501970 seconds time elapsed

       0.001621000 seconds user
       0.000000000 seconds sys


Output is unexpected order.
I don't think there should be any reordering without a group.

-Andi
