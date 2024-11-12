Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1F2202F77;
	Tue, 12 Nov 2024 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731376199; cv=none; b=MZaR8EhrsIfZXCSu9zBM1dCmWn25wUAVAG+J5MZuyEoYSqrwwOgJfVM/JHoB6BvAw7tadHJ4gSZgkTzOeAhtf5k/jpOZBwx3bsJGY8eP08xsbtt2ZNfLsW9Xf3aVc8zMfqw1c5y1Unk5B/UxdyOyW5s6hY3yV8UyWG/zVXnhEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731376199; c=relaxed/simple;
	bh=W5dCceaQ8c1Tlrheo9PxDqh0C/BrR2s3drGBwgZ0K50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxhSx+NsJQNWhmrClw2PvhXWyunPN0WPGUN7eCKw/UnxuVrXDlTX692ErBv+W8t35VFIZwhyHk2HPmYka+vzpJVjp2bF0WLAYrnABni8UQf6YSsY6gxFgF3Ugc//lvbbDGgtCD1ILP6W+U1MQS8zu9Hx4jxHfXKQWpuTcHHgowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66732b440d54-d8624;
	Tue, 12 Nov 2024 09:49:53 +0800 (CST)
X-RM-TRANSID:2ee66732b440d54-d8624
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46732b440cb1-27099;
	Tue, 12 Nov 2024 09:49:53 +0800 (CST)
X-RM-TRANSID:2ee46732b440cb1-27099
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Subject: Re: [PATCH] perf tools: Remove redundant variable assignment
Date: Tue, 12 Nov 2024 09:49:52 +0800
Message-Id: <20241112014952.279316-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <ZzJErOTawAelWAQd@x1>
References: <ZzJErOTawAelWAQd@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ok, I'll check what happened and fix it, then resubmit the patch.



