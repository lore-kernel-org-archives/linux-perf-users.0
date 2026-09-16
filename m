Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BA542802
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577324; cv=none; b=FJz5XIBs8KL7SALW8HDyQ30WWLLrkKzTTVQLO4GqaFFB4h6KnTQ1g6pmY302ZTwDktg4m/XIKPQjew5OaZLUQ/wzn0pQPrWDexPxnSVWQJ3w6rqqKOmWaQgg1HBT5ZE5jQM6/DpVk0u2TTLZFzmFqIpnaIVlteiWqV2dB5eTQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577324; c=relaxed/simple;
	bh=G6QaEBeJAlVBDx1v3f7JQG6SJ8+/KlbT2FM1vh1wRl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sXgxkvxnt0KKd9kD29HPdbqst8VgpFDtrusigveQw8zzYT+kP+xpFkRErlHBJzd3MMmy9mPfZRcCQkLG1o1ki3+aAQF0PKsNXs4Lze13o2O+iD31FX23w0thJzwgFsbNla0AfdHbdgkoQ8EC8+8XCIBn7G+Clxz6XQvTEARYeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdAlr97v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdAlr97v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5B01F00893;
	Wed, 16 Sep 2026 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577311;
	bh=v5IGbY6vASqUeYhye1fzg6RLsJy6K1kN7SRo+hwyT5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdAlr97vYfYPOACLTAmveMA4IGY6oWNCxxwODUw0uMvd86x7tFrMyNL0wuhj7yr1G
	 H7+/WYX2KRIbQp3+Q8EXNYaPAFVUM9bXk9WMurlCdBnF5TT5h1zPO9Rju3VjFcrmn3
	 q+aLwRQ9ogDfRwa9kr0pvitvxIH0HIZkSS9h2OSPpg71huwxqF2b24Z/Ktfszm/lfk
	 sdN2AOAqrkgsRHJmrbiWOLatrrG6Fr2Dhpj4UChyBphs+v1jKmllmUg3CbmyI/VSyP
	 O1X4N64rtr5YGWOI7zEtiV0yKBOucJBPdgAfZfxXzWpmqxgqMITmIhED1WY05hYm5+
	 KZt3LNZyJl5Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916163127.318885-7-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:48:30 +0000
Message-Id: <20260916164831.7E5B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.
>=20
> Example output of perf c2c report --stdio:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                   Memory Ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id =
0, remote region id 255
> Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id =
0, remote region id 255
> Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id=
 1, remote region id 255
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916163127.3188=
85-1-thomas.falcon@intel.com?part=3D6

