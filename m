Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D155D891
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873295; cv=none; b=SDhGg+XenhDLK0VdFM2xDDz5GAxPBByejC43OJI/tumXw/FH8ytuSViQP+DYr/5CE1SP+FzZDKUiSAc+SPXzeih8Gz3Rkvc3/9bAgLdLmdMMDZGHVx5QPcX+5uaJXb4H87v8oNzKvHtaRoDSHh5T6jItZ4H58xJUqISg6fjWc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873295; c=relaxed/simple;
	bh=t+3F84oH5O5RZtcJDWDlDauHtZKefl50wZ2TaXm0T/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WhUJQP5Py5GA16rDJtPMMzjvHS2RdhN0xEgDBSIF0MnTPnRMyo2gluQQ1V5kVw30GGm30I0/Lec8fsdAYU9xWZHu/5A9sdxmiWiZLri8JxeiWW2EK4veauTWRBDjCPWp5RU4JmHixzuPDtf/GIHkkl21nOtHfAAlfgS7oPwrU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inFZFgnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inFZFgnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A1C1F00A3A;
	Tue,  8 Sep 2026 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873285;
	bh=t+3F84oH5O5RZtcJDWDlDauHtZKefl50wZ2TaXm0T/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=inFZFgnHWmYP1qs8EIut44xQUARwS0EyzFEizSUVp18KzGrpwchOTxssaoLANk5PO
	 2Vf+ULHkUkqyBp2B5xyvvHQOovKR1e3mDkzp8tORxJjNuaWp6JxyOEib/DVPRChH8v
	 ktXKfD5rveJYnv2gVOXWlqVYgk/V8ahq3cYM57minYGdtUygg+JBku/Y5NZIl/afPi
	 k2Jsplj7QWUjhIy1e0W4mcpBIuGwGNdEuAXadAz5vee08r/t/+ajWP+xqD58ULBW/y
	 3fwIfLsjDyTIUoUN81Ci/bHOuOLLOuI/NS6IWsXzi97woBm1p4Re3IBED6wLMDxSMw
	 3AdjYKWyxJPJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/26] perf annotate-arm64: Track return type after
 call instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <eb17eb9c66f5ef22f1256a8c8844234c2c139e1a.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <eb17eb9c66f5ef22f1256a8c8844234c2c139e1a.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:14:44 +0000
Message-Id: <20260908131444.D4A1C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable data type profiling to track function return values in arm64
> annotations by looking up the DWARF return type of called functions.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D15

