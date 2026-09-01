Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B738DC62;
	Tue,  1 Sep 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272745; cv=none; b=bF6TC96E9Iqkb1VeB3OESKRezvsYveUq0foU5zhEVms2IjFSksB6UCHlN9DjAjO96ZsSZTxQwchUKkiFIkMX/N/mJ1Xmq4yTEJ8f5MoPmTJhwLyrNIXdXTed/M4iTFQFd6+0mLFrM3OdpO7P424YYRHVbY6qq4bKbFGFRNpDBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272745; c=relaxed/simple;
	bh=jwp27w6An+0hp7f5GNbfzsvdKqhD3ac7mrQngQ/ntmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ueaHcYofH67Qn1FXLdoGuiwXtMzmbmJhhTAukKKoAp2mi67/mVqiWu665T7pzjie8eyFrOT7i/1d4qJajx2ItE5wS4RanFb8noLVDbh7vZ8BnwPgHEEuOkmo8qwWEng/oX9Xp5VBjgvKFvIMyGjLbRD9yvhtxNiP577FnrDTH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNRg4M60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNRg4M60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2071F000E9;
	Tue,  1 Sep 2026 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272743;
	bh=jwp27w6An+0hp7f5GNbfzsvdKqhD3ac7mrQngQ/ntmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UNRg4M602GePZE/Y9aQhmeansq579vG9QK0mOIrSf5oLtoa20xKlqFrbCpQmIz7QX
	 2orLV+ub+g9s7cU1swDPlgxFH9VGPhwWXATzN3MSvwW1xsq+7va2ZJ4vJMuNhSxCH7
	 8R7UqmplcfR6HtAZ+KgVB2tR3Wydd8I5Ww9knwof/sux5ZJpr9XTKTXuf/+HBAYvpf
	 8VmLgGhCgskOxZbEBnldec0qHPJhG5+kUqQ3xiqt+XY+xttTNhgaQ25zduEvE/eMIY
	 ugGk+t0E/NOlax8Fb4Gmog834pe5wgTIFj6w0pU/8OdNdanHaJ0598WrGw6q/uoCCN
	 JsVL+5LSFRu3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] tracing/probes: Fix code indent in
 get_bitoffset_of_field()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178827252027.123716.7095571176291547259.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
 <178827252027.123716.7095571176291547259.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:25:42 +0000
Message-Id: <20260901142543.5C2071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Fix code block indentation introduced by commit f21834524025
> ("tracing/probes: Support field specifier option for typecast").
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178827248631.123716=
.2627172171811720261.stgit@devnote2?part=3D3

