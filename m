Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73B3D9540;
	Fri, 14 Aug 2026 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677407; cv=none; b=H/iXmf3YNvvL7Qxm236GXG9ORF7+iP7wmYNLedkfVHR77lF0sFebStasTE0ZGHLiyKDXTUqmNNq7fgCyM9pWUestjC6nITf0Km569brP8h+VZu1AvlaRWEzKDH2gQSHjlu5gS9vBUPGdRvDkg5rhsmUu2LUJIAQPGvXNrBqjvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677407; c=relaxed/simple;
	bh=99XyIDJsHcYP8xokvihhUKF6FVcIza5MGaDtFbl9x7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLukwIQUb7glavBYORI2CyGYM6QS1sfgRYxKlWGrWqMqQVRXfKi1DWumrKxdo/F8EsqrBhH1s/7aWk0QiRlqzjCOQMUAW3sW6Die2PR4Wn2JBuJ5niHbTdSLUSE2yTAD6JG1NGrJ6/Vl4UIIIJSPy/lQtJUx9tzFRJInKU9WPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uhft9A9B; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uhft9A9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786677406; x=1818213406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99XyIDJsHcYP8xokvihhUKF6FVcIza5MGaDtFbl9x7Q=;
  b=Uhft9A9BFq7rrPiMiw12QN1ZQUYNfMnbmlapxOE+1IiKNDMbGz/JoAxQ
   nDJ66ULYrFUDQ944nnQFGVzoZdhffYZqHYYlp/lqPaZaHkCu/iY2yJQVD
   S7jm5tYFMH2AhNfFy5CkIU/nAd6Q0EUgdYgE9fXjEIbJ2JlpwB1dt+sw8
   /UuGc/MaBoa3+lTariSIvAl89xT5g5Bqzmdx9KsAipZ7vkx7A7q93yusC
   6HRmiy4AJcFEjT2q7wWZTCo06cxRj1wuqnU2EN6fbmV10P/xxdawMLbgw
   X5x1BNBSRjJVeJPZYxrwawo0ODNYcCSEc0jw+bWNRIa0jTDGEzYq7EfS9
   Q==;
X-CSE-ConnectionGUID: KXGri8xJQVy1EjS4qQTbNQ==
X-CSE-MsgGUID: t6AlJq0pTXC1LHxLqKHcdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97850006"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97850006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:16:46 -0700
X-CSE-ConnectionGUID: ZbkS0cetRpCyX7dd8lAOnQ==
X-CSE-MsgGUID: cDy7oupMRb6MPbiwqZhXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262790352"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2026 20:16:43 -0700
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
Subject: Re: [PATCH v8 3/9] perf c2c: add column rendering for function view
Date: Fri, 14 Aug 2026 11:23:05 +0800
Message-ID: <20260814032306.2055624-2-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anwyNEKi0wSHEuOI@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com> <20260810052647.588867-4-jiebin.sun@intel.com> <anwyNEKi0wSHEuOI@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

> Can it be simplified like this?
>
> 		struct c2c_hist_entry *child_c2c =
> 			rb_entry(nd, struct c2c_hist_entry, he.rb_node);

Yes, thanks. I made this change here and in two other places where the
intermediate hist_entry was not otherwise needed. These changes will be
included in v9.

Thanks,
Jiebin
