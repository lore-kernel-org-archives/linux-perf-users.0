Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D03C09FA
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228464; cv=none; b=gNmn7D72CMOGjSwIWb54rsCMe3kxtd/qf7R8CH4ScXyVxLQEvaFDyRsH8UoKIaJ038o1jo0b6s+jfbLLTak/Ri1E6YBRHxoxiLs49xYdR43qNwkssHEcOxDMQFUKer7XD1aqUsaak7ei3fQk8lttbq4BVapbPXWXXdwaSyylF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228464; c=relaxed/simple;
	bh=tHu+elX8JNqJftcez2HdsKYvQUiV+Qu+9VNEW5hZvZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZrF8GIZP0bLiH9KKGOhgguKjEwO8V9ZZ1xQk7elFr1oHWPbMfTTYODsTASK3y98NqOh/lvNQatyB/zfcFyXs3brbj57YaLte156J0ycHN79BLpH2ehVfUN1qx4RpcTcfftncBf1SyGMGXE/mpVoLamS9eDfIy5jTFz1a2aL1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzVzYMy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzVzYMy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90781F00893;
	Thu, 24 Sep 2026 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228462;
	bh=94/ifvqlvUpu3b3i17c6gLWeIG9pRV+jX1z1sC7DNEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzVzYMy3GSUyNiMQe9sNKWmtIlnCu4YcQJCDZiGy6LLfMeOJ+yl4DcP5s0X/V52Cv
	 LvyyaYykuVPLUkDgVutyVYlvV5RCqrNS8aB+r5DtEwJITNgnShPxP4km5RKeS+ieT6
	 9WYkMvZdApMG7zlgvW8jm3vXD1EkcP0txW38kQ55MisAr6ZR+K/QFi51rxUX/MwDTi
	 wHf+41/eQiZtfu7yOplLVbC/a04r1CUTSynuau1VJNsY9Oq3WGDcsGpp1BNYRw7nrt
	 jxSXeCe+AOVJmmhRPeR9DnHPBCXoOrlUER5/0ro8Kp0kx+uyBFXd7tLIP24vk6ddbB
	 BLmMSTTLkcDOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/21] perf vendor events intel: Update meteorlake
 events from 1.22 to 1.23
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-15-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:41:02 +0000
Message-Id: <20260924054102.A90781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/9020a281323a0fb26ee464b3be6e294=
6573cb963
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D14

