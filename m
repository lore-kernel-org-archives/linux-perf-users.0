Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3585478D
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835245; cv=none; b=Upgrq09knZpgzrzFSRXIchCln2tCltU+1xT49CX8KBVoctXPhJI8A7oVXS5JIyATsNsJ71chOLaT6TuDnCqnOv9kuHKA9DLnxAlMTZGGmWvXbhDycqj5yIqPqRhOquzu40FeD3q6XUjnHtpV1kDR55nenI531O+avCVks+6RtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835245; c=relaxed/simple;
	bh=dCG8q+JOCPoVE0XI2cskLB6lRRdx6Vl5rvC9cvPpgus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9fatqlJwMd70GaQb2bu17LbsSFhHTDEe+tZIF9MA9VDmtVABnt9cpBoXg3P8QQ6NhJ5iR8Mgrs8inIZ68Qw28Bv69ejXvxYizihIRfkZ6hOQ4y4fV57oOgK3Q/rirgJy5i+JnClo4ZBKU7A28F+doOdt8fcy40LyDZjTTV5fnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE+Zzl3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE+Zzl3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4112B1F00A3A;
	Tue,  8 Sep 2026 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788835244;
	bh=dCG8q+JOCPoVE0XI2cskLB6lRRdx6Vl5rvC9cvPpgus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aE+Zzl3yydwe2YgY1ch5G8qFIaT4Ng5etoIyFSpp8sEuzOVjxji5HVKafMwEJ50B7
	 PXWUkN/aPUzVHHh+nuBGoHkeXXHTH43lsAJqLEzCq+kXtKcUjdv0a4TLTPRkzwX7jF
	 7ke47qkiZ1rhqaoaMg8pKzNueEY6j9AgjztgUlsO66catSPkN6T1ytJzKd/QQ7oaf+
	 29ahnzTZkjcAoYNb4eiNROXvS8ZcbvZiyNyGweWKPvpHGuK0ALMzhHgguPDtuYyiuw
	 zuUerhJOnd6x3Q2yPuGidqAEimEiHjjHz07T76FQ/9zkqtMdpMd3xQ/koM7naotxKb
	 e2c9aDQJ4V/Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Fix slab use-after-free in filter_chain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zafir Rasyidi Taufik" <zafir.taufik@starlabs.sg>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908023223.1516819-2-zafir.taufik@starlabs.sg>
References: <20260908023223.1516819-2-zafir.taufik@starlabs.sg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 02:40:43 +0000
Message-Id: <20260908024044.4112B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Syzbot reported a slab use-after-free read in uprobe_mmap. The root cause=
 is
> when a trace_probe has a sibling event, unregister_trace_uprobe() does
> not unlink &tu->consumer. This memory can still be referenced in
> multiple locations, namely filter_chain and uprobe_mmap, resulting in a
> use-after-free. This is not a security issue as creating uprobes
> requires CAP_SYS_ADMIN.
>=20
> Here's a short repro in bash which will trigger a KASAN report, tested on
> v7.2.4. Note the offsets used for /bin/true may need some adjusting,
> they are the offset of its entrypoint in this example:
> ```
> echo "p:uprobe_test/evS /bin/true:0x23d0" >> /sys/kernel/tracing/uprobe_e=
vents
> echo "p:uprobe_test/evS /bin/true:0x23d4" >> /sys/kernel/tracing/uprobe_e=
vents
> echo 1 > /sys/kernel/tracing/events/uprobe_test/evS/enable
> echo "-:uprobe_test/evS" >> /sys/kernel/tracing/uprobe_events
> /bin/true
> ```
>=20
> This is my first time sending a patch to the linux kernel mailing list,
> apologies if there are any mistakes.
>=20
> Reported-by: syzbot+1340ad4350ad43394c10@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1340ad4350ad43394c10
> Signed-off-by: Zafir Rasyidi Taufik <zafir.taufik@starlabs.sg>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908023223.1516=
819-2-zafir.taufik@starlabs.sg?part=3D1

