Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCE8C1F;
	Fri, 31 Jul 2026 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483477; cv=none; b=kJpfvmSWPN48SA93Kl6GW2Lkp4tK1AI6YD6V0Cru61F/OsYNj6T52De8Ba+k/Xmb5+w7Jo7mFt4mcXcV6SOCMWhiKk+yLDWev84yU7OOeen601m5LYoKWXKfYYnuXlw+wk64Obcl+81d5GsA3dgAMmssBa7cbq+bEazkNbfd1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483477; c=relaxed/simple;
	bh=uw6A37i8UknN3xWJtGW5LZq90o9FhxG1Gc0xI35RaAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E83XbPwwr53iQzS9BHqd1fHPChsipkURtRpjuFHVSAT9obIoua4ypXuJ9eU0KOVSTCFUOG6HCna6TuAC6S0lB3qG40veaivk9TjYLFMA0l6qndlZZtGe54BQdSdWC+zXS3fbZYq4CRneVZeUaktEj0P/Z0reASSynicoEMR5ygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvC9PhNo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvC9PhNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785483476; x=1817019476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uw6A37i8UknN3xWJtGW5LZq90o9FhxG1Gc0xI35RaAU=;
  b=hvC9PhNorzPnYt/gxJifJx6vbXVzphPv1heMlogysnvGQYIMc7DJek8f
   OyTv3nWN2FzarsxItnGOOood4ooBlIRbCesBV9tKuWFweT8+AuhCn8CmB
   8NIkQUiPJmh1HCDNJYAYJKZ7JTJSyJhOANgsyba/Bb6HZpSKXybYh3Fmc
   7bBm7UkPP0itRwc2GtRtkUAuvr7bGfbZ3zRSPiN4sQLc7ghrJ/+l/PVVV
   9rMkk/yDdYsLaQUdIkWqb863YvToKUrL6jNLX9gTw/w7BiByCfB7HkZrn
   4D79plWE54XHL3IcSYtPEcbfVVKuMd1/2AwBuXXbthltJheXKDenNtvxG
   Q==;
X-CSE-ConnectionGUID: e20/ZI+TRO6uyCN5j1Lo2Q==
X-CSE-MsgGUID: EgPGai4lT1uoJFpOK6e4Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96464751"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="96464751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 00:37:55 -0700
X-CSE-ConnectionGUID: 8+LeXcwvRI+QIE4L5X5hXw==
X-CSE-MsgGUID: ccXYFHKnR3G7rB9fH0G38g==
X-ExtLoop1: 1
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa003.fm.intel.com with ESMTP; 31 Jul 2026 00:37:51 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH v4 0/9] perf c2c: add a function view
Date: Fri, 31 Jul 2026 15:44:20 +0800
Message-ID: <20260731074420.359844-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <amwL794Mj0O3vOkr@google.com>
References: <amwL794Mj0O3vOkr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 07:43:59PM -0700, Namhyung Kim wrote:
> Is it possible to add proper refcounts instead of borrowing?  I guess
> that'd make the code simpler.

Yes, and it is simpler. Let me check the approach with you before I post v6.

The children now take their own references:

      child_he->ops = &c2c_function_entry_ops;
      map_symbol__copy(&child_he->ms, &src_he->ms);   /* was memcpy() */
      child_he->thread = thread__get(src_he->thread); /* was a raw assign */

      hist_entry__delete(child_he);                   /* was a custom free */

hist_entry__delete() takes care of thread/ms, mem_info, stat_acc and
srcline/srcfile, and calls ops->free() for the c2c-private fields. So the
custom destructor and the WARN_ON_ONCE(report_hierarchy) guard both go away.

Two sashiko comments fall out of this as well: the leaked srcline/srcfile and
the missing ops are both covered by the generic destructor now, so I did not
treat them separately. It also asked for NO_SLANG stubs for the two entry
points declared in c2c.h, so I added them the way util/hist.h does.

If this looks right, I will send v6.

Thanks,
Jiebin
