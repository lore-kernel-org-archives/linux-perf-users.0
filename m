Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C579383320
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665305; cv=none; b=rDDIVLLoaiFa4bugRfSMD/Im8KGi0tMGs+SkLZtXbWmKYYGIxHaXsMk2aKa69euEYnzWgIJRy0/fEoPmULLTFdztLiof8XgyByOUiz+1gRiEvzl+BQVSFIV5wj34tEkodAn/NgQKJ+nfxG6+rAW5Bum+4Wffzc93zBKALEgdHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665305; c=relaxed/simple;
	bh=uJ3s4X1AYmxf3EQcTbCCIu6xRfrRafcjG+6cU5MOkCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTJtt69GJuJUDFY7VzkWfhlzcq+ofZAfqZwDfZ1LDBFyILesoPXIWSuGyyMGU4plovqXm+fPX7yoxZiwj2FNFiFZFeWu3EfVG1WDm8ZRMITIQ8pITUQSpy/VfKrza8UN4eBsPv5OOtK2VoJGMK++yAhGT+dzqDpXpcdDcTkK5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBh3nLVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBh3nLVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8FF1F000E9;
	Thu, 13 Aug 2026 23:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665303;
	bh=uJ3s4X1AYmxf3EQcTbCCIu6xRfrRafcjG+6cU5MOkCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBh3nLVnTxBIcWcJAjM6ewz6Bgcas2FFB6vgFGmNN8ZziNC2/lp7tJksNAS610Gnw
	 0sIvVYd4R9tNPSap2bjRnNC4tK3wGaQARpYnKukOqMx/+Yy2Fv38EyfgWkj/6Vli9Z
	 cmV2ZPcTVONLyGThVEHr2RJny0ZkFSgYkJr1GkFO40v0lCeGjYOLhix3A2F6pE8L5D
	 yfArg/EfnL8x40kRe3xSdaPZPWM+NG/Pr5Ag0b7hsOW2V7e8uklJOSIndW83AYuRuH
	 2aqSJRAonNpL5KklfQv8JcCsG7DqT0L8+FF02NnTCJqJFOodRCz01GPMV954MHSms+
	 a/x43yGBjFKuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/25] perf lock: Constify trace_lock_handler
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260403204017.2919994-11-irogers@google.com>
References: <20260403204017.2919994-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:54:58 +0000
Message-Id: <20260813235503.AB8FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Structs don't change and so constify.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260403204017.2919=
994-1-irogers@google.com?part=3D10

