Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03042DFA2D;
	Mon, 24 Nov 2025 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971578; cv=none; b=qTWJeP2HWPXn2NiefSL3Vv1CbBtTem/2B3ojdQAv5HxOIjH4NppOdE3HdnYkjKsePKuvgTMURjsfFmO/6k6AqJ3yIjdfpyT+9VHT22OI9BsnAS3Umj6EuH5uZAXQcJ5pv6HI9aCWWsCu8DEAhLXuR18k7hbjWyFiZpRGJMhSxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971578; c=relaxed/simple;
	bh=PMzkBO//8WDq1tkTkIx0PVqzyte18D1/JifnbllLWyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bU8QJBgfP/nI7RqTdR3wQsALmkBtabdUBAu2o/Kg2tH8hzN0TekO5Xl7Kd8MSP6gA5H972a0iUno3fu/BvhSMQgRcEybFH7d7Dt2aPvbJ5GSfm/fB/1mbfhoAlSVYp1mJvPWdBgCj2ckeLUljDldzP2PzmT0ebmAr1q6fHdwxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=EOYTcjps; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="EOYTcjps"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=1437707645=ms@dev.tdt.de>)
	id 1vNRK3-003IUc-AA; Mon, 24 Nov 2025 08:49:19 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vNRK2-009pp8-DV; Mon, 24 Nov 2025 08:49:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1763970557;
	bh=kRi1gpli3cGMbZUvgHl2yFbNspzWoVIhg09LfDrXUyE=;
	h=From:To:Cc:Subject:Date:From;
	b=EOYTcjps6OqdzqEhCSiN/VZQT4xP1bik3vFyN65132dUqoUaeUH09y/8zApeuiZIC
	 T2vjpsywsEGvzuE97l/FoFZn6eBOk1n2hxYeklsOrKm8pZ/PxenYUcMfPNNnQpwBzD
	 OyIt/nwghlbAsmNOxUo+Qze1/bBy7cf9ncQ+FzbzJ4/uJXhfPORldOVQKkh9nunVEd
	 horHb6IDydnuggCvwyXjB5tok5afSo7tg0EdHEGCsvBD8SssNTCZwPJmP6Mf5uPxUO
	 IoECKTjubRRg8iG9Uf36YbaEJIX0PXNLOQCL1t4Wh1P6y1EeehJaDBxpNIey82Fl2d
	 gj3yqRSiljiow==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E0183240042;
	Mon, 24 Nov 2025 08:49:17 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C3F7F240036;
	Mon, 24 Nov 2025 08:49:17 +0100 (CET)
Received: from mschillerX13.tdtnet.local (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 93A2D20807;
	Mon, 24 Nov 2025 08:49:17 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: tony.luck@intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, fe@dev.tdt.de,
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 0/3] perf/x86: Add Airmont NP
Date: Mon, 24 Nov 2025 08:48:43 +0100
Message-ID: <20251124074846.9653-1-ms@dev.tdt.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1763970559-A72C30DE-0AFB5FEA/0/0
X-purgate-type: clean

From the perspective of Intel cstate, PMU and MSR the Airmont NP
(aka Lightning Mountain) is identical to Airmont.

This changes are taken from patched kernel sources of the MaxLinear SDK
which can be found at https://github.com/maxlinear/linux

Martin Schiller (3):
  perf/x86/msr: Add Airmont NP
  perf/x86/intel: Add Airmont NP
  perf/x86/cstate: Add Airmont NP

 arch/x86/events/intel/core.c   | 1 +
 arch/x86/events/intel/cstate.c | 1 +
 arch/x86/events/msr.c          | 1 +
 3 files changed, 3 insertions(+)

--=20
2.47.3

