Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066312DFA2D;
	Mon, 24 Nov 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971624; cv=none; b=Fvy6fxEX6KSOIBC/Wd09OvsbYfuO2WTPvIlPMhq9wvoLqefgA7p37PbYKjlQSsWZUpL11VyLke1wgCUy5G/vn2w/yVsvPOFSnpcAfpLH3ZuVhceLcX+660+LoLRTux7oUUrWw6l3HDvaLoVfMhm31uW7t/PsX/opI/lFl1lj9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971624; c=relaxed/simple;
	bh=YjpV8a/b+3XZWj9YGxtJU7MpoE3cs3sCHXvo2avfjy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMZ2BLbcQCctTsbBGX0cS03g65ZRJ4DEFy5YWuYETNIAmVq61xbTJ8n8kdyyOXlZLP/BqagxP0l45vlr73hDvpQntLj0WnCd+jbpqJV8oN+gDfexgSlBpGKRzBLTIN0nes2ayjTTC8sSh8RGW0BQwJYpm3WAw/aebvNVtsf2oLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=GlYfnKVe; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="GlYfnKVe"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=1437707645=ms@dev.tdt.de>)
	id 1vNRKB-003Ian-P7; Mon, 24 Nov 2025 08:49:27 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vNRKB-003cu9-2u; Mon, 24 Nov 2025 08:49:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1763970566;
	bh=8iXdg9biPmrAlI62Amh3svltb4bmVIj/g0MMCCRiclY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlYfnKVe6uppiqcWbME1EpwAdpIe++/jjgbd+VCwSCRXx/9FkS0voLC+m34Usf+fM
	 i5/RerfXTbFFDmf+nhqqdc1k7HZGjJL6f3EILIFSeI5sBMVOwHCjh4MLlMUcG9MVIH
	 3mddHMhGl92l+wZmvWQCOnllWUyvMz8gx81f4iBCRM8BFmrzF9Zx82tVyMvdDr0gys
	 VfTI2K+j08uHFHXxhSLWefQJ6rMKU9vLzkJnDv30MGZS/ut9lc/ATTa6p16p35gBj3
	 nBs2R7ab6NeVjvUl2sovc61BtufVWpJVIiHSwi38zv6Hh+u7gqxo9mlVX/hT7HPq65
	 tQD1Jcjmxk5YQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 96532240041;
	Mon, 24 Nov 2025 08:49:26 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 8C4FB240036;
	Mon, 24 Nov 2025 08:49:26 +0100 (CET)
Received: from mschillerX13.tdtnet.local (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 6B6B520807;
	Mon, 24 Nov 2025 08:49:26 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: tony.luck@intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, fe@dev.tdt.de,
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 2/3] perf/x86/intel: Add Airmont NP
Date: Mon, 24 Nov 2025 08:48:45 +0100
Message-ID: <20251124074846.9653-3-ms@dev.tdt.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124074846.9653-1-ms@dev.tdt.de>
References: <20251124074846.9653-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1763970567-A6AC20DE-3D03E177/0/0
X-purgate-type: clean

The Intel / MaxLinear Airmont NP (aka Lightning Mountain) supports the
same architectual and non-architecural events as Airmont.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fe65be0b9d9c..641008590a17 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7024,6 +7024,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_SILVERMONT_MID:
 	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_NP:
 	case INTEL_ATOM_SILVERMONT_MID2:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));
--=20
2.47.3

