Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212A341050;
	Tue, 17 Mar 2026 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711898; cv=none; b=gAGGc4tUoeUXFZ3Sk3E7vfK6+exhJcO0PX35MPa33loO9jFqoRiVWHltKWSqjqFrhw6D66DQ9GbhIbxS7OC/kyNzXb/jKFyrLpqkvrTOONODMclXIQ+MUnEx35VCnPAF04djnG3Q22v3Fsvo47Y6LPjbYCRad2ph/zWhIs4JqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711898; c=relaxed/simple;
	bh=hnmQqFAuMAXBpw0fT6RkYdaNqS6B5uagQMd8UspN4B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRYIiUl/Jo9kjQbDPKzTXZmjVDR22xzC+xwuwo0fJerEC8H+6VxFAifY7bCwjfA4Kn0P2PvwFBiFCXzMDw+QJ498lY+e8t38mOMtwbt/SkODgjIpbNgpw3NjRZs4SN9XmUKEGrpzm7oa1eAefKfoIZTmhxSyjRLCW3UgbX1efuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qo7CKRhg; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qo7CKRhg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773711886; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jR8xXeKXRtFp4B6MzFxUH+gq5oQ7668Kpt1nBF5hgrM=;
	b=Qo7CKRhgn0OLEPVn/cDiKZCa2cdBfLsFd6IwkmvH19PQmXkmLseZSx+g2WLKS6pTJZFSpGqSI1oRas2yGXvyO+vUvKJQRDAdlq9zwtWxQyouzq5oGorejKpXjxSiOntbjq4zCbRCv9h3bu8DAZ9xMmUpsFVnl90VXUey7j5vORg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X.93N8l_1773711874;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X.93N8l_1773711874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 09:44:45 +0800
From: cp0613@linux.alibaba.com
To: irogers@google.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	guoren@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Avoid argument list too long in orphan pruning
Date: Tue, 17 Mar 2026 09:44:34 +0800
Message-ID: <20260317014434.1440-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAP-5=fUAf5bhbHiy_45xP4LhUM-qOa6YykQaMF4yp4Ta7qmbog@mail.gmail.com>
References: <CAP-5=fUAf5bhbHiy_45xP4LhUM-qOa6YykQaMF4yp4Ta7qmbog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Mar 2026 08:47:31 -0700, irogers@google.com:
> 
> > The original problem was encountered when compiling the Linux tool perf in
> > buildroot. I think it might also occur in buildroot or yocto environments.
> >
> > I also constructed a method to reproduce the issue in an x86 native
> > environment by extracting a long file list. The problem can be reproduced
> > using:
> >   make -C tools/perf O=./patches-perf NO_LIBTRACEEVENT=1 NO_LIBPYTHON=1
> 
> Hi cp0613,
> 
> I'm not sure what the patch diff is, but I think you're encountering
> the issue discussed here:
> https://lore.kernel.org/lkml/20260303211503.165337-1-mmayer@broadcom.com/
> The fix has been merged, so I'm not sure why it remains a problem.
> 
> Thanks,
> Ian

Oh, I just wanted to provide a way to reproduce the issue with this patch.
It looks like the same problem, but maybe I haven't updated my local code
as soon as possible. Thanks for reminding me.

Thanks,
Pei
