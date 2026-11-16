Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853779;
	b=RCRgCLJwq5W/cWF3uGSU7M19HPEMa/05ooTfPDTxMSjiR5GLtSTn+CWLPIN3B4XMxhix
	 4RZlcLYHei6CjLoUQ1vwYqWPsowkLo+uN4Pje2qvH1Lo98336GLbwsGvbYgWPYmnLp6li
	 dv1IEFb9KXb6pCHGx/ySjIT29gKLWgf0WVtHrhxPB6/KtPnJjk70llkpyivxnS8MJ/XCm
	 E5bcmxxLWTUYPB1kBov7i4YBGUVbywf9CElWTfhhqzcWOqzygELkGuaz61BnPF/rYD6Pv
	 E3fJ2Wds2joRXX4JmABhwHNAVtbou6B4mvDBTlRA0zQ0yF20qbK5sStrg2OrfOLoEGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ogtR6lS7N+dPu8nRQ1T88G8abXvdW9rQzJfQqomzZ/w=;
	b=3q956Vbnim2w6KjAqkbFSZZtygqmJQR0L4HZOnyfX1akenTG8d6WcrSED0KnQ6ziaIXI
	 tVkqxgqM3ONoc7XR5LUSfL4oGP8nHXEVZ6rKFwtK4yoI4w1xuTfY6q1PzD0rKmgHxiid1
	 kC6lP8q74DcOH6lAT6QYmCKAvTkEU14ptnzsuXyt1mESY4dNI+mQEvhWoGMSSEa9HCNub
	 fZjdvYhy8t7ugG4Nbi9I8UL/nDcVW7e73yK5GHaE352WHOtIBit7h/rY+DcXfUOQuFtFP
	 SPMW3RJpJF/IapcO5Cs0fkVHhHLN1MRcYC0nEvMWVLnkibzN4k08cvpNg3Xi8zlcGZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjNSSxXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44321606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjNSSxXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62731F000C9;
	Mon, 16 Nov 2026 18:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853778;
	bh=ogtR6lS7N+dPu8nRQ1T88G8abXvdW9rQzJfQqomzZ/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bjNSSxXdVYtdMApeac1/ZILbqOWjlJZLAHqdUXyufuGaVS36q5A9rxfzdMCSZpjCQ
	 s/IPCtPrciDrKGTmk4NT2TylsCE+47i4+U6KiX4VuMoHpunJpiXQEdSUGhP6pMt3xH
	 kc4G/DyY5GtYi9fiNOyhYiLy2vVvmq658jQ2pYJVYEhRxwgxAiRmRaDJ+w4I+I3py2
	 SngYhDQwO8g+110dfD2BgPfw6kB39oZ0uEgENBwVWW8nMkqJ+2gr+V77tmdrYk30RE
	 asPSgs1IyxG0zzVHpQlh/EvoViUOvFXZDJ+Porz7wIexT3M3AQGjc3kA68SW0ss9Y+
	 si9DpAXBTxoBw==
Message-ID: <sashiko-outbox-217500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] device property: Add software-node IRQ affinity
 masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-2-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
 <20261116-acpi_arm_pmu_registration_hmp-v1-2-0371d4eca626@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:29:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Devices created from firmware tables may need CPU affinity information
> without a corresponding firmware node. Allow software nodes to supply
> this information through the common firmware node IRQ affinity API.
>=20
> Add software_node_add_irq_affinity() to copy a CPU mask for an IRQ index,
> and implement the software node irq_get_affinity callback. Keep each mask
> until the node is released and reject replacement so borrowed masks remain
> valid for the node's lifetime.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-acpi_arm_p=
mu_registration_hmp-v1-0-0371d4eca626@arm.com?part=3D2

