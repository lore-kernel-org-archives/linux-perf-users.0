Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215579B96;
	Fri, 19 Jul 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379423; cv=none; b=WA3vlvr3zCkKrRvNCxuds+5Ec6Dt/yrsNzE7eAdoww2SZ9JBIR6sXS/IMThMix2CA03B8lLtDFlJPOEKFdxQosIUQ2lFu/6OqJdNSffBgsjQgWxOAqo+pGx3POMIcRgJakraOfwoYbtDQuLNIFS3rVrgKUKV8Is0X8h7S+5mf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379423; c=relaxed/simple;
	bh=SLTEoIanWY5XtN1aVQbk85fIW9AXREmPvziMz0cN42g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=smNbOF48k+tL/fYreg1AeSkIa/HWwmuhucdTYfuyClAIjTxBBix0mYmIpd0qxuSu8sji/ftw7wD8v5Q7dMlTrYXYA3HvqquW3f6OcW+MJGT4esPK3ohTMw+5a0oXfvBM/jt8QQiEGnI8GsyzxPfbC/8I4OG257YomWauWm7XXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=ApOmpFly; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="ApOmpFly"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 50DA861BB1;
	Fri, 19 Jul 2024 11:51:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4e22:0:640:3724:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id E30B0609A9;
	Fri, 19 Jul 2024 11:51:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2pFgMY1On8c0-UCuAlS9V;
	Fri, 19 Jul 2024 11:51:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1721379068; bh=SLTEoIanWY5XtN1aVQbk85fIW9AXREmPvziMz0cN42g=;
	h=Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=ApOmpFlyHodXNs2nKBGExgy7/kJQW9Wd3Rc5Roy9paoG/0gRvV9XAMaOn2voIEjcW
	 Z1rYnyrSNXqtUYsTqbHoQyI0eYyVrnrHlOgpyn62SKe2W/p4lFvbDt8j9VS4oDGeFE
	 U9fpBiDEdnDcB2xuI1vzTBjqMSvpweEXfxfSgku4=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <12bd744ea481c8a3505e6f4869d409d24d3db795.camel@maquefel.me>
Subject: Re: [PATCH] perf arch events: Fix duplicate RISC-V SBI firmware
 event name
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: eric.lin@sifive.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, aou@eecs.berkeley.edu,
 dminus@andestech.com,  inochiama@outlook.com, irogers@google.com,
 jisheng.teoh@starfivetech.com,  jolsa@kernel.org,
 kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
 locus84@andestech.com, mark.rutland@arm.com, mingo@redhat.com,
 n.shubin@yadro.com,  namhyung@kernel.org, palmer@dabbelt.com,
 peterlin@andestech.com,  peterz@infradead.org, samuel.holland@sifive.com
Date: Fri, 19 Jul 2024 11:51:06 +0300
In-Reply-To: <20240718152254.16007-1-eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Eric,

Nice catch!

Shouldn't it fix every patch that copied affected 'firmware.json' by
the way ?

Something like:

Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event
files")
Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON
file")
Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80
JSON file")
Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON
file")
Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic
firmware and hardware raw event")

Reviewed-by: Nikita Shubin <n.shubin@yadro.com>
