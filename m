Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC354B1C6;
	Tue,  8 Sep 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878361; cv=none; b=Ww/lUVJHpUUkKoXP13k8mrWJAAb44nTSW7i0zDo+YESypd+5FiFNqyFYtLuVg8a46Yjw9p7JxDXj143E0ktGTbE0hvYZaxHnogNIa94gi+6IvTSys5QabH6T2LUNj8DqdgMTQI0iJaHt8GmmwguY2p3CQpCYl6yiChd3w/UUkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878361; c=relaxed/simple;
	bh=FmRrnTS6pFoZlJW7FYRcX7PO7d+JsY/VwNPbArjHD18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UafRDD54gIDfiW7C+5vtWpd3CTCt52Tx4/gVHt0+VWPnCtLaEC92iRtafXgcrUiYi1CyuxRrpvHl7qwNwmoqO3quSrIgUKhnJuw5zfAxbP0Yqax3imL69ywG6UHJb+5JyAs3I6hi0K8HZcwaROgHYOsY1wvB4QTPF8Ub6L2+psI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iadWHY06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iadWHY06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139B1F00A3D;
	Tue,  8 Sep 2026 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878347;
	bh=FmRrnTS6pFoZlJW7FYRcX7PO7d+JsY/VwNPbArjHD18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iadWHY069iDVAIm5icxY7M0nTBw7d43ygHm94j2NrFqNG9iK4feZc3nl5/qdNoUqd
	 bPRIGgp0SFdze2BpRq1d1nRtx1Y/ooOHsqKsFBttPMJE57aIaQbkbnJMuj21s68N3+
	 47Ldf7tdjdiBRwYiWJ9iSGmBC042N9hf/Zk0WcsSkt7wrtn5xGUghybD743NtNtFQ/
	 iaw6RLKpIAj8nZmmwcnI3yyr7TEZ6X7SBNRIySk1IDA0P8S8O7C1scs8a8p8EHqLq8
	 3wGFljtt5F5yIfezHQZUHh/Rf5Ja0rK1lKj8xA/q0hvuylO9pCqDpd6WU88gtYlIzH
	 XQIY92Ozwf8gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/3] perf bpf_counter: Track valid BPF
 counter snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-2-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-2-60e86f325c35@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:39:07 +0000
Message-Id: <20260908143907.B139B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> The perf profiler uses a zero counter value to reject an invalid entry
> snapshot. However, zero is valid when the PMU has not scheduled the event.
>=20
> To reproduce the issue, fill the PMU with other events and profile a
> long-running BPF program for iTLB misses. In this test, the entry read
> returned 0.
>=20
> Use an armed flag to track successful entry reads. Reset the flag before
> each new read. The fexit path clears the flag when it consumes the
> snapshot.
>=20
> Fixes: fa853c4b839e ("perf stat: Enable counting events for BPF programs")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-bpftool_cy=
les_per_run-v3-0-60e86f325c35@meta.com?part=3D2

