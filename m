Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A7352037;
	Sat, 22 Aug 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391213; cv=none; b=a7hXvKhlnLEYwXH+Bfnusy8Bi6Oqp9PhX4FfZEqbrLZlVMwaF9hqUDRQGIoGKFXKsQji68cYV1S5Zd2IaYhfrWWOPmyK6QjcNM4HOwfKBQBPp2XcHIJt9F2F9EF5EX132M2/6aQ7bzWsRRCvOtomeEbZiMTGxEjGT4Y3HsHKWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391213; c=relaxed/simple;
	bh=vIOP4Dju2lTtvy36saVd3XewpGGL1VuRo7A63IuufOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GspxGKQ1HHFszq7RSTwuOKNSszBFbmP6Y7a+Yd5R+068Slb/0gyRjm2sbwzDPFkAAc1e1OW/MtxfbwM8eZa+6XYCKGbhr6jHJV/hAl+6OYEFw/db+45T1wTkPiwePcaVsGV10088umQKLiHxfdaI4ibRNrELXruD1BBHQ3/ox1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBmptNwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBmptNwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF73E1F000E9;
	Sat, 22 Aug 2026 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391212;
	bh=vIOP4Dju2lTtvy36saVd3XewpGGL1VuRo7A63IuufOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UBmptNwO3QJcWLyeVytYcbN9cIQv3hHYyXkmm2h8LGnx7D/fBDdyeAJ14nAHLrWIN
	 mpfqCSHMHJnHo1bJvK52B0Oy/JacNkuv8KBmHaCBaCSI1R0o8JpTyxyYgEdrSwtDYS
	 IWoU80+mNaKkNrMqIdXwETKydLx5AMQvog8VensnB0YBg3LIvquPumIEVmkbR66AcP
	 xU5RfD8jbkL514DxRx/wZxG46j4uepWITS1WhywlBzBo8cKqanJI/fk1kc7/VT8L2F
	 ENxyFXKyGwUv6vq0s7BPY/Q2+nnqdsjVR3J0erKWvLi2YasuwaRgiNu3xqhGfnZ1Ic
	 mXsTFlZ3+23uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/12] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178739058492.1520941.9157739840785471708.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739058492.1520941.9157739840785471708.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:33:31 +0000
Message-Id: <20260822093331.EF73E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add modify_local_hw_breakpoint_addr() to update only the watched
> address of an installed hardware breakpoint on the local CPU without
> releasing and reserving its hardware slot. This is available when the
> architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
>=20
> The caller must provide an installed local event and a valid address,
> and update other CPUs separately.
>=20
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf9=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D4

