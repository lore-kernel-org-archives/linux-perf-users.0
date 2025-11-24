Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110102EBB8C;
	Mon, 24 Nov 2025 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971643; cv=none; b=uOH/3I3tltNMub/ziU+dyRGFQTxcEtZr9hd2fs+J+wVfrcM6RwVX8zigha5YbMVgKKmm7yBVAJyiQBsK2oAlQyBNIVFUcOqLfN7rV7R0nYHNP7ciJna8MtSIBhv3XlOPVBt+MX2iBfxsEi/XimaF+73FxNwyJ/QpwNLGoMfn3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971643; c=relaxed/simple;
	bh=KFa4vTZr0uRdIPuHYGQLszzuau8R3dwTAeJBUYe3VPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7IiC+jOLg7XO3KPKQh30PEId8+32MMJqkR1EPNpaU2OoGACfUO1KCy6k/7vwtRf37UTQS6X8VE4hi7/B8f9SYEE2lDzu0KXh7lkOAoke5nv6JotdjpW8F9GKsbV6hTn6AH/anQ1nZKMfDjG0lvtp+qOwtE2MAC+MJsHqTqUxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=jY8Q5CzC; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="jY8Q5CzC"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=1437707645=ms@dev.tdt.de>)
	id 1vNRKC-003IbK-Py; Mon, 24 Nov 2025 08:49:28 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vNRKC-0000iU-4G; Mon, 24 Nov 2025 08:49:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1763970567;
	bh=k4EA6anycoPgCYLxOhgWRVt70C+ttaebkhehKtNd+LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jY8Q5CzCR0G52ElJydXe1FXbDZoM6vmVUqJ4pznpY/a2JHDWUtt/JLQ/ocgQkeKrx
	 r2BYj2hIbz7KIJq3Hrly0j3I0xd+Urga3OUTtIaQ80iu2F1cgExF4HCzl5Qm1OS5XH
	 LgcYdzsi7SYQU1glzutKU53GKTyylnswSL+gVFicoEdL5KLjk/KCiEXdLMLimAIkrI
	 j+14FGHUeZA48dQ7hz4YmzPTs8zIgalkYjLmMCqk6P7Tom7JMmMIcgLwNP8eiSGRio
	 0qUqyGCOODiVsXJ9vBiHrTPooRjC80PD9ysZwtduukw4rjbAV8hjo430YRcKLB2UEw
	 vXy4PriauHLJQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id A5630240041;
	Mon, 24 Nov 2025 08:49:27 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 9C4C5240036;
	Mon, 24 Nov 2025 08:49:27 +0100 (CET)
Received: from mschillerX13.tdtnet.local (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7AE9520807;
	Mon, 24 Nov 2025 08:49:27 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: tony.luck@intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, fe@dev.tdt.de,
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 3/3] perf/x86/cstate: Add Airmont NP
Date: Mon, 24 Nov 2025 08:48:46 +0100
Message-ID: <20251124074846.9653-4-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1763970568-7E6E00DE-283D9A80/0/0
X-purgate-type: clean

From the perspective of Intel cstate residency counters, the Airmont NP
(aka Lightning Mountain) is identical to the Airmont.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstat=
e.c
index ec753e39b007..531dba5a8095 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -599,6 +599,7 @@ static const struct x86_cpu_id intel_cstates_match[] =
__initconst =3D {
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&slm_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,	&slm_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,	&slm_cstates),
=20
 	X86_MATCH_VFM(INTEL_BROADWELL,		&snb_cstates),
 	X86_MATCH_VFM(INTEL_BROADWELL_D,	&snb_cstates),
--=20
2.47.3

