Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605875;
	b=azonH8kEzaFFWA8fiGLPHumPeU87djMBnTGTGMu8A+tuc1QO/HZmac4qB11SeIDaw3EP
	 9ggHjX61a7Yl85f0YM48XWcs4xXefvK3JgfvmWlcRGeoWxnu13SZroalkgkWkdOkXYVgp
	 2IwuZp0JRHzNFtC735ywnIMsK0GQP12jWTaEf0HkeUY3Dj6s0Mp9+GwCbuf2J/kxRkp8+
	 P6d0qLXH0uOT69KamNZUjM07WkMx9wQk80+sP90QXk8dxnAQ8vfOGgKHda2sKgarFjDEO
	 ykIY91l78VoEu/ec6rCOfnrj5WHtkD1VzZcrAC7kXiQ8cJ9qknEoGUHQDlfb3MeszLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0hQ+qrQRSu/N8/qCNGynARlszbxMX7MjQCqfRJK499U=;
	b=ZkB9DPK7InCHyPrsqBv24pEOsVcA9pUOpcpu4J53kI1CShp1wBirsMaAPE0g8E/sSXXN
	 EbEMcsHjoJV02S3H+rDGDqdWbN/8g8glDn3aNJAIsZTDYNeHhpDf53tdalsNw9+RDLjwZ
	 VMVyI8ywHQrD2ko3QOGVdpsgilUbzSM9QE/32swUV+uiwxeSspE0RY8wnrr3Csn5eV4mw
	 c4FJzf7iCJ4Kz3XHunfLsQif/Jzsc/vo7oOYlY2Qoj2qtqG1QNZXYDQ6UvZJG7OSBTtIP
	 gLVZUdJPx9pSpeqe24vT1s0nmu0O/cKT04/hT4RZPQT11/zWneK6Wq0zkvoIRRID2Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Su8/4fGA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCD606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Su8/4fGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4FC1F000C1;
	Mon,  2 Nov 2026 07:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605874;
	bh=0hQ+qrQRSu/N8/qCNGynARlszbxMX7MjQCqfRJK499U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Su8/4fGA8mrgZj+0vxr8UpLfo7U0vUs14GWuU1hGgQGDE/Y7jt3HYTfFkf4PatuoE
	 RWNYzUPgTbdJcmHyG56cTjD293ifY894FubGG1zE54/HS7C4NazvGQyBwNfO9GA/dC
	 9K97HpTx2LQ0bn0wvc8PtDMUGTkZ1IGtUaZh2/GG/RdRCNCG/wbLBouCllTDlmddn2
	 ddXvkurP2jP0BZfmVdFxbyHB4RCvF+fn5RB0yf10JkpSuegLs7xHJ5opTk6SvSRsD+
	 2RjMsk22H5aVMF8NCyNacvslMhKJKwmsw6o3uclQbEX7nUgpUkRnqNb7Ke9Bbg7qHf
	 vdheGiw/+BL1Q==
Message-ID: <sashiko-outbox-193053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] irq_work: Re-raise pending irq_work after system
 resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102074039.26983-2-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:51:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> irq_work_queue() raises the irq_work self-interrupt only when adding
> work to an empty raised_list.  Once raised_list is non-empty, further
> queueing assumes the interrupt is already pending and will eventually
> process the list.
>=20
> That assumption can fail across system suspend.  irq_work queued after
> arch_suspend_disable_irqs() and before the interrupt controller is
> suspended, for example from NMI context, may leave its self-interrupt
> pending in hardware.  If that pending interrupt state is lost during
> suspend, hibernation restore, or kexec jump, raised_list remains
> non-empty after resume but nothing will process it.
>=20
> Subsequent irq_work added to raised_list will not raise another
> interrupt because the list is already non-empty.  Architectures that use
> an irq_work interrupt and do not process raised_list from the tick can
> [ ... ]
>  task:kworker/u8:1    state:D stack:0     pid:35    tgid:35    ppid:2    =
  task_flags:0x4208060 flags:0x00080000
>  Workqueue: events_unbound fsnotify_mark_destroy_workfn
>=20
> Fixes: 76a33061b932 ("irq_work: Force raised irq work to run on irq work =
interrupt")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074039.2698=
3-1-adrian.hunter@intel.com?part=3D1

