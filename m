Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C2201278
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140700; cv=none; b=U/T8hOVYrOBGFvaKJXvsm0mrLj8Ms9Jl7K8X6aiw0hTKHaMiqG291D9Ewr9Ygzf6dDcl4UcK9FijozmvLXI3IE/06i88Nvsicpp1BA+eEuObRPtXqPI+aa2BLzEdrhqHwqfyx6Y9KuHSYEDd55NVilco6zmpCrTUMQsEcjvtybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140700; c=relaxed/simple;
	bh=69oEO7zcAr3dJMq3PBSt2OfIM+fVCtkmNf4+PVh9zM0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=j11DO4+3ECksg6IWG+wOD3POqJ8NV/0yak7s2oUSsH81QoG3tk/mdh4YigmZlKqjxVX9p7DfPFUbE4MQXw+/7aWW2lPOAhfZu8j5CJL/MkJIZfoVJF2GZ+ajSYoXnU5b7Kh6+XFWJiihmONNXqwT1YohJhvC1/rM5mbJ2kFmmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name; spf=pass smtp.mailfrom=michel-slm.name; dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b=UimMyjtZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvVHBdWG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michel-slm.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michel-slm.name header.i=@michel-slm.name header.b="UimMyjtZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvVHBdWG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CC9DA1140149;
	Thu,  5 Jun 2025 12:24:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Jun 2025 12:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michel-slm.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1749140697; x=
	1749227097; bh=hPhNBAFqOftPy3LRhGmRXKx8EXscCTv4vGEuCX+jKV4=; b=U
	imMyjtZhOj76uAIJuhiTid5M6P2RZDmStR2e0rZbYSeAdMuQhVoyC4F9oR9/fpuz
	9T/Oc6/LaozLDPYx3owr05wfg6Xah9xJha09q2SpYoOs0zjghZBLq956+J5nEala
	qQnFuYmqfykyneV0a+KzTgFXb4kL8MpiF2HTnF5n1a0dgx4A7/j94YC92osvIDQw
	CWQCOzK5gBV7Gwrkv4zuMmmfttMEJbSNFbfCzKNv8hmOAcASw1QKfBs/jNDwybHP
	Zgz4+5ZdJ1YyB7Dg2gjQOS9go5nCE2GXMvlvUuOl9io+a1hrtL9Ef5fr59rRorKK
	uc2430AjdZ5AMq780c/vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1749140697; x=1749227097; bh=hPhNBAFqOftPy3LRhGmRXKx8EXsc
	CTv4vGEuCX+jKV4=; b=XvVHBdWGyLWznPUE4wD/w4jqbpT665YPOFm3MTrwC8HV
	9zFEEQH05ldTW0+JxWHqa7Y4v4VczMxN66bYYkhmBfng8Nv5WZxq+Bj1AUntVn68
	m2wR3fOdkW/mF0N556Nnx96weRDFzHmszr92UjDvID/Y1So3AQrFXWAT0VK7W3Zc
	fX4IxoNVdQi9WbBUqdjSr1iD1zfPIrffKcbvrI7pykqzgPK8fDfkbFXjNqGk6Jmv
	VYj1Uj6KF6pbWjMrtbVtLUBOglbUjr1Kb9pzmBWBQc9nf93Dnm+dxpUqNoz8rtsI
	nWDDMI8V5KjGJJ/0NcBhLZ+dVY6Juf3IkYqlABqAwg==
X-ME-Sender: <xms:2cRBaGSQCpXdlkaUu4qnXnR649Bx8M7TqhoF6D6RcAXHu3xpwFoolA>
    <xme:2cRBaLxuXw-t6bB7nyWq4-k2ao8ofXkJPRU6HPJu1zoabU9pysrhKYFOrd4ijiCf2
    0F8kFQX7_gemEqogcY>
X-ME-Received: <xmr:2cRBaD1mz13N3LkttgO6bkIO9tPg4fCzyNypPb98ryNu_uVQlMIc3l_pofDyYp2YYlzeGWFJz5wEUdNXrBn_QR6yVX88dCusrbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvf
    evffgtgfgfggesthhqredttderjeenucfhrhhomhepofhitghhvghlucfnihhnugcuoehm
    ihgthhgvlhesmhhitghhvghlqdhslhhmrdhnrghmvgeqnecuggftrfgrthhtvghrnhepud
    etveekvdejgeekkeffueejvdehtdfhueefudelvdehffekleegudeiueetgfffnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpkhgvhihogihiuggvrdhorhhgpdhfvgguohhrrg
    hprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhhitghhvghlsehmihgthhgvlhdqshhlmhdrnhgrmhgvpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhp
    vghrfhdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtg
    hmvgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2cRBaCDCSLLiDSCYv0o58saNJudJQL47Inf-kOCEWbiDIPXlPu09mQ>
    <xmx:2cRBaPgrJzmrlLnJckToBVFNOtKv5NHBtYa67pT0_woPhUuW2QL3_A>
    <xmx:2cRBaOoktaB6G82w0ZEjf5CqR3-SJkDvqENOzCltrg8kag6B1A89ng>
    <xmx:2cRBaCiFoJJ6PooZ7XAkMC7S1mPLO6JpHqrCDXiEoNmOrivrFW1ygQ>
    <xmx:2cRBaFOiX-CNTY5cNiCoAeNDemSexwWLejPLPRVNdafVjPhLpOaTl5wy>
Feedback-ID: i71264891:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:24:57 -0400 (EDT)
Message-ID: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
Subject: perf-tools v6.15 tarball not uploaded?
From: Michel Lind <michel@michel-slm.name>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Thu, 05 Jun 2025 11:24:50 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnaldo,

I noticed the kernel.org mirrors don't have perf tarballs newer than
6.14.0 - https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/

Will they be uploaded soon? Presumably I can just generate the tarball
myself for now from the Git tag.

Thanks,

--=20
 _o) Michel Lind
_( ) identities:
https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
     README:     https://fedoraproject.org/wiki/User:Salimma#README
