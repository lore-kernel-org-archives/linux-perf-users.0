Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879A56E048
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873323; cv=none; b=kW2vYqf2bMTlAyc6ywsJUXA9cORV2q7Bx3PDhaT/bfiy5l2Up1gu48JE8XgGYhpURqWgHoL11V/xWqYM+1Kj/naFOqxWfYpx9nOiGpr7z94DebswgtiGb57PvuVgZWC9HrAWpgCGsZ6g1MV6S/IdOPbhEQFgV70fTvQOIOdl/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873323; c=relaxed/simple;
	bh=i3qs8qeRT+yElXv0OGFcHqRqGW5lDW+eerIzTYZVeGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kfj9g9L61TBIrtM1QUaDYstk78radvOJQagDuiZGl0uOsrytcjS/ovf/UmwA2mrFzs6RcVWAXrg8z57M3vEGsTNurWtFLFXe2h4GqXLLME6xgqelMKs5teiB6hVtNps+vMQP9twf2NExo10LZE7+bJdn021xFQRsGeA+cZb4dpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q24kQgod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q24kQgod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3BB1F00A3A;
	Tue,  8 Sep 2026 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873321;
	bh=CU9h0/HwcYlXLBmU/m3jR/wY21J3G4KXwpWUWZQcLD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q24kQgodmyTyPKkr6NitrkD5UNj1eUWVqjtGANdbN3Gycj0cHR6fdbb7rPH/fOIQc
	 JgzyvuAq6A8FVN4lvhw4an7ZSELrP4a6OGXZ2hMIT5mcso0F1gA5tWO7ADFLoKIcf4
	 cI3gMZrduAvvIGeSv8TKn5Tn2YELOlusOLG9/a0cShjKTZUF9+ZoKWl2FFEWqqpMp5
	 bATf21zQb6brVFt7iOPHKVp0/v6XABTAGuXMGO6IdYlq/0DVB63Vcp8vNApr7BwsLD
	 r/wRkkuWq/QTvMnRw2a1Jh3KBL0NAjCzv3f/S8uw4TcHc4QZvNn9pVp/lOC6TRdp0m
	 g3p7jVMs2l6WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/26] perf annotate-arm64: Generalize
 arm64_mov__parse to support more instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <872f51108191d20f65fc12f17c796863a36166da.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <872f51108191d20f65fc12f17c796863a36166da.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:15:21 +0000
Message-Id: <20260908131521.AC3BB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> As the default parser for arm64 instructions, arm64_mov__parse()
> currently only supports parsing instructions with the 'addr <symbol>'
> suffix. Other instructions are not supported, causing a lack of
> source and target information for most regular instructions.
>=20
> Generalize arm64_mov__parse to extend its parsing capabilities:
> 1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
> 2. Utilize arm64__check_multi_regs() to identify if source and
>    target contain multiple registers.
> 3. Maintain backward compatibility for instructions containing the
>    'addr <symbol>' suffix.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D3

