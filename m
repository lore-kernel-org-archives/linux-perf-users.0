Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175332D73A7;
	Tue,  9 Sep 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413999; cv=none; b=bnNTss71URZX8K0Q5/RKnbc/lym4TfTb0WJb8dSi2mGq+AJnDJpwS5Ka/TEvV+Xfeb4gORQkc3bbhHFOiFgkCPnpeFyEFGEZjLHPJnm7ZdyiGMllpooOzdsbkg89inRMxPdxs+2r6epW1YLhu4XVwGZyjuzTWKDktopM16B9DUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413999; c=relaxed/simple;
	bh=d/O2y0APJ2XaliFqcz36t1/7aQVB7z9BjhsRyA51mkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L2m4al/D52M5+xj802skJ8Gr9qfXVVtKhGftV1pOAtgU8ms0lAR0eA+uF6EV3201jt0D4wZXD1zzpPvyDsYyUK1UGeBQSx4D8k6DNqy9f5MBs5jRz86WUpk1UiQFf0MJZPEB7jV9/kOPaP6Mh2XWG0QZppGUnrDQR2iprDwo6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 85441340F79;
	Tue, 09 Sep 2025 10:33:16 +0000 (UTC)
Date: Tue, 9 Sep 2025 12:33:12 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Problem with perf report --gtk
Message-ID: <aMACaOmneDrG8_pQ@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Arnaldo, Namhyung,

Since sometime we have a bug in Gentoo's bugzilla about perf report --gtk not
working¹: https://bugs.gentoo.org/937869

I know this feature is not used very much, but I thought I'd report in
any case. The problem is easily reproducible as shown below:


$ perf record -a -g -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
$ LD_DEBUG=symbols perf report --gtk 2>&1 | grep '(fatal)'
    288067:	/usr/libexec/perf-core/libperf-gtk.so: error: symbol lookup error: undefined symbol: hashmap_find (fatal)
$ perf report --gtk
GTK browser requested but could not find libperf-gtk.so

I tried this with perf 6.16, but this bug seems to have been there since
at least 6.12.

Please let me know if it's better to file problems at https://bugzilla.kernel.org/.

Best regards,
-Guilherme

