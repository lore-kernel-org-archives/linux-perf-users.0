Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA146EF75
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582520; cv=none; b=JkvpvdWy/p1jpyOmyuRdKF2WcylhZyFJ5IT8i2RYyxRVjAuPZdeX5FEYlHXHcSZkJIrdZjbYJ3+QcFejhTMsfD564BqsJVLGDAA5/urMpZYO0osHeQNBOptE16DrE2ObMmlmKwf88xFAYrrDCFnZK/mmtJao+YRm4he8PAPI7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582520; c=relaxed/simple;
	bh=MbKfCFRrnBr+XjwQ92aXE0IBXi1WS0Z3+FOoL4Jtgkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sc3jfKFi7gK26C5mGprLv2R87/SKbq2hZbV9urOusBJR33LzMmstg8O2iC1AfEL4/fp9QnCdgrw8+1xqGtBnA90jU2ORuZK+/mOJKYzhSBcW1DA7pBckauc2v01BFRrOw7BYngx/RvDfDCyN72JHfDcwjQH8rsSHYoXtlIJHZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQk2lR4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQk2lR4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11AD1F000FF;
	Mon, 28 Sep 2026 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582513;
	bh=MbKfCFRrnBr+XjwQ92aXE0IBXi1WS0Z3+FOoL4Jtgkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQk2lR4NGlUwHyo2hUSZubCZnUXbsSDioA016YfLiNRtuzSpwCZ6Uj4D1GGF5BVEK
	 mWNWyQZ1kFi09HEG/SgqCyzH0OT0egPyM1usZShJKtiACqDfC4gNcQwELUFkWUtYAC
	 4eyhDZ39u1WK6Sd6hR3XS7DsqMxHaNz5nbU6RTlhJ0KEhDyL5tYonc235QQkRXpIJr
	 bt2t76VTPWwzdOq44CFLfLdu1uMm8til/w1P9WQeL+9E+eUUk8lpbz8XAyI9Qa+y7U
	 FfEZu6NUOM+BcRSO2gIz1ZavRKxRIBOrWOklqysox3OvIgek91ITinMGxvvcPGjeL9
	 X/0GLaibMDr5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] perf/x86: Validate event type before
 topdown/mem-loads classification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-14-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:01:52 +0000
Message-Id: <20260928080152.F11AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Software events can be grouped with x86 PMU events. While iterating an
> x86 event group, a non-x86 event may be misclassified as a SLOTS,
> topdown metric or mem-loads{,-aux} events if its config bits happen to
> match the x86 masks.
>=20
> Require is_x86_event() before classifying SLOTS, topdown metric or
> mem-loads{,-aux} events to avoid false matches on software events.
>=20
> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDow=
n metrics")
> Fixes: 61b985e3e775 ("perf/x86/intel: Add perf core PMU support for Sapph=
ire Rapids")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D13

