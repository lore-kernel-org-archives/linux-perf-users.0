Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F503242A4;
	Fri, 14 Aug 2026 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677405; cv=none; b=UzWNpFTk4x74hAerS6rWCscO8uwqfK9sUj5ljw1ep32GhaKd2RY8oPZvjadNacUg0qKtrSy5dBeW3ZGqkcxwu/rMv5LVpLsV4jD4iq/XlB+2KkmxDsVQuJfqlmRjaauWCI95wNwGwUS+PgJrDgrkkqe7slVzYyGWkWpTnvroZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677405; c=relaxed/simple;
	bh=hmYj+8AmopKf1DpWYruOdx63McR8Lh6q13g8UYQZXFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY/i4G5v2SICpdzzUdIO8GIGKnEnf1AORoXCLJek63SfD7gk917oXfQb6qGJk7kKl//UDwR+5w3h/M7J+Y1IuSUeXmfd9uAqST5USKm65A/igFqERCkEl0d7SbwmhfXKsfCe3UEPZxY0pNArJuoDsFfQNm3AqwAJFg+MmWu1Y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTPEv9bs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTPEv9bs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786677403; x=1818213403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmYj+8AmopKf1DpWYruOdx63McR8Lh6q13g8UYQZXFY=;
  b=CTPEv9bsBhMBo2gnD5wpbRdDK4L7xq7axel6UQGaRh5uxKxH0zAMXqmR
   auxOfrDZ+t4QAB9EH4ccKJCpC3ClNHzLSo8vI+LE022mJvZiuEl3ifw4K
   bkVIiEt2l/EhtZCIMPLO0m7GhOVZBZwGL0iu7NKGqPncM8njhKps8QoL+
   b0pBSSrcU8D91MnduSwS8zynqH4UTDTGnnWB/I2LdsuD0X5pvCuttXZDA
   knrwS11plCPkXq82gTWcT7LZutFor5Vz7InYXD7ZrXYvpLqAMLa9KtLWe
   08H7H7L5MbPAKFDUZYrwnWl2YuGqNix9XFpgtl4Sdna7etGXqS8dve9Sl
   A==;
X-CSE-ConnectionGUID: GZeCieK+QCqxRGG3R97TRw==
X-CSE-MsgGUID: fg7xeKheQ+KBO92OxrCiOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97849999"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97849999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 20:16:42 -0700
X-CSE-ConnectionGUID: rNtn8v+LTlSdF9YMvu9Hsw==
X-CSE-MsgGUID: zeuepTLfSxSPwtJ0C00dzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262790344"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2026 20:16:39 -0700
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
Subject: Re: [PATCH v8 2/9] perf c2c: add function view browser skeleton
Date: Fri, 14 Aug 2026 11:23:04 +0800
Message-ID: <20260814032306.2055624-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anwuHmiI7DCOCm4T@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com> <20260810052647.588867-3-jiebin.sun@intel.com> <anwuHmiI7DCOCm4T@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

> Considering function view in stdio, wouldn't it be better to move the
> common code to util/c2c.c instead?

Good point. Since this series only adds the TUI function view and has no
stdio caller yet, I would prefer to defer the split until stdio support is
implemented, when the shared interface is clearer.

Would that be acceptable? If you prefer the separation in this series, I
can move the common model to a separate util/c2c-function.c and keep the
TUI code in ui/browsers/c2c-function.c.

Thanks,
Jiebin
