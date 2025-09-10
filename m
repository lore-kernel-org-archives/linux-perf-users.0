Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A842BE02B
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.126.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494797; cv=none; b=IhiI3nM7icFlQkTwvKzV5mg75mG07SeQUVrJAKl+7u+KaxoqVgaAA9+vqB8LHaP4F6a4FFjCycsZt/IjUFq975GRNFjat9MhUdmPGCc9Fqihs25u8B8VuJLIVeCvUqwfDVk8YX2GGcBoMAPCtTVzpzphaBXAs/Hl99AOeQysLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494797; c=relaxed/simple;
	bh=opNS0WGEyO7j9MxtLjvROuwsO8mR/dhgOz2V732OluI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKhA+YUvFVyoo5ilQREvqelLvqTV+HYGWgnUUwon8HCOz7yrlh+9fiJydxHeTvh/hJdRNY8/e8uAHvHDEs8VcA87KA8MozfrLqb2rgLkH1EVW1JlzzTrv8QMUYajlLmdGHJVk+FCyKe9xeJfdhsOR5S5THJbTv1WcuXapD5sID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com; spf=pass smtp.mailfrom=kdab.com; dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b=F2t87ajH; arc=none smtp.client-ip=176.9.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="F2t87ajH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1757494292; x=1758358293; bh=WN3bWpnnbaUVyOnbPS9Mm81PtmN
 OsyPBnj06g4ZtD/E=; b=F2t87ajHBbb1D/aQQp4CdDgfn2HjFNUb/e4ce8p/vSq
 XF64nJm4ziV/S6e4I8iuhNxA4scoY0PDV/rWwO+pV+Q3vxC6vfN7q7YPOpFwEUD+
 yNSR+z+bndEQRY5c5cEJLKGPtNLuKfM+Auabh1nUYzyxCsHf22bG0Wp3d9X0ZptY
 =
X-Virus-Scanned: amavisd-new at kdab.com
From: Milian Wolff <milian.wolff@kdab.com>
To: linux-perf-users@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, acme@kernel.org
Subject: combined usage of `--aio -z` corrupts perf.data files - fallout from
 COMPRESSED2?
Date: Wed, 10 Sep 2025 10:51:31 +0200
Message-ID: <38208379.DOZC079dcN@milian-workstation>
Organization: KDAB
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hey all,

for some context, see https://github.com/KDAB/hotspot/issues/
736#issuecomment-3273734660

The gist is the following:

```
$ perf record --call-graph dwarf -z --aio -- ls
...
[ perf record: Captured and wrote 0.005 MB perf.data, compressed (original 
0.101 MB, ratio is 28.747) ]
$ perf script
Couldn't decompress data
0x598 [0xe53]: failed to process type: 83 [Operation not permitted]
```

If you remove the explicit `--aio` while keeping compression via `-z` enabled, 
then the result file can be parsed. Enabling `--aio` but disabling `-z` also 
works as expected.

My understanding so far was that `-z` implies `--aio`, and that there should 
be zero semantic difference between `-z` and `-z --aio`. But apparently this 
was a misunderstanding on my end.

I suspect that the above issue is related to the recent addition of the 
COMPRESSED2 record type, since commands combining both of these flags used to 
work fine until very recently.

Cheers
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - Trusted Software Excellence

