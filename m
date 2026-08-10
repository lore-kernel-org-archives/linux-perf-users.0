Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FA39657A;
	Mon, 10 Aug 2026 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339653; cv=none; b=cMKa8aDBgpLlqbTwHQLMzJrs115awBf9I7VhqoJMt1QIowbqDHmUWqJ7V0pAfag4YhSZrByj0rTgO1zkn6udDNg0d7fxFQabQw1doVjLEjSKb5N8VmXhpezWJYUR4EjzCieMp74iiGjMHsTqmKeQ2oJZgfks3F6KHUJfGfQGWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339653; c=relaxed/simple;
	bh=mSbhRTFAGdMRUltBaO7nQUDIJM3Wom3HWUQb0pyOGKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCbEvwkOJKFrOLw1u9wuXanQZJIlN07M2QAUg3TejOGwVBc0izW+BkOiZkDrL9ZMlYOXn0BBffZ6YUTAbTiKJQkJqkvk230y2d00lAZpdG2X6HBL6nwN1bSzVkNsn9LbEbvjUhQBlS+B7SLOX3bhq+lopBpwTNhhqfAI2aS3o0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHBxK6Jb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHBxK6Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786339651; x=1817875651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSbhRTFAGdMRUltBaO7nQUDIJM3Wom3HWUQb0pyOGKc=;
  b=UHBxK6Jb49rExaUbDRMX30Xczr3iEGi9YsWx42oesGXYSv6/g/knWdTw
   0OTiB02GFXHbpTQHcYDOEM7SHlMHg2gYAtHrDTtGg+zs4OY63kMq7bG1y
   CbFeafpoADxn7AK5z93jHMkYZVOkFDo+7AD9p8hFTk2AyTJndD2BsJQsF
   ihUWgrZZMT5iUq3r+cAMca6dQENmLzerkvAQZhToMfZYUQPNI07IGnpf3
   yenUHycuUr3/0Ib3q3j4ZFA8EusHUxb6hYsWnyOW5kOdV2lTHdb/s0IPB
   5FAwopC4LT2sS29iTjpcTJAwa4kJWFPU5EJje+73QoCYph0IrgGUEWYur
   g==;
X-CSE-ConnectionGUID: z7AJXk3AT5+cn5kdA2o5rA==
X-CSE-MsgGUID: eGFl1ZthQAqy53JhC4j05g==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86873845"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86873845"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:27:31 -0700
X-CSE-ConnectionGUID: DLSkN5+YRDWoxYHfJS71Zw==
X-CSE-MsgGUID: eJOvrx0uTb+790GD4ecQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="261645893"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2026 22:27:28 -0700
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
Subject: Re: [PATCH v6 0/9] perf c2c: add a function view
Date: Mon, 10 Aug 2026 13:34:01 +0800
Message-ID: <20260810053401.590185-2-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anV438EFQvwGp-bh@google.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com> <anN-livkfPdXq7Uy@google.com> <20260806074710.2847155-1-jiebin.sun@intel.com> <anV438EFQvwGp-bh@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

> Thanks for doing that.  I think you may change the code to take pointers
> instead of direct references.

Yes, this works. In v8, builtin-c2c.c passes the required state and the
cacheline detail callback through struct c2c_function_view_args. The
browser no longer references command-private symbols, so c2c-function.o
stays in libperf-ui.a.

Thanks,
Jiebin
