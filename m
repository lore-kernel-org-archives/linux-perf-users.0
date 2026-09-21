Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EE4C9E06;
	Mon, 21 Sep 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012583; cv=none; b=fuYIAZE0a+PpLxS0hHUpLOeFLXUyybgZ0ea2pAAywOz9xpqIv3DoaLabw58KeRJ9lPA3vvG5pWJZledG5UTk1mq5eLn/1iDDF69OztPvtpUPoEzpPm2L9XOezRLFJhY0Q9pBkmVUiPclcBAPju3EcOWuxvL2UlDvmBsoqrtxdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012583; c=relaxed/simple;
	bh=fLjjd0pHkuQCnW3OLCGZryvEL0neR89MXXbRO9+7hvE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uOEs5xTAuSbZhCl0Wb2eDRvX2u1a0T66qu66E83nRKduiMbVLqctp4LSVIg+TWtC23xVuBgSEkFoaSRFInRla34EQzojm4a02BpfgFug7mBo70ZDJNc9DyPOscO74veVPKvGMTQ7vY6HuAgmbeEP/LbpHnDEkK5jqZH3Af7AcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IIx3VxVu; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IIx3VxVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Message-ID:From:To:Subject; bh=fLjjd0pHkuQCnW3
	OLCGZryvEL0neR89MXXbRO9+7hvE=; b=IIx3VxVu4mLLTAFEUOUjMPZGh2V5N1H
	t/xGZ5j7zJR8k2DkWAzZ0Vn1Gm5mov390x3BXF6mCOIsaBA1jwrH1THRUuDJIAsY
	EAU9yQdf515EAOLCbP7o7OgTPtI8orcCQfw6sNZCKGaD8wBdsp052cpEqmkfh18g
	XF3gbf2flY8o=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3LyF2bLFq3G9fCA--.13578S2;
	Tue, 22 Sep 2026 01:42:15 +0800 (CST)
Date: Tue, 22 Sep 2026 02:42:14 +0900
Message-ID: <45a1bcb861cbe6fbdf3c04831dca53ad.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf thread_map: Deduplicate numerically equivalent
	PID and TID strings
In-Reply-To: <CAP-5=fUxHz=mp=GOkZsAoXYuayYS60TKBgafTBpRjkMJU5goBg@mail.gmail.com>
References: <20260912031112.1814574-2-sh_def@163.com>
	<20260912051747.2215776-1-sh_def@163.com>
	<CAP-5=fUxHz=mp=GOkZsAoXYuayYS60TKBgafTBpRjkMJU5goBg@mail.gmail.com>
X-CM-TRANSID:_____wD3LyF2bLFq3G9fCA--.13578S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr48uw1kKr43Wr4rZr4fKrg_yoWfKFb_Wr
	yDKwn8Ka1Ivrs3JrnIkr4Fqr4kCr43Wr1vva92qwsxKFn8Ww43WF9Ykr1xGF1xZw4Yyr90
	qrs5AryIgw12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRifOzDUUUUU==
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hc-nmqxbHc4XAAA34
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Why not parse the pid_str into the intlist and then remove duplicates?

Good point. I initially kept the strlist and used a separate intlist as a
seen-set to minimize the change.

One wrinkle is that intlist__new(pid_str) currently treats duplicate numeric
values as an error: intlist__parse_list() propagates -EEXIST from
intlist__add(). Thus, "123,0123" currently makes intlist__new() fail instead
of deduplicating the values.

I think the cleaner solution is to make intlist parsing fold duplicate values,
for example by using intlist__findnew(), and then iterate the intlist directly
in the PID/TID paths. That removes both the extra strlist and the separate
seen-set.

I'll check whether any existing intlist__new() users rely on duplicates being
rejected, and whether any thread_map callers rely on the current lexicographic
ordering from strlist, since intlist iteration is numeric.

I'll rework it that way for v3.

Thanks,
Hui

