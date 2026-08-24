Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568713876BB
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561638; cv=none; b=jN0MNDmgcf5XbEqG5bxxii7UJv22LYRGM9RJy8Jiv0hR8QFhVePq4PlxuZIgOdG8cR6lv3NWc9avEYKIy+WxInndJTu6KVIdMgm3wIv/RBOZilrFzdWKE3z/gzqJIN2xT9dVVFOT4hGYGpcJBFMQvHQjtYtZnfVw/h0Qt233dqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561638; c=relaxed/simple;
	bh=QS3wrJvw5ulmKP1+SffGk+yvA3Yl07PlNdc3euy6Llc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nGZYdvk4KSms7B9d3JQRk5vCgpmyBiUgtTh0OdNsqBWEroSmxViOj7Uch3XCyGI4OG7L13ijgyYwFJNW8EzpP1/3+9b7My4T/tfbeC/eWOy6ZUC0MaZx3lqXxis8oEQDLR1pzQnsXTV2en8q3voC9pbbhK4K22jTrBLjRTLekpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOWE/g0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOWE/g0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57CA1F000E9;
	Mon, 24 Aug 2026 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561637;
	bh=QS3wrJvw5ulmKP1+SffGk+yvA3Yl07PlNdc3euy6Llc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOWE/g0qlwXCYWORU7KqgLeTHVZ02DdpxEhH8NlevAJqarlCW+9SBvMFjYNib28vP
	 ciVmfUJHU1bGb+HEnTGvmTDN9RcXQgEey9y1LXv77KLzYmdk3bfEc05VtzzsY4+7nR
	 MGdfMmCzPfsqy+AnvIEl+kRpgkBQppWBMm9DDEjsQbavrf5mWdL+98Sr94RFz5IHaN
	 J9WjZedFWzisbSWykU/3PiSzx/JUeSMt3fqeAQEPl1Fd1St7eSKeUGMv7rsML4nCWD
	 0wyM51CVvQJAKNxtSH9asDdBBikk+gas9jXerNk5DmAgxN5qW991Fxb746EfVC4RIj
	 J9wDN6KMi+bpw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 10/23] perf/x86: Enable XMM register sampling
 for non-PEBS events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-11-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:53:56 +0000
Message-Id: <20260824085356.D57CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Previously, XMM register sampling was only available for PEBS events
> starting from Icelake. Extend the support to non-PEBS events using
> the xsaves instruction, thereby completing the feature set.
>=20
> To implement this, a 64-byte aligned buffer is required. A per-CPU
> ext_regs_buf is introduced to store SIMD and other registers, with an
> approximate size of 2K. The buffer is allocated using kzalloc_node(),
> ensuring natural and 64-byte alignment for all kmalloc() allocations
> with powers of 2.
>=20
> XMM sampling for non-PEBS events is supported in the REGS_INTR case.
> Support for REGS_USER will be added in a subsequent patch. For PEBS
> events, XMM register sampling data is directly retrieved from PEBS
> records.
>=20
> Future support for additional vector registers (YMM/ZMM/OPMASK) is
> planned. An ext_regs_mask is added to track the supported vector
> register groups.
>=20
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D10

