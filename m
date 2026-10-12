Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E53B4EB2
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849172; cv=none; b=XvvdAZ27WVzDqcfB5zy4ieTcjr0ms/kvf37QgLfL7svirxFDU0fT2DHHMlBqKnDTXVHJASbkIaDZeSOAGur9/9pMmZM2QW67i2l4BBa6V96Mers5ijGg/hSvmTFhbOy2ID+gyeCxr1OKhDJ60r+rdUPWQ+k9d7Roiqn62gyg5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849172; c=relaxed/simple;
	bh=9Wbu7XiBneF5zomiHAsyouWNMskvNb8Rd1uD5nXY+Wg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rdLyyd67DaOyKn1Cs3wsS44OhTRjce8t77mYSRnPF4hOF+1j69WQKBWE8QgvW7ULQfLbF8AL3b9Xa+XBu/ysbDhO/NfTPWpVEjvOfP7ixH1niXmk/fZnxbwf/ZOR7rWoUr/l8v/MDkGCfreHJVkk/QIFTMqEPuIWAH67Jtnkgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+VfuM55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+VfuM55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8FE1F008A1;
	Mon, 12 Oct 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849171;
	bh=dFA8gedhI+0AxPpAMk6Nohl0h4lo0Oc3uwCubfghPN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+VfuM551pO2g94f4BezRt1AWTwqqe9NrEnPApb1SGYRVOlYMlJM+4dXUY6qjcMib
	 PYKbG4o4J3VtXipZpBUHzIGiyiUCgJ9VBsDQfqBY+KBkw2KbY0HCI3A29ntvmrCCmq
	 9bR+dyFg1Ecp0dcozr/cb0AgbVx+WEt6YZlzQRXd/Ql4mUiIkOxBy8regm6JHFcx3J
	 obQnigMN4AgKCHpWbVbOeJozLxvmkilCD4G/RmvNgjzYbkS3oSMhyNXruNIyunO1by
	 AqgymZhzc9kBl9kJH1+9aw+yeQBB75Tph847zJtyWpQXwACqx4u4rdPlNhwsHLxbQP
	 fXMorHB+eKFOw==
Message-ID: <sashiko-outbox-168747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] perf symbol: Update symtab type of vmlinux
 from build-id cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-4-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:52:50 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently dso__load_vmlinux() sets both binary type and symtab type to
> VMLINUX.  To precisely track the symtab type of the kernel dso, update
> the type to build-id cache if it's loaded from there.  It won't have
> any functional difference though.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D3

