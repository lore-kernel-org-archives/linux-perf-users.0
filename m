Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82835CB7B
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040014; cv=none; b=EgiVWOD6EEmWU1gDG9YXqo7KnrBndWDqHviXi+BT1+H4rbTQxFD5+RlvDEcH2qo6e8N1MCiwYj49iW5E4kL8KlxBsbLj5rbhl0ud9RdQ3sh06XXY9f6f+xC6e65NcPsQSdS+OkYyhlcb3L8aeQe7zU67R3WFrdT65G0h4Q61WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040014; c=relaxed/simple;
	bh=IT+KaSrPvpemm9Bq4kn8WAN2BzDd6sXXyozRIBVjud8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rqhpc8kmokSW+PMAd4B07ABsJq5IhKByUEwGwgAg/D+4AxaR4dC61l4aPEllIjkJ5dpfUIsrhdiWDfC7BnmdMtG60SUjVrpvAmxny0Tn+zj+1qtdlEqRUWrLxj4wdopXJtQIe8kiNsaJgaK7D8CkxfhnWod6N6RmxMk+3FHTTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK4roMPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK4roMPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793351F000FF;
	Tue, 22 Sep 2026 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040012;
	bh=IT+KaSrPvpemm9Bq4kn8WAN2BzDd6sXXyozRIBVjud8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cK4roMPGB05uClDyDKDj2uyovxHVupyMdk6TxfP2SuT0HT6TBLcawg7dvWLd7D+RP
	 iNcxJ8Ne0Q08h5elhv4lTU1cciIGc8aaQNVFAbC+1erLhHvW1KExTEiQo5wr3F6+Er
	 0WPDSRB+CpHyENRbrjV+vwP14q3Pc2FvWJPdf2nCihy+wPH1RK3Ba3F8qJ9WU6ttp/
	 rnlZiOZkVHofUvKlErzufeV+8xPCZxtoSHO2TDxUHWsYNnRDZmRLddfpiTbLjNejTg
	 0scn6ZhSDdEA0LlPD5g9yKElpgRG9PNPWOxOe/WqzE7Zm2b/JZe8WD9Zk9qX363Dot
	 7u9YNfD/zp7Ww==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 1/2] perf aslr: Add missing SIMD handling in
 aslr_tool__process_sample()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922010531.1933320-1-dapeng1.mi@linux.intel.com>
References: <20260922010531.1933320-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:20:12 +0000
Message-Id: <20260922012012.793351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently the SIMD register sampling is supported, but the corresponding
> handling is missed in aslr_tool__process_sample(). This can break parsing
> of the sample record.
>=20
> Add the missing SIMD register handling in aslr_tool__process_sample().
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922010531.1933=
320-1-dapeng1.mi@linux.intel.com?part=3D1

