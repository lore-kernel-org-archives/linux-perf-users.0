Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B142877DE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557621; cv=none; b=R2uY97+ZYl/hJs8smQ5HZbUigqiYnm4Q5DPJpChQ+Js/+Gaj0Sf9XVPPq3chABHutWsB/UwEUFUpYEIFobDIaQ5S23aCsj9cd+c+9CQgka6uqc/EiEpg91EI3cLyJAZJvE6DrNd4EWaRX0Bj1dvLMbN9k7UlmRA/MdKGClryHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557621; c=relaxed/simple;
	bh=zwp/Wv+3YqhwVkrgoE81SjHpVvffZftHD+KNQLy1SqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LCLiSrQZ6t6yhH4l2sEMT/zM0c9wKF5GmUmrCvKRDY37mp9rJVIEi04YirjJcOT77HDJX6z4sEy8s1bntL6Uu/GBwB9KdLWRMqO175Bi69n9928XtRDZCXWdFRW/UC/TO1+Gg3o1rqf23iM4iMayOZLTAm5HsO0OrnVGKc3rRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqWrBe88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqWrBe88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582511F000FF;
	Mon, 28 Sep 2026 01:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790557619;
	bh=SOeEULe0t5yPjjnjUd/me1cFUKlZSmw0vOBqTLnz7gY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqWrBe886OYrzQz2vFf6ul6gqDXdFxYdwc9b0zxa0UBCSS+2GjN/tsSH/i2OYiH8w
	 NkHUcs1FYg96LvI6hBKEbvX0qQ71mMl0TDS1jX+frGe+IKPQWe4auH1PCsYy4xUDMc
	 I+Us1zgUj3g4ussH4jY/eo8OvWkj2o/gYQAEF/l/U/A0wYJUDPW0yAElrszuMEbTLR
	 hnRbf0RhEf80JkzNMb1oAIwPV36X8Cs/Vvx3q4pkTQbhwOkzmYBizcAVpQZGZhUgJX
	 LPH0wTMkPGd1aFJSx+XGU9VmeN1AWlzE1v0502Wsvp52nxrLoQyORjpys4PDhErcs6
	 yyx/cX9tfYyZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf symbol: Don't return an unterminated Rust
 demangle buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928010227.1903673-3-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-3-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:06:58 +0000
Message-Id: <20260928010659.582511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When dso__demangle_sym() runs out of retries or fails to grow the
> output buffer for a Rust v0 symbol, it returns the buffer and callers
> blindly use it as the demangled symbol name.  However,
> rust_demangle_display_demangle() doesn't NUL terminate its output when
> it reports OverflowOverflow, so the buffer isn't a string.
>=20
> Free the buffer and return NULL in both cases.  Callers already fall back
> to the mangled name when no demangled name is returned.
>=20
> Fixes: e20848c317b5 ("perf symbol-elf: Integrate rust-v0 demangling")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928010227.1903=
673-1-michalpl2003@gmail.com?part=3D2

