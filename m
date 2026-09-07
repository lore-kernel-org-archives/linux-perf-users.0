Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FC1DDA18;
	Mon,  7 Sep 2026 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753217; cv=none; b=SWr3FWVYhYs+BEa1X7ByMQqGGM2HMdCTA8Es/ezP1AAiw5T0PmfRhVSg7GCRey/ipxK70NcqhBX/SpCo0GtwKqMDHZZOfU1bsfkFZTHD1dnne2BM25UPCVN6zZ0oUXDg9UG5BlAL+6ycqDtj7cW770KX+dFVt5oPBkquMz7U36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753217; c=relaxed/simple;
	bh=tBNwZE8lEwCpqyiGX7eDrdsaAIcLLccnT+ayqwihwO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gaeW9Hknb6DhyjZCzd6XaaqJpC9hZhpBHuCPxsphm5ETM3Vmu/M+CzyqXJHaZoMl2hsk860Xb0GrhZHoK45p/saPXe84XzLhM2fNVC3+aqttFg6MbDyAHKK8aDVtsB5CPO4eCt8Gl3T6L24ge+8+CM4Fwa+JOOYl2MvUx0xOENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoM/QzTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoM/QzTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810661F00A3A;
	Mon,  7 Sep 2026 03:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753215;
	bh=tBNwZE8lEwCpqyiGX7eDrdsaAIcLLccnT+ayqwihwO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoM/QzTxEbZbavkrzgpc9dCemURE00+YhkvLdRTnFxDnHKY5TcmvKFl53j367c7vw
	 jK5eDI4Tv/nyHa/7FE67UyF+2nya4Ilj7GagL4MktyoPqCbWFGCeJGt34QY/0CiTRA
	 9xjX4/XTYPED7R/7J9UCmJPbatUYTb13y92vRvEwL+S+nEsLszkbB5G4D98rRdwQew
	 jYO02F4q05Vg7LpWSlE5+LTiYQSN2RdIclOq1rqtVmcsC26U4ghQ6LJ3AwogZM8mqq
	 wD332PMFtyQytI+UnfPqcjXMHSAVSLTcsJaA1uq9kxn7/RNISepT/CX/6DnSePaRZi
	 nXItMhTJtOmdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/12] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178875285732.93794.2953704844412327111.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875285732.93794.2953704844412327111.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:53:35 +0000
Message-Id: <20260907035335.810661F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D7

