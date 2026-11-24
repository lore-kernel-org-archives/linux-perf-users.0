Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.90.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500342;
	b=VlIbPQh5bYt8ZjikN1AcVUfdWjA2IS6zO5Cp7t0Hn6h87Hnccaj8TM87G7o2axVQg6xh
	 o0S9R/7ffBpU31GWnFOxPakxq+cUyF1YD6dUIN5iFNC8qJMpIOUhAdkxeH/tK6zDEpZo8
	 jgAZw8bC0tNaJIRR+RCWUO6jyGuAswoQvUixW9R3CEfmcgQKAwKrQqv7kdNLXI6gLQUSV
	 2DiPd2e2UxeDyUgDe8QbeuwGL2kXDSL6B+Nvwl9GEZD8iQAztKPegD4of5qGk7ZeICOiO
	 l2mWmNk/P1rdV0ak2/gvzWeTsIDvFhaPqT+jte3CS6Us/z+EzmWI1zijqiKIZ8UZ3VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500342;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eBczXh2rwT/tVRir2/HArzL/+HYC+3RjuBz4lTVxOt8=;
	b=m7NJuQpPEw44MbqPaWiKyv13CLSI3PVlblza/ulrM4Aukw9FOxXWNYPdl126g2A/t3E6
	 YSZP6ssR2dtlOBmMhE14+FIdJwVGWIv5qxdtHCVyrOgfwjgTXbRv8ClLqmsWVl2kxOYpg
	 8AB3pSRGLvR0CI5xMbg3rJJlbH8Vde791Xp56tPAoZy6QRKpmlawTa2Jp1X09UKMqCi9X
	 fAQ9HuMZjQOjpoMnhLFhyGKpdy45Euo7TlmPE0iIkyYftbYdpateDNrNSsoQL4/USAdsK
	 Uj+xo+dAIpXIUlooVYu1M/9WHxwdgxJVElJhZgGxoLh05kG2ZqXvyvsMLks19/3Ux1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=U4slQWCW;
	arc=none smtp.remote-ip=207.54.90.47
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E8E606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 06:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=U4slQWCW
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795500342; x=1827036342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGKQ4qS9S+b/Gx7erQ6F7hfdQX2hbg0Db7UCm3AICPE=;
  b=U4slQWCWoJdBpYLO/LZrGw2WHgZqVMoP+zUAMZxJu0cS7EW41dKcVq6F
   eF11CSgwGZ6qL2Bxby1mcWy8+Ts3FDsbNHMZvUMdliCsGpjRdKBTHJJLD
   C7MOzD4unYONH5feVVb98N4H+F3daLc0HRqA5IOZkwTFFa3N6bjBFidfB
   xILz1AZ5/CZmHDkFWx0CijUKQU25jYMuGyTs/A2iONlOO2Ia6HW5lOVqZ
   NDx+842Uwpk8JwMReGrs/xhtY+77W2NFC7ylxiddXiaeopmVHoR7Woegr
   2IolzYRQbINdpNQ9G+wX84WVdgUa8vvvwXx4MahBAhQVSoiDvpnjMxOq5
   w==;
X-CSE-ConnectionGUID: oNjbL+PlS/+Lk46o63IaLg==
X-CSE-MsgGUID: xgepDh/MQHe2E20esKHExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="262868305"
X-IronPort-AV: E=Sophos;i="6.27,230,1786978800"; 
   d="scan'208";a="262868305"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 15:05:34 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 5DEC58204DB
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 06:05:34 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 0E23F1800279
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 06:05:34 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.1.165])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with SMTP id C7E5D100008E;
	Tue, 24 Nov 2026 06:05:30 +0000 (UTC)
Date: Tue, 24 Nov 2026 15:05:29 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: sashiko-reviews@lists.linux.dev
Cc: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
	linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 4/5] irqchip/gicv3: Add workaround for FUJITSU-MONAKA
 Erratum E#030003
Message-ID: <awUo0MClQ_hYIbpE@FCCLS0092175.localdomain>
References: <20261119-monaka-fix-for-upstream-v3-0-057df4d2ca3c@fujitsu.com>
 <20261119-monaka-fix-for-upstream-v3-4-057df4d2ca3c@fujitsu.com>
 <sashiko-outbox-222816@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-222816@kernel.org>

On 11/19 09:21, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Does defining gic_fujitsu_030003_erratum unconditionally trigger a
> -Wunused-variable warning when building with CONFIG_ARM=y and
> CONFIG_SMP=n?
> 
> Its only two users are gic_ipi_send_mask() (under #ifdef CONFIG_SMP) and
> gic_enable_quirk_fujitsu_030003() (under #ifdef CONFIG_ARM64), so both are
> compiled out on 32-bit ARM UP builds.  Marking it __maybe_unused (like
> broken_rdists earlier in the file) or guarding it with #ifdef CONFIG_SMP
> would avoid the warning.

I'll fix this in the next revision.

Thanks,
Kohei
