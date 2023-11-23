Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7h8TXeA"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB41A2;
	Wed, 22 Nov 2023 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726370; x=1732262370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GEAc77OsF4bxWxrj2dawT/0XeezNSL1qGVLTk4TsRX8=;
  b=G7h8TXeA9gPji+xyNJ4wpXgVu1+mZ+aLTMqP3I8TUnBxHXLur3a3QNZt
   Vkj4S5F0QBk+jR4NZXrbk0cXzaqyUa6Q5Xql4Z+odw9KZmILigpYGOYMe
   3CQUmfFotp09MMeTX1GPyz9LgSlNJPzJ1Ym+CXtVKNCOuHbflyABteFc7
   1plH6i+1vda3ECpHxLgbULP5Ea4rjtZvfWoD0VXqq6QAnzAA5d10ekSNU
   1HKUIY4pd26dVdwYFAPwzZaybboRgH87H3IHWqrS2p09uUhkbeezoLbqA
   2wTwpDgBmSBHXVxrA1DjmLhDXZ4iYyOEsEey2rrJIZ3czuBfZX9ZN0rAc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126406"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126406"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764977"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:03 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/8] perf tests: Reduce inexplicable test failures
Date: Thu, 23 Nov 2023 09:58:40 +0200
Message-Id: <20231123075848.9652-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here are some small changes to help reduce inexplicable perf test failures.

Regards
Adrian
